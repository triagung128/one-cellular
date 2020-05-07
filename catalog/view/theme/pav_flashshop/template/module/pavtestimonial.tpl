<?php $columns_count=1; ?>
<?php if( count($testimonials) ) { ?>
	<?php $id = rand(1,10)+rand();?>
   	<div id="pavtestimonial<?php echo $id;?>" class="panel testimonials <?php echo $setting['class'];?>">
   		<div class="panel-heading">
			<h4 class="panel-title"><?php echo $text_testimonial_title ?></h4>
		</div>
		<div class="panel-body padding-0 owl-carousel-play"  data-ride="owlcarousel">
			<div class="owl-carousel"  data-show="<?php echo ($columns_count); ?>" data-pagination="false" data-navigation="true">
				 <?php foreach ($testimonials as $i => $testimonial) {  ?>
					<div class="item <?php if($i==0) {?>active<?php } ?>">
		 				<div class="testimonial-item">
		 					<div class="avatar"><img  alt="<?php echo strip_tags($testimonial['profile']); ?>" src="<?php echo $testimonial['thumb']; ?>" class="img-circle"/></div>
							<?php if(  $testimonial['description'] ) { ?>
							<?php if(  $testimonial['profile'] ) { ?>
							<div class="profile">
								<div><?php echo $testimonial['profile']; ?></div>
							</div>
							<?php } ?>
							<div class="testimonial">
								<div><?php echo $testimonial['description']; ?></div>
							</div>
							<?php } ?>						
							
							<?php if( $testimonial['video_link']) { ?>
								<a class="colorbox-t hidden>" href="<?php echo $testimonial['video_link'];?>"><?php echo $objlang->get('text_watch_video_testimonial');?></a>
							<?php } ?>
						</div>
					</div>
				<?php } ?>		
			</div>
			<?php if( count($testimonials) > 1 ){ ?>	
				<div class="carousel-controls">
					<a class="carousel-control left" href="#pavtestimonial<?php echo $id;?>" data-slide="prev"><i aria-hidden="true" class="zmdi zmdi-chevron-left"></i></a>
					<a class="carousel-control right" href="#pavtestimonial<?php echo $id;?>" data-slide="next"><i aria-hidden="true" class="zmdi zmdi-chevron-right"></i></a>
				</div>
			<?php } ?>		
    	</div>
    </div>
	<?php if( count($testimonials) > 1 ){ ?>
	<script type="text/javascript">
	<!--
		$('#pavtestimonial<?php echo $id;?>').carousel({interval:<?php echo ( $auto_play_mode?$interval:'false') ;?>,auto:<?php echo $auto_play;?>,pause:'hover'});
	-->
	</script>
	<?php } ?>

<?php } ?>
