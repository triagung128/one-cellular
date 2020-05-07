<div class="product-block product-v1">
    <div class="image">
         <!-- Sale lable -->
        <?php if( $product['special'] ) {   ?>
          <div class="product-label bts"><div class="product-label-special"><?php echo $objlang->get('text_sale'); ?></div></div>
        <?php } ?>
        <!-- / Sale lable -->
        <a class="img" href="<?php echo $product['href']; ?>">
            <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
        </a>
        <div class="action">
            <div class="cart"><button class="btn btn-outline-light btn-sm" title="<?php echo $button_cart; ?>" type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="zmdi zmdi-shopping-cart-plus"></i><?php echo $button_cart; ?>                
            </button>
            </div> 
            <button class="compare btn-style" type="button" title="<?php echo $objlang->get("button_compare"); ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="zmdi zmdi-tune"></i></button>
             <button class="wishlist btn-style" type="button" title="<?php echo $objlang->get("button_wishlist"); ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="zmdi zmdi-favorite-outline"></i></button>
            <?php if( isset($categoryPzoom) && $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>

            <?php if ($quickview) { ?>
            <a class="quickview iframe-link btn-style" data-placement="top" href="<?php echo $ourl->link('themecontrol/product','product_id='.$product['product_id']);?>"  title="<?php echo $objlang->get('quick_view'); ?>" ><i class="zmdi zmdi-eye"></i></a>
            <?php } ?>            
           
            <a data-placement="top" class="zoom info-view btn-style" title="<?php echo $product['name']; ?>" href="<?php echo $zimage;?>"><i class="zmdi zmdi-zoom-in"></i></a>
            <?php } ?>
        </div>
    </div>
    <div class="product-meta clearfix">
        <h6 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h6>
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
        <?php if( isset($product['description']) ){ ?>
            <p class="description"><?php echo utf8_substr( strip_tags($product['description']),0,200);?>...</p>
        <?php } ?>
        <div class="bottom clearfix">
            <?php if ($product['price']) { ?>
                <div class="price">
                  <?php if (!$product['special']) { ?>
                  <span class="price-new"><?php echo $product['price']; ?></span>
                  <?php } else { ?>
                  <span class="price-new"><?php echo $product['special']; ?></span><span class="price-old"><?php echo $product['price']; ?></span>
                  <?php } ?>
                </div>
            <?php } ?>
        </div>
    </div>

</div>




