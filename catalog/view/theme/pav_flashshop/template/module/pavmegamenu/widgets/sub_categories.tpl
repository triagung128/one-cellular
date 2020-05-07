<?php if( $show_title ) { ?>
	<h6 class="widget-heading"><?php echo $heading_title?></h6>	
<?php } ?>

<div class="<?php echo $addition_cls; ?>">
	<ul class="content">
		<?php foreach ($subcategories as $category){ ?>
		<li>
            <a href="<?php echo $category['href']; ?>">
                <span><?php echo $category['name']; ?></span>
            </a>
        </li>
		<?php } ?>
	</ul>
</div>

