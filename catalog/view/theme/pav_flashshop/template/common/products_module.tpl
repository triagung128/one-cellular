<?php
    $config = $sconfig;
    $theme  = $themename;
	$cols = isset($customcols)? $customcols : 2;
	$span = 12/$cols;
					$themeConfig  	 			= (array)$config->get('themecontrol');
						$listingConfig  			= array(
				'category_pzoom' 		=> 1,
				'show_swap_image' 		=> 0,
					'quickview' 			=> 0,
				'product_layout'		=> 'default',
					'catalog_mode'			=> '',
	);
				$listingConfig  			= array_merge($listingConfig, $themeConfig );
				$categoryPzoom 	    		= $listingConfig['category_pzoom'];
						$quickview 					= $listingConfig['quickview'];
						$swapimg 					= ($listingConfig['show_swap_image'])?'swap':'';

	if( isset($_COOKIE[$theme.'_productlayout']) && $listingConfig['enable_paneltool'] && $_COOKIE[$theme.'_productlayout'] ){
		$listingConfig['product_layout'] = trim($_COOKIE[$theme.'_productlayout']);
	}

	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';
	if( !is_file($productLayout) ){
		$listingConfig['product_layout'] = 'default';
	}
  $productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';
?>
<div class="panel-heading">
	<h3 class="panel-title"><?php echo $heading_title; ?></h3>
</div>
<div class="products-block panel-body">
	<?php foreach ($products as $i => $product) { $i=$i+1; ?>
	<?php if( $i%$cols == 1 && $cols > 1 ) { ?>
	<div class="row products-row">
		<?php } ?>
		<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-<?php echo $span;?> col-xs-12 product-col">
			<?php require( $productLayout );  ?>
		</div>
		<?php if( ($i%$cols == 0 || $i==count($products) ) && $cols > 1 ) { ?>
	</div>
	<?php } ?>
	<?php } ?>
</div>