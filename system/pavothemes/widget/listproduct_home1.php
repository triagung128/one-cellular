<?php
/******************************************************
 *  Leo Opencart Theme Framework for Opencart 1.5.x
 *
 * @package   leotempcp
 * @version   3.0
 * @author    http://www.leotheme.com
 * @copyright Copyright (C) October 2013 LeoThemes.com <@emai:leotheme@gmail.com>
 *               <info@leotheme.com>.All rights reserved.
 * @license   GNU General Public License version 2
 * ******************************************************/

class PtsWidgetListproduct_home1 extends PtsWidgetPageBuilder {

		public $name = 'listproduct_home1';
		public $group = 'product';

		public static function getWidgetInfo(){
			return array('label' => ('Get List products'), 'explain' => 'this widget only support for layout home 1', 'group' => 'product'  );
		}


		public function renderForm( $args, $data ){

			$products = (isset($data['params']['product']) && $data['params']['product']) ? $data['params']['product'] : array();
			$list_product = array();
			if($products){
				$this->load->model('catalog/product');
				foreach($products as $id_product){
					$product = $this->model_catalog_product->getProduct($id_product);
					$list_product[$id_product] = 	$product['name'];
				}
			}

			$key = time();

			$helper = $this->getFormHelper();


			$this->fields_form[1]['form'] = array(
	            'legend' => array(
	                'title' => $this->l('Widget Form.'),
	            ),
	            'input' => array(

	            	// list links
	            	array(
	                    'type'  => 'links-category',
	                    'label' => $this->l('Links Category'),
	                    'name'  => 'links',
	                    'default'=> array(),
	                    'desc'	=> "Add links category",
	                ),


	            	array(
	                    'type'  => 'text',
	                    'label' => $this->l('Limit'),
	                    'name'  => 'limit',
	                    'default'=> 8,
	                ),
	                array(
						'type'  => 'text',
						'label' => $this->l('Items'),
						'name'  => 'itemsperpage',
						'default'=> 4,
						'description' => 'input number show items per page.',
					),
					array(
						'type'  => 'text',
						'label' => $this->l('Columns'),
						'name'  => 'cols',
						'default'=> 4,
					),

 					array(
	                    'type'  => 'text',
	                    'label' => $this->l('width'),
	                    'name'  => 'width',
	                    'default'=> 200,
	                ),

 					 array(
	                    'type'  => 'text',
	                    'label' => $this->l('height'),
	                    'name'  => 'height',
	                    'default'=> 200,
	                ),
	            	array(
	                    'type'  	=> 'ajax_product',
	                    'label' 	=> $this->l('List Products Featured'),
	                    'name'  	=> 'product[]',
	                    'default'	=> array(),
	                    'desc'		=> '',
						'products' 	=> $list_product,
						'desc'    => $this->l('Add List Products type Featured')
	                ),
	                // banner
	                array(
		                'type'  => 'image',
		                'label' => $this->l('Banner Image'),
		                'name'  => 'banner_img',
		                'default'=> '',
		                'desc'	=> 'Put image folder in the image folder ROOT_SHOP_DIR/image/'
		            ),
	                array(
	                    'type'  => 'text',
	                    'label' => $this->l('Banner width'),
	                    'name'  => 'b_width',
	                    'default'=> 200,
	                ),

 					 array(
	                    'type'  => 'text',
	                    'label' => $this->l('Banner height'),
	                    'name'  => 'b_height',
	                    'default'=> 200,
	                ),
	            ),
	      		 'submit' => array(
	                'title' => $this->l('Save'),
	                'class' => 'button'
           		 )
	        );


		 	$default_lang = (int)$this->config->get('config_language_id');

			$helper->tpl_vars = array(
	                'fields_value' => $this->getConfigFieldsValues( $data  ),
	                'id_language' => $default_lang
        	);


			return  $helper->generateForm( $this->fields_form );
		}

		public function checkExistCategory($category_id){
			$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "category WHERE category_id = '" . (int)$category_id . "'" );
			return $query->row;
		}

		public function renderContent( $args, $setting ){
			$this->load->model('catalog/category');
			$this->load->model('catalog/product');
			$this->load->language('module/themecontrol');

			$t = array(
				'links'	        => array(),
				'height'  => '200',
				'width'   => '200',

				'b_height'  => '153',
				'b_width'   => '153',
				
				'limit'			=> 9,
				'itemsperpage'	=> 3,
				'cols'			=> 3,

			);
			$setting = array_merge( $t, $setting );
			// THEME CONFIG
			$setting['objlang'] = $this->registry->get('language');
			$setting['ourl'] = $this->registry->get('url');

			$config = $this->registry->get("config");
			$setting['sconfig'] = $config;
			$setting['themename'] = $config->get("theme_default_directory");
			
			// heading title
			$languageID = $this->config->get('config_language_id');
			$setting['heading_title'] = isset($setting['widget_title_'.$languageID])?$setting['widget_title_'.$languageID]:'';

			// get Links
			$categories = array();
			foreach ($setting['links'] as $link) {
				$check = $this->checkExistCategory($link);

				if(!empty($check)) {
					$category = $this->model_catalog_category->getCategory($link);
					$categories[] = array(
						'category_id' => $category['category_id'],
						'name' => $category['name'],
						'href' => $this->url->link('product/category', 'path=' . $category['category_id']),
					);
				}
			}
			$setting['categories'] = $categories;

			// list product1
			$setting['list1'] = $this->getProducts($setting);

			// banner
			$placeholder = $this->model_tool_image->resize('no_image.png', 279, 406);
			$banner = $this->model_tool_image->resize($setting['banner_img'], $setting['b_width'], $setting['b_height']);


			if ($setting['banner_img'] && file_exists(DIR_IMAGE . $setting['banner_img'])) {
				$image = $banner;
			} else {
				$image = $placeholder;
			}

			$setting['banner'] = $image;


			$output = array('type'=>'product','data' => $setting);
			return $output;
		}

		public function getProducts($setting){
			$data = array();

			if (!empty($setting['product'])) {
			$products = array_slice($setting['product'], 0, (int)$setting['limit']);

				foreach ($products as $product_id) {
					$product_info = $this->model_catalog_product->getProduct($product_id);

					if ($product_info) {
						if ($product_info['image']) {
							$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
						} else {
							$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
						}

						if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
							$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
						} else {
							$price = false;
						}

						if ((float)$product_info['special']) {
							$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
						} else {
							$special = false;
						}

						if ($this->config->get('config_tax')) {
							$tax = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
						} else {
							$tax = false;
						}

						if ($this->config->get('config_review_status')) {
							$rating = $product_info['rating'];
						} else {
							$rating = false;
						}

						$data[] = array(
							'product_id'  => $product_info['product_id'],
							'thumb'       => $image,
							'name'        => $product_info['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
							'tax'         => $tax,
							'rating'      => $rating,
							'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
						);
					}
				}
			}

			return $data;
		}
	}
?>