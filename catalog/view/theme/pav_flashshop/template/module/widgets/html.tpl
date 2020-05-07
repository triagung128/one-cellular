
<div class="widget-html <?php echo $addition_cls ?>  <?php if( isset($stylecls)&&$stylecls ) { ?>box-<?php echo $stylecls;?><?php } ?>">
	<?php if( $show_title ) { ?>
	<div class="panel-heading widget-heading">
		<h3 class="panel-title"><?php echo $heading_title?></h3>
	</div>
	<?php } ?>
	<div class="panel-body padding-0">
		<?php echo htmlspecialchars_decode( $html ); ?>
	</div>	 
</div>
