<?php 
class ControllerPavdealsDeals extends Controller {

	private $mdata = array();

	public function index() {

		// Pavo 2.2 fix
		require_once( DIR_SYSTEM . 'pavothemes/loader.php' );
		$this->load->language('module/themecontrol');

        $config = $this->registry->get('config');
        $themename = $config->get('theme_default_directory');
        $helper = ThemeControlHelper::getInstance( $this->registry, $themename );
        
        $this->mdata['objlang'] = $this->language;
        $this->mdata['ourl'] = $this->url;
        $this->mdata['sconfig'] = $config;
        $this->mdata['helper'] = $helper;
        $this->mdata['themename'] = $themename;
        // Pavo 2.2 end fix

		//Language
		$this->load->language('module/pavdeals');
		
		//Model
		$this->load->model('catalog/category');
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		$this->load->model('pavdeals/product');

		//Get general default setting
		$default = $this->model_pavdeals_product->getDefaultSetting();
		$general_setting = $this->config->get("pavdeals_config");
		if(isset($general_setting)){
			$setting = array_merge($default, $general_setting);
		} else {
			$setting = $default;
		}
		//get filter deal
		if (isset($this->request->get['filter_deal'])) {
			$deal_type = $this->request->get['filter_deal'];
		} else {
			$deal_type = 2;
		}
		//get categories_ids
		if (isset($this->request->get['idcat'])) {
			$idcat = $this->request->get['idcat'];
		} else {
			$idcat = 0;
		}
		//get sort_order
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}
		//get order
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		//page
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		//get limit
		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];
		} else {
			$limit = $setting['limit'];
		}

		//Breadcrumbs Home
		$this->mdata['breadcrumbs'] = array();
		$this->mdata['breadcrumbs'][] = array(
			'text'	  => $this->language->get('text_home'),
			'href'	  => $this->url->link('common/home'),
			'separator' => false
		);

		//Include js, css
		$theme = isset($setting['theme'])?$setting['theme']:"default";
		if (file_exists(DIR_TEMPLATE . $themename . '/stylesheet/pavdeals.css')) {
			$this->document->addStyle('catalog/view/theme/'.$themename.'/stylesheet/pavdeals.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/pavdeals.css');
		}
		$this->document->addScript('catalog/view/javascript/pavdeals/countdown.js');
		
		//$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');
		//$this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');

		/*Removed when install on pavotheme
		$this->document->addStyle('catalog/view/theme/default/stylesheet/bootstrap.css');
		$this->document->addScript('catalog/view/javascript/jquery/bootstrap/bootstrap.min.js');
		/*End*/

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->mdata['base'] = $this->config->get('config_ssl');
		} else {
			$this->mdata['base'] = $this->config->get('config_url');
		}

		if( isset($setting['description'][$this->config->get('config_language_id')]) ) {
			$this->mdata['message'] = html_entity_decode($setting['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
		}else {
			$this->mdata['message'] = '';
		}
		$this->mdata['button_cart'] = $this->language->get('button_cart');
		$this->mdata['limit'] = isset($setting['limit'])?(int)$setting['limit']:10;
		$this->mdata['width'] = $setting['width'];
		$this->mdata['height'] = $setting['height'];
		$this->mdata['cols']   = isset($setting['cols'])?(int)$setting['cols']:3;
		$this->mdata['itemsperpage']   = (int)$setting['itemsperpage'];

		$today_deal = (int)$setting['today_deal'];

		//get deal_type
		$deal_type = 2;
		$breadcrumbs_deals_url = '';
		if (isset($this->request->get['filter_deal'])) {
			$deal_type = $this->request->get['filter_deal'];
			$breadcrumbs_deals_url .= '&filter_deal=' . $deal_type;
		}

		$this->getDataSelectedBox();
		$this->getCategory();
		// echo  '<pre>'.print_r( $today_deal, 1 );die; 
		$active = false;
		$active1 = false;
		$active2 = false;
		if ($deal_type == 1) { //today
			$this->document->setTitle($this->language->get('today_deals_title'));
			$deal_name = "today";
			if($today_deal == 99) {
				$start_date = date("Y-m-d");
				$end_date = $setting['time_end'];
			} elseif ($today_deal == 88) { // in today
				$start_date = date("Y-m-d");
				$end_date = date("Y-m-d");
				$deal_type = 99;
			} else {
				$start_date = date("Y-m-d");
				date('Y-m-d', strtotime("+".$today_deal." days"));
				$end_date = date('Y-m-d', strtotime("+".$today_deal." days"));
			}
			$breadcrumbs_deals = $this->language->get('today_deals_title');
			$active = true;

		} elseif ($deal_type == 2) {//available
			$this->document->setTitle($this->language->get('today_deals_title'));
			$deal_name = "available";
			$start_date = date("Y-m-d");
			$end_date = date("Y-m-d");
			$breadcrumbs_deals = $this->language->get('available_deals_title');
			$active1 = true;
		} else { //pass
			$this->document->setTitle($this->language->get('pass_deals_title'));
			$deal_name = "pass";
			$start_date = date("0000-00-00");
			$end_date = date("Y-m-d");
			$breadcrumbs_deals = $this->language->get('pass_deals_title');
			$active2 = true;
		}


		if ($idcat == 0){
			$ids = null;
		} else {
			$ids = explode("_", $idcat);
		}

		//Get data model
		$data = array(
			'deal_type' => $deal_type,
			'start_date' => $start_date,
			'end_date' => $end_date,
			'filter_categories' => $ids,
			'sort'=> $sort,
			'order'=> $order,
			'start' => ($page - 1) * $limit,
			'limit'=> $limit
		);

		$product_total = count($this->model_pavdeals_product->getProductSpecialsForDeals($data, false));
		$results = $this->model_pavdeals_product->getProductSpecialsForDeals($data);
		$products = array();
		foreach ($results as $result) {
			$products[] = $this->getItemDeal($result, $setting);
		}

		$url = '';
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		if (isset($this->request->get['idcat'])) {
			$url .= '&idcat=' . $this->request->get['idcat'];
		}

		$pagination = new Pagination();
		$pagination->total = $product_total;
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type . $url . '&page={page}');

		$this->mdata['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));


		$this->mdata['pagination'] = $pagination->render();
		$this->mdata['sort'] = $sort;
		$this->mdata['order'] = $order;
		$this->mdata['limit'] = $limit;
		$this->mdata['page'] = $page;



		$this->mdata['breadcrumbs'][] = array(
			'text'	  => $breadcrumbs_deals,
			'href'	  => $this->url->link('pavdeals/deals', $breadcrumbs_deals_url),
			'separator' => $this->language->get('text_separator')
		);

		//Assign data to template
		$this->mdata['products'] = $products;
		$this->mdata['heading_title'] = $this->language->get($deal_name."_deals_title");


		$head_titles = array(
			// 0 => array(
			// 	'text' => $this->language->get('today_deals_title'),
			// 	'href' => $this->url->link('pavdeals/deals', 'filter_deal=1'),
			// 	'active' => $active,
			// 	'status' => 1
			// ),
			1 => array(
				'text' => $this->language->get('today_deals_title'),
				'href' => $this->url->link('pavdeals/deals', 'filter_deal=2'),
				'active' => $active1,
				'status' => $setting['enable_available'],
			),
			2 => array(
				'text' => $this->language->get('pass_deals_title'),
				'href' => $this->url->link('pavdeals/deals', 'filter_deal=3'),
				'active' => $active2,
				'status' => $setting['enable_pass'],
			),
		);
		if(isset($setting['enable_available']) && !$setting['enable_available']){
			unset($head_titles[1]);
		}
		if(isset($setting['enable_pass']) && !$setting['enable_pass']){
			unset($head_titles[2]);
		}
		$this->mdata['head_titles'] = $head_titles;

		$this->mdata['module'] = '';
		
		$template = 'pavdeals/list';
		

		$this->mdata['objlang'] = $this->language;
		$this->mdata['objurl'] = $this->url;
		//Children layout
		$this->mdata['column_left'] = $this->load->controller('common/column_left');
		$this->mdata['column_right'] = $this->load->controller('common/column_right');
		$this->mdata['content_top'] = $this->load->controller('common/content_top');
		$this->mdata['content_bottom'] = $this->load->controller('common/content_bottom');
		$this->mdata['footer'] = $this->load->controller('common/footer');
		$this->mdata['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view($template, $this->mdata));
  	}

	//getItemDeal
	public function getItemDeal($product = null, $setting = array()){

		if(is_numeric($product)){
			$product = $this->model_catalog_product->getProduct((int)$product);
		}
		$deal = $this->model_pavdeals_product->getDeal($product);
		if(!$deal)
			return false;

		$order_status_id = isset($setting['order_status_id'])?(int)$setting['order_status_id']:5;
		$bought = $this->model_pavdeals_product->getTotalBought($deal['product_id'], $order_status_id );
		$bought = empty($bought)?0:$bought;
		$save_price = (float)$deal['price'] - (float)$deal['special'];
		$discount = round(($save_price/$deal['price'])*100);

		$save_price = $this->currency->format($this->tax->calculate( $save_price,      $deal['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency'] );

		if ($deal['image'] && isset($setting['width']) && $setting['height']) {
			$image = $this->model_tool_image->resize($deal['image'], $setting['width'], $setting['height']);
		} else {
			$image = false;
		}

		// version 2.2
		if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
			$price = $this->currency->format($this->tax->calculate($deal['price'], $deal['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
		} else {
			$price = false;
		}

		if ((float)$deal['special']) {
			$special = $this->currency->format($this->tax->calculate($deal['special'], $deal['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
		} else {
			$special = false;
		}

		if ($this->config->get('config_tax')) {
			$tax = $this->currency->format((float)$deal['special'] ? $deal['special'] : $deal['price'], $this->session->data['currency']);
		} else {
			$tax = false;
		}
		// version 2.2 end edit


		if ($this->config->get('config_review_status')) {
			$rating = $deal['rating'];
		} else {
			$rating = false;
		}
		$date_end_string = isset($deal['date_end'])?$deal['date_end']:"";

		$product = array(
			'product_id' => $deal['product_id'],
			'deal_discount' 	 => $discount,

			'discount' 	 => '-'.$discount.'%',

			'bought'	 => $bought,
			'thumb'   	 => $image,
			'name'		 => $deal['name'],
			'quantity'	 => $deal['quantity'],
			'tax'        => $tax,
			'price'   	 => $price,
			'special' 	 => $special,
			'rating'	 => $rating,
			'save_price' => $save_price,
			'date_end_string' => $date_end_string,
			'date_end'	 => explode("-", $date_end_string),
			'description' => utf8_substr(strip_tags(html_entity_decode($deal['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
			'reviews'	=> sprintf($this->language->get('text_reviews'), (int)$deal['reviews']),
			'href'		 => $this->url->link('product/product', 'product_id=' . $deal['product_id']),
		);
		return $product;
	}

	public function getCategory() {
		if (isset($this->request->get['filter_deal'])) {
			$deal_type = $this->request->get['filter_deal'];
		} else {
			$deal_type = 1;
		}
		if (isset($this->request->get['idcat'])) {
			$this->mdata['category_id'] = $this->request->get['idcat'];
		} else {
			$this->mdata['category_id'] = 0;
		}

		//category default
		$this->mdata['href_default'] = $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type);

		$url = '';
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}


		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			$children_data = array();
			$children = $this->model_catalog_category->getCategories($category['category_id']);
			foreach ($children as $child) {
				$data = array(
					'filter_category_id'  => $child['category_id'],
					'filter_sub_category' => true
				);
				$children_data[] = array(
					'category_id' => $child['category_id'],
					'child_id'    => $category['category_id'] . '_' . $child['category_id'],
					'name'        => $child['name'],
					'href'        => $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type . $url . '&idcat=' . $category['category_id'] . '_' . $child['category_id'])
				);
			}
			$this->mdata['categories'][] = array(
				'category_id' => $category['category_id'],
				'name'        => $category['name'],
				'children'    => $children_data,
				'href'        => $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type . $url . '&idcat=' . $category['category_id'])
			);
		}
	}

	public function getDataSelectedBox(){
		if (isset($this->request->get['filter_deal'])) {
			$deal_type = $this->request->get['filter_deal'];
		} else {
			$deal_type = 1;
		}
		$url = '';
		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}
		if (isset($this->request->get['idcat'])) {
			$url .= '&idcat=' . $this->request->get['idcat'];
		}
		//sort select box
		$this->mdata['sorts'] = array();

		$this->mdata['sorts'][] = array(
			'text'  => $this->language->get('text_default'),
			'value' => 'p.sort_order-ASC',
			'href'  => $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type . '&sort=p.sort_order&order=ASC' . $url)
		);
		$this->mdata['sorts'][] = array(
			'text'  => $this->language->get('text_name_asc'),
			'value' => 'pd.name-ASC',
			'href'  => $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type . '&sort=pd.name&order=ASC' . $url)
		);
		$this->mdata['sorts'][] = array(
			'text'  => $this->language->get('text_name_desc'),
			'value' => 'pd.name-DESC',
			'href'  => $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type . '&sort=pd.name&order=DESC' . $url)
		);
		$this->mdata['sorts'][] = array(
			'text'  => $this->language->get('text_price_asc'),
			'value' => 'p.price-ASC',
			'href'  => $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type . '&sort=p.price&order=ASC' . $url)
		);
		$this->mdata['sorts'][] = array(
			'text'  => $this->language->get('text_price_desc'),
			'value' => 'p.price-DESC',
			'href'  => $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type . '&sort=p.price&order=DESC' . $url)
		);
		if ($this->config->get('config_review_status')) {
			$this->mdata['sorts'][] = array(
				'text'  => $this->language->get('text_rating_desc'),
				'value' => 'rating-DESC',
				'href'  => $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type . '&sort=rating&order=DESC' . $url)
			);
			$this->mdata['sorts'][] = array(
				'text'  => $this->language->get('text_rating_asc'),
				'value' => 'rating-ASC',
				'href'  => $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type . '&sort=rating&order=ASC' . $url)
			);
		}
		$this->mdata['sorts'][] = array(
			'text'  => $this->language->get('text_model_asc'),
			'value' => 'p.model-ASC',
			'href'  => $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type . '&sort=p.model&order=ASC' . $url)
		);
		$this->mdata['sorts'][] = array(
			'text'  => $this->language->get('text_model_desc'),
			'value' => 'p.model-DESC',
			'href'  => $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type . '&sort=p.model&order=DESC' . $url)
		);

		$url = '';
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		if (isset($this->request->get['idcat'])) {
			$url .= '&idcat=' . $this->request->get['idcat'];
		}

		//limit
		$this->mdata['limits'] = array();
		$limits = array_unique(array(5, 10, 25, 50, 75, 100));
		sort($limits);
		foreach($limits as $limits){
			$this->mdata['limits'][] = array(
				'text'  => $limits,
				'value' => $limits,
				'href'  => $this->url->link('pavdeals/deals', 'filter_deal=' . $deal_type . $url . '&limit=' . $limits)
			);
		}

	}
}
?>