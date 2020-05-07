<?php
	$col = isset($cols)?$cols:4;
	$span = 12/$col;

?>
<div class="feature-category feature-category-v1 panel panel-warning <?php echo $addition_cls?>">
	<?php if( $show_title ) { ?>
	<div class="widget-heading panel-heading"><h3 class="panel-title"><span><?php echo $heading_title?></span></h3></div>
	<?php } ?>
	<div class="widget-inner panel-body padding-0">
		<?php if(!empty($categories)) { ?>
			<div class="box-content">
				<ul class="list-unstyled row">
					<?php foreach ($categories as $category): ?>
					<li class="col-lg-<?php echo $span ?> col-md-<?php echo $span ?> col-sm-4 col-xs-12 column">
						<div class="item-category clearfix">
							<div class="item">
                                <div class="inner">
                                    <div class="caption">
        								<h4><a href="<?php echo $category['href']; ?>"><span>+</span><?php echo $category['name']; ?></a></h4>
        								<div class="category-items"><a class="text-lighten" href="<?php echo $category['href']; ?>"><?php echo $category['items']; ?></a></div>
        							</div>
                                </div>
                            </div>
							<div class="image">
							<a href="<?php echo $category['href']; ?>">
								<?php if ($category['image'] !== '') { ?>
								<img src="image/<?php echo $category['image']; ?>" alt="" class="img-responsive">
								<?php
								} ?>
							</a>
							</div>
						
						</div>
					</li>
					<?php endforeach ?>
				</ul>
			</div>
		<?php } ?>
	</div>
</div>


