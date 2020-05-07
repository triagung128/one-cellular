<?php 
	echo $header; 
	echo $column_left;
	$module_row=0; 
?>
<div id="content">

	<div class="page-header">
		<div class="container-fluid">
			
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div><!-- End div#page-header -->
	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
		<input type="hidden" value="" id="action" name="action"/>
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
			
			<div class="panel-body">
				<ul class="nav nav-tabs" id="grouptab">
					<li><a href="#tab-general" data-toggle="tab"><?php echo $objlang->get('tab_general');?></a></li>
					<li><a href="#tab-position" data-toggle="tab"><?php echo $objlang->get('tab_position');?></a></li>
				</ul>
				<div class="tab-content">
					
					<div id="tab-general" class="tab-pane">
						
						<div class="pull-right">
							<a class="btn btn-primary" onclick="$('#action').val('config');$('#form').submit();"><?php echo $button_save; ?></a>
							<a class="btn btn-danger" href="<?php echo $cancel; ?>"><?php echo $button_cancel; ?></a>
						</div>
						<table class="table">
							<tr class="no-border">
								<td><?php echo $objlang->get('entry_order_status'); ?></td>
								<td>
									<select class="form-control" style="width:30%" class="form-control" name="pavdeals_config[order_status_id]">
										<?php 
											if(isset($order_statuses) && !empty($order_statuses)){
												foreach($order_statuses as $order_status){
													if(isset($general['order_status_id']) && ($order_status['order_status_id'] == $general['order_status_id'])){
										?>
										<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status["name"];?></option>
										<?php }else{ ?>
										<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status["name"];?></option>
										<?php } } } ?>
									</select>
									<br/><p><?php echo $objlang->get("text_order_status_help");?></p>
								</td>
							</tr>
							<tr>
								<td><?php echo $objlang->get("entry_saleoff_icon");?></td>
								<td>
									<?php $image = isset($general['saleoff_icon'])?$general['saleoff_icon']:""; ?>
									<a href="" id="thumb-img" data-toggle="image" class="img-thumbnail">
										<img src="<?php echo empty($bg_thumb)?$no_image:$bg_thumb; ?>" alt="" title="" data-placeholder="<?php echo $no_image; ?>" />
									</a>
									<input type="hidden" name="pavdeals_config[saleoff_icon]" value="<?php echo $general['saleoff_icon']; ?>" id="input-icon-saleoff" />
									<br class="clear clr" style="clear:both"/>
									<p><font style="font-size:12px"><i><?php echo $objlang->get("entry_saleoff_icon_help"); ?></i></font></p>
								</td>
							</tr>
							<tr>
								<td><?php echo $objlang->get('entry_today_deal'); ?><br/><span class="help"><?php echo $objlang->get('help_range_date'); ?></span></td>
								<td>
									<select class="form-control" style="width:30%" class="form-control" id="today-deal" name="pavdeals_config[today_deal]">
										<?php foreach($today_deals as $key=>$value): ?>
										<?php $selected = (isset($general['today_deal']) && ($key == $general['today_deal']))?'selected=selected':''?>
										<option value='<?php echo $key;?>' <?php echo $selected;?> ><?php echo $value;?></option>
										<?php endforeach; ?>
									</select>
									<span class="help"><?php echo $objlang->get('help_range_date_1'); ?></span>
								</td>
							</tr>
							<tr class="deal-specific">
								<td class="col-sm-4"><?php echo $objlang->get('entry_today_date_start_end'); ?></td>
								<td class="col-sm-8">
									<div class="input-group date" style="width:30%">
										<input type="text" name="pavdeals_config[time_end]" value="<?php echo isset($general['time_end'])?$general['time_end']:''; ?>" placeholder="<?php echo $objlang->get('entry_date_available'); ?>" data-date-format="YYYY-MM-DD" id="input-time-end" class="form-control" />
										<span class="input-group-btn">
											<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td><?php echo $objlang->get('enable_available'); ?></td>
								<td>
									<select class="form-control" style="width:30%" class="form-control" id="today-deal" name="pavdeals_config[enable_available]">
										<?php if (isset($general['enable_available']) && $general['enable_available']) { ?>
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
								<td><?php echo $objlang->get('enable_pass'); ?></td>
								<td>
									<select class="form-control" style="width:30%" class="form-control" id="today-deal" name="pavdeals_config[enable_pass]">
										<?php if ($general['enable_pass']) { ?>
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
								<td><?php echo $objlang->get("entry_saleoff_icon_width_height");?></td>
								<td>
									<input style="width:30%" type="text" class="form-control" name="pavdeals_config[icon_width]" value="<?php echo isset($general['icon_width'])?$general['icon_width']:180;?>" size="10"/> / 
									<input style="width:30%" type="text" class="form-control" name="pavdeals_config[icon_height]" value="<?php echo isset($general['icon_height'])?$general['icon_height']:180;?>" size="10"/>
								</td>
							<tr>
							<tr>
								<td><?php echo $objlang->get("entry_limit_cols");?></td>
								<td>
									<input style="width:30%" type="text" class="form-control" value="<?php echo isset($general['limit'])?$general['limit']:10;?>" size="10" name="pavdeals_config[limit]"> - 
									<input  style="width:30%"type="text" class="form-control" value="<?php echo isset($general['cols'])?$general['cols']:3;?>" size="10" name="pavdeals_config[cols]">
								</td>
							</tr>
							<tr>
								<td><?php echo $objlang->get("entry_width_height");?></td>
								<td>
									<input style="width:30%" type="text" class="form-control" value="<?php echo isset($general['width'])?$general['width']:180;?>" size="10" name="pavdeals_config[width]"> /
									<input style="width:30%" type="text" class="form-control" value="<?php echo isset($general['height'])?$general['height']:180;?>" size="10" name="pavdeals_config[height]">
								</td>
							</tr>
						</table>
						
						<div class="more-info">
							<h4><?php echo $objlang->get('text_explain_urlformats');?></h4>
							<ol> 
								<li><div><b><?php echo $objlang->get('text_front_page'); ?></b></div>Normal: <?php echo HTTPS_CATALOG."index.php?route=pavdeals/deals";?></li>
							</ol>
						</div>
					</div> <!-- End Div #tab general -->
					
					
					
					<div id="tab-position" class="tab-pane">
						<div class="form-horizontal">
							
							<div class="row">
								<div class="col-sm-2">
									<ul class="nav nav-pills nav-stacked">
										<?php if ($extensions) { ?>
										<?php foreach ($extensions as $extension) { ?>
										<?php $actived = (empty($module_id))?"class='active'":''; ?>
										<li <?php echo $actived; ?>><a href="<?php echo $extension['edit']; ?>" ><i class="fa fa-plus-circle"></i> <?php echo $extension['name']; ?></a></li>
										<?php $i=0; foreach ($extension['module'] as $m) { $i++;?>
										<?php $active = ($m['module_id'] == $module_id)?'class="active"':''; ?>
										<li <?php echo $active; ?>><a href="<?php echo $m['edit']; ?>" ><i class="fa fa-plus-circle"></i> <?php echo $m['name']; ?></a></li>
										<?php } //end modules?>
										<?php } //end extensions?>
										<?php } //end if?>
									</ul>
								</div>
								<div class="col-sm-10">
									<div class="tab-content" id="tab-content">
										<div class="pull-right">
											<a class="btn btn-primary" title="" onclick="$('#action').val('module');$('#form').submit();" data-toggle="tooltip" data-original-title="Save">Save</a>
											<?php if(!empty($module_id)) { ?>
											<a onclick="confirm('Are you sure?') ? location.href='<?php echo $delete; ?>' : false;" data-toggle="tooltip" title="" class="btn btn-danger" data-original-title="Delete">Delete</a>
											<?php } ?>
										</div>

								
										<div class="tab-pane active" id="tab-module-pavdeal">
											<table class="table">
												<tr class="no-border">
													<td class="col-sm-4"><?php echo $entry_status; ?></td>
													<td class="col-sm-8">
														<select style="width:60%" class="form-control" class="form-control" name="pavdeals_module[status]" id="input-status" class="form-control">
															<?php if ($module['status']) { ?>
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
													<td class="col-sm-4"><?php echo $objlang->get("entry_module_name"); ?></td>
													<td class="col-sm-8">
														<input class="form-control" type="text" placeholder="<?php echo $objlang->get('entry_module_name'); ?>" value="<?php echo isset($module['name'])?$module['name']:''; ?>" name="pavdeals_module[name]" />
													</td>
												</tr>
												<tr>
													<td colspan="2"><?php echo $objlang->get("entry_filter_label"); ?></td>
												</tr>
												<tr>
													<td class="col-sm-4"><?php echo $objlang->get('entry_date_start_end'); ?></td>
													<td class="col-sm-8">
														<?php echo $objlang->get('entry_from'); ?>
														<div class="input-group date" style="width:60%">
															<input type="text" name="pavdeals_module[date_start]" value="<?php echo $module['date_start']; ?>" placeholder="<?php echo $objlang->get('entry_date_start'); ?>" data-date-format="YYYY-MM-DD" id="input-pavdeals-date-start" class="form-control" />
															<span class="input-group-btn">
																<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
															</span>
														</div>

														<?php echo $objlang->get('entry_to'); ?>
														<div class="input-group date" style="width:60%">
															<input type="text" name="pavdeals_module[date_to]" value="<?php echo isset($module['date_to'])?$module['date_to']:''; ?>" placeholder="<?php echo $objlang->get('entry_date_to'); ?>" data-date-format="YYYY-MM-DD" id="input-pavdeals-date-to" class="form-control" />
															<span class="input-group-btn">
																<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
															</span>
														</div>
													</td>
												</tr>
												<tr>
													<td class="col-sm-4"><?php echo $objlang->get('entry_categories'); ?></td>
													<td class="col-sm-8">
														<select class="form-control" name="pavdeals_module[category_ids][]" id="pavdeals_module_category_ids" multiple="multiple" size="10">
															<?php foreach ($categories as $category) { ?>
															<?php if(empty($category['category_id'])) { ?>
															<option onclick="selectAll('#pavdeals_module_category_ids');" value="<?php echo isset($category['category_id'])?$category['category_id']:''; ?>" <?php if( isset($module['category_ids']) && in_array($category['category_id'],$module['category_ids'])) { ?> selected="selected" <?php } ?>><?php echo $category['name']; ?></option>
															<?php } else { ?>
															<option value="<?php echo $category['category_id']; ?>" <?php if( isset($module['category_ids']) && in_array($category['category_id'],$module['category_ids'])) { ?> selected="selected" <?php } ?>><?php echo $category['name']; ?></option>
															<?php } ?>
															<?php } ?>
														</select>
													</td>
												</tr>
												<tr>
													<td class="col-sm-4"><?php echo $objlang->get('entry_sort_order_deals'); ?></td>
													<td class="col-sm-8">
														<select class="form-control" name="pavdeals_module[sort_deals]">
															<?php foreach ($sortdeals as $k=>$v) { ?>
															<?php $selected = (isset($module['sort_deals']) && $module['sort_deals'])?'selected="selected"':''; ?>
															<option <?php echo $selected; ?> value="<?php echo $k; ?>"><?php echo $v; ?></option>
															<?php } ?>
														</select>
													</td>
												</tr>
												<tr>
													<td class="col-sm-4"><?php echo $objlang->get('entry_limit_cols_itemsperpage'); ?></td>
													<td class="col-sm-8">
														<input class="form-control" type="text" name="pavdeals_module[limit]" size="10" value="<?php echo isset($module['limit'])?$module['limit']:4; ?>"/> - 
														<input class="form-control" type="text" name="pavdeals_module[cols]" size="10" value="<?php echo isset($module['cols'])?$module['cols']:4;?>"/> - 
														<input class="form-control" type="text" name="pavdeals_module[itemsperpage]" size="10" value="<?php echo isset($module['itemsperpage'])?$module['itemsperpage']:4; ?>"/>
													</td>
												</tr>
												<tr>
													<td class="col-sm-4"><?php echo $objlang->get('entry_additional_class'); ?></td>
													<td class="col-sm-8">
														<input class="form-control" type="text" name="pavdeals_module[prefix]" size="45" value="<?php echo isset($module['prefix'])?$module['prefix']:'class'; ?>"/>
													</td>
												</tr>
												<tr>
													<td class="col-sm-4"><?php echo $objlang->get('entry_width_height'); ?></td>
													<td class="col-sm-8">
														<input class="form-control" type="text" name="pavdeals_module[width]" size="10" value="<?php echo isset($module['width'])?$module['width']:'200'; ?>"/> x 
														<input class="form-control" type="text" name="pavdeals_module[height]" size="10" value="<?php echo isset($module['height'])?$module['height']:'200'; ?>"/>
													</td>
												</tr>
												<tr>
													<td class="col-sm-4"><?php echo $objlang->get('entry_auto_play'); ?></td>
													<td class="col-sm-8">
														<select class="form-control" class="form-control" name="pavdeals_module[auto_play]">
															<?php foreach ($yesno as $k=>$v) { ?>
															<?php $selected = (isset($module['auto_play']) && $module['auto_play'])?'selected="selected"':''; ?>
															<option <?php echo $selected; ?> value="<?php echo $k; ?>"><?php echo $v; ?></option>
															<?php } ?>
														</select>
													</td>
												</tr>
												<tr>
													<td class="col-sm-4"><?php echo $objlang->get('entry_interval'); ?></td>
													<td class="col-sm-8">
														<input class="form-control" type="text" name="pavdeals_module[interval]" size="10" value="<?php echo isset($module['interval'])?$module['interval']:'1000'; ?>"/>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div> <!-- End Div.Tab Module -->
							</div>
							
						</div>
					</div><!-- End Div #tab position -->
					
				</div>
			</div>

		</div>


	</div><!-- end div #page-content -->
	</form>
</div><!-- End div.content -->

<script type="text/javascript">
	$('#grouptab li:first-child a').tab('show');

	// Cookies tab
	$('#grouptab a').click( function(){
		$.cookie("megaactived_tab", $(this).attr("href") );
	});

	if($.cookie("megaactived_tab") !="undefined"){
		$('#grouptab a').each( function(){
			if( $(this).attr("href") ==  $.cookie("megaactived_tab")){
				$(this).click();
				return ;
			}
		});
	}

	// Active Tab Module
	$('#module-pavdeal li:first-child a').tab('show');

	// Multiple Store
	$('#pavstores').bind('change', function () {
		url = 'index.php?route=module/pavdeals&token=<?php echo $token; ?>';
		var id = $(this).val();
		if (id) {
			url += '&store_id=' + encodeURIComponent(id);
		}
		window.location = url;
	});

	// Choose Show Format Today-Deal
	selectbox($("#today-deal").val());
	$( "#today-deal" ).change(function() {
		$selected = $(this).val();
		selectbox($selected);
	});
	function selectbox($selected) {
		$(".deal-specific").hide();
		if($selected == 99){
			$(".deal-specific").show();
		}
	}

	// Select ALL
	function selectAll(obj){
		$(obj).find("option").each(function(index,Element) {
			$(Element).attr("selected","selected");
		}); 
	}
	// Date
	$('.date').datetimepicker({
		pickTime: false
	});

	$('.time').datetimepicker({
		pickDate: false
	});

	$('.datetime').datetimepicker({
		pickDate: true,
		pickTime: true
	});
</script> 

<style type="text/css">
	.no-border > td{ border-top: 1px solid white !important;}
</style>
<?php echo $footer; ?>
