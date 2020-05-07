<?php echo $header; ?><?php echo $column_left; $module_row=0; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
          <a class="btn btn-primary" onclick="$('#form').submit();"><?php echo $button_save; ?></a>
          <a class="btn btn-success" onclick="$('#action').val('save-edit');$('#form').submit();"><?php echo $objlang->get('button_save_stay'); ?></a>
          <a class="btn btn-danger" href="<?php echo $cancel; ?>"><?php echo $button_cancel; ?></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div><!-- End div#page-header -->
  <div id="page-content" class="container-fluid">
    <?php if ($error_warning) { ?>
      <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>
  <?php if (isset($success) && !empty($success)) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
      <input type="hidden" name="action_mode" value="" id="action"/>
         
		<div>
			<table class="table table-striped table-bordered table-hover">

				<tr>
				  <td class="col-sm-2"><?php echo $objlang->get('text_name'); ?></td>
				  <td class="col-sm-10"><input type="text" name="pavtestimonial_module[<?php echo $module_row; ?>][name]" value="<?php echo $module['name']; ?>" size="3" class="form-control" style="width:10%;" /></td>
				</tr>


				<tr>
				  <td class="col-sm-2"><?php echo $objlang->get('text_status'); ?></td>
				  <td class="col-sm-10"><select name="pavtestimonial_module[<?php echo $module_row; ?>][status]" class="form-control" style="width:10%;">
					  <?php if ( isset($module['status']) && $module['status'] ) { ?>
					  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					  <option value="0"><?php echo $text_disabled; ?></option>
					  <?php } else { ?>
					  <option value="1"><?php echo $text_enabled; ?></option>
					  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					  <?php } ?>
					</select></td>
				</tr>


				<tr>
				  <td class="col-sm-2"><?php echo $objlang->get('text_auto_play'); ?></td>
				  <td class="col-sm-10"><select name="pavtestimonial_module[<?php echo $module_row; ?>][auto_play]" class="form-control" style="width:10%;">
					  <?php if ( isset($module['auto_play']) && $module['auto_play'] ) { ?>
					  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					  <option value="0"><?php echo $text_disabled; ?></option>
					  <?php } else { ?>
					  <option value="1"><?php echo $text_enabled; ?></option>
					  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					  <?php } ?>
					</select></td>
				</tr>
				<tr>
				  <td class="col-sm-2"><?php echo $objlang->get('text_interval'); ?></td>
				  <td class="col-sm-10"><input type="text" name="pavtestimonial_module[<?php echo $module_row; ?>][text_interval]" value="<?php echo $module['text_interval']; ?>" size="3" class="form-control" style="width:10%;" /></td>
				</tr>


				<tr>
				  <td class="col-sm-2"><?php echo $entry_width; ?></td>
				  <td class="col-sm-10"><input type="text" name="pavtestimonial_module[<?php echo $module_row; ?>][width]" value="<?php echo $module['width']; ?>" size="8" class="form-control" style="width:10%;"/></td>
				</tr>
				<tr>
				  <td class="col-sm-2"><?php echo $entry_height; ?></td>
				  <td class="col-sm-10"><input type="text" name="pavtestimonial_module[<?php echo $module_row; ?>][height]" value="<?php echo $module['height']; ?>" size="8" class="form-control" style="width:10%;"/></td>
				</tr>


		 		<tr>
				  <td class="col-sm-2"><?php echo $objlang->get('Page Carousel Setting'); ?></td>
				  <td class="col-sm-10">
				  	<div style=" float:left">
		  			<label><?php echo $objlang->get('text_column'); ?></label>
				  	<input type="text" name="pavtestimonial_module[<?php echo $module_row; ?>][column_item]" value="<?php echo $module['column_item']; ?>" class="form-control" style="width:55%;"/>
				  </div>
				  <div style="float:left;padding:0 12px;">
				  	<label><?php echo $objlang->get('text_max_items_page'); ?></label>
					<input type="text" name="pavtestimonial_module[<?php echo $module_row; ?>][page_items]" value="<?php echo $module['page_items']; ?>" class="form-control" style="width:55%;"/>
				</div>
				  </td>
				</tr>
				<tr>
				  <td class="col-sm-2"><?php echo $entry_class; ?></td>
				  <td class="col-sm-10"><input type="text" name="pavtestimonial_module[<?php echo $module_row; ?>][class]" value="<?php echo $module['class']; ?>" size="8" class="form-control" style="width:10%;"/></td>
				</tr>
			</table>
		</div>
		<h3><?php echo $objlang->get('text_header_group_data');?></h3>
		<div class="row">
            <div class="col-sm-2">
              <ul class="nav nav-pills nav-stacked" id="module">
                <?php $banner_row=1;

		  		foreach ($testimonial_item as $banner_row=> $banner) { ?>
	                <li><a href="#tab-module<?php echo $banner_row; ?>" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$('a[href=\'#tab-module<?php echo $banner_row; ?>\']').parent().remove(); $('#tab-module<?php echo $banner_row; ?>').remove(); $('#module a:first').tab('show');"></i> <?php echo $tab_module . ' ' . $banner_row; ?></a></li>
	                <?php $banner_row++; ?>
	                <?php } ?>
	                <li id="module-add"><a onclick="addModule();"><i class="fa fa-plus-circle"></i> <?php echo $button_module_add; ?></a></li>
              </ul>
            </div>
            <div class="col-sm-10">
            <div class="tab-content" id="tab-content">
        <?php $banner_row = 1; ?>
        <?php foreach ($testimonial_item as $banner_row=> $banner) { ?>
        <div class="tab-pane" id="tab-module<?php echo $banner_row; ?>">

		 <table class="table table-striped table-bordered table-hover">

			 <tr>
				<td class="col-sm-2">Avartar</td>
				<td class="col-sm-10">

	                <a href="" id="thumb-image<?php echo $banner_row; ?>" data-toggle="image" class="img-thumbnail">
                   	<img src="<?php echo isset($banner['thumb']) ? $banner['thumb'] : $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                   	<input type="hidden" name="testimonial_item[<?php echo $banner_row; ?>][image]" value="<?php echo $banner['image']; ?>" id="input-image<?php echo $banner_row; ?>" />
	            </td>

			</tr>
			<tr>
				<td class="col-sm-2">Video Testimonial Link (youtube or vimeo link)</td>
				<td class="col-sm-2"><input type="text" name="testimonial_item[<?php echo $banner_row;?>][video_link]" size="100" value="<?php echo $banner['video_link']; ?>" class="form-control" style="width:55%;"/></td>
			</tr>
			<tr>
				<td class="col-sm-2"><?php echo $entry_profile; ?></td>
				<td class="col-sm-2">
					<ul class="nav nav-tabs" id="language-profile-<?php echo $banner_row; ?>">
			            <?php foreach ($languages as $language) { ?>
			            <li><a href="#tab-language-profile<?php echo $banner_row; ?>-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
			            <?php } ?>
		          	</ul>
		          	<div class="tab-content">
			          	 <?php foreach ($languages as $language) { ?>
				          <div class="tab-pane" id="tab-language-profile<?php echo $banner_row; ?>-language<?php echo $language['language_id']; ?>">
				          	<textarea class="pavo-editor" name="testimonial_item[<?php echo $banner_row; ?>][profile][<?php echo $language['language_id']; ?>]" id="profile-<?php echo $banner_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($banner['profile'][$language['language_id']]) ? $banner['profile'][$language['language_id']] : ''; ?></textarea>
				          </div>
				          <?php } ?>
			      	</div>
				</td>
			</tr>

			<tr>
				<td class="col-sm-2"><?php echo $entry_description; ?></td>
				<td class="col-sm-2">
					<ul class="nav nav-tabs" id="language<?php echo $banner_row; ?>">
			            <?php foreach ($languages as $language) { ?>
			            <li><a href="#tab-module<?php echo $banner_row; ?>-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
			            <?php } ?>
			        </ul>

		          	<div class="tab-content">
			          	 <?php foreach ($languages as $language) { ?>
				          <div class="tab-pane" id="tab-module<?php echo $banner_row; ?>-language<?php echo $language['language_id']; ?>">
				          	<textarea class="pavo-editor" name="testimonial_item[<?php echo $banner_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description-<?php echo $banner_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($banner['description'][$language['language_id']]) ? $banner['description'][$language['language_id']] : ''; ?></textarea>
				          </div>
				          <?php } ?>
			      	</div>
				</td>
			</tr>
		  </table>


        </div>

        <?php $banner_row++; } ?>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('.pavo-editor').summernote({
    height: 300
  });
//--></script>
<script type="text/javascript"><!--
var banner_row = <?php echo $banner_row; ?>;

function addModule() {
	html  = '<div class="tab-pane" id="tab-module' + banner_row + '">';


	html += '<table class="table table-striped table-bordered table-hover">';
	html += '<tr>';
	html += '<td class="col-sm-2">Avartar</td>';
	html += '<td class="col-sm-10">';
	html += ' <a href="" id="thumb-image' + banner_row + '" data-toggle="image" class="img-thumbnail">';
	html += ' <img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>';
	html += '<input type="hidden" name="testimonial_item[' + banner_row + '][image]" value="" id="input-image' + banner_row + '" />';
	html += '</td>';
	html += '</tr>';

	html +='<tr><td class="col-sm-2">Video Testimonial Code</td><td class="col-sm-2"><input type="text" name="testimonial_item['+banner_row+'][video_link]" size="100" class="form-control" style="width:55%;"/></td></tr>';
	html += '<tr><td class="col-sm-2"><?php echo $entry_profile; ?></td>';
	html +='			<td class="col-sm-2">';
	html += '  <ul class="nav nav-tabs" id="language-profile-' + banner_row + '">';
  	<?php foreach ($languages as $language) { ?>
	html += '    <li><a href="#tab-language-profile' + banner_row + '-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>';
	<?php } ?>
	html += '  </ul>';
	html += '  <div class="tab-content">';
		          	 <?php foreach ($languages as $language) { ?>
	html += '   			  <div class="tab-pane" id="tab-language-profile' + banner_row + '-language<?php echo $language['language_id']; ?>">';
	html +='		            <textarea class="pavo-editor" name="testimonial_item[<?php echo $banner_row; ?>][profile][<?php echo $language['language_id']; ?>]" id="profile-<?php echo $banner_row; ?>-<?php echo $language['language_id']; ?>"></textarea>';
	html +='		          </div>';
			          <?php } ?>
	html += '    </div>';
	html +='			</td>';
	html +='		</tr>';


	html += '<tr><td class="col-sm-2"><?php echo $entry_description; ?></td>';
	html +='			<td class="col-sm-2">';
	html += '  <ul class="nav nav-tabs" id="language' + banner_row + '">';
  	<?php foreach ($languages as $language) { ?>
	html += '    <li><a href="#tab-module' + banner_row + '-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>';
	<?php } ?>
	html += '  </ul>';
	html += '  <div class="tab-content">';
	<?php foreach ($languages as $language) { ?>
	html += '    <div class="tab-pane" id="tab-module' + banner_row + '-language<?php echo $language['language_id']; ?>">';
	html += '         <textarea class="pavo-editor" name="testimonial_item[' + banner_row + '][description][<?php echo $language['language_id']; ?>]" id="description-' + banner_row + '-<?php echo $language['language_id']; ?>"></textarea>';
	html += '    </div>';
	<?php } ?>
	html += '    </div>';
	html +='			</td>';
	html +='		</tr>';
	html += '</table>';


	html += '</div>';


  $('#tab-content').append(html);

  $('.pavo-editor').summernote({
    height: 300
  });

  $('#module-add').before('<li><a href="#tab-module' + banner_row + '" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$(\'a[href=\\\'#tab-module' + banner_row + '\\\']\').parent().remove(); $(\'#tab-module' + banner_row + '\').remove(); $(\'#module a:first\').tab(\'show\');"></i> <?php echo $tab_module; ?> ' + banner_row + '</a></li>');

  $('#module a[href=\'#tab-module' + banner_row + '\']').tab('show');

  $('#language' + banner_row + ' li:first-child a').tab('show');

  $('#language-profile-' + banner_row + ' li:first-child a').tab('show');

  banner_row++;
}
//--></script>

 <script type="text/javascript"><!--
$('#module li:first-child a').tab('show');
<?php $banner_row = 1; ?>
<?php foreach ($testimonial_item as $banner) { ?>
$('#language<?php echo $banner_row; ?> li:first-child a').tab('show');
$('#language-profile-<?php echo $banner_row; ?> li:first-child a').tab('show');
<?php $banner_row++; ?>
<?php } ?>
//--></script></div>
<?php echo $footer; ?>
