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

class PtsWidgetInteractive_banner extends PtsWidgetPageBuilder {

		public $name = 'interactive_banner';
		public $usemeneu = false;


		public  static function getWidgetInfo(){
			return array( 'label' => 'Interactive Banner', 'explain' => 'Interactive Banner', 'group' => 'image'  );
		}

		public static function renderButton(){

		}

		public function renderForm( $args, $data ){

			$key = time();

			$helper = $this->getFormHelper();

			$this->fields_form[1]['form'] = array(
	            'legend' => array(
	                'title' => $this->l('Widget Form.'),
	            ),
	            'input' => array(

					array(
	                    'type'  => 'text',
	                    'label' => $this->l('Image File'),
	                    'name'  => 'imagefile',
	                    'class' => 'imageupload',
	                    'default'=> '',
	                    'id'	 => 'imagefile'.$key,
	                    'desc'	=> 'Put image folder in the image folder ROOT_SHOP_DIR/img/'
	                ),
					array(
						'type' => 'text',
						'label' => $this->l('Image Width'),
						'name' => ('width'),
						'desc' => $this->l('Define the width of images displayed in this block.'),
						'default' => '280'
					),
					array(
						'type' => 'text',
						'label' => $this->l('Image Height.'),
						'name' => ('height'),
						//'class' => 'fixed-width-xs',
						'desc' => $this->l('Define the height of images displayed in this block.'),
						'default' => '240'
					),
					array(
	                    'type' => 'textarea',
	                    'label' => $this->l('Content'),
	                    'name' => 'htmlcontent',
	                    'cols' => 40,
	                    'rows' => 10,
	                    'value' => '',
	                    'lang'  => true,
	                    'default'=> '',
	                    'autoload_rte' => true,
	                ),

                	 array(
	                    'type' => 'text',
	                    'label' => $this->l('Title link:'),
	                    'name' => 'text_link',
	                    'value' => '',
	                    'lang'  => true,
	                    'default'=> '',
	                ),
					 array(
	                    'type' => 'text',
	                    'label' => $this->l( 'Mask link' ),
	                    'name' => 'mask_link',
	                    'default' => "#",
						'desc' => ''
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
			$this->load->model('tool/image');
			$this->model_tool_image->resize('no_image.png', 100, 100);
			$placeholder  = $this->model_tool_image->resize('no_image.png', 100, 100);
		//	d( $this->token );
			$string = '



					 <script type="text/javascript">
						$(".imageupload").WPO_Gallery({key:"'.$key.'",gallery:false,placehold:"'.$placeholder.'",baseurl:"'.HTTP_CATALOG . 'image/'.'" } );
					</script>

			';
			return  '<div id="imageslist'.$key.'">'.$helper->generateForm( $this->fields_form ) .$string."</div>" ;

		}



		public function renderContent(  $args, $setting ){

			$t  = array(
				'name'=> '',
				'html'   => '',
				'text_link'	=> '',
				'height' => 130,
				'width'  => 170,
				'nbr'    => 6,
				'page'   => 3,
				'cols'	 => 4,
				'intv'	 => 8000,
				'show'  => 1,
				'banner_type'	=> ''
			);

			$setting = array_merge( $t, $setting );



			$url = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443) ? HTTPS_SERVER : HTTP_SERVER;
	        $url .= 'image/';


			$setting = array_merge( $t, $setting );



			$setting['thumbnailurl'] = $url.$setting['imagefile'];
			$setting['imageurl'] = $url.$setting['imagefile'];

			$this->load->model('tool/image');
			$setting['thumbnailurl']= $this->model_tool_image->resize( $setting['imagefile'], (int)$setting['width'], (int)$setting['height'],'w');


			$languageID = $this->config->get('config_language_id');
			$setting['heading_title'] = isset($setting['widget_title_'.$languageID])?$setting['widget_title_'.$languageID]:'';

			$setting['text_link'] = isset($setting['text_link_'.$languageID])?$setting['text_link_'.$languageID]:'';

			$setting['htmlcontent']= isset($setting['htmlcontent_'.$languageID])?html_entity_decode($setting['htmlcontent_'.$languageID],ENT_QUOTES,'UTF-8'): '';

			$output = array('type'=>'image','data' => $setting );

	  		return $output;

		}

	}
?>