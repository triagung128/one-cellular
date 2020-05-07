
<?php if( !empty($blogs) ) { ?>
<div class="widget-blogs">
	<?php if( $show_title ) { ?>
	<div class="widget-heading"><?php echo $heading_title?></div>
	<?php } ?>
	<div class="widget-inner">
		<div class="row">
			<?php $i=0; foreach( $blogs as $key => $blog ) { $i++; if($i<=$itemsperpage) { ?>

			<div class="col-lg-<?php echo floor(12/$cols);?> col-md-<?php echo floor(12/$cols);?> col-sm-6 col-xs-12">
				<div class="latest-posts-body">
					<?php if( $blog['thumb']  )  { ?>
					<div class="latest-posts-image">
					  	<a href="<?php echo $blog['link'];?>">
							<img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" alt="<?php echo $blog['title'];?>" class="img-responsive"/>
					  	</a>
					</div>
					<?php } ?>
					<div class="latest-posts-meta">
						<div class="posts-meta">
							<div class="created">
								<i class="text-primary zmdi zmdi-time zmdi-hc-fw"></i>
								<span class="day"><?php echo date("d",strtotime($blog['created']));?></span>
								<span class="month"><?php echo date("M",strtotime($blog['created']));?></span>
								<span class="year"><?php echo date("Y",strtotime($blog['created']));?></span>
								<span class="comment"><i class="text-primary zmdi zmdi-comment-outline zmdi-hc-fw"></i><?php echo $objlang->get("text_comment_count");?><?php echo $blog['comment_count'];?></span>
							</div>
							<a class="latest-posts-title" href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a>
						</div>
					</div>
				</div> <!-- end latest-posts-body -->
			</div>
			<?php } } ?>
		</div>
	</div>
</div>
<?php } ?>