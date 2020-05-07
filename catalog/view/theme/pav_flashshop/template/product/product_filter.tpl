<div class="no-space-row">
<div class="row margin-top-30 filter">
  <div class="col-md-2">
    <div class="btn-group display group-switch hidden-xs">
        <button type="button" id="grid-view" class="btn-switch active" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="zmdi zmdi-apps"></i></button>
      <button type="button" id="list-view" class="btn-switch" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="zmdi zmdi-view-list-alt"></i></button>
    </div>
  </div>
  <div class="col-md-3">
    <a href="<?php echo $compare; ?>" id="compare-total" class="btn-link"><?php echo $text_compare; ?></a>
  </div>
  <div class="col-md-2 text-right">
    <label class="control-label" for="input-sort"><?php echo $text_sort; ?></label>
  </div>
  <div class="col-md-2 text-right">
    <select id="input-sort" class="form-control input-sm" onchange="location = this.value;">
      <?php foreach ($sorts as $sorts) { ?>
      <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
      <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
      <?php } ?>
      <?php } ?>
    </select>
  </div>
  <div class="col-md-1 text-right">
    <label class="control-label" for="input-limit"><?php echo $text_limit; ?></label>
  </div>
  <div class="col-md-2 text-right">
    <select id="input-limit" class="form-control input-sm" onchange="location = this.value;">
      <?php foreach ($limits as $limits) { ?>
      <?php if ($limits['value'] == $limit) { ?>
      <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
      <?php } ?>
      <?php } ?>
    </select>
  </div>

</div>
</div>