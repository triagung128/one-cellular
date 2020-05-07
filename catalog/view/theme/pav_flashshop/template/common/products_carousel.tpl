<?php
    $config = $sconfig;
    $theme  = $themename;
	$cols = isset($customcols)? $customcols : 4;
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
	$id = md5(rand()+time()+$heading_title);
	$columns_count  = 1;
?>
<div class="panel-heading">
	<h3 class="panel-title">
		<?php echo $heading_title; ?>
	</h3>
</div>

<div class="products-owl-carousel owl-carousel-play panel-body padding-0" id="wrap<?php echo $id; ?>" data-ride="owlcarousel">
 <!-- Controls -->
 <?php
    if(count($products)>$cols){
    ?>
 <div class="carousel-controls">
        <a class="carousel-control left" href="#image-additional" data-slide="prev">
            <i class="zmdi zmdi-chevron-left" aria-hidden="true"></i>
        </a>
        <a class="carousel-control right" href="#image-additional" data-slide="next">
            <i class="zmdi zmdi-chevron-right" aria-hidden="true"></i>
        </a>
    </div>
 <?php } ?>
<div class="owl-carousel product-grid "  data-show="<?php echo ($columns_count); ?>" data-pagination="false" data-navigation="true">

                <?php $pages = array_chunk( $products, $cols); ?>
                    <?php foreach ($pages as  $k => $products ) {   ?>
                    <div class="item <?php if($k==0) {?>active<?php } ?> products-block">
                        <?php foreach( $products as $i => $product ) {  $i=$i+1;?>
                            <?php if( $i%$cols == 1 || $cols == 1) { ?>
                            <div class="row products-row <?php ;if($i == count($products) - $cols +1) { echo "last";} ?>"><?php //start box-product?>
                            <?php } ?>
                                <div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 <?php if($i%$cols == 0) { echo "last";} ?> product-col border">
                                    <?php require( $productLayout );  ?>
                                </div>

                            <?php if( $i%$cols == 0 || $i==count($products) ) { ?>
                            </div><?php //end box-product?>
                            <?php } ?>
                        <?php } //endforeach; ?>
                    </div>
              <?php } ?>
            </div>




</div>
 <script type="text/javascript">
	$(document).ready(function() {
	   var $carousel =  $("#<?php echo $id; ?>");
	   $carousel.owlCarousel({
	        autoPlay: false, //Set AutoPlay to 3 seconds
	        items : <?php echo $cols; ?>,
	        lazyLoad : true,
			navigation: false,
			navigationText:false,
			rewindNav: false,
			pagination:false

	    });
	    $("#wrap<?php echo $id; ?> .carousel-control.left").click(function(){
	         $carousel.trigger('owl.prev');
	    })
	   $("#wrap<?php echo $id; ?> .carousel-control.right").click(function(){
	        $carousel.trigger('owl.next');
	    })
	});
</script>