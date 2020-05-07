<?php $module_row=0;  ?>
<html>
<title>Vertical Menu Title</title>

<script type="text/javascript" src="view/javascript/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="view/javascript/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui.min.js"></script>
<link type="text/css" href="view/javascript/jquery/ui/jquery-ui.min.css" rel="stylesheet" />
<link type="text/css" href="view/javascript/bootstrap/css/bootstrap.css" rel="stylesheet" />
<script src="view/javascript/common.js" type="text/javascript"></script>
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>

<style type="text/css"> #page-content{ min-height: 1200px; width: 100%; padding-bottom: 100px } </style>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>

<div id="page-content">
<div id="menu-form"  style="display: none; left: 340px; top: 15px; max-width:600px" class="popover top out form-setting">
		<div class="arrow"></div>
		<h3 style="display: block;" class="popover-title">Sub Menu Setting <span class="badge pull-right"><?php echo $objlang->get('text_close');?></span></h3>
		<div class="popover-content"> 
			<form  method="post" action="<?php echo $liveedit_action;?>"  enctype="multipart/form-data" >
			<div class="col-lg-12">	
			<table class="table table-hover">
		 
				<tr>
					<td><?php echo $objlang->get('text_create_submenu');?></td>
					<td>
						<select name="menu_submenu" class="menu_submenu form-control">
							<option value="0"><?php echo $objlang->get('text_no');?></option>
							<option value="1"><?php echo $objlang->get('text_yes');?></option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td><?php echo $objlang->get('text_width_submenu');?></td>
					<td>
						 <input type="text" name="menu_subwidth" class="menu_subwidth form-control"> 
					</td>
				</tr>
					<tr>
					<td colspan="2">
						<button type="button" class="add-row btn btn-success btn-sm"><?php echo $objlang->get('text_add_row');?></button>
					</td>
				</tr>
			</table>
			<input type="hidden" name="menu_id">
			</div>
		 
			</form>
		</div>
	</div>


<div id="content-s">

	<div class="container">
		<div class="page-header">
		<h1 ><?php echo $objlang->get('text_heading_live_edit_verticalmenu') ;?></h1>
 		</div>
	 	<div class="bs-example">
	      <div class="alert alert-danger fade in">
	        <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
	        <strong><?php echo $objlang->get('text_explain_live_editor'); ?></strong>  
	      </div>
	    </div>
 	</div>
	<div id="column-form" style="display: none; left: 340px; top: 45px;" class="popover top   form-setting">
		<div class="arrow"></div>
		<h3 style="display: block;" class="popover-title">Column Setting <span class="badge pull-right"><?php echo $objlang->get('text_close');?></span></h3>
		<div class="popover-content"> 
			<form    method="post" action="<?php echo $liveedit_action;?>"  enctype="multipart/form-data" >
			<table class="table table-hover">
				<tr>
					<td><?php echo $objlang->get('text_addition_class');?></td>
					<td>
						<input type="text" class="form-control" name="colclass"> 
					</td>
				</tr>
				<tr>
					<td>Column Width</td>
					<td>
						<select class="colwidth form-control" name="colwidth">
							<?php for( $i = 1; $i<=12; $i++ )  { ?>
							<option value="<?php echo $i;?>"><?php echo $i;?></option>
							<?php } ?>
						</select>
					</td>
				</tr>
			</table>
			</form>
		</div>
	</div>


	<div  id="submenu-form" style="display: none; left: 340px; top: 45px;" class="popover top  form-setting">
		<div class="arrow"></div>
		<h3 style="display: block;" class="popover-title"><?php echo $objlang->get('text_setting_sub_submenu');?><span class="badge pull-right"><?php echo $objlang->get('text_close');?></span></h3>
		<div class="popover-content"> 
			<form   method="post" action="<?php echo $liveedit_action;?>"  enctype="multipart/form-data" >
									   					
				<input type="hidden" name="submenu_id">
				<table class="table table-hover">
					<tr>
						<td><?php echo $objlang->get('text_group_submenu');?></td>
						<td>
							<select class="form-control" name="submenu_group">
								<option value="0"><?php echo $objlang->get('text_no');?></option>
								<option value="1"><?php echo $objlang->get('text_yes');?></option>
							</select>
						</td>
					</tr>	  
				</table>
			</form>
		</div>
	</div>

   	<div id="pav-verticalmenu-liveedit">

	<div id="toolbar" class="container">
		<div id="menu-toolbars">
				   						
			<div>
				<div class="pull-right">
					
					
					
					<a id="unset-data-menu" href="#" class="btn btn-danger btn-action"><?php echo $objlang->get('text_reset_verticalmenu');?></a>
					
					<button id="save-data-menu" class="btn btn-warning">Save</button>
				</div>
				<a id="save-data-back" class="btn btn-default" href="<?php echo $action_backlink;?>"><?php echo $objlang->get('text_back');?></a>
			</div>

		</div>
	</div>
	   		

		<div class="container"><div class="verticalmenu-wrap">
			<div class="progress" id="pavo-progress">
				<div class="progress-bar progress-bar-warning progress-bar-striped" role="progressbar"  aria-valuemin="0" aria-valuemax="100" style="width: 00%;">
					<span class="sr-only">60% Complete</span>
				</div>
			</div>
   		<div id="verticalmenu-content">
   		</div></div>
	 	</div>

   	</div>
