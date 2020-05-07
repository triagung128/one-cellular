<?php
class ControllerModulePavautosearch extends Controller {
	private $error = array(); 
	private $mdata = array();
	 
	public function index() {

		$this->mdata['objlang'] = $this->language;
		$this->mdata['objurl'] = $this->url;

		$this->load->language('module/pavautosearch');
		$this->load->model('tool/image');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
		
			$this->model_setting_setting->editSetting('pavautosearch', $this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->response->redirect($this->url->link('module/pavautosearch', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->_language();
		
		$this->_breadcrumbs();
		
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

		// Get Setting Status
		if (isset($this->request->post['pavautosearch_status'])) {
			$this->mdata['pavautosearch_status'] = $this->request->post['pavautosearch_status'];
		} else {
			$this->mdata['pavautosearch_status'] = $this->config->get('pavautosearch_status');
		}

   		// Get Data Setting 
		$this->mdata['modules'] = array();
		if (isset($this->request->post['pavautosearch_module'])) {
			$this->mdata['modules'] = $this->request->post['pavautosearch_module'];
		} elseif ($this->config->get('pavautosearch_module')) { 
			$this->mdata['modules'] = $this->config->get('pavautosearch_module');
		}

		// Render
		$this->mdata['header'] = $this->load->controller('common/header');
		$this->mdata['column_left'] = $this->load->controller('common/column_left');
		$this->mdata['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/pavautosearch.tpl', $this->mdata));
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
			'href'      => $this->url->link('module/pavautosearch', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
	}

	public function _language(){
		$this->mdata['heading_title'] = $this->language->get('heading_title');
		$this->mdata['text_image_manager'] = $this->language->get('text_image_manager');
 		$this->mdata['text_browse'] = $this->language->get('text_browse');
		$this->mdata['text_clear'] = $this->language->get('text_clear');			
				
		$this->mdata['text_enabled'] = $this->language->get('text_enabled');
		$this->mdata['text_disabled'] = $this->language->get('text_disabled');
		$this->mdata['text_content_top'] = $this->language->get('text_content_top');
		$this->mdata['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->mdata['text_column_left'] = $this->language->get('text_column_left');
		$this->mdata['text_column_right'] = $this->language->get('text_column_right');
		
		$this->mdata['entry_title'] = $this->language->get('entry_title');
		$this->mdata['entry_width'] = $this->language->get('entry_width');
		$this->mdata['entry_height'] = $this->language->get('entry_height');
		
		$this->mdata['entry_description'] = $this->language->get('entry_description');
		$this->mdata['entry_layout'] = $this->language->get('entry_layout');
		$this->mdata['entry_position'] = $this->language->get('entry_position');
		$this->mdata['entry_status'] = $this->language->get('entry_status');
		$this->mdata['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->mdata['button_save'] = $this->language->get('button_save');
		$this->mdata['button_cancel'] = $this->language->get('button_cancel');
		$this->mdata['button_add_module'] = $this->language->get('button_add_module');
		$this->mdata['button_remove'] = $this->language->get('button_remove');
		$this->mdata['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);		
		$this->mdata['entry_show_image'] = $this->language->get( 'entry_show_image' );
		$this->mdata['entry_module_title'] = $this->language->get( 'entry_module_title' );
		$this->mdata['tab_module'] = $this->language->get('tab_module_banner');
		$this->mdata['entry_image_navigator'] = $this->language->get( 'entry_image_navigator' );
		$this->mdata['entry_navigator_width'] = $this->language->get( 'entry_navigator_width' );
		$this->mdata['entry_navigator_height'] = $this->language->get( 'entry_navigator_height' );

		$this->mdata['action'] = $this->url->link('module/pavautosearch', 'token=' . $this->session->data['token'], 'SSL');
		$this->mdata['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->mdata['token'] = $this->session->data['token'];
	}
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/pavautosearch')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>
