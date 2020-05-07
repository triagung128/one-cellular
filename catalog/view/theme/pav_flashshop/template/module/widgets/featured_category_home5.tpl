<div class="feature-category feature-category-v2 panel <?php echo $addition_cls?>">
	<div class="item-category">
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
			<img src="<?php echo $category['image']; ?>" alt="" class="img-responsive">
			<?php } ?>
		</a>
		</div>
	</div>
</div>
