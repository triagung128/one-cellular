<?php
  $megamenu = $helper->renderModule('pavmegamenu');
  if( isset($_COOKIE[$themeName .'_skin']) && $_COOKIE[$themeName .'_skin'] ){
    $skin = trim($_COOKIE[$themeName .'_skin']);
  }
?>
<div class="navbar-mega">
    <button data-toggle="offcanvas" class="btn btn-primary canvas-menu hidden-lg hidden-md margin-9" type="button"><span class="fa fa-bars"></span></button>
    <?php $checkmenu = true ;if ($megamenu) { $checkmenu = false; ?> <?php echo $megamenu; ?> <?php } ?>
    <?php if ($categories && $checkmenu) { ?>
    <nav id="menu" class="navbar">
      <div class="navbar-header"><span id="category" class="visible-xs"><?php echo $text_category; ?></span>
      <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
    </div>
    <div class="collapse navbar-collapse navbar-ex1-collapse">
      <ul class="nav navbar-nav">
        <?php foreach ($categories as $category) { ?>
        <?php if ($category['children']) { ?>
        <li class="dropdown"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
        <div class="dropdown-menu">
          <div class="dropdown-inner">
            <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
            <ul class="list-unstyled">
              <?php foreach ($children as $child) { ?>
              <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
              <?php } ?>
            </ul>
            <?php } ?>
          </div>
          <a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $category['name']; ?></a> </div>
        </li>
        <?php } else { ?>
        <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
        <?php } ?>
        <?php } ?>
      </ul>
    </div>
  </nav>
  <?php } ?>
</div>