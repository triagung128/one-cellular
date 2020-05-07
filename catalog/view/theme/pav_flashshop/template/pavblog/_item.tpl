<div class="blogs-item">

	<?php if( $cat_show_title ) { ?>
	<div class="image">
	<?php if( $blog['thumb'] && $cat_show_image )  { ?>
	<img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" alt="<?php echo $blog['title'];?>" class="img-responsive"/>
	<?php } ?>
	</div>

	<div class="blog-meta">
		<ul class="list-inline">
		  	<li><?php if( $blog_show_author ) { ?>
			<span class="author"><i class="zmdi zmdi-account-o zmdi-hc-fw text-primary"></i><?php echo $blog['author'];?></span>
			<?php } ?>
			</li>

			<li>
			<?php if( $blog_show_category ) { ?>
			<span class="publishin">
				<i class="zmdi zmdi-folder-outline zmdi-hc-fw text-primary"></i>
				<a class="color" href="<?php echo $blog['category_link'];?>" title="<?php echo $blog['category_title'];?>"><?php echo $blog['category_title'];?></a>
			</span>
			<?php } ?>
			</li>

			<li>
			<?php if( $blog_show_created ) { ?>
			<span class="created"><i class="zmdi zmdi-time zmdi-hc-fw text-primary"></i> <?php echo $blog['created'];?></span>
			<?php } ?>
			</li>

			<li>
			<?php if( $blog_show_hits ) { ?>
			<span class="hits"><i class="zmdi zmdi-bookmark-outline zmdi-hc-fw text-primary"></i> <?php echo $blog['hits'];?></span>
			<?php } ?>
			</li>

			<li>
			<?php if( $blog_show_comment_counter ) { ?>
			<span class="comment_count"><i class="zmdi zmdi-comment-outline zmdi-hc-fw text-primary"></i> <?php echo $blog['comment_count'];?></span>
			<?php } ?>
			</li>
		</ul>
		<div class="blog-body">
			<div class="blog-header">
				<div class="blog-title">	<a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a></div>
			<?php } ?>
			</div>
		<?php if( $cat_show_description ) {?>
			<div class="description">
				<?php echo utf8_substr( $blog['description'],0, 180 );?>...
			</div>
			<?php } ?>
		<?php if( $cat_show_readmore ) { ?>
				<a class="readmore btn btn-primary" href="<?php echo $blog['link'];?>"><?php echo $objlang->get('text_readmore');?></a>
			<?php } ?>
		</div>
	</div>
</div>

