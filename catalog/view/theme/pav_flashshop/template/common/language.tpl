<?php if (count($languages) > 1) { ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-language">
  <div class="btn-group">
    <button class="btn btn-link dropdown-toggle" data-toggle="dropdown">
    <span><?php echo $text_language; ?></span>
    <?php foreach ($languages as $language) { ?>
    <?php if ($language['code'] == $code) { ?>
    <?php } ?>
    <?php } ?>
    <i class="fa fa-angle-down"></i></button>
    <div class="dropdown-menu">
        <ul class="links">
          <?php foreach ($languages as $language) { ?>
          <li><button class="language-select" type="button" name="<?php echo $language['code']; ?>"><img src="catalog/language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></button></li>
          <?php } ?>
        </ul>
    </div>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
<?php } ?>