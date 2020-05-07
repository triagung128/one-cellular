<?php echo $header; ?>
<style type="text/css">
	.no-border tbody > tr > td{ border-top: 1px solid white !important; }
</style>
<div id="content">
	<?php if( isset($message) ) { ?> 
	<div class="alert alert-success" role="alert"><?php echo $message; ?></div>
	<?php } ?>
	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
		<table class="table no-border">
			<input value="<?php echo $id;?>" name="widget[id]" type="hidden"/>
			 <?php if( !$disabled ){ ?> 
			<tr>
				<td class="col-sm-2"><?php echo $objlang->get("text_widget_type");?></td>
				<td class="col-sm-10">
					<select class="form-control" name="widget[type]" id="widget_type">
						<option  value=""><?php echo $objlang->get("text_widget_select_one");?></option>	
						<?php foreach( $types as $widget => $text ) { ?>
						<option value="<?php echo $widget; ?>" <?php if( $widget_selected == $widget ) { ?> selected="selected" <?php } ?>><?php echo $text; ?></option>
						<?php } ?>
					</select>
					<script type="text/javascript">
						$('#widget_type').change( function(){
							location.href = '<?php echo html_entity_decode($action); ?>&wtype='+$(this).val();
						} );
					</script>
				</td>
			</tr>
			<?php }   ?>
			<tr>
				<td class="col-sm-2"><?php echo $objlang->get("text_widget_name");?></td>
				<td class="col-sm-10">
					<input class="form-control" type="text" name="widget[name]" value="<?php echo $widget_data['name'];?>">
					 <?php if( $disabled ){ ?> 
					 <input type="hidden" name="widget[type]" value="<?php echo $widget_data['type'];?>">
					 <?php } ?>
				</td>
			</tr>
		</table>
		
		<div>
			<?php echo $form; ?>
		</div>
		<div>
			<button type="submit" class="btn btn-warning">Save</button>
		</div>
	</form>
</div>
<script type="text/javascript">
	 $("#form").submit( function(){ 
	 	var er = false;
	 	$.each( $("#form").serializeArray(), function(i, e){
	 		 if( e.value == '' ){
	 		 	er = true;
	 		 }
	 	} );
	 	if( er ){
	 		alert(  '<?php echo $objlang->get("text_please_fill_data"); ?>' );
	 		return false; 
	 	}
	 	return true;
	 });
</script>
<?php echo $footer; ?>

 