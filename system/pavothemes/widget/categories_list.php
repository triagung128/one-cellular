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
class PtsWidgetCategories_list extends PtsWidgetPageBuilder {

	public $name = 'categories_list';
	public $group = 'product';
    public $ismenu =  false;

	public static function getWidgetInfo(){
		return array('label' => ('Categories List'), 'explain' => 'Show Category to Front Office', 'group' => 'opencart'  );
	}

	public function renderForm( $args, $data ){

		$helper = $this->getFormHelper();

		$orders = array(
            0 => array('value' => 'date_add', 'name' => $this->l('Date Add')),
            1 => array('value' => 'date_add DESC', 'name' => $this->l('Date Add DESC')),
            2 => array('value' => 'name', 'name' => $this->l('Name')),
            3 => array('value' => 'name DESC', 'name' => $this->l('Name DESC')),
            4 => array('value' => 'quantity', 'name' => $this->l('Quantity')),
            5 => array('value' => 'quantity DESC', 'name' => $this->l('Quantity DESC')),
            6 => array('value' => 'price', 'name' => $this->l('Price')),
            7 => array('value' => 'price DESC', 'name' => $this->l('Price DESC'))
        );

        /*Widget Form Config*/
		$this->fields_form[1]['form'] = array(
            'legend' => array(
                'title' => $this->l('Widget Form.'),
            ),
            'input' => array(
				array(
                    'type' => 'text',
                    'label' => $this->l('Categories'),
                    'name' => 'catids',
                    'desc' => '',
                    'default' => '3,4,5,6,7,8',
                ),
                 array(
                'type'  => 'image',
                'label' => $this->l('Icon'),
                'name'  => 'banner_img',
                'default'=> '',
                'desc'  => 'Put image folder in the image folder ROOT_SHOP_DIR/image/'
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
                    'type' => 'text',
                    'label' => $this->l('View More Link'),
                    'name' => 'link',
                    'desc' => '',
                    'default' => '#',
                ),
                array(
                    'type' => 'select',
                    'label' => $this->l( 'Background Color' ),
                    'name' => 'background',
                    'options' => array(  'query' => array(
                        array('id' => '', 'name' => $this->l('None')),
                        array('id' => 'bg-warning', 'name' => $this->l('Warning')),
                        array('id' => 'bg-info', 'name' => $this->l('Info')),
                        array('id' => 'bg-danger', 'name' => $this->l('Danger')),
                        array('id' => 'bg-success', 'name' => $this->l('Success')),
                    ),
                    'id' => 'id',
                    'name' => 'name' ),
                    'default' => "",
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

	public function renderContent( $args, $setting ){

        $languageID = $this->config->get('config_language_id');
        $this->load->model('catalog/category');
        $this->load->language('module/themecontrol');
		$t  = array(
            'widget_name' => 'categories',
            'show_title' => 1,
            'addition_cls' => 'prefix_class',
            'catids' => '20,18,25',
            'link' => '#',
            'height'  => '16',
            'width'   => '16'
		);

		$setting = array_merge( $t, $setting );

		$catids = explode(",", $setting['catids']);

        $categories = array();
        foreach ($catids as $catid) {
        	$category = $this->model_catalog_category->getCategory($catid);
            if(isset($category['category_id'])) {
                $categories[$catid] = array(
                    'category_id' => $category['category_id'],
                    'name'        => $category['name'],
                    'href'        => $this->url->link('product/category', 'path=' . $category['category_id']),
                );
            }
        }
		$setting['categories_list'] = $categories;

        $languageID = $this->config->get('config_language_id');
        $setting['heading_title'] = isset($setting['widget_title_'.$languageID])?$setting['widget_title_'.$languageID]:'';

        $setting['view_more'] = $this->language->get("text_viewmore");


         // banner
        $placeholder = $this->model_tool_image->resize('no_image.png', 16, 16);
        $banner = $this->model_tool_image->resize($setting['banner_img'], $setting['width'], $setting['height']);


        if ($setting['banner_img'] && file_exists(DIR_IMAGE . $setting['banner_img'])) {
            $image = $banner;
        } else {
            $image = $placeholder;
        }

        $setting['icon'] = $image;

		$output = array(
            'type' => 'categories_list',
            'data' => $setting,
        );

		return $output;
	}
}
?>