<?php
	$config = $sconfig;
	$theme  = $themename;
	$themeConfig = (array)$config->get('themecontrol');
	$listingConfig = array(
		'category_pzoom'        => 1,
		'quickview'             => 0,
		'show_swap_image'       => 0,
		'product_layout'		=> 'default',
		'enable_paneltool'	    => 0
	);
	$listingConfig = array_merge($listingConfig, $themeConfig );
	$categoryPzoom = $listingConfig['category_pzoom'];
	$quickview     = $listingConfig['quickview'];
	$swapimg       = $listingConfig['show_swap_image'];
	$categoryPzoom = isset($themeConfig['category_pzoom']) ? $themeConfig['category_pzoom']:0;

	$span = 12/$cols;

	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';
	if( !is_file($productLayout) ){
		$listingConfig['product_layout'] = 'default';
	}
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';
	$button_cart = $objlang->get('button_cart');
	$button_wishlist = $objlang->get('button_wishlist');
	$button_compare = $objlang->get('button_compare');
	$id = rand(1,9)+rand();

	$columns_count  = 1;
?>
<div class="widget-products">
    <?php if( $show_title ) { ?>
    <h6 class="widget-heading">
        <?php echo $heading_title?>
    </h6>
    <?php } ?>

    <?php if ( isset($imagefile) && $imagefile )  { ?>
     <div class="image-item pull-left hidden-xs hidden-sm">
        <img class="img-responsive" alt=" " src="<?php echo $thumbnailurl; ?>"/>
     </div>
    <?php } ?>

    <div class="list box-products owl-carousel-play <?php echo $addition_cls;?> <?php if ( isset($stylecls)&&$stylecls) { ?>box-<?php echo $stylecls; ?><?php } ?>" id="product_list<?php echo $id;?>" data-ride="owlcarousel">
            <?php if( count($products) > $itemsperpage ) { ?>
            <div class="carousel-controls">
                <a class="carousel-control left" href="#product_list<?php echo $id;?>"   data-slide="prev"><i class="zmdi zmdi-chevron-left" aria-hidden="true"></i></a>
                <a class="carousel-control right" href="#product_list<?php echo $id;?>"  data-slide="next"><i class="zmdi zmdi-chevron-right" aria-hidden="true"></i></a>
            </div>
        <?php } ?>
            <div class="owl-carousel product-grid"  data-show="<?php echo ($columns_count); ?>" data-pagination="false" data-navigation="true">

                <?php $pages = array_chunk( $products, $itemsperpage); ?>
                    <?php foreach ($pages as  $k => $tproducts ) {   ?>
                    <div class="item <?php if($k==0) {?>active<?php } ?> products-block">
                        <?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
                            <?php if( $i%$cols == 1 || $cols == 1) { ?>
                            <div class="row products-row <?php ;if($i == count($tproducts) - $cols +1) { echo "last";} ?>"><?php //start box-product?>
                            <?php } ?>
                                <div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 <?php if($i%$cols == 0) { echo "last";} ?> product-col border">
                                    <?php require( $productLayout );  ?>
                                </div>

                            <?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
                            </div><?php //end box-product?>
                            <?php } ?>
                        <?php } //endforeach; ?>
                    </div>
              <?php } ?>
            </div>
    </div>
    <div class="clearfix"></div>
</div>
