
<?php 
 	$landingpage = $landingpage[0];
 	$banners = $landingpage['banner_image'];
	$langID = $this->config->get('config_language_id');
?>

<div class="line-loader">
	<div class="loader"></div>
</div>

<div class="landingpage w-screen-size parallax anima3te-bg" id="fullscreen" data-bg="<?php echo HTTP_SERVER. 'image/'. $landingpage['mainimage']; ?>">
		<div class="inner w-screen-size">
			<div class="button-close text-right"><span>Skip intro <i class="fa fa-times"></i></span></div>
			<div class="clearfix"></div>
			<?php if( isset($landingpage['videoid']) && !empty($landingpage['videoid']) ) { ?>	
			<!-- Video -->
			<div id="P10" class="player video-container p-video-v" data-property="{videoURL:'<?php echo $landingpage['videoid']; ?>',containment:'#fullscreen',autoPlay:true, showControls:true, mute:false, startAt:0, opacity:1}"></div>
			<!-- End Video -->
			<?php } ?>
		<?php
			if( isset($banners) &&  count($banners) ) {  ?>
				<?php $id = rand(1,10);?>
			   <div id="pavlandingpage<?php echo $id;?>" data-ride="carousel" class="carousel slide pavlandingpage line-middle">
					<div class="pav-caption slideUp ">
						<?php if( $logoType=='logo-theme'){ ?>
								<a href="<?php echo $home; ?>">
									<img src="image/data/logo.png" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
								</a>
							<?php } elseif ($logo) { ?>
								<a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
						<?php } ?> 							
					</div>
					<div class="carousel-inner">
						 <?php $i=0; foreach ($banners as  $banner) {  ?>
							<div class="item <?php if($i++==0) {?>active<?php } ?>">

								<?php if( isset($banner['title'][$langID]) && is_array($banner['title'][$langID]) ){ ?>

							 
								<?php  foreach( $banner['title'][$langID] as $ilayer => $caption ) { 
										$layer = array();
								 		$layer['caption'] =  isset($caption)?html_entity_decode( $caption, ENT_QUOTES, 'UTF-8'):"";
										$layer['effect'] =  isset($banner['effect'][$langID][$ilayer])?$banner['effect'][$langID][$ilayer]:"";
										$layer['class'] =  isset($banner['class'][$langID][$ilayer])?$banner['class'][$langID][$ilayer]:"normal-caption";

								 ?>
								<div class="pav-caption <?php echo $layer['effect']. " ".$layer['class'];?>" >
									<?php  echo $layer['caption'];?>
								</div>
								<?php } ?>
								<?php } ?>		 
							</div>
						<?php } ?>
					</div>

					<?php if( count($banners) > 1 ){ ?>	
					<a class="carousel-control left" href="#pavlandingpage<?php echo $id;?>" data-slide="prev"></a>
					<a class="carousel-control right" href="#pavlandingpage<?php echo $id;?>" data-slide="next"></a>
					<?php } ?>
			    </div>
				<?php if( count($banners) > 1 ){ ?>
				<script type="text/javascript">
				<!--
					$('#pavlandingpage<?php echo $id;?>').carousel(  );
				-->
				</script>
				<?php } ?>
			<?php } ?>
		</div>	
		<div class="landingpage-scroll-down"></div>
</div>

 <script type="text/javascript">
		$(window).on('load', function() {
			$('.line-loader').fadeOut(function() {
				$('.line-loader').remove();
			});
		});
		$('.landingpage').each(function(){
				var bg      = $(this).data('bg');
				$(this).css("background-image","url(" + bg + ")");
		});

		wheighter = $(window).height();
		wwidth = $(window).width();
		$(".w-screen-size").css("height",wheighter);
		$(".w-screen-size").css("width",wwidth);


		$(window).resize(function(){
			wheighter = $(window).height();
			wwidth = $(window).width();
			$(".w-screen-size").css("height",wheighter);
			$(".w-screen-size").css("width",wwidth);
		});
		$(".player").mb_YTPlayer();

		$('.button-close').click( function(){
			$.cookie( 'pavlandingpage', 1);
			$('.landingpage').css({
				'display':'none',
				'height':'0'
			});
		} );
</script>

