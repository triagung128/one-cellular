<?php if ( isset($thumbnailurl) )  { ?>
<div class="panel widget-images  <?php echo $addition_cls ?> <?php if( isset($stylecls)&&$stylecls ) { ?>box-<?php echo $stylecls;?><?php } ?>">
	<?php if( $show_title ) { ?>
	<div class="panel-heading widget-heading"><h3 class="panel-title"><?php echo $heading_title?></h3></div>
	<?php } ?>
	<div class="widget-inner img-adv clearfix">
		 <div class="image-item">
		 <a href="<?php echo $link;?>">
		 	<div class="effect-v4">
		 	<img class="img-responsive" alt=" " src="<?php echo $thumbnailurl; ?>"/>
		 	</div>
	 	</a>
	 	<?php if( $ispopup ){ ?>
	 	<a href="<?php echo $imageurl; ?>" class="pts-popup fancybox" title="<?php echo $this->language->get('Large Image');?>"><span class="icon icon-expand"></span></a>
	 	<?php } ?>
		 </div>
	</div>
</div>
<?php } ?>

<script type="text/javascript">
    $(document).ready(function(){
        $(".widget-images").click(function(){
            var link = $(".click").attr("href");
            $(location).attr('href',link);
        });
    });
</script>