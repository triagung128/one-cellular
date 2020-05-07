<?php
/******************************************************
 * @package Pav Megamenu module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2012 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/
class ControllerModulePavverticalmenu extends Controller {

	private $mdata = array();

	public function index($setting) {
		static $module = 0;

		$this->load->model('catalog/product'); 
		$this->load->model('tool/image');
		$this->load->model( 'verticalmenu/verticalmenu' );
		$this->load->model('setting/setting');


		// fix bug version 2.2.0.0
		$config_theme = $this->config->get('theme_default_directory');
		$this->mdata['objlang'] = $this->language;
		$this->load->language('module/themecontrol');

		$this->load->language('module/pavverticalmenu');
		
		$this->mdata['button_cart'] = $this->language->get('button_cart');
		if (file_exists('catalog/view/theme/' . $config_theme . '/stylesheet/pavverticalmenu/style.css')) {
			$this->document->addStyle('catalog/view/theme/' . $config_theme . '/stylesheet/pavverticalmenu/style.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/pavverticalmenu/style.css');
		}
				
		$this->mdata['module'] = $module++;
		$params = $this->model_setting_setting->getSetting( 'pavverticalmenu_params' );
		if( isset($params['params']) && !empty($params['params']) ){
	 		$params = json_decode( $params['params'] );
	 	}

		// Get Config store_id
		$store_id = $this->config->get('config_store_id');
		$this->mdata['store_id'] = $store_id;

		$parent = '1';
		$this->mdata['treemenu'] = $this->model_verticalmenu_verticalmenu->getTree( $parent, true, $params, $store_id );

		$template = 'module/pavverticalmenu';
		return $this->load->view($template, $this->mdata);
	}

	public function ajxgenmenu( ){ 
 	 	
	}

	public function renderwidget(){

		$this->load->model( 'verticalmenu/widget' );
		$this->model_verticalmenu_widget->loadWidgets();

		if( isset($this->request->post['widgets']) ){
	
			$widgets = $this->request->post['widgets'];
			$widgets = explode( '|wid-', '|'.$widgets );
			if( !empty($widgets) ){
				unset( $widgets[0] );
				
				$output = '';
				foreach( $widgets as $wid ){
					$output .= $this->model_verticalmenu_widget->renderButton( $wid );
				}

				echo $output;
			}
		 
		}
		exit();
	}
}
?>