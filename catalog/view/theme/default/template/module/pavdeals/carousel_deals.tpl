<?php 
	$span = 12/$cols; 
	$active = 'latest';
	$id = rand(1,9);	
?>
<div class="<?php echo $prefix;?> box productdeals">
	<div class="box-heading"><?php echo $heading_title; ?></div>
	<div class="box-content" >
 		<div class="box-products slide" id="pavdeals<?php echo $id;?>">
			<?php if( trim($message) ) { ?>
			<div class="box-description"><?php echo $message;?></div>
			<?php } ?>
			<?php if( count($products) > $itemsperpage ) { ?>
			<div class="carousel-controls">
			<a class="carousel-control left" href="#pavdeals<?php echo $id;?>"   data-slide="prev">&lsaquo;</a>
			<a class="carousel-control right" href="#pavdeals<?php echo $id;?>"  data-slide="next">&rsaquo;</a>
			</div>
			<?php } ?>
			<div class="carousel-inner ">		
			<?php $pages = array_chunk( $products, $itemsperpage); ?>
			<?php foreach ($pages as  $k => $tproducts ) {   ?>

				<div class="item <?php if($k==0) {?>active<?php } ?>">
					<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
					<?php if( $i%$cols == 1 || $cols == 1) { ?> <div class="row-fluid box-product"> <?php } ?>

						<div class="product-layout col-sm-<?php echo $span;?> col-xs-12">
							<div class="product-thumb">
								<div class="image">
									<?php if( $product['special'] ):  ?>
										<div class="product-label-special label"><?php echo $objlang->get( 'text_sale' ); ?></div>
									<?php endif; ?>
									<a href="<?php echo $product['href']; ?>">
										<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
									</a>
								</div>

								<div>
									<div class="caption">
										<h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
										<p><?php echo $product['description']; ?></p>
										<?php if ($product['rating']) { ?>
										<div class="rating">
											<?php for ($i = 1; $i <= 5; $i++) { ?>
											<?php if ($product['rating'] < $i) { ?>
											<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
											<?php } else { ?>
											<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
											<?php } ?>
											<?php } ?>
										</div>
										<?php } ?>
										<?php if ($product['price']) { ?>
										<p class="price">
											<?php if (!$product['special']) { ?>
											<?php echo $product['price']; ?>
											<?php } else { ?>
											<span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
											<?php } ?>
											<?php if (!empty($product['tax'])) { ?>
											<span class="price-tax"><?php echo $objlang->get('text_tax'); ?> <?php echo $product['tax']; ?></span>
											<?php } ?>
										</p>
										<?php } ?>
										<!-- count down -->
										<div class="deal_detail">
											<ul>
												<li>
													<span><?php echo $objlang->get("text_discount");?></span>
													<span class="deal_detail_num"><?php echo $product['deal_discount'];?>%</span>
												</li>
												<li>
													<span><?php echo $objlang->get("text_you_save");?></span>
													<span class="deal_detail_num"><span class="price"><?php echo $product["save_price"]; ?></span></span>
												</li>
												<li>
													<span><?php echo $objlang->get("text_bought");?></span>
													<span class="deal_detail_num"><?php echo $product['bought'];?></span>
												</li>
											</ul>
										</div>

										<div class="deal-qty-box">
											<?php echo sprintf($objlang->get("text_quantity_deal"), $product["quantity"]);?>
										</div>

										<div class="item-detail">
											<div class="timer-explain">(<?php echo date($objlang->get("date_format_short"), strtotime($product['date_end_string'])); ?>)</div>
										</div>

										<div id="item<?php echo $module; ?>countdown_<?php echo $product['product_id']; ?>" class="item-countdown"></div>
										<script type="text/javascript">
											jQuery(document).ready(function($){
												$("#item<?php echo $module; ?>countdown_<?php echo $product['product_id']; ?>").lofCountDown({
													formatStyle:2,
													TargetDate:"<?php echo date('m/d/Y G:i:s', strtotime($product['date_end_string'])); ?>",
													DisplayFormat:"<ul><li>%%D%% <div><?php echo $objlang->get("text_days");?></div></li><li> %%H%% <div><?php echo $objlang->get("text_hours");?></div></li><li> %%M%% <div><?php echo $objlang->get("text_minutes");?></div></li><li> %%S%% <div><?php echo $objlang->get("text_seconds");?></div></li></ul>",
													FinishMessage: "<?php echo $objlang->get('text_finish');?>"
												});
											});
										</script>
									</div>
							
									<div class="button-group">
										<button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
										<button type="button" data-toggle="tooltip" title="<?php echo $objlang->get("button_wishlist"); ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
										<button type="button" data-toggle="tooltip" title="<?php echo $objlang->get("button_compare"); ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
									</div>
								</div>
							</div>
						</div>

					<?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?> </div> <?php } ?>
					<?php } ?>
				</div>  

			<?php } ?>
			</div>  
		</div>
	</div> 
</div>


<script type="text/javascript">
$('#pavdeals<?php echo $id;?>').carousel({interval:<?php echo ( $auto_play_mode?$interval:'false') ;?>,auto:<?php echo $auto_play;?>,pause:'hover'});
</script>