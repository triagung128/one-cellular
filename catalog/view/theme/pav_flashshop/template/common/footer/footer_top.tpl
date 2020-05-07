<div class="<?php echo str_replace('_','-',$blockid); ?> <?php echo $blockcls;?>" id="pavo-<?php echo str_replace('_','-',$blockid); ?>">
    <div class="container"><div class="inner">
        <div class="row">
                <?php if( $content=$helper->getLangConfig('widget-feature-box') ) {?>
                    <?php echo $content; ?>
                <?php } ?>
        </div> <!-- end row -->
    </div></div>
</div>

