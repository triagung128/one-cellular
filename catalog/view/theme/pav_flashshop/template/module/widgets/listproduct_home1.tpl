<?php
	$config = $sconfig;
	$theme  = $themename;
	$span = 12/$cols;
	$id = rand(1,9)+substr(md5($heading_title),0,3);
	$themeConfig = (array)$config->get('themecontrol');
	$listingConfig = array(
		'category_pzoom'    => 1,
		'quickview'         => 0,
		'product_layout'	=> 'default',
		'enable_paneltool'	=> 0
	);
	$listingConfig = array_merge($listingConfig, $themeConfig );
	$quickview     = $listingConfig['quickview'];
	$categoryPzoom = isset($themeConfig['category_pzoom']) ? $themeConfig['category_pzoom']:0;


	if( $listingConfig['enable_paneltool'] && isset($_COOKIE[$theme.'_productlayout']) && $_COOKIE[$theme.'_productlayout'] ){
		$listingConfig['product_layout'] = trim($_COOKIE[$theme.'_productlayout']);
	}
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';	
	if( !is_file($productLayout) ){
		$listingConfig['product_layout'] = 'default';
	}
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';


	//$quick_view = $language['quick_view'];
	$button_cart = $objlang->get('button_cart');
	$columns_count=1;
?>


<div class="listproduct panel">
	<div class="row">
		
		<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 <?php echo $addition_cls; ?>">
			<?php if( $show_title ) { ?>
			<div class="panel-heading"><h4 class="panel-title"><?php echo $heading_title?></h4></div>
			<?php } ?>
		</div>
		<div class="col-lg-9 col-md-9 col-sm-9 hidden-xs">
			<?php if (!empty($categories)): ?>
			<ul class="list-inline">
				<?php foreach ($categories as $category): ?>
				<li><a href="<?php echo $category["href"] ?>"><?php echo $category["name"] ?></a></li>
				<?php endforeach ?>
			</ul>
			<?php endif ?>
		</div>
	</div>
	<div class="border-top">
		<div class="row">
			<div class="col-lg-3 col-md-3 hidden-sm hidden-xs ">
				<!-- banner -->
				<?php if(!empty($banner)) { ?>
				<div class="banner effect-v4 hidden-sm hidden-xs ">
					<a href="#"><img class="img-responsive" src="<?php echo $banner; ?>" alt="img"></a>
				</div>
				<?php } ?>
				<!-- column 1 -->	
			</div>
			<div class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
					<div class="owl-carousel-play" id="carousel<?php echo $id;?>" data-ride="owlcarousel">	
						<div class="owl-carousel product-grid"  data-show="<?php echo ($columns_count); ?>" data-pagination="false" data-navigation="true">
							<?php $pages = array_chunk( $list1, $itemsperpage); ?>
							<?php foreach ($pages as  $k => $tproducts ) {   ?>
							<div class="item <?php if($k==0) {?>active<?php } ?> products-block">
								<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
									<?php if( $i%$cols == 1 || $cols == 1) { ?>
									<div class="row products-row <?php ;if($i == count($tproducts) - $cols +1) { echo "last";} ?>"><?php //start box-product?>
									<?php } ?>
										<div class="col-md-<?php echo $span;?> col-sm-<?php echo $span;?> col-xs-12 <?php if($i%$cols == 0) { echo "last";} ?> product-col border">
											<?php require( $productLayout );  ?>
										</div>

									<?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
									</div><?php //end box-product?>
									<?php } ?>
								<?php } //endforeach; ?>
							</div>
						  <?php } ?>
						</div>
					<?php if( count($list1) > $itemsperpage ) { ?>
						<div class="carousel-controls">
							<a class="carousel-control left" href="#carousel<?php echo $id;?>"   data-slide="prev">
								<i class="zmdi zmdi-chevron-left"></i>
							</a>
							<a class="carousel-control right" href="#carousel<?php echo $id;?>"  data-slide="next">
								<i class="zmdi zmdi-chevron-right"></i>
							</a>
						</div>

						<?php } ?>
					</div>
			</div>
		</div>
	</div>
			

</div>