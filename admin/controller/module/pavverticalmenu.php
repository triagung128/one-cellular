<?php
/******************************************************
 * @package Pav verticalmenu module for Opencart 1.5.x
 * @version 2.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Steptember 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/
require_once(DIR_SYSTEM . 'pavothemes/loader.php');	
/**
 * class ControllerModulePavverticalmenu 
 */
class ControllerModulePavverticalmenu extends Controller {

	private $error = array(); 
	private $moduleName = 'pavverticalmenu';
	private $mdata = array();

	public function __construct($registry) {
		$this->registry = $registry;
		// check tables created or not
		$this->load->model('verticalmenu/verticalmenu');	
		
	}

	public function install() {
		$this->model_verticalmenu_verticalmenu->install();
	}

	public function index() {   
		
		$this->load->language('module/pavverticalmenu');
		
		$this->document->setTitle( strip_tags($this->language->get('heading_title')) );
		$this->document->addStyle('view/stylesheet/pavverticalmenu.css');
		$this->document->addStyle('view/javascript/jquery/ui/jquery-ui.min.css');
		$this->document->addScript('view/javascript/jquery/ui/jquery-ui.min.js');
		$this->document->addScript('view/javascript/pavverticalmenu/jquerycookie.js');
		$this->document->addScript('view/javascript/pavverticalmenu/jquery.nestable.js');
		$this->load->model('verticalmenu/verticalmenu');
		
		$this->load->model('setting/setting');
		$this->load->model('extension/module');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST')  && !empty($this->request->post) ) {

			// Save setting module
			if(isset($this->request->post['pavverticalmenu_module'])){
				if (!isset($this->request->get['module_id'])) {
					$this->model_extension_module->addModule('pavverticalmenu', $this->request->post['pavverticalmenu_module']);
					$this->response->redirect( $this->url->link('module/pavverticalmenu', 'token=' . $this->session->data['token'], 'SSL') );
				} else {

					$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post['pavverticalmenu_module']);
					$this->response->redirect( $this->url->link('module/pavverticalmenu', 'token=' . $this->session->data['token'].'&module_id='.$this->request->get['module_id'], 'SSL') );
				}
			}

			// Save setting menu-item
			if (!$this->user->hasPermission('modify', 'module/'.$this->moduleName)) {
				$this->error['warning'] = $this->language->get('error_permission');
			}else { 
				$id = 0;
				$this->load->model('verticalmenu/verticalmenu');
				
				//$this->model_setting_setting->editSetting('pavverticalmenu', $this->request->post);	
				// Get Hidden store_id Value
				$verticalmenu = $this->request->post['verticalmenu'];

				$store_param = isset($verticalmenu['store_id'])?'&store_id='.$verticalmenu['store_id']:'';


				if( $this->validate() ) {
					if($this->request->post['save_mode']=='save-edit'){
						if(!empty($verticalmenu['verticalmenu_id'])){
							$id = $this->model_verticalmenu_verticalmenu->editData( $this->request->post );
						}	
					} else {
						$id = $this->model_verticalmenu_verticalmenu->editData( $this->request->post );
					}
				}
				
				// Delete Cagtegories
				if($this->request->post['save_mode']=='delete-categories'){
					$this->model_verticalmenu_verticalmenu->deletecategories($verticalmenu['store_id']);
				}
				// Import Categories
				if($this->request->post['save_mode']=='import-categories'){
					$this->model_verticalmenu_verticalmenu->importCategories($verticalmenu['store_id']);
				}
				// Save Edit
				$this->session->data['success'] = $this->language->get('text_success');
				if( isset($id) && $this->request->post['save_mode']=='save-edit'){
					$this->response->redirect($this->url->link('module/pavverticalmenu', 'id='.$id.'&token=' . $this->session->data['token'].$store_param, 'SSL'));
				} else {
					$this->response->redirect($this->url->link('module/pavverticalmenu', 'token=' . $this->session->data['token'].$store_param, 'SSL'));
				}
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'].$store_param, 'SSL'));
			}
		}
				
		$this->mdata['heading_title'] = $this->language->get('heading_title');
		$this->mdata['text_enabled'] = $this->language->get('text_enabled');
		$this->mdata['text_disabled'] = $this->language->get('text_disabled');
		$this->mdata['text_content_top'] = $this->language->get('text_content_top');
		$this->mdata['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->mdata['text_column_left'] = $this->language->get('text_column_left');
		$this->mdata['text_column_right'] = $this->language->get('text_column_right');

		$this->mdata['entry_banner'] = $this->language->get('entry_banner');
		$this->mdata['entry_dimension'] = $this->language->get('entry_dimension'); 
		$this->mdata['entry_layout'] = $this->language->get('entry_layout');
		$this->mdata['entry_position'] = $this->language->get('entry_position');
		$this->mdata['entry_status'] = $this->language->get('entry_status');
		$this->mdata['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->mdata['button_save'] = $this->language->get('button_save');
		$this->mdata['button_cancel'] = $this->language->get('button_cancel');
		$this->mdata['entry_module_name'] = $this->language->get('entry_module_name');
		$this->mdata['button_remove'] = $this->language->get('button_remove');
	
		$this->mdata['extensions'] = $this->module("pavverticalmenu");

		$this->_breadcrumbs();

		// Form Module
		$this->_dataModule();

		// Get Data Stores
		$this->mdata['stores'] = $this->_getStores();
		if (isset($this->request->get['store_id'])){
			$store_id = $this->request->get['store_id'];
			$store_param = "&store_id=".$store_id;
		} else {
			$store_id = 0;
			$store_param = "";
		}
		$this->mdata['store_id'] = $store_id;
		
		// Alert Warning
 		if (isset($this->error['warning'])) {
			$this->mdata['error_warning'] = $this->error['warning'];
		} else {
			$this->mdata['error_warning'] = '';
		}
		
		if (isset($this->error['dimension'])) {
			$this->mdata['error_dimension'] = $this->error['dimension'];
		} else {
			$this->mdata['error_dimension'] = array();
		}
		
		// Action Link
		$this->mdata['action'] = $this->url->link('module/pavverticalmenu', 'token=' . $this->session->data['token'].$store_param, 'SSL');
		$this->mdata['actionGetTree'] = $this->url->link('module/pavverticalmenu/gettree', 'token=' . $this->session->data['token'].$store_param, 'SSL');
		$this->mdata['actionDel'] = $this->url->link('module/pavverticalmenu/delete', 'token=' . $this->session->data['token'].$store_param, 'SSL');
		$this->mdata['actionGetInfo'] = $this->url->link('module/pavverticalmenu/info', 'token=' . $this->session->data['token'].$store_param, 'SSL');
		$this->mdata['updateTree'] = $this->url->link('module/pavverticalmenu/update', 'root=1&token=' . $this->session->data['token'].$store_param, 'SSL');
		$this->mdata['liveedit_url'] = $this->url->link('module/pavverticalmenu/liveedit', 'root=1&token=' . $this->session->data['token'].$store_param, 'SSL');
		$this->mdata['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'].$store_param, 'SSL');
		
		// Get Data Widgets
		$this->load->model('verticalmenu/widget');
		$this->mdata['widgets'] = $this->model_verticalmenu_widget->getWidgets();


		// Get Data currentID
		$this->mdata['currentID'] = 0 ;
		if( isset($this->request->get['id'] ) ){
			$this->mdata['currentID'] = $this->request->get['id'];
		}

		// Get Data Tree
		$this->mdata['tree'] = $this->model_verticalmenu_verticalmenu->getTree( null, $store_id );
		
		$this->info();

		// Render Template
		$this->mdata['header'] = $this->load->controller('common/header');
		$this->mdata['column_left'] = $this->load->controller('common/column_left');
		$this->mdata['footer'] = $this->load->controller('common/footer');
		$template = 'module/pavverticalmenu/pavverticalmenu.tpl';
		$this->response->setOutput($this->load->view($template, $this->mdata));
	}

	public function ndelete(){
		$this->load->model('extension/module');
		$this->load->language('module/pavverticalmenu');
		if (isset($this->request->get['module_id'])) {
			$this->model_extension_module->deleteModule($this->request->get['module_id']);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->response->redirect($this->url->link('module/pavverticalmenu', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}


	public function _dataModule(){
		// DATA
		if (isset($this->request->get['module_id'])) {
			$module_id = $this->request->get['module_id'];
			$url = '&module_id='.$module_id;
		} else {
			$module_id = '';
			$url = '';
		}
		$this->mdata['module_id'] = $module_id;

		// action
		$this->mdata['delete'] = $this->url->link('module/pavverticalmenu/ndelete', 'token=' . $this->session->data['token'].$url, 'SSL');
		$this->mdata['maction'] = $this->url->link('module/pavverticalmenu', 'token=' . $this->session->data['token'].$url, 'SSL');

		$this->mdata['extensions'] = $this->module("pavverticalmenu");

		// GET DATA SETTING
		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}

		$this->mdata['module'] = array();
		// status
		if (isset($this->request->post['pavverticalmenu_module']['status'])) {
			$this->mdata['module']['status'] = $this->request->post['pavverticalmenu_module']['status'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['status'] = $module_info['status'];
		} else {
			$this->mdata['module']['status'] = 1;
		}
		// name
		if (isset($this->request->post['pavverticalmenu_module']['name'])) {
			$this->mdata['module']['name'] = $this->request->post['pavverticalmenu_module']['name'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['name'] = $module_info['name'];
		} else {
			$this->mdata['module']['name'] = '';
		}
	}

	// tab module
	public function module($extension){
		$module_data = array();
		$this->load->model('extension/extension');
		$this->load->model('extension/module');
		$extensions = $this->model_extension_extension->getInstalled('module');
		$modules = $this->model_extension_module->getModulesByCode($extension);
		foreach ($modules as $module) {
			$module_data[] = array(
				'module_id' => $module['module_id'],
				'name'      => $module['name'],
				'edit'      => $this->url->link('module/pavverticalmenu', 'token=' . $this->session->data['token'] . '&module_id=' . $module['module_id'], 'SSL'),
			);
		}
		$ex[] = array(
			'name'      => $this->language->get("create_module"),
			'module'    => $module_data,
			'edit'      => $this->url->link('module/pavverticalmenu', 'token=' . $this->session->data['token'], 'SSL')
		);
		return $ex;
	}


	public function _breadcrumbs(){
		$this->mdata['breadcrumbs'] = array();

   		$this->mdata['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->mdata['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->mdata['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/pavverticalmenu', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
	}

	public function _getStores(){
		$this->load->model('setting/store');
		$action = array();
		$action[] = array(
			'text' => $this->language->get('text_edit'),
			'href' => $this->url->link('setting/setting', 'token=' . $this->session->data['token'], 'SSL')
		);
		$store_default = array(
			'store_id' => 0,
			'name'     => $this->config->get('config_name') . $this->language->get('text_default'),
			'url'      => HTTP_CATALOG,
		);
		$stores = $this->model_setting_store->getStores();
		array_unshift($stores, $store_default);
		foreach ($stores as &$store) {
			$url = '';
			if ($store['store_id'] > 0 ) {
				$url = '&store_id='.$store['store_id'];
			}
			$store['option'] = $this->url->link('module/pavverticalmenu', $url.'&token=' . $this->session->data['token'], 'SSL');
		}
		return $stores;
	}

	/**
	 * Delete Mega Menu Action
	 */
	public function delete(){
		if (!$this->user->hasPermission('modify', 'module/'.$this->moduleName)) {
			$this->error['warning'] = $this->language->get('error_permission');
			die(  $this->error['warning'] );
		}
		// Get Rquest store_id
		$store_id = isset($this->request->get['store_id'])?$this->request->get['store_id']:0;
		$store_param = ($store_id == 0)?'':'&store_id='.$store_id;
		if( isset($this->request->get['id']) ){
			$this->load->model('verticalmenu/verticalmenu');
			$this->model_verticalmenu_verticalmenu->delete( (int)$this->request->get['id'], $store_id );
			
		}
		$this->response->redirect($this->url->link('module/pavverticalmenu', 'token=' . $this->session->data['token'].$store_param, 'SSL'));
	}

	/**
	 * Update Action
	 */
	public function update(){
		if (!$this->user->hasPermission('modify', 'module/'.$this->moduleName)) {
			$this->error['warning'] = $this->language->get('error_permission');
			die(  $this->error['warning'] );
		}
		$data =  ( ($this->request->post['list']) );
		$root = $this->request->get['root'];
	
		$this->load->model('verticalmenu/verticalmenu');
		$this->model_verticalmenu_verticalmenu->massUpdate( $data, $root  );

		$json['success'] = 'success';
		$this->response->setOutput(json_encode($json));
	}

	/**
	 * Infor Action to Get Mega menu information by id
	 */
	public function info(){

		$this->mdata["objlang"] = $this->language;
		$this->mdata["objurl"] = $this->url;

		$id=0;
		
		if( isset($this->request->post) && isset($this->request->post['id']) ){
			$id = (int)$this->request->post['id'] ;
		}else if( isset($this->request->get["id"]) ){
			$id = (int)$this->request->get['id'];
		}

		$default = array(
			'verticalmenu_id'=>'',
			'title' => '',
			'parent_id'=> '',
			'image' => '',
			'is_group'=>'',
			'width'=>'12',
			'menu_class'=>'',
			'submenu_colum_width'=>'',
			'is_group'=>'',
			'submenu_width'=>'12',
			'column_width'=>'200',
			'submenu_column_width'=>'',
			'colums'=>'1',
			'type' => '',
			'item' => '',
			'is_content'=>'',
			'show_title'=>'1',
			'type_submenu'=>'',
			'level_depth'=>'',
			'status'    => '',
			'position'  => '',
			'show_sub' => '',
			'url' => '',
			'targer' => '',
			'level'=> '',
			'content_text'=>'',
			'submenu_content'=>'',
			'verticalmenu-information'=>'',
			'verticalmenu-product'=>'',
			'verticalmenu-category'=>'',
			'published' => 1,
			'verticalmenu-manufacturer'=>'',
			'widget_id'=> 0
		);
		
		$this->load->language('module/pavverticalmenu');
		$this->load->model('verticalmenu/verticalmenu');
		$this->load->model('catalog/product');
		$this->load->model('catalog/category');
		$this->load->model('catalog/manufacturer');
		$this->load->model('catalog/information');
		$this->load->model('localisation/language');
		$this->load->model('tool/image');

		$this->mdata['no_image'] = $this->model_tool_image->resize('no_image.png', 16, 16);

		$this->mdata['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);
	
		$this->mdata['entry_image'] = 'Image:';
		$this->mdata['text_image_manager'] = $this->language->get('text_image_manager');
		$this->mdata['text_clear'] = $this->language->get('text_clear');		
		$this->mdata['text_browse'] = $this->language->get('text_browse');
		$this->mdata['tab_module'] = $this->language->get('tab_module');
		$this->mdata['text_none'] = $this->language->get('text_none');
		$this->mdata['yesno'] = array( '0' => $this->language->get('text_no'),'1'=> $this->language->get('text_yes') );
		$this->mdata['token'] = $this->session->data['token'];
		$this->mdata['languages'] = $this->model_localisation_language->getLanguages();
		$this->mdata['informations'] = $this->model_catalog_information->getInformations();
		
		$menu = $this->model_verticalmenu_verticalmenu->getInfo( $id );
		$menu = array_merge( $default, $menu );
		
		// Get Rquest store_id
		$store_id = isset($this->request->get['store_id'])?$this->request->get['store_id']:0;
		
		$this->mdata['menu'] = $menu;  
		$this->mdata['menus'] = $this->model_verticalmenu_verticalmenu->getDropdown(null, $menu['parent_id'], $store_id );
		$this->mdata['thumb'] = $this->model_tool_image->resize($menu['image'], 32, 32);
		$this->mdata['menu_description'] = array();
		$descriptions  = $this->model_verticalmenu_verticalmenu->getMenuDescription( $id );
		$this->mdata['menu_description'] = array();
		
		$this->mdata['verticalmenutypes'] = array(
			'url' => 'URL',
			'category' => 'Category',
			'information' => 'information',
			'product' => 'Product',
			'manufacturer' => 'Manufacturer',
			'html'  => "HTML"
		);
		
		if( $menu['item'] ){
			switch( $menu['type'] ){
				case 'category':
					$category = $this->model_catalog_category->getCategory( $menu['item'] );
					$menu['verticalmenu-category'] = isset($category['name'])?$category['name']:"";
					
					break;
				case 'product':
					$product = $this->model_catalog_product->getProduct( $menu['item'] );
					$menu['verticalmenu-product'] = isset($product['name'])?$product['name']:"";
					break;
				case 'information':
						$menu['verticalmenu-information'] = $menu['item'] ;
					break;
				case 'manufacturer':
					$manufacturer = $this->model_catalog_manufacturer->getManufacturer( $menu['item'] );
					$menu['verticalmenu-manufacturer'] = isset($manufacturer['name'])?$manufacturer['name']:"";
					break;					
			}
		}
		foreach( $descriptions as $d ){
			$this->mdata['menu_description'][$d['language_id']] = $d;
		}

		if( empty($this->mdata['menu_description']) ){
			foreach(  $this->mdata['languages'] as $language ){
				$this->mdata['menu_description'][$language['language_id']]['title'] = '';
				$this->mdata['menu_description'][$language['language_id']]['description'] = '';
			}
		}
		
		if( isset($this->request->post['verticalmenu']) ){
			$menu = array_merge($menu, $this->request->post['verticalmenu'] );
		}


		$this->mdata['menu'] = $menu;
		
		
		$this->mdata['submenutypes'] = array('menu'=>'Menu', 'html'=>'HTML','widget'=>'Widget');
		$this->mdata['text_edit_menu'] = $this->language->get('text_edit_menu');
		$this->mdata['text_create_new'] = $this->language->get('text_create_new');

		$template = 'module/pavverticalmenu/pavverticalmenu_form.tpl';
		$this->response->setOutput($this->load->view($template, $this->mdata));
	}
 	
 	/**
 	 * Check Validation
 	 */
	protected function validate() {
	
		if (!$this->user->hasPermission('modify', 'module/pavverticalmenu')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		$data = $this->request->post['verticalmenu_description'];

		foreach ($data as $language_id => $value) {
			if ( empty($value['title']) ) {
				$this->error['title'][$language_id] = $this->language->get('error_title');
			}
		}	
						
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
		
		return !$this->error;
	}

	/**
	 * Ajax Menu Information Action
	 */
	public function ajxmenuinfo(){
		$this->load->language('module/pavverticalmenu');
		$this->load->language('module/pavverticalmenu');
		if (!$this->user->hasPermission('modify', 'module/pavverticalmenu')) {
			die( $this->language->get('error_permission') );
		}
		
		$this->load->model('setting/setting');

		if( isset($this->request->post['params']) ) { 
			$params = trim(html_entity_decode($this->request->post['params'])); 

			$a = json_decode(($params));
			$this->load->model("verticalmenu/verticalmenu");

			$this->model_verticalmenu_verticalmenu->editSetting( 'pavverticalmenu_params', array('params'=> $params) );
		}
		// note: add query (pavverticalmenu_params) in file query (admin/model/sample/default/query.php)
		return $this->ajxgenmenu();
	}

	/**
	 * Live Edit Mega Menu Action
	 */
	public function liveedit(){
		$this->mdata['objlang'] = $this->language;
		$this->load->language('module/pavverticalmenu');
	
		$themeConfig = $this->config->get( 'themecontrol' );
		$theme = isset($themeConfig['default_theme'])?$themeConfig['default_theme']:'default';

		$this->document->addStyle('view/stylesheet/pavverticalmenu_live.css');
		$this->mdata['filemagement_uri'] = $this->url->link('common/filemanager', '1=1&token=' . $this->session->data['token'], 'SSL'); 

 		$this->document->addStyle('view/javascript/pavbuilder/style.css');
 		 		
		$this->document->addScript( 'view/javascript/summernote/summernote.js');
		$this->document->addStyle( 'view/javascript/summernote/summernote.css');

		$this->document->addScript( 'view/javascript/pavverticalmenu/editor.js');
		$this->document->addScript( 'view/javascript/pavverticalmenu/image_gallery.js');
		$this->document->addScript( 'view/javascript/pavverticalmenu/widget.js');
		$this->document->addStyle(  'view/javascript/font-awesome/css/font-awesome.min.css');

		$this->document->addStyle( HTTP_CATALOG.'catalog/view/theme/default/stylesheet/stylesheet.css');
		$this->document->addStyle( HTTP_CATALOG.'catalog/view/theme/default/stylesheet/pavverticalmenu/style.css');

		$this->load->model( 'verticalmenu/widget' );

		$this->mdata['live_site_url'] = HTTP_CATALOG;
		$this->mdata['widgets'] =  $this->model_verticalmenu_widget->getWidgets();

		// GET Request Url By store_id
		$store_param = isset($this->request->get['store_id'])?'&store_id='.$this->request->get['store_id']:'';

		$this->mdata['liveedit_action'] = $this->url->link('module/pavverticalmenu/livesave', 'root=1&token=' . $this->session->data['token'].$store_param, 'SSL');
		$this->mdata['action_backlink'] = $this->url->link('module/pavverticalmenu', 'root=1&token=' . $this->session->data['token'].$store_param, 'SSL');
		$this->mdata['action_widget'] =  HTTP_CATALOG.'index.php?route=module/pavverticalmenu/renderwidget';
		$this->mdata['action_addwidget'] = $this->url->link('module/pavverticalmenu/addwidget', 'token=' . $this->session->data['token'].$store_param, 'SSL'); 

		$this->mdata['ajxgenmenu'] 	   = $this->url->link('module/pavverticalmenu/ajxgenmenu', 'root=1&token=' . $this->session->data['token'].$store_param, 'SSL'); 
		$this->mdata['ajxmenuinfo'] 	   = $this->url->link('module/pavverticalmenu/ajxmenuinfo', 'root=1&token=' . $this->session->data['token'].$store_param, 'SSL'); 
 		$this->mdata['styles']  		   = $this->document->getStyles();
 		$this->mdata['scripts']  	   = $this->document->getScripts();

		$this->mdata['action_wform'] = $this->url->link('module/pavverticalmenu/widgetform', 'token=' . $this->session->data['token'].$store_param, 'SSL'); 

 		//
 		$this->model_verticalmenu_widget->loadWidgetsEngines();
		$widgets = $this->model_verticalmenu_widget->getButtons();


		$this->mdata['widgets'] = $widgets['widgets'];
		$this->mdata['groups'] = $widgets['groups'];


 		//Render
 			
		$this->mdata['header'] = $this->load->controller('common/header');
		$this->mdata['column_left'] = $this->load->controller('common/column_left');
		$this->mdata['footer'] = $this->load->controller('common/footer');
		$template = 'module/pavverticalmenu/liveedit.tpl';
		$this->response->setOutput($this->load->view($template, $this->mdata));
	}
 

	/**
	 *  Ajax Live Save Action.
	 */
	public function livesave(){
		$this->ajxgenmenu();
	}

	/**
	 * Ajax Render List Tree Mega Menu Action
	 */
	public function ajxgenmenu( ){ 
		
		$this->load->language('module/pavverticalmenu');
 		$this->load->model('setting/setting');
		$this->load->model( 'verticalmenu/tree' );
	 	$this->load->model( 'verticalmenu/widget' );
		$parent = '1';
		
		/* unset mega menu configuration */
		if( isset($this->request->post['reset']) ){
	 		$this->model_setting_setting->editSetting( 'pavverticalmenu_params', array('params'=>'') ); 
	 	}

	 	$params = $this->model_setting_setting->getSetting( 'pavverticalmenu_params' );
	 	
	 	if( isset($params['params']) && !empty($params['params']) ){
	 		$params = json_decode( $params['params'] );
	 	}

		// Get Request store_id
		$store_id = isset($this->request->get['store_id'])?$this->request->get['store_id']:0;

		$this->mdata['treemenu'] = $this->model_verticalmenu_tree->getTree( 1, true, $params, $store_id );
	 
		//echo $this->render();
		$template = 'module/pavverticalmenu/verticalmenu-tree.tpl';
		$this->response->setOutput($this->load->view($template, $this->mdata));
	}

	/**
	 * Add / Edit  Widget Action
	 */
	public function addwidget(){

		$this->mdata['objlang'] = $this->language;

		$this->load->language('module/pavverticalmenu');
		$this->template = 'module/pavverticalmenu/widget_form.tpl';
		$this->document->addStyle( 'view/stylesheet/pavverticalmenu/widget.css');
		
		$this->mdata['heading_title'] = $this->language->get('heading_widget_title');

		$this->load->model('setting/setting');
		$this->load->model( 'verticalmenu/widget' );

		$model = $this->model_verticalmenu_widget; 

		$this->mdata['types'] = $model->getTypes();

		$disabled  		 = false;
		$form 	  		 = '';
		$widget_selected = '';
		$id 			 = 0;
 
		if( isset($this->request->get['id']) && ($id=$this->request->get['id']) ) { 
			$id = (int)$this->request->get['id'];  
		}	

		if( isset($this->request->post['widget']) && isset($this->request->post['params']) ){
			$this->request->post['widget']['params'] = $this->request->post['params'];
			$row = $model->saveData( $this->request->post['widget'] );
			$this->response->redirect( $this->url->link('module/pavverticalmenu/addwidget', 'done=1&id='.$row['id'].'&wtype='.$row['type'].'&token=' . $this->session->data['token'], 'SSL') ); 
		}

		$data = $model->getWidetById( $id );

		if( $data['id'] ){
			$disabled = true;
		}

		if( isset($this->request->get['wtype']) ) {
			$widget_selected =  trim(strtolower($this->request->get['wtype']));	
			$form = $model->getForm( $widget_selected, $data['params'] );
		}
		$this->mdata['widget_data'] = $data;

		if( isset($this->request->get['done']) ){
			 $this->mdata['message'] = $this->language->get('message_update_data_done');
		}
		$this->mdata['id'] 		 = $id;
		$this->mdata['form'] 	 = $form;
		$this->mdata['disabled']  = $disabled; 
		$this->mdata['widget_selected'] = $widget_selected;

		$this->mdata['action'] = $this->url->link('module/pavverticalmenu/addwidget', 'token=' . $this->session->data['token'], 'SSL'); 
		
		// Get Form
		$this->model_verticalmenu_widget->getForm( 'html' );

 		// Render
		$this->mdata['header'] = $this->load->controller('common/header');
		$this->mdata['column_left'] = $this->load->controller('common/column_left');
		$this->mdata['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('module/pavverticalmenu/widget_form.tpl', $this->mdata));
	}


	/**
	 *  Delete Widget Action
	 */
	public function delwidget(){
		if( isset($this->request->get['id']) ){
			$this->load->model( 'verticalmenu/widget' );

			$id = (int)$this->request->get['id'];

			$this->model_verticalmenu_widget->delete( $id ); 
		}

		$this->response->redirect($this->url->link('module/pavverticalmenu', 'token=' . $this->session->data['token'], 'SSL'));
	}
	public function getLang( $text ){
		return $this->language->get($text);
	}
	
	public function widgetform(){
		$this->load->model('setting/setting');
		$this->load->model( 'verticalmenu/widget' );
		
		$model = $this->model_verticalmenu_widget; 

		if( isset($this->request->get['delete']) ){
			$model->delete( (int)$this->request->post['id'] );
			die('done');
		}
		if( isset($this->request->get['savedata']) && isset($this->request->post['wtype']) ){

			$data = array();
			$data['id'] = $this->request->post['wkey'];
			$data['params'] = $this->request->post; 
			$data['type'] = $this->request->post['wtype'];

		 	$info = $model->saveData( $data );
		 	 
		 	$output = new stdClass();
		 	$output->status = true; 
		 	$output->name =  $this->request->post['widget_name'];
		 	$output->id = $info['id'] ; 
		 	$output->msg = '';
		 	$output->type = $data['type'];
		 	$output->update = $data['id']?true:false;
			
			echo json_encode ( $output );exit();
		}

		if( isset($this->request->post['id']) ){
			$id = (int) $this->request->post['id']; 
			$data = array( 'type'=>'', 'params'=> array() );

			if( $id <= 0 && isset($this->request->post['type']) ){
				$data['type'] = $this->request->post['type'];
			}else {	
				$data = $model->getWidetById( $id );	
			}	
			$this->request->post['wkey'] = $id; 
			$data['params']['wkey'] =   $id ;

			 

			$this->model_verticalmenu_widget->loadWidgetsEngines();

			$form = $this->model_verticalmenu_widget->renderForm( $data['type'], array(), array('params'=>$data['params']) );



			 
			echo '
			<div>
				<div class="wpo-widget-form">
					'.$form.'
				</div>
			</div>';


		 	exit(); 
		}
	}
}
?>
