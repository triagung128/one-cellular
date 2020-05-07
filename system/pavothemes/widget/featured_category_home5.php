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

class PtsWidgetFeatured_category_home5 extends PtsWidgetPageBuilder {

		public $name = 'featured_category_home5';
		public $group = 'product';
		public $usemeneu = false;

		public static function getWidgetInfo(){
			return array('label' => ('Featured Category Home 5'), 'explain' => 'Featured Category box item', 'group' => 'product'  );
		}

		public function renderForm( $args, $data ){

			$helper = $this->getFormHelper();

			$styles = array(
					array('label'=>'Default', 'value'=>'style'),
					array('label'=>'Home 5 ( Only show 5 items )', 'value'=>'home5'),
				);


			$this->fields_form[1]['form'] = array(
	            'legend' => array(
	                'title' => $this->l('Widget Form.'),
	            ),
	            'input' => array(
	            	array(
	                    'type'  => 'featured-category-item',
	                    'label' => $this->l(''),
	                    'name'  => 'categories_featured',
	                    'default'=> '',
	                    'desc'	=> 'Add List Featured Category',
	                ),


					// width && height
	                array(
	                    'type'  => 'text',
	                    'label' => $this->l('Width'),
	                    'name'  => 'image_width',
	                    'default'=> 200,
	                    'desc'	=> '',
	                ),
	                array(
	                    'type'  => 'text',
	                    'label' => $this->l('Height'),
	                    'name'  => 'image_height',
	                    'default'=> 200,
	                    'desc'	=> '',
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

		public function renderContent(  $args, $setting ){
			$this->load->model('catalog/category');
			$this->load->model('catalog/product');
			$this->load->language('module/themecontrol');
			$default = array(
					'widget_name' => '',
					'show_title' => 1,
					'addition_cls' => '',
					'image_width' => 200,
					'image_height' => 200,
					'categories_featured' => array(),
				);
			$setting = array_merge( $default, $setting );

			// THEME CONFIG
			$config = $this->registry->get("config");
			$setting['themename'] = $config->get("theme_default_directory");

			$category = isset($setting['categories_featured']) ? $setting['categories_featured'] : array();

			$data = array();
			
			$filter_data = $this->model_catalog_category->getCategory($category['id']);

			$datap = array(
				'filter_category_id'  => $filter_data['category_id'],
				'filter_sub_category' => true
			);
			$product_total = $this->model_catalog_product->getTotalProducts($datap);

			$data = array(
				'items' => $product_total." ".$this->language->get('text_items'),
				'image' => $this->model_tool_image->resize($category['image'], $setting['image_width'], $setting['image_height']),
				'category_id' => $filter_data['category_id'],
				'name' => $filter_data['name'],
				'href' => $this->url->link('product/category', 'path=' . $filter_data['category_id']),
			);
		
			$setting['category'] = $data;

			$languageID = $this->config->get('config_language_id');
        	$setting['heading_title'] = isset($setting['widget_title_'.$languageID])?$setting['widget_title_'.$languageID]:'';


			$output = array('type'=>'image','data' => $setting );

	  		return $output;
		}
	}
?>