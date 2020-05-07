<hr>
<div class="tab-group">
    <ul class="nav nav-tabs">
      <li class="active"><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>
      <?php if ($attribute_groups) { ?>
      <li><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
      <?php } ?>
      <?php if ($review_status) { ?>
      <li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
          <?php } ?>
      <?php if( $productConfig['enable_product_customtab'] && isset($productConfig['product_customtab_name'][$languageID]) ) { ?>
            <li><a href="#tab-customtab" data-toggle="tab"><?php echo $productConfig['product_customtab_name'][$languageID]; ?></a></li>
        <?php } ?>
    </ul>
    <div class="tab-content">
      <div class="tab-pane active" id="tab-description"><?php echo $description; ?></div>
      <?php if ($attribute_groups) { ?>
      <div class="tab-pane " id="tab-specification">
        <table class="table table-bordered">
            <?php foreach ($attribute_groups as $attribute_group) { ?>
            <thead>
              <tr>
                <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
              </tr>
            </thead>
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
      <?php } ?>
      <?php if ($review_status) { ?>

          <div class="tab-pane" id="tab-review">

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
      <?php } ?>
      <?php if( $productConfig['enable_product_customtab'] && isset($productConfig['product_customtab_content'][$languageID]) ) { ?>
       <div id="tab-customtab" class="tab-pane custom-tab">
        <div class="inner">
          <?php echo html_entity_decode( $productConfig['product_customtab_content'][$languageID], ENT_QUOTES, 'UTF-8'); ?>
        </div></div>
     <?php } ?>
    </div>
    </div>