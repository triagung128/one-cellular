<div class="<?php echo str_replace('_','-',$blockid); ?> <?php echo $blockcls;?>" id="pavo-<?php echo str_replace('_','-',$blockid); ?>">
    <div class="container"><div class="inner">
        <?php if( $content=$helper->getLangConfig('widget-html-custom') ) {?>
            <?php echo $content; ?>
        <?php } ?>
    </div></div>
</div>
