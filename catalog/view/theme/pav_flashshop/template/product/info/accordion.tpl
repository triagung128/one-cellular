<div id="accordion" class="tab-group accordion">
    <ul class="nav nav-pills nav-stacked">
        <li>
            <a class="collapsed" data-toggle="collapse" href="#collapse1"><?php echo $tab_description; ?></a>
            <div id="collapse1" class="panel-collapse collapse">
                 <?php echo $description; ?>
            </div>
        </li>
        <?php if ($attribute_groups) { ?>
        <li>
            <a class="collapsed" data-toggle="collapse" href="#collapse2"><?php echo $tab_attribute; ?></a>
            <div id="collapse2" class="panel-collapse collapse">
                <table class="table table-bordered">
                <?php foreach ($attribute_groups as $attribute_group) { ?>

                  <tr>
                    <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                  </tr>

                <tbody>
                  <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                  <tr>
                    <td><?php echo $attribute['name']; ?></td>
                    <td><?php echo $attribute['text']; ?></td>
                  </tr>
                  <?php } ?>
                </tbody>
                <?php } ?>
              </table>
            </div>
        </li>
        <?php } ?>
        <?php if ($review_status) { ?>
        <li>
            <a class="collapsed" data-toggle="collapse" href="#collapse3"><?php echo $tab_review; ?></a>
            <div id="collapse3" class="panel-collapse collapse">
             <div id="review"></div>
              <p> <a href="#review-form"  class="popup-with-form btn btn-primary" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;" ><?php echo $text_write; ?></a></p>

             <div class="hide"> <div id="review-form" class="panel review-form-width"><div class="panel-body">
              <form class="form-horizontal" id="form-review">

                  <h2><?php echo $text_write; ?></h2>
                   <?php if ($review_guest) { ?>
                  <div class="form-group required">
                      <div class="col-sm-12">
                          <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                          <input type="text" name="name" value="" id="input-name" class="form-control" />
                      </div>
                  </div>
                  <div class="form-group required">
                      <div class="col-sm-12">
                          <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                          <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                          <div class="help-block"><?php echo $text_note; ?></div>
                      </div>
                  </div>
                  <div class="form-group required">
                      <div class="col-sm-12">
                          <label class="control-label"><?php echo $entry_rating; ?></label>
                          &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
                          <input type="radio" name="rating" value="1" />
                          &nbsp;
                          <input type="radio" name="rating" value="2" />
                          &nbsp;
                          <input type="radio" name="rating" value="3" />
                          &nbsp;
                          <input type="radio" name="rating" value="4" />
                          &nbsp;
                          <input type="radio" name="rating" value="5" />
                          &nbsp;<?php echo $entry_good; ?></div>
                  </div>
                   <?php echo $captcha; ?>
                  <div class="buttons">
                      <div class="pull-right">
                        <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
                      </div>
                  </div>
                   <?php } else { ?>
                <?php echo $text_login; ?>
                <?php } ?>
              </form></div></div></div>
            </div>
        </li>
        <?php } ?>
         <?php if( $productConfig['enable_product_customtab'] && isset($productConfig['product_customtab_name'][$languageID]) ) { ?>
         <li>
             <a class="collapsed" data-toggle="collapse" href="#collapse4"><?php echo $productConfig['product_customtab_name'][$languageID]; ?></a>
             <div id="collapse4" class="panel-collapse collapse">
                <?php echo html_entity_decode( $productConfig['product_customtab_content'][$languageID], ENT_QUOTES, 'UTF-8'); ?>
            </div>
         </li>
         <?php } ?>
    </ul>
</div>