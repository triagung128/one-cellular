<?php
class ControllerModulePavdeals extends Controller {
	private $error = array();
	private $mdata = array();



	public function index() {

		$this->mdata['objlang'] = $this->language;
		$this->mdata['objurl'] = $this->url;

		$this->load->language('module/pavdeals');

		$this->load->model('setting/setting');

		$this->load->model('extension/module');

		$this->load->model('catalog/category');

		$this->load->model('tool/image');

		

		$this->load->model('localisation/order_status');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->document->addScript('view/javascript/pavdeals/jquery-cookie.js');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$action = $this->request->post['action'];
			if ($action == "module") {
				if (!isset($this->request->get['module_id'])) {
					$this->model_extension_module->addModule('pavdeals', $this->request->post['pavdeals_module']);
					$this->response->redirect( $this->url->link('module/pavdeals', 'token=' . $this->session->data['token'], 'SSL') );
				} else {

					$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post['pavdeals_module']);
					$this->response->redirect( $this->url->link('module/pavdeals', 'token=' . $this->session->data['token'].'&module_id='.$this->request->get['module_id'], 'SSL') );
				}
			}
			if ($action == "config") {

				$this->load->model('pavdeals/setting');

				if (version_compare(VERSION, '2.1.0.1') >= 0) {
				    $this->model_setting_setting->editSetting( 'pavdeals', array("pavdeals_config"=>$this->request->post['pavdeals_config']) );
				} else {
					$this->model_pavdeals_setting->editSetting( 'pavdeals', array("pavdeals_config"=>$this->request->post['pavdeals_config']) );
				}
				
				$this->response->redirect( $this->url->link('module/pavdeals', 'token=' . $this->session->data['token'], 'SSL') );
			}
		}

		$this->_language();
    	$this->_breadcrumbs();


		// Get Data DropDown
		$this->_getDataCategory();
 		
 		// Alert 
 		if (isset($this->error['warning'])) {
			$this->mdata['error_warning'] = $this->error['warning'];
		} else {
			$this->mdata['error_warning'] = '';
		}
		if (isset($this->session->data['success'])) {
			$this->mdata['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->mdata['success'] = '';
		}

		$this->_dataModule();

		// Get Data Setting General
		$gConfig = array(
			'order_status_id'     => 5,
			'saleoff_icon'        => $this->model_tool_image->resize("data/saleoff.png", 150, 150),
			'today_deal'          => 10,
			'time_end'            => '',
			'enable_available'    => 1,
			'enable_pass'         => 1,
			'icon_width'          => 180,
			'icon_height'         => 180,
			'limit'               => 10,
			'cols'                => 3,
			'width'               => 180,
			'height'              => 180,
		);

		$pavdealsConfig = (array)$this->config->get('pavdeals_config');

		$generalConfig = array_merge($gConfig, $pavdealsConfig);

		$this->mdata['general'] = $generalConfig;

		$this->mdata['bg_thumb'] = $this->model_tool_image->resize($generalConfig['saleoff_icon'], 150, 150);
		$this->mdata['no_image'] = $this->model_tool_image->resize('data/saleoff.png', 150, 150);

		$this->mdata['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		// Generate Layout
		$this->mdata['header'] = $this->load->controller('common/header');
		$this->mdata['column_left'] = $this->load->controller('common/column_left');
		$this->mdata['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/pavdeals.tpl', $this->mdata));

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
		$this->mdata['delete'] = $this->url->link('module/pavdeals/ndelete', 'token=' . $this->session->data['token'].$url, 'SSL');
		$this->mdata['action'] = $this->url->link('module/pavdeals', 'token=' . $this->session->data['token'].$url, 'SSL');

		$this->mdata['extensions'] = $this->module("pavdeals");

		// GET DATA SETTING
		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}

		$this->mdata['module'] = array();
		// status
		if (isset($this->request->post['pavdeals']['status'])) {
			$this->mdata['module']['status'] = $this->request->post['pavdeals']['status'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['status'] = $module_info['status'];
		} else {
			$this->mdata['module']['status'] = 1;
		}
		// name
		if (isset($this->request->post['pavdeals']['name'])) {
			$this->mdata['module']['name'] = $this->request->post['pavdeals']['name'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['name'] = $module_info['name'];
		} else {
			$this->mdata['module']['name'] = '';
		}
		//date_start
		if (isset($this->request->post['pavdeals']['date_start'])) {
			$this->mdata['module']['date_start'] = $this->request->post['pavdeals']['date_start'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['date_start'] = $module_info['date_start'];
		} else {
			$this->mdata['module']['date_start'] = '';
		}
		//date_to
		if (isset($this->request->post['pavdeals']['date_to'])) {
			$this->mdata['module']['date_to'] = $this->request->post['pavdeals']['date_to'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['date_to'] = $module_info['date_to'];
		} else {
			$this->mdata['module']['date_to'] = '';
		}
		//category_ids
		if (isset($this->request->post['pavdeals']['category_ids'])) {
			$this->mdata['module']['category_ids'] = $this->request->post['pavdeals']['category_ids'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['category_ids'] = isset($module_info['category_ids'])?$module_info['category_ids']:array();
		} else {
			$this->mdata['module']['category_ids'] = array();
		}
		//sort_deals
		if (isset($this->request->post['pavdeals']['sort_deals'])) {
			$this->mdata['module']['sort_deals'] = $this->request->post['pavdeals']['sort_deals'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['sort_deals'] = $module_info['sort_deals'];
		} else {
			$this->mdata['module']['sort_deals'] = '';
		}
		//limit
		if (isset($this->request->post['pavdeals']['limit'])) {
			$this->mdata['module']['limit'] = $this->request->post['pavdeals']['limit'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['limit'] = $module_info['limit'];
		} else {
			$this->mdata['module']['limit'] = 4;
		}
		//cols
		if (isset($this->request->post['pavdeals']['cols'])) {
			$this->mdata['module']['cols'] = $this->request->post['pavdeals']['cols'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['cols'] = $module_info['cols'];
		} else {
			$this->mdata['module']['cols'] = 4;
		}
		//itemsperpage
		if (isset($this->request->post['pavdeals']['itemsperpage'])) {
			$this->mdata['module']['itemsperpage'] = $this->request->post['pavdeals']['itemsperpage'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['itemsperpage'] = $module_info['itemsperpage'];
		} else {
			$this->mdata['module']['itemsperpage'] = 4;
		}
		//prefix
		if (isset($this->request->post['pavdeals']['prefix'])) {
			$this->mdata['module']['prefix'] = $this->request->post['pavdeals']['prefix'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['prefix'] = $module_info['prefix'];
		} else {
			$this->mdata['module']['prefix'] = '';
		}
		//width
		if (isset($this->request->post['pavdeals']['width'])) {
			$this->mdata['module']['width'] = $this->request->post['pavdeals']['width'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['width'] = $module_info['width'];
		} else {
			$this->mdata['module']['width'] = 200;
		}
		//height
		if (isset($this->request->post['pavdeals']['height'])) {
			$this->mdata['module']['height'] = $this->request->post['pavdeals']['height'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['height'] = $module_info['height'];
		} else {
			$this->mdata['module']['height'] = 200;
		}
		//auto_play
		if (isset($this->request->post['pavdeals']['auto_play'])) {
			$this->mdata['module']['auto_play'] = $this->request->post['pavdeals']['auto_play'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['auto_play'] = $module_info['auto_play'];
		} else {
			$this->mdata['module']['auto_play'] = 0;
		}
		//interval
		if (isset($this->request->post['pavdeals']['interval'])) {
			$this->mdata['module']['interval'] = $this->request->post['pavdeals']['interval'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['interval'] = $module_info['interval'];
		} else {
			$this->mdata['module']['interval'] = 1000;
		}

		//echo "<pre>"; print_r($this->mdata['module']); die;
	}

	public function ndelete(){

		$this->load->model('extension/module');
		$this->load->language('module/pavdeals');
		
		if (isset($this->request->get['module_id'])) {
			$this->model_extension_module->deleteModule($this->request->get['module_id']);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('module/pavdeals', 'token=' . $this->session->data['token'], 'SSL'));
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
				'edit'      => $this->url->link('module/pavdeals', 'token=' . $this->session->data['token'] . '&module_id=' . $module['module_id'], 'SSL'),
			);
		}
		$ex[] = array(
			'name'      => $this->language->get("create_module"),
			'module'    => $module_data,
			'edit'      => $this->url->link('module/pavdeals', 'token=' . $this->session->data['token'], 'SSL')
		);
		return $ex;
	}

	public function _getDataCategory() {

    	$this->mdata['default_values'] = array();
		$this->mdata['today_deals'] = array(
			'10' => '10 '.$this->language->get('entry_day_deals'), 
			'15' => '15 '.$this->language->get('entry_day_deals'), 
			'30' => '30 '.$this->language->get('entry_day_deals'), 
			'45' => '45 '.$this->language->get('entry_day_deals'), 
			'88' => $this->language->get('entry_in_today_deals'), 
			'99' => $this->language->get('value_specific')
		);
    	
   		$categories = $this->model_catalog_category->getCategories(array());
   		$this->mdata['categories'] = array();
		$this->mdata['categories'][] = array('category_id'=>0, 'name' => $this->language->get('all_categories') );
   		$this->mdata['categories'] = array_merge($this->mdata['categories'], $categories);
   		$this->mdata['sortdeals'] = array('pd.name__desc'=>$this->language->get("text_name_desc"),
   											'pd.name__asc'=>$this->language->get("text_name_asc"),
   											'p.date_added__desc'=>$this->language->get("text_date_added_desc"),
   											'p.date_added__asc'=>$this->language->get("text_date_added_asc"),
											'p.model__desc'=>$this->language->get("text_model_desc"),
											'p.model__asc'=>$this->language->get("text_model_asc"),
											'ps.price__desc'=>$this->language->get("text_price_desc"),
											'ps.price__asc'=>$this->language->get("text_price_asc"),
											'rating__desc'=>$this->language->get("text_rating_desc"),
											'p.sort_order__asc'=>$this->language->get("text_sort_order_asc"),
											'p.sort_order__desc'=>$this->language->get("text_sort_order_desc"));
	}

	public function _getStores() {
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
			$store['option'] = $this->url->link('module/pavdeals', $url.'&token=' . $this->session->data['token'], 'SSL');
		}
		return $stores;
	}

	public function _language() {
		$this->mdata['heading_title'] = $this->language->get('heading_title');
		$this->mdata['token'] = $this->session->data['token'];
		$this->mdata['text_enabled'] = $this->language->get('text_enabled');
		$this->mdata['text_disabled'] = $this->language->get('text_disabled');
		$this->mdata['text_content_top'] = $this->language->get('text_content_top');
		$this->mdata['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->mdata['text_column_left'] = $this->language->get('text_column_left');
		$this->mdata['text_column_right'] = $this->language->get('text_column_right');

		$this->mdata['entry_limit'] = $this->language->get('entry_limit');
		$this->mdata['entry_username'] = $this->language->get('entry_username');
		$this->mdata['entry_layout'] = $this->language->get('entry_layout');
		$this->mdata['entry_position'] = $this->language->get('entry_position');
		$this->mdata['entry_status'] = $this->language->get('entry_status');
		$this->mdata['entry_sort_order'] = $this->language->get('entry_sort_order');
    	$this->mdata['entry_width_height'] = $this->language->get('entry_width_height');
    	$this->mdata['entry_image_selector']	= $this->language->get('entry_image_selector');
    	$this->mdata['entry_image_selector_help'] = $this->language->get('entry_image_selector_help');
    	$this->mdata['entry_additional_width_height'] = $this->language->get('entry_additional_width_height');

		$this->mdata['button_save'] = $this->language->get('button_save');
		$this->mdata['button_cancel'] = $this->language->get('button_cancel');
		$this->mdata['button_add_module'] = $this->language->get('button_add_module');
		$this->mdata['button_remove'] = $this->language->get('button_remove');
    	$this->mdata['tab_module'] = $this->language->get('tab_module');

		$this->mdata['action'] = $this->url->link('module/pavdeals', 'token=' . $this->session->data['token'], 'SSL');
		$this->mdata['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->mdata['yesno'] = array(0=>$this->language->get('text_no'),1=>$this->language->get('text_yes'));

	}

	public function _breadcrumbs() {
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
			'href'      => $this->url->link('module/pavdeals', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/pavdeals')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (isset($this->request->post['pavdeals_module'])) {

		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>
