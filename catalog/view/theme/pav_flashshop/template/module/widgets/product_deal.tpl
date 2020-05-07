<?php
    $config = $sconfig;
    $theme  = $themename;
    $themeConfig = (array)$config->get('themecontrol');
    $listingConfig = array(
        'category_pzoom'        => 1,
        'quickview'             => 0,
        'show_swap_image'       => 0,
        'product_layout'        => 'default',
        'enable_paneltool'      => 0
    );
    $listingConfig = array_merge($listingConfig, $themeConfig );
    $categoryPzoom = $listingConfig['category_pzoom'];
    $quickview     = $listingConfig['quickview'];
    $swapimg       = $listingConfig['show_swap_image'];
    $categoryPzoom = isset($themeConfig['category_pzoom']) ? $themeConfig['category_pzoom']:0;

    $span = 12/$cols;

    $productLayout = DIR_TEMPLATE.$theme.'/template/common/product/deal_default.tpl';

    $button_cart = $objlang->get('button_cart');
    $button_wishlist = $objlang->get('button_wishlist');
    $button_compare = $objlang->get('button_compare');
    $id = rand(1,9)+rand();
    $text_sale = $objlang->get('text_sale');
    $text_days = $objlang->get('text_days');
    $text_hours = $objlang->get('text_hours');
    $text_minutes = $objlang->get('text_minutes');
    $text_seconds = $objlang->get('text_seconds');
    $columns_count  = 1;
?>

<div class="productdeals panel panel-danger <?php echo $addition_cls; ?>">
  <?php if( $show_title ) { ?>
  <div class="panel-heading">
    <h3 class="panel-title"><?php echo $heading_title?></h3>
  </div>
  <?php } ?>

  <div class="widget-deals panel-body padding-0">
    <div class="box-products owl-carousel-play product-grid" id="pavdeals<?php echo $id;?>" data-ride="owlcarousel">
        <?php if( count($products) > $itemsperpage ) { ?>
        <div class="carousel-controls">
          <a class="carousel-control left" href="#pavdeals<?php echo $id;?>"   data-slide="prev">
            <i class="zmdi zmdi-chevron-left" aria-hidden="true"></i>
          </a>
          <a class="carousel-control right" href="#pavdeals<?php echo $id;?>"  data-slide="next">
           <i class="zmdi zmdi-chevron-right" aria-hidden="true"></i>
          </a>
        </div>

        <?php } ?>
      <div class="owl-carousel product-grid" data-show="<?php echo ($columns_count); ?>" data-pagination="false" data-navigation="true">
       <?php
        $pages = array_chunk( $products, $itemsperpage);
       ?>

       <?php foreach ($pages as  $k => $tproducts ) {   ?>
          <div class="item <?php if($k==0) {?>active<?php } ?> products-block">
            <?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
              <?php if( $i%$cols == 1 || $cols == 1) { ?>
                <div class="row products-row">
                <?php } ?>
                <div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 product-col border">
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



</div>
</div>
<script type="text/javascript">
$('#pavdeals<?php echo $id;?>').carousel({interval:false,pause:'hover'});
</script>