<?php 
	echo $header; 
	echo $column_left;
	$module_row=0; 
?>
<div id="content">

	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<a class="btn btn-primary" onclick="$('#form').submit();"><?php echo $button_save; ?></a>
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
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>
			<?php echo $error_warning; ?>
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
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
			</div>
			<!-- ############################################ -->
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
				<div class="panel-body">
					<!-- Status -->
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
						<div class="col-sm-10">
							<select style="width:60%" class="form-control" class="form-control" name="pavautosearch_status" id="input-status">
								<?php if ($pavautosearch_status) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select><br>
						</div>
					</div>
					<!-- Modules -->
					<div class="row">
						<div class="col-sm-2">
							<ul class="nav nav-pills nav-stacked" id="module-pavautosearch">
								<?php $module_row = 1; ?>
								<?php foreach ($modules as $module) { ?>
								<li>
									<a href="#tab-module-pavautosearch-<?php echo $module_row; ?>" id="module-pavautosearch-<?php echo $module_row; ?>" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$('a[href=\'#tab-module-pavautosearch-<?php echo $module_row; ?>\']').parent().remove(); $('#tab-module-pavautosearch-<?php echo $module_row; ?>').remove(); $('#module a:first').tab('show');"></i> <?php echo $tab_module . ' ' . $module_row; ?></a>
								</li>
								<?php $module_row++; ?>
								<?php } ?>
								<li id="module-add"><a onclick="addModule();"><i class="fa fa-plus-circle"></i> <?php echo $objlang->get('button_module_add'); ?></a></li>
							</ul>
						</div> <!-- End UL TAB -->
						<div class="col-sm-10">
							<div class="tab-content" id="tab-content">
								
								<?php $module_row = 1; ?>
								<?php foreach ($modules as $module) { ?>
								<div class="tab-pane" id="tab-module-pavautosearch-<?php echo $module_row ;?>">
									<table class="table no-border">
										<tr>
											<td class="col-sm-4"><?php echo $objlang->get("entry_additional_class"); ?></td>
											<td><input class="form-control" type="text" name="pavautosearch_module[<?php echo $module_row; ?>][class]" value="<?php echo isset($module['class'])?$module['class']:''; ?>" size="35" /></td>
										</tr>
										<tr>
											<td class="col-sm-4"><?php echo $objlang->get("entry_limit"); ?></td>   
											<td class="col-sm-8"><input class="form-control" type="text" name="pavautosearch_module[<?php echo $module_row; ?>][limit]" value="<?php echo isset($module['limit'])?$module['limit']:'5'; ?>" size="5" /></td> 
										</tr>
										<tr>
											<td class="col-sm-4"><?php echo $objlang->get("entry_show_category"); ?></td>
											<td class="col-sm-8">
												<select class="form-control no-style" name="pavautosearch_module[<?php echo $module_row; ?>][show_category]">
													<?php if ($module['show_category']) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
										<tr>
											<td class="col-sm-4"><?php echo $objlang->get("entry_display_image"); ?></td>
											<td>
												<select class="form-control no-style" name="pavautosearch_module[<?php echo $module_row; ?>][show_image]">
													<?php if (isset($module['show_image']) && $module['show_image']) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
										<tr>
											<td class="col-sm-4"><?php echo $objlang->get("entry_display_price"); ?></td>
											<td>
												<select class="form-control no-style" name="pavautosearch_module[<?php echo $module_row; ?>][show_price]">
													<?php if (isset($module['show_price']) && $module['show_price']) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
									</table> 
								</div>
								<?php $module_row++; ?>
								<?php } ?>

							</div>
						</div>
					</div>
				</div>
			</form>
			<!-- ############################################ -->
		</div>
	</div><!-- End div#page-content -->

</div><!-- End div#content -->

<script type="text/javascript">
// Active Tab Module
$('#module-pavautosearch li:first-child a').tab('show');
</script>
<script type="text/javascript">
var module_row = <?php echo $module_row; ?>;

function addModule() {

	html  = '<div class="tab-pane" id="tab-module-pavautosearch-' + module_row + '">';
	html += '	<table class="table no-border">';
	html += '		<tr>';
	html += '			<td class="col-sm-4"><?php echo $objlang->get("entry_additional_class"); ?></td>';
	html += '			<td class="col-sm-8"><input class="form-control" type="text" name="pavautosearch_module[' + module_row + '][class]" value="class" size="35" /></td>';
	html += '		</tr>';
	html += '		<tr>';
	html += '			<td class="col-sm-4"><?php echo $objlang->get("entry_limit"); ?></td> ';  
	html += '			<td class="col-sm-10"><input class="form-control" type="text" name="pavautosearch_module[' + module_row + '][limit]" value="5" size="5" /></td> ';
	html += '		</tr>';

	html += '		<tr>';
	html += '			<td class="col-sm-4"><?php echo $objlang->get("entry_show_category"); ?></td>';
	html += '			<td class="col-sm-8"><select class="form-control no-style" name="pavautosearch_module[' + module_row + '][show_category]">';
	html += '			<option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
	html += '			<option value="0"><?php echo $text_disabled; ?></option>';
	html += '		</select></td>';
	html += '		</tr>';

	html += '		<tr>';
	html += '			<td class="col-sm-4"><?php echo $objlang->get("entry_display_image"); ?></td>';
	html += '			<td class="col-sm-8"><select class="form-control no-style" name="pavautosearch_module[' + module_row + '][show_image]">';
	html += '			<option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
	html += '			<option value="0"><?php echo $text_disabled; ?></option>';
	html += '		</select></td>';
	html += '		</tr>';
	html += '		<tr>';
	html += '			<td class="col-sm-4"><?php echo $objlang->get("entry_display_price"); ?></td>';
	html += '			<td class="col-sm-8"><select class="form-control no-style" name="pavautosearch_module[' + module_row + '][show_price]">';
	html += '			<option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
	html += '			<option value="0"><?php echo $text_disabled; ?></option>';
	html += '		</select></td>';
	html += '		</tr>';
	html += '	</table>';

	html += '</div>'

	$('#tab-content').append(html);

	$('#module-pavautosearch #module-add').before('<li><a href="#tab-module-pavautosearch-' + module_row + '" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$(\'a[href=\\\'#tab-module-pavautosearch-' + module_row + '\\\']\').parent().remove(); $(\'#tab-module-pavautosearch-' + module_row + '\').remove(); $(\'#module a:first\').tab(\'show\');"></i> <?php echo $tab_module; ?> ' + module_row + '</a></li>');

	$('#module-pavautosearch a[href=\'#tab-module-pavautosearch-' + module_row + '\']').tab('show');

	module_row++;
}
</script>

<style type="text/css">
	.no-border > td{ border-top: 1px solid white !important;}
	.no-style { width:30%;}
</style>
<?php echo $footer; ?>