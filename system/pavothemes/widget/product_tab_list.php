<?php
class PtsWidgetproduct_tab_list extends PtsWidgetPageBuilder {

		public $name = 'product_tab_list';
		public $group = 'product';
		public $usemeneu = false;
		
		public static function getWidgetInfo(){
			return array('label' => ('Product Tab list'), 'explain' => 'products tab categories', 'group' => 'product'  );
		}


		public function renderForm( $args, $data ){

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
	                ),
	            	array(
	                    'type'  => 'text',
	                    'label' => $this->l('Limit'),
	                    'name'  => 'limit',
	                    'default'=> '8',
	                ),
	                array(
	                    'type'  => 'text',
	                    'label' => $this->l('Items Per Page'),
	                    'name'  => 'itemsperpage',
	                    'default'=> '4',
	                ),
	                array(
	                    'type'  => 'text',
	                    'label' => $this->l('Columns'),
	                    'name'  => 'cols',
	                    'default'=> '4',
	                ),
	                array(
	                    'type'  => 'text',
	                    'label' => $this->l('width'),
	                    'name'  => 'image_width',
	                    'default'=> '400',
	                ),
	                array(
	                    'type'  => 'text',
	                    'label' => $this->l('height'),
	                    'name'  => 'image_height',
	                    'default'=> '400',
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
				'image_height'  => '153',
				'image_width'   => '153',
				'limit'			=> 8,
				'itemsperpage'	=> 4,
				'cols'			=> 4,
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

			$tablist = array();

			foreach ($categories as $category) {
				$filter_data = array(
					'filter_category_id' => $category['category_id'],
					'filter_filter'      => "",
					'sort'               => "p.sort_order",
					'order'              => "DESC",
					'start'              => 0,
					'limit'              => $setting['limit'],
				);

				$results = $this->model_catalog_product->getProducts($filter_data);

				$tablist[$category['category_id']] = $this->getProducts($results, $setting);
			}

			// list product
			$setting['tablist'] = $tablist;


			$output = array('type'=>'product','data' => $setting);
			return $output;
		}

		// get list products by category id
		private function getProducts( $results, $setting ){
			$data = array();
			if ($results) {
				foreach ($results as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['image_width'], $setting['image_height']);
					}

					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$price = false;
					}
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$special = false;
					}
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
					} else {
						$tax = false;
					}
					if ($this->config->get('config_review_status')) {
						$rating = $result['rating'];
					} else {
						$rating = false;
					}

					$data[] = array(
						'product_id'  => $result['product_id'],
						'thumb'       => $image,
						'name'        => $result['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
					);
				}
			}
			return $data;
		}
	}
?>