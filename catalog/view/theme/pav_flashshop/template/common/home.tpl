<?php  echo $header; ?>
<?php require( ThemeControlHelper::getLayoutPath( 'common/config-home.tpl' )  ); ?>
<?php
	$themeConfig = (array)$sconfig->get('themecontrol');
	$fullclass = isset($themeConfig['home_container_full'])&&$themeConfig['home_container_full']?"-full":""; 
?>

<div class="main-columns container<?php echo $fullclass; ?>">
  	<div class="row">
  		<?php echo $column_left; ?>
            <?php if ($column_left && $column_right) { ?>
            <?php $class = 'col-md-6'; ?>
            <?php } elseif ($column_left || $column_right) { ?>
            <?php $class = 'col-md-9'; ?>
            <?php } else { ?>
            <?php $class = 'col-md-12'; ?>
            <?php } ?>

	   	<div id="sidebar-main" class="<?php echo $class; ?>">
			<div id="content"><?php echo $content_top; ?><?php echo $content_bottom; ?></div>
	   	</div>
		<?php echo $column_right; ?>
	</div>
</div>
<?php echo $footer; ?>