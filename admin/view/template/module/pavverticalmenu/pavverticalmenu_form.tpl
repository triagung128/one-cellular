<?php
/******************************************************
 * @package Pav verticalmenu module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/?>


<?php if( $menu ): $module_row= 'ss'; ?>
<?php if( $menu['verticalmenu_id'] > 0 ) { ?>
<h3><?php echo sprintf($text_edit_menu, $menu['title'], $menu['verticalmenu_id']);?></h3>
<?php } else { ?><h3><?php echo $text_create_new;?></h3><?php } ?>
<div>

	<h4><?php echo $objlang->get('entry_menu_information');?></h4>

	<ul class="nav nav-tabs" id="language-<?php echo $module_row; ?>">
		<?php foreach ($languages as $language) { ?>
		<li>
			<a href="#tab-language-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
		</li>
		<?php } ?>
	</ul>


	<div class="tab-content">
		<?php foreach ($languages as $language) { ?>
		<div class="tab-pane" id="tab-language-<?php echo $language['language_id']; ?>">
			<table class="table">
				<tr>
					<td class="col-sm-3 no-border"><?php echo $objlang->get('entry_title_menu');?></td>
					<td class="col-sm-9 no-border"><input class="form-control" name="verticalmenu_description[<?php echo $language['language_id'];?>][title]" value="<?php echo (isset($menu_description[$language['language_id']]['title'])?$menu_description[$language['language_id']]['title']:"" );?>"/></td>
				</tr>
				<tr>
					<td class="col-sm-3"><?php echo $objlang->get('entry_description');?></td>
					<td class="col-sm-9">
						<textarea name="verticalmenu_description[<?php echo $language['language_id'];?>][description]" value=""><?php echo (isset($menu_description[$language['language_id']]['description'])?$menu_description[$language['language_id']]['description']:"");?></textarea>
					</td>
				</tr>
			</table>
		</div>
		<?php } ?>
	</div>

	<!-- Entry Menu Type -->
	<h4><?php echo $objlang->get('entry_menu_type');?></h4>
	<input type="hidden" name="verticalmenu[item]" value="<?php echo $menu['item'];?>" />
	<table class="table">
		<tr>
			<td class="col-sm-3"><?php echo $objlang->get('entry_publish');?></td>
			<td class="col-sm-9">
				<select class="form-control" type="list" name="verticalmenu[published]" >
					<?php foreach( $yesno as $key => $val ){ ?>
					<option value="<?php echo $key;?>" <?php if( $key==$menu['published']){ ?> selected="selected"<?php } ?>><?php echo $val; ?></option>
					<?php } ?>
				</select>
 			</td>
		</tr>
		<tr>
			<td class="col-sm-3"><?php echo $objlang->get('entry_type');?></td>
			<td class="col-sm-9">
				<select class="form-control" name="verticalmenu[type]" id="verticalmenutype">
					<?php foreach(  $verticalmenutypes as $mt => $val ){ ?>
					<option value="<?php echo $mt; ?>" <?php if($mt == $menu['type']) {?> selected="selected" <?php } ?>><?php echo $val; ?></option>
					<?php } ?>
				</select>
 			</td>
		</tr>
		<tr id="verticalmenutype-url" class="verticalmenutype">
			<td class="col-sm-3"><?php echo $objlang->get('entry_url');?></td>
			<td class="col-sm-9">
				<input type="text" class="form-control" name="verticalmenu[url]" value="<?php echo $menu['url'];?>" size="50"/>
			</td>
		</tr>
		<tr id="verticalmenutype-category" class="verticalmenutype">
			<td class="col-sm-3"><?php echo $objlang->get('entry_category');?></td>
			<td class="col-sm-9">
				<input type="text" class="form-control" name="path" value="<?php echo $menu['verticalmenu-category'];?>" size="100" />
                <i><?php echo $objlang->get('text_explain_input_auto');?></i>
			</td>
		</tr>
		<tr id="verticalmenutype-product" class="verticalmenutype">
			<td class="col-sm-3"><?php echo $objlang->get('entry_product');?></td>
			<td class="col-sm-9">
				<input type="text" class="form-control" name="verticalmenu-product" value="<?php echo $menu['verticalmenu-product'];?>" size="50"/>
				<i><?php echo $objlang->get('text_explain_input_auto');?></i>
			</td>
		</tr>
		<tr id="verticalmenutype-manufacturer" class="verticalmenutype">
			<td class="col-sm-3"><?php echo $objlang->get('entry_manufacturer');?></td>
			<td class="col-sm-9">
				<input type="text" class="form-control" name="verticalmenu-manufacturer" value="<?php echo $menu['verticalmenu-manufacturer'];?>" size="50"/>
				<i><?php echo $objlang->get('text_explain_input_auto');?></i>
			</td>
		</tr>
		<tr id="verticalmenutype-information" class="verticalmenutype">
			<td class="col-sm-3"><?php echo $objlang->get('entry_information');?></td>
			<td class="col-sm-9">
				<select class="form-control" type="text" name="verticalmenu-information" id="verticalmenu-information">
					<?php foreach( $informations as $info ){ ?>
					<option value="<?php echo $info['information_id'];?>" <?php if( $menu['verticalmenu-information'] == $info['information_id']){ ?> selected="selected" <?php } ?>><?php echo $info['title'];?></option>
					<?php } ?>
				</select>
			</td>
		</tr>
		<tr id="verticalmenutype-html" class="verticalmenutype">
			<td class="col-sm-3"><?php echo $objlang->get('entry_html');?></td>
			<td class="col-sm-9">
				<textarea type="text" name="verticalmenu[content_text]" id="content_text" size="50"><?php echo $menu['content_text'];?></textarea>
				<i><?php echo $objlang->get('text_explain_input_html');?></i>
			</td>
		</tr>
	</table>
	
	<h4><?php echo $objlang->get("entry_menu_params"); ?></h4>	  
 	<table class="table">
		<tr>
			<td class="col-sm-3"><?php echo $objlang->get('entry_parent_id');?></td>
			<td class="col-sm-9">
				<?php echo $menus;?>
 			</td>
		</tr>
		<tr>
            <td class="col-sm-3"><?php echo $entry_image;  ?></td>
            <td class="col-sm-9">
                <a href="" id="thumb-img" data-toggle="image" class="img-thumbnail">
					<img src="<?php echo empty($thumb)?$placeholder:$thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
				</a>
				<input type="hidden" name="verticalmenu[image]" value="<?php echo $menu['image']; ?>" id="input-icon-menu" />
			</td> 		
        </tr>
		<tr>
			<td class="col-sm-3"><?php echo $objlang->get('entry_menuclass');?></td>
			<td class="col-sm-9">
				<input type="text" class="form-control" name="verticalmenu[menu_class]" value="<?php echo $menu['menu_class']?>"/>
 			</td>
		</tr>	
		<tr>
			<td class="col-sm-3"><?php echo $objlang->get('entry_font_icon');?></td>
			<td class="col-sm-9">
				<input type="text" class="form-control" name="verticalmenu[icon]" value="<?php echo isset($menu['icon'])?$menu['icon']:'';?>"/>
 				<i><?php echo $objlang->get('text_explain_font');?></i>
 			</td>
		</tr>
		<tr>
			<td class="col-sm-3"><?php echo $objlang->get('entry_showtitle');?></td>
			<td class="col-sm-9">
				<select class="form-control" type="list" name="verticalmenu[show_title]" >
					<?php foreach( $yesno as $key => $val ){ ?>
					<option value="<?php echo $key;?>" <?php if( $key==$menu['show_title']){ ?> selected="selected"<?php } ?>><?php echo $val; ?></option>
					<?php } ?>
				</select>
 			</td>
		</tr>
		<tr>
			<td class="col-sm-3"><?php echo $objlang->get('entry_isgroup');?></td>
			<td class="col-sm-9">
				<select class="form-control" type="list" name="verticalmenu[is_group]" value="">
					<?php foreach( $yesno as $key => $val ){ ?>
					<option value="<?php echo $key;?>" <?php if( $key==$menu['is_group']){ ?> selected="selected"<?php } ?>><?php echo $val; ?></option>
					<?php } ?>
				</select>
				<i><?php echo $objlang->get('text_explain_group');?></i>
 			</td>
		</tr>
		<tr style="display:none">
			<td class="col-sm-3"><?php echo $objlang->get('entry_iscontent');?></td>
			<td class="col-sm-9">
				<select class="form-control" type="list" name="verticalmenu[is_content]">
					<?php foreach( $yesno as $key => $val ){ ?>
					<option value="<?php echo $key;?>" <?php if( $key==$menu['is_content']){ ?> selected="selected"<?php } ?>><?php echo $val; ?></option>
					<?php } ?>
				</select>
 			</td>
		</tr>
		<tr>
			<td class="col-sm-3"><?php echo $objlang->get("entry_columns");?></td>
			<td class="col-sm-9">
				<input type="text" class="form-control" name="verticalmenu[colums]" value="<?php echo $menu['colums']?>"/>
				<i><?php echo $objlang->get('text_explain_columns');?></i>
 			</td>
		</tr>
		<tr>
			<td class="col-sm-3"><?php echo $objlang->get("entry_detail_columns");?></td>
			<td class="col-sm-9">
				<textarea type="text" name="verticalmenu[submenu_colum_width]" rows="5"><?php echo $menu['submenu_colum_width']?></textarea>
				<i><?php echo $objlang->get('text_explain_submenu_cols');?></i>
 			</td>
		</tr>
		<tr>
			<td class="col-sm-3"><?php echo $objlang->get("entry_sub_menutype");?></td>
			<td class="col-sm-9">
				<select class="form-control" name="verticalmenu[type_submenu]" id="verticalmenu-type_submenu">
					<?php foreach( $submenutypes as $stype => $text ) { ?>
					<option value="<?php echo $stype;?>" <?php if($stype==$menu['type_submenu']) { ?> selected="selected"<?php } ?>><?php echo $text;?></option>
					<?php } ?>
				</select>
				<i><?php echo $objlang->get('text_explain_submenu_type');?></i>
			</td>
		</tr>
		<tr class="type_submenu" id="type_submenu-html" style="display:none;">
			<td class="col-sm-3"><?php echo $objlang->get('entry_submenu_content');?></td>
			<td class="col-sm-9">
				<textarea name="verticalmenu[submenu_content]" id="submenu_content"><?php echo $menu['submenu_content'];?></textarea>
			
			</td>
		<tr>
		<tr class="type_submenu" id="type_submenu-widget" style="display:none;">
			<td class="col-sm-3"><?php echo $objlang->get('entry_widget_id');?></td>
			<td class="col-sm-9">
				 <?php if( is_array($widgets) )  { ?>
				 <select class="form-control" name="verticalmenu[widget_id]">
				 	<?php foreach( $widgets as $w => $t ) { ?>
				 	<option <?php if($t['id'] == $menu['widget_id']) { ?> selected="selected" <?php } ?>value="<?php echo $t['id']; ?>"><?php echo $t['name']; ?></option>
				 	<?php } ?>
				 </select>
				 <?php } ?>
			</td>
		<tr>
	</table>
	<input type="hidden" name="verticalmenu[verticalmenu_id]" value="<?php echo $menu['verticalmenu_id']?>"/>

</div>
<?php endif; ?>
<script type="text/javascript">
$('#language-<?php echo $module_row; ?> li:first-child a').tab('show');
</script>
<style type="text/css">
	.no-border { border-top: 1px solid white !important;}
	.no-style { width:30%;}
</style>
<script type="text/javascript">
$("#type_submenu-"+$("#verticalmenu-type_submenu").val()).show();
$("#verticalmenu-type_submenu").change( function(){
	$(".type_submenu").hide();
	$("#type_submenu-"+$(this).val()).show();
});

// Editor textarea
$('#submenu_content').summernote({ height: 300 });
$('#content_text').summernote({ height: 300 });

// Active first tab language
$('#language-<?php echo $module_row; ?> li:first-child a').tab('show');

$(".verticalmenutype").hide();
$("#verticalmenutype-"+ $("#verticalmenutype").val()).show();
$("#verticalmenutype").change( function(){
	$(".verticalmenutype").hide();
	$("#verticalmenutype-"+$(this).val()).show();
});


$('input[name=\'verticalmenu-manufacturer\']').autocomplete({
	delay: 500,
	source: function(request, response) {		
		$.ajax({
			url: 'index.php?route=catalog/manufacturer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				json.unshift({
					'manufacturer_id':  0,
					'name':  '<?php echo $text_none; ?>'
				});
				
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.manufacturer_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'verticalmenu-manufacturer\']').val(ui.item.label);
		$('input[name=\'verticalmenu[item]\']').val(ui.item.value);
		
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$("#verticalmenu-information").change( function(){ 
	$('input[name=\'verticalmenu[item]\']').val($(this).val());
} );

$('input[name=\'verticalmenu-product\']').autocomplete({
	delay: 500,
	source: function(request, response) {		
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				json.unshift({
					'product_id':  0,
					'name':  '<?php echo $text_none; ?>'
				});
				
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'verticalmenu-product\']').val(ui.item.label);
		$('input[name=\'verticalmenu[item]\']').val(ui.item.value);
		
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

   
$('input[name=\'path\']').autocomplete({
	delay: 500,
	source: function(request, response) {		
		$.ajax({
			url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				json.unshift({
					'category_id':  0,
					'name':  '<?php echo $text_none; ?>'
				});
				
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.category_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'path\']').val(ui.item.label);
		$('input[name=\'verticalmenu[item]\']').val(ui.item.value);
		
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});
</script>