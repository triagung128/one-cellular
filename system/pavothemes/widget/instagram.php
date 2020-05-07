<?php
class PtsWidgetInstagram extends PtsWidgetPageBuilder {

		public $name = 'instagram';
		public $group = 'others';

		public static function getWidgetInfo(){
			return array('label' =>  ('Instagram'), 'explain' => '', 'group' => 'others'  );
		}


		public function renderForm( $args, $data ){
			$helper = $this->getFormHelper();

			$this->fields_form[1]['form'] = array(
	            'legend' => array(
	                'title' => $this->l('Widget Form.'),
	            ),
	            'input' => array(
 					array(
	                    'type'  => 'text',
	                    'label' => $this->l('Username ID'),
	                    'name'  => 'i_username',
	                    'default'=> '3192164486',
	                ),
	                array(
						'type'  => 'text',
						'label' => $this->l('Count'),
						'name'  => 'i_count',
						'default'=> 5,
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
						'label' => $this->l('Token'),
						'name'  => 'i_token',
						'default'=> '3192164486.cf0499d.f86ff9b88933421c85f40ae797539c59',
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

			$this->language->load('module/themecontrol');

			// HEADDING TITLE
			$languageID = $this->config->get('config_language_id');
			$setting['heading_title'] = isset($setting['widget_title_'.$languageID])?$setting['widget_title_'.$languageID]:'';

			// SETTING
			$t = array(
                'i_username' => '1213565508',
                'i_count'    => '6',
                'cols'       => 4,
                'i_token'    => '1213565508.1677ed0.e31553e458274a178d41daa1968e9671',
			);
			$setting = array_merge( $t, $setting );

			$setting['user_id'] = $setting['i_username'];
			$setting['access_token'] = $setting['i_token'];

			// OUTPUT
			$output = array('type'=>'others','data' => $setting );
			return $output;
		}
	}
?>