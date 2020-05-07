<div class="list-category <?php echo $addition_cls; ?> clearfix">
    <div class="img-category">
        <?php if( $show_title ) { ?>
            <h3 class="heading-title <?php echo $background;?>"><?php echo $heading_title?></h3>
        <?php } ?>
        <div class="text-center"><img class="img-responsive" alt="img" src="<?php echo $icon; ?>"></div>
    </div>
    <ul class="list-group">
        <?php foreach ($categories_list as $category){ ?>
        <li class="list-group-item"><a href="<?php echo $category['href']; ?>"><span class="title"><?php echo $category['name']; ?></span></a></li>
        <?php } ?>
    </ul>
</div>

