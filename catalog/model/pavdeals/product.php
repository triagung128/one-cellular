<?php 
/******************************************************
 * @package Pav blog module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

/**
 * class ModelPavblogcategory 
 */
class ModelPavdealsproduct extends Model {		
	
	public function getDefaultSetting(){
		return array(
			'theme' => 'default',
			'latest' => 1,
			'limit' => 8,
			'width' => 300,
			'height' => 310,
			'auto_play' => '0',
			'auto_play_mode' => '',
			'interval' => 1000,
			'cols' => 4,
			'itemsperpage' => 2,
			'saleoff_icon' => 'data/saleoff.png',
			'icon_width' => 140,
			'icon_height' => 70,
			'today_deal' => 30,
			'time_start' => date("Y-m-d"),
			'time_end' => date('Y-m-d', strtotime("+30 days")),
			'order_status_id' => 1,
			'enable_available' => 1,
			'enable_pass' => 1
		);
	}
	public function getDeal($product = array()) {
		if(isset($product['date_start']) && isset($product['date_end']) && isset($product['special']))
			return $product;
		
		$product_id = isset($product['product_id'])?(int)$product['product_id']:0;
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = ".$product_id." AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1");

		if (!empty($product) && $query->num_rows) {
			$special_price = $query->row['price'];
			$date_start = $query->row['date_start'];
			$date_end = $query->row['date_end'];
			$product["special"] = $special_price;
			$product["date_start"] = $date_start;
			$product['date_end'] = $date_end;
			return $product;
		} else {
			return false;
		}
	}
	public function getProductSpecials($data = array()) { 
		$this->load->model( 'catalog/product' );
			
		$filter = "  ";
		if(isset($data['start_date']) && isset($data['to_date'])){
			$filter .= " AND ((ps.date_start <= '{$data['to_date']}') AND (ps.date_end >= '{$data['start_date']}')) ";
		}

		$join = "";
		if (!empty($data['filter_categories'])) {
			$join .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (ps.product_id = p2c.product_id) ";
			$filter .= " AND p2c.category_id IN (" . implode(",",$data["filter_categories"]) . ")";
		}
		$sql = "SELECT DISTINCT ps.product_id,ps.date_start,ps.date_end,ps.price AS special, (SELECT AVG(rating) FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = ps.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating FROM " . DB_PREFIX . "product_special ps LEFT JOIN " . DB_PREFIX . "product p ON (ps.product_id = p.product_id) ".$join." LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' {$filter} GROUP BY ps.product_id";

		$sort_data = array(
			'pd.name',
			'p.date_added',
			'p.model',
			'ps.price',
			'rating',
			'p.sort_order'
		);
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			if ($data['sort'] == 'pd.name' || $data['sort'] == 'p.model') {
				$sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
			} else {
				$sql .= " ORDER BY " . $data['sort'];
			}
		} else {
			$sql .= " ORDER BY p.sort_order";	
		}
		
		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC, LCASE(pd.name) DESC";
		} else {
			$sql .= " ASC, LCASE(pd.name) ASC";
		}
	
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}				

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	
		
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$product_data = array();
		
		$query = $this->db->query($sql);
		
		foreach ($query->rows as $result) { 		
			$product_data[$result['product_id']] = $this->model_catalog_product->getProduct($result['product_id']);
			$product_data[$result['product_id']]["date_start"] = $result["date_start"];
			$product_data[$result['product_id']]["date_end"] = $result["date_end"];
			$product_data[$result['product_id']]["special"] = $result["special"];
		}
		
		return $product_data;
	}
	public function getTotalBought($product_id = 0, $order_status_id = 5){
		$bought = 0;
		
		$query = $this->db->query("SELECT sum(quantity) as total FROM `" . DB_PREFIX . "order_product` op
			LEFT JOIN `".DB_PREFIX."order` AS o ON op.order_id = o.order_id WHERE op.product_id = ".$product_id." AND o.order_status_id=".$order_status_id);
		if($query->num_rows){
			return $query->row['total'];
		}
		return 0;
	}


	//#1 start edit code
	public function getProductSpecialsForDeals($data = array(), $flag = true) {
		$this->load->model('catalog/product');
		
		$filter = " AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ";
		if($data['deal_type'] == 1) { //today 
			$filter = " AND (ps.date_end <= '{$data['end_date']}') ";
		} elseif($data['deal_type'] == 2) { //available
			$filter = " AND ps.date_end > '{$data['end_date']}' ";
		} elseif($data['deal_type'] == 99) { //available
			$filter = " AND ps.date_end >=now() ";
		} else { //pass
			$filter = " AND ps.date_start >= '{$data['start_date']}' AND ps.date_end < '{$data['end_date']}' ";
		}
		$join = "";
		if (!empty($data['filter_categories']) || $data['filter_categories'] != null) {
			$join .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (ps.product_id = p2c.product_id) ";
			$filter .= " AND p2c.category_id IN (" . implode(",",$data["filter_categories"]) . ")";
		}

		$sql = "SELECT DISTINCT ps.product_id,ps.date_start,ps.date_end,ps.price AS special, (SELECT AVG(rating) FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = ps.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating FROM " . DB_PREFIX . "product_special ps LEFT JOIN " . DB_PREFIX . "product p ON (ps.product_id = p.product_id) ".$join." LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' {$filter} GROUP BY ps.product_id";

		$sort_data = array(
			'pd.name',
			'p.date_added',
			'p.model',
			'ps.price',
			'rating',
			'p.sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			if ($data['sort'] == 'pd.name' || $data['sort'] == 'p.model') {
				$sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
			} else {
				$sql .= " ORDER BY " . $data['sort'];
			}
		} else {
			$sql .= " ORDER BY p.sort_order";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC, LCASE(pd.name) DESC";
		} else {
			$sql .= " ASC, LCASE(pd.name) ASC";
		}

		if ($flag == true) {
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}
		}

		$product_data = array();
		$query = $this->db->query($sql);
		foreach ($query->rows as $result) {
			$product_data[$result['product_id']] = $this->model_catalog_product->getProduct($result['product_id']);
			$product_data[$result['product_id']]["date_start"] = $result["date_start"];
			$product_data[$result['product_id']]["date_end"] = $result["date_end"];
			$product_data[$result['product_id']]["special"] = $result["special"];
		}

		return $product_data;
	}
	//#1 end edit code
}
?>