</div>
 </div>

 

  <!-- Modal -->
  <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title"><?php echo $objlang->get('text_preview_on_live_site');?></h4>
        </div>
        <div class="modal-body">
         	
        </div>
        <div class="modal-footer">
          	<button type="button" class="btn btn-submit btn-danger"  data-type="save"><?php echo $objlang->get('text_save'); ?></button>
          <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $objlang->get('text_close'); ?></button>
        </div>
      </div> 
    </div> 
  </div> 

<!-- Widgets -->
<div class="modal fade" id="mdwidgetbuttons" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      <h4 class="modal-title"><?php echo $objlang->get('text_preview_on_live_site');?></h4>
    </div>
    <div class="modal-body">

<div class="wpo-widgets clearfix">
	
	<div class="widgets-filter">
		<div class="form-group has-success clearfix">
			<label class="col-lg-2 control-label" for="searchwidgets"><?php echo $objlang->get('Filter By Name');?></label>
			<div class="col-lg-10">
				<input class="form-control" type="text" id="searchwidgets"  name="searchwidgets">
			</div>
		</div>

		<div class="form-group clearfix">
			<label class="col-lg-2 control-label" for="searchwidgets"><?php echo $objlang->get('Filter By Group');?></label>
			<div class="col-lg-10" id="filterbygroups">
				 <ul class="nav nav-pills">
				 	<li class="filter-option" data-option="all">
						<a href="#"><?php echo $objlang->get('All');?><span class="badge"></span></a>
					</li>

				 	<?php  foreach( $groups  as $group) { ?>
					<li class="filter-option" data-option="<?php echo $group['key'];?>">
						<a href="#"><?php echo $group['group'];?><span class="badge"></span></a>
					</li>
			 		<?php } ?>
				</ul>
	      </div>  
		</div>
 	</div>

	<ul>
		<?php foreach ( $widgets as $widget ){ ?>
		<li class="wpo-wg-button" data-group="<?php echo $widget['group'];?>"> 
			 <?php echo $widget['button'];?>
		</li>
		<?php } ?>
 	</ul>
 	<div class="clearfix"></div>
</div>


   </div>
        <div class="modal-footer">
          	<button type="button" class="btn btn-submit btn-danger"  data-type="save"><?php echo $objlang->get('text_save'); ?></button>
          	<button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $objlang->get('text_close'); ?></button>
        </div>
      </div> 
    </div> 
  </div> 


<script type="text/javascript">
	$(".btn-modal").click( function(){
		$('#myModal .modal-dialog').css('width',980);
		var a = $( '<span class="glyphicon glyphicon-refresh"></span><iframe src="'+$(this).attr('href')+'" style="width:100%;height:100%; display:none"/>'  );
		$('#myModal .modal-body').html( a );
			
		$('#myModal').modal( );
		$('#myModal').attr('rel', $(this).attr('rel') );
		$( a  ).load( function(){  
			
			$('#myModal .modal-body .glyphicon-refresh').hide();
	 		$('#myModal .modal-body iframe').show();
		} );
		return false;
	} );
	
	$('#myModal').on('hidden.bs.modal', function () { 
	 	 if( $(this).attr('rel') == 'refresh-page' ){
	 	 	location.reload();
	 	 }
	})


	var _action 	   = '<?php echo str_replace("&amp;","&",$ajxgenmenu);?>';
	var _action_menu   = '<?php echo str_replace("&amp;","&",$ajxmenuinfo);?>';
	var _action_widget = '<?php echo str_replace("&amp;","&",$action_widget);?>';
	var _action_wform  = '<?php echo str_replace("&amp;","&",$action_wform);?>';

	$("#verticalmenu-content").PavMegamenuEditor({
		'action':_action, 
		'action_menu':_action_menu,
		'action_widget':_action_widget,
		'action_wform':_action_wform,
	});

</script>
 </html>
