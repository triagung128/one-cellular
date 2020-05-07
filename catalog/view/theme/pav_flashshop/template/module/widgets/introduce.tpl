<div class="panel panel-default widget-accordion introduce <?php echo $addition_cls;?> <?php if (isset($stylecls)&&$stylecls){echo "block-".$stylecls;}?>">
    <div class="row">
        <div class="col-md-6 col-sm-12 col-xs-12 text-center content-introduce pull-<?php if($position == 'left'){ echo 'right';}?>">
            <div class="content">
                <div class=" panel-heading">
                    <?php if($iconclass){ ?>
                        <i class="fa <?php echo $iconclass;?>"></i>
                    <?php } ?>
                    <?php if( $show_title ) { ?>
                        <h3 class="panel-title"><?php echo $widget_heading; ?></h3>
                    <?php } ?>
                </div>
                <div class="detail">
                    <?php if($content_html) {?>
                        <span><?php echo $content_html; ?></span>
                    <?php }?>
                </div>
                <div class="button">    
                    <a class="btn btn-primary btn-lg" href="<?php echo $link;?>"><?php echo $objlang->get('text_link');?></a>
                </div>
            </div>
        </div>  
        <div class="col-md-6 col-sm-12 col-xs-12 text-center media-introduce pull-<?php if($position == 'left'){ echo 'left';}?>">
            <?php if($thumbnailurl){?>
                    <img class="img-responsive" src="<?php echo $thumbnailurl;?>" alt="">
            <?php }elseif($id_video){ ?>
                    <iframe width="<?php echo $width;?>" height="<?php echo $height;?>" src="https://www.youtube.com/embed/<?php echo $id_video;?>?rel=0&amp;showinfo=0" allowfullscreen></iframe>
            <?php } ?>
        </div>   
    </div>    
</div>
