
<div class="panel panel-default <?php echo $prefix; ?>" id="newsletter_<?php echo $position.$module;?>">
<?php $id = "new" . uniqid(); ?>
    <form id="<?php echo $id; ?>" action="#" method="post" class="form-newsletter">
            <div class="panel-heading">
                <h5 class="panel-title"> <?php echo $objlang->get("entry_newsletter");?></h5>
            </div>
            <?php if($description){?>
                <div class="description">
                    <?php echo html_entity_decode( $description );?>
                </div>
            <?php }?>
            <div class="input-group">
                <input type="text" placeholder="<?php if(isset($value) && $value){ echo $value; }else{ echo "Enter your email...";} ?>" class="form-control email" size="18" name="email">
                <span class="input-group-btn">
                    <button id="bt<?php echo $id; ?>" class="btn-submit btn btn-link" type="button" name="submitNewsletter">
                        <i class="fa fa-chevron-right" aria-hidden="true"></i>
                    </button>
                </span>
                <div class="valid" id="valid<?php echo $id; ?>"></div>
            </div>
            <input type="hidden" value="1" name="action">
    </form>
</div>

<script type="text/javascript"><!--
   $('#bt<?php echo $id ?>').on('click', function() {
      $.ajax({
          url: 'index.php?route=module/pavnewsletter/subs',
          type: 'post',
          dataType: 'json',
          data: $("#<?php echo $id ?> input"),
          beforeSend: function() {
              $('#valid<?php echo $id; ?>').html('');
          },
          success: function(json) {
              $('.alert-success, .alert-danger').remove();

              if (json['error']) {
                  $('#valid<?php echo $id; ?>').html('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">×</button></div>');
              }

              if (json['success']) {
                  $('#valid<?php echo $id; ?>').html('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">×</button></div>');
              }
          }
      });
  });
--></script>
