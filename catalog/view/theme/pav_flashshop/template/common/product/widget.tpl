<?php
  $load = $this->registry->get("load");
  $language = $load->language("module/themecontrol");
  $text_sale = $language['text_sale'];
  $ourl = $this->registry->get('url');
  $objlang = $this->registry->get('language');
?>
<div class="product-block">
  <div class="image">
     <!-- Sale lable -->
    <?php if( $product['special'] ) {   ?>
      <span class="product-label sale"><?php echo $text_sale; ?></span>
    <?php } ?>
    <!-- / Sale lable -->
    <a href="<?php echo $product['href']; ?>">
      <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
    </a>
    <div class="bottom">
       <button class="btn btn-outline-light wishlist" type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
      <i class="fa fa-heart-o"></i></button>
      <button class="btn btn-outline-light compare" type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');">
      <i class="fa fa-refresh"></i></button>
       <?php if ( isset($quickview) && $quickview ) { ?>
        <a class="quickview iframe-link btn btn-outline-light" data-toggle="tooltip" data-placement="top" href="<?php echo $ourl->link('themecontrol/product','product_id='.$product['product_id']);?>"  title="<?php echo $objlang->get('quick_view'); ?>" ><i class="fa-fw fa fa-eye"></i></a>
      <?php } ?>
       <?php if( isset($categoryPzoom) && $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
            <a data-toggle="tooltip" data-placement="top" href="<?php echo $zimage;?>" class="zoom info-view colorbox cboxElement btn btn-outline-light" title="<?php echo $product['name']; ?>"><i class="fa fa-search-plus"></i></a>
        <?php } ?>
    </div>
  </div>
  <div class="product-meta">
      <h6 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h6>
      <?php if( isset($product['description']) ){ ?>
        <p class="description"><?php echo utf8_substr( strip_tags($product['description']),0,200);?>...</p>
      <?php } ?>
      <?php if ($product['rating']) { ?>
      <div class="rating">
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
      <div class="action">
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <span class="price-new"><?php echo $product['price']; ?></span>
          <?php } else { ?>
          <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <button class="cart btn btn-primary" title="<?php echo $button_cart; ?>" type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><?php echo $button_cart; ?></button>
      </div>
    </div>

</div>




