<?php
	$span = 12/$cols;
	$active = 'latest';
	$id = rand(1,9)+rand();
	$themeConfig = (array)$this->config->get('themecontrol');
	$listingConfig = array(
		'category_pzoom'                     => 1,
		'quickview'                          => 0,
		'show_swap_image'                    => 0,
		'product_layout'		=> 'default',
		'enable_paneltool'	=> 0
	);
	$listingConfig     = array_merge($listingConfig, $themeConfig );
	$categoryPzoom 	    = $listingConfig['category_pzoom'];
	$quickview          = $listingConfig['quickview'];
	$swapimg            = $listingConfig['show_swap_image'];
	$categoryPzoom = isset($themeConfig['category_pzoom']) ? $themeConfig['category_pzoom']:0;
	$theme  = $themename;
	if( $listingConfig['enable_paneltool'] && isset($_COOKIE[$theme.'_productlayout']) && $_COOKIE[$theme.'_productlayout'] ){
		$listingConfig['product_layout'] = trim($_COOKIE[$theme.'_productlayout']);
	}
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';
	if( !is_file($productLayout) ){
		$listingConfig['product_layout'] = 'default';
	}
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';
	$button_cart = $objlang->get('button_cart');
	$button_wishlist = $objlang->get('button_wishlist');
    $button_compare = $objlang->get('button_compare');
	$tab = rand();
	$columns_count  = 1;
?>

<div class="product-tabs panel <?php echo $addition_cls; ?>">
	<?php if( $show_title ) { ?>

		<div class="panel-heading">
		<h3 class="panel-title"><?php echo $heading_title; ?></h3>
	</div>
	<?php } ?>
	<div class="tab-heading text-center">
        <ul role="tablist" class="nav nav-tabs" id="product_tabs<?php echo $id;?>">
        	<?php foreach( $tabs as $tab => $products ) { if( empty($products) ){ continue;} ?>
                <li>
                    <a data-toggle="tab" role="tab" href="#tab-<?php if($tabsstyle=='tab-2'){echo $tab.'-left-'.$id;}elseif($tabsstyle=='tab-3'){echo $tab.'-right-'.$id;;}else{echo $tab.$id;}?>" aria-expanded="true"><i class="fa <?php if($tab == 'latest'){echo $icon_newest;}elseif($tab=='featured'){echo $icon_featured;}elseif($tab=='bestseller'){echo $icon_bestseller;}elseif($tab=='special'){echo $icon_special;}else{echo $icon_mostviews;};?>"></i><?php echo $objlang->get('text_'.$tab); ?></a>
                </li>
            <?php } ?>
        </ul>
     </div>


	 <div class="tab-content ">
		<?php foreach( $tabs as $tab => $products ) {
				if( empty($products) ){ continue;}
			?>
				<div class="tab-pane box-products owl-carousel-play  tabcarousel<?php echo $id; ?>" id="tab-<?php if($tabsstyle=='tab-2'){echo $tab.'-left-'.$id;}elseif($tabsstyle=='tab-3'){echo $tab.'-right-'.$id;;}else{echo $tab.$id;}?>" data-ride="owlcarousel">

				<?php if( count($products) > $itemsperpage ) { ?>
				<div class="carousel-controls">
				<a class="carousel-control left" href="#tab-<?php echo $tab.$id;?>"   data-slide="prev"><i class="zmdi zmdi-chevron-left" aria-hidden="true"></i></a>
				<a class="carousel-control right" href="#tab-<?php echo $tab.$id;?>"  data-slide="next"><i class="zmdi zmdi-chevron-right" aria-hidden="true"></i></a>
				</div>
				<?php } ?>

				<div class="owl-carousel"  data-show="<?php echo ($columns_count); ?>" data-pagination="false" data-navigation="true">
				<?php $pages = array_chunk( $products, $itemsperpage); ?>
				<?php foreach ($pages as  $k => $tproducts ) {   ?>
						<div class="item <?php if($k==0) {?>active<?php } ?> products-block">
							<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
								<?php if( $i%$cols == 1 ) { ?>
								  <div class="row products-row">
								<?php } ?>
									  <div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 product-col">
									  <?php require( $productLayout );  ?>
									  </div>

							  <?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
								 </div>
								<?php } ?>
							<?php } //endforeach; ?>
						</div>
			  	<?php } ?>
				</div>


			</div>
		<?php } // endforeach of tabs ?>
	</div>
</div>


<script>
$(function () {
	$('#product_tabs<?php echo $id;?> a:first').tab('show');
})

</script>