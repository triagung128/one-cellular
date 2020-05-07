<?php
class ControllerModulePavtestimonial extends Controller {
	private $error = array();

	private $data = array();

	public function index() {

		$this->data['objlang'] = $this->language;
		$this->data['objurl'] = $this->url;


		$this->load->language('module/pavtestimonial');
		$this->load->model('extension/module');
		$this->load->model('extension/extension');
		$this->load->model('tool/image');
		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');


		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$action = $this->request->post['action_mode']	;
			unset(  $this->request->post['action_mode']	 );


 			$this->request->post['pavtestimonial_module'][0]['testimonial_item'] = 	$this->request->post['testimonial_item'];
 			unset($this->request->post['testimonial_item']);

 			
 			$data = array();
			foreach ($this->request->post['pavtestimonial_module'] as $key => $value) {
		 	 	$data = $value;	
		 	 	break;
		 	}

			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('pavtestimonial', $data );
			} else {
				$this->model_extension_module->editModule( $this->request->get['module_id'], $data );
			}	


			$this->session->data['success'] = $this->language->get('text_success');
			if( isset($this->request->get['module_id']) ) {
				$this->response->redirect($this->url->link('module/pavtestimonial', 'module_id='.$this->request->get['module_id'].'&token=' . $this->session->data['token'], 'SSL'));
			}else{
				$this->response->redirect($this->url->link('module/pavtestimonial', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		$this->_language();

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		$this->_breadcrumbs();


		$this->data['action'] = $this->url->link('module/pavtestimonial', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['token'] = $this->session->data['token'];

		// status
		if (isset($this->request->post['pavtestimonial_status'])) {
			$this->data['pavtestimonial_status'] = $this->request->post['pavtestimonial_status'];
		} else {
			$this->data['pavtestimonial_status'] = $this->config->get('pavtestimonial_status');
		}

		$this->data['modules'] = array();


		$d = array('layout_id'=>'','position'=>'','status'=>'','sort_order'=>'1',
					'testimonial_item'=>array(),'width'=>940,'height'=>350,
					'image_navigator' => 0,
					'navimg_height'   =>97,
					'navimg_weight'   =>177,
					'text_interval'	  =>8000,
					'column_item'	  => '1',
					'page_items'	  => 2,
					'name'			=> '',
					'status' => 1,
					'class' => ''
		);

		

		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$d = $this->model_extension_module->getModule($this->request->get['module_id']);
			$d = array_merge( $d, $d );
			$this->data['selectedid'] = $this->request->get['module_id'];

			
			$this->data['subheading'] = $this->language->get('text_edit_module') . $d['name'];
			$this->data['action'] = $this->url->link('module/pavtestimonial', 'module_id='.$this->request->get['module_id'].'&token=' . $this->session->data['token'], 'SSL');
		}else {
			$d = $d;
			$this->data['selectedid'] = 0;
			$this->data['subheading'] = $this->language->get('text_create_new_module');
			$this->data['action'] = $this->url->link('module/pavtestimonial', 'token=' . $this->session->data['token'], 'SSL');
		}

		 

		$this->data['module'] = $d;
		if( $d['testimonial_item'] ){
			$tmp = array();$i=1;
			foreach( $d['testimonial_item'] as $key => $banner ){
				$banner['link'] = isset($banner['link'])?trim($banner['link']):"";
				$banner['thumb'] = $this->model_tool_image->resize($banner['image'], 100, 100);
				$tmp[$i++] = $banner;
			}
			 $d['testimonial_item'] = $tmp;
		}

		$this->data['testimonial_item'] = $d['testimonial_item'];
		$this->load->model('design/layout');
		$this->data['layouts'][] = array('layout_id'=>99999, 'name' => $this->language->get('all_page') );

		$this->data['layouts'] = array_merge($this->data['layouts'],$this->model_design_layout->getLayouts());


		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);


		$this->data['header'] = $this->load->controller('common/header');
		$this->data['column_left'] = $this->load->controller('common/column_left');
		$this->data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/pavtestimonial.tpl', $this->data));
	}

	public function _language(){
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
 		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');

		$this->data['text_edit'] = $this->language->get('text_edit');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');

		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_width'] = $this->language->get('entry_width');
		$this->data['entry_height'] = $this->language->get('entry_height');
		$this->data['entry_class'] = $this->language->get('entry_class');
		
		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_module_add'] = $this->language->get('button_module_add');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		$this->data['entry_show_image'] = $this->language->get( 'entry_show_image' );
		$this->data['entry_module_title'] = $this->language->get( 'entry_module_title' );
		$this->data['tab_module'] = $this->language->get('tab_module_banner');
		$this->data['entry_image_navigator'] = $this->language->get( 'entry_image_navigator' );
		$this->data['entry_navigator_width'] = $this->language->get( 'entry_navigator_width' );
		$this->data['entry_navigator_height'] = $this->language->get( 'entry_navigator_height' );
		$this->data['entry_profile']	= $this->language->get( 'entry_profile' );
	}

	public function _breadcrumbs(){
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/pavtestimonial', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/pavtestimonial')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if( !isset($this->request->post['testimonial_item']) ){
			$this->error['warning'] = $this->language->get('error_missing_banner');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>
