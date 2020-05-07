<div class="product-block product-v1">
    <?php if ($product['thumb']) {    ?>
    <div class="image">
        <?php if( $product['special'] ) {   ?>
          <span class="product-label bts"><span class="product-label-special"><?php echo $product['deal_discount'].'%'; ?><?php echo $objlang->get('text_off'); ?></span></span>
        <?php } ?>
        <a class="img" title="<?php echo $product['name']; ?>" href="<?php echo $product['href']; ?>">
            <img class="img-responsive" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
        </a>
        <div class="action">
            <?php if( !isset($listingConfig['catalog_mode']) || !$listingConfig['catalog_mode'] ) { ?>
              <div class="cart"> <button data-loading-text="Loading..." class="btn btn-outline-light btn-sm" type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="zmdi zmdi-shopping-cart-plus"></i>
                <?php echo $button_cart; ?>
              </button></div>
            <?php } ?>

            <button class="compare btn-style" type="button" data-placement="top" title="<?php echo $objlang->get("button_compare"); ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="zmdi zmdi-tune"></i></button>

            <?php if ( isset($quickview) && $quickview ) { ?>
            <a class="quickview iframe-link btn-style" data-placement="top" href="<?php echo $ourl->link('themecontrol/product','product_id='.$product['product_id']);?>"  title="<?php echo $objlang->get('quick_view'); ?>" ><i class="zmdi zmdi-eye"></i></a>
            <?php } ?>
            
            <button class="wishlist btn-style" type="button" data-placement="top" title="<?php echo $objlang->get("button_wishlist"); ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="zmdi zmdi-favorite"></i></button>
            <?php if( isset($categoryPzoom) && $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
                <?php if( isset($categoryPzoom) && $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
                <a data-placement="top" href="<?php echo $zimage;?>" class="zoom info-view btn-style" title="<?php echo $product['name']; ?>"><i class="zmdi zmdi-zoom-in"></i></a>
                <?php } ?>
            <?php } ?>
        </div>
        <div id="item_countdown_<?php echo $product['product_id']; ?>" class="item-countdown"></div>
    </div>
    <?php } ?>
    <div class="product-meta clearfix">
        <h6 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h6>
        <?php if( isset($product['description']) ){ ?>
        <p class="description"><?php echo utf8_substr( strip_tags($product['description']),0,80);?>...</p>
        <?php } ?>

        <?php if ($product['rating']) { ?>
        <div class="rating clearfix">
        <?php for ($is = 1; $is <= 5; $is++) { ?>
        <?php if ($product['rating'] < $is) { ?>
        <span class="fa fa-stack"><i class="fa fa-star-o"></i></span>
        <?php } else { ?>
        <span class="fa fa-stack"><i class="fa fa-star"></i>
        </span>
        <?php } ?>
        <?php } ?>
        </div>
        <?php } ?>
        <div class="bottom clearfix">
            <?php if ($product['price']) { ?>
            <div class="price">
                <?php if (!$product['special']) {  ?>
                <span class="price-new"><?php echo $product['price']; ?></span>
                <?php if( preg_match( '#(\d+).?(\d+)#',  $product['price'], $p ) ) { ?>
                <?php } ?>
                <?php } else { ?>
                <span class="price-new"><?php echo $product['special']; ?></span>
                <span class="price-old"><?php echo $product['price']; ?></span>
                <?php if( preg_match( '#(\d+).?(\d+)#',  $product['special'], $p ) ) { ?>
                <?php } ?>

                <?php } ?>
            </div>
            <?php } ?>
          
        </div>
    </div>
</div>

<script type="text/javascript">
  jQuery(document).ready(function($){
    $("#item_countdown_<?php echo $product['product_id']; ?>").lofCountDown({
      formatStyle:2,
      TargetDate:"<?php echo date('m/d/Y G:i:s', strtotime($product['date_end_string'])); ?>",
      DisplayFormat:"<ul class='list-inline'><li class='days'> %%D%% <span><?php echo $objlang->get("text_days");?></span></li><li class='hours'> %%H%% <span><?php echo $objlang->get("text_hours");?></span></li><li class='minutes'> %%M%% <span><?php echo $objlang->get("text_minutes");?></span></li><li class='seconds'> %%S%% <span><?php echo $objlang->get("text_seconds");?></span></li></ul>",
      FinishMessage: "<?php echo $objlang->get('text_finish');?>"
    });
  });
</script>





