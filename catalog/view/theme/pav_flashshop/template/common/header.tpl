
<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]>-->

<html dir="<?php echo $direction; ?>" class="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<?php
    require( ThemeControlHelper::getLayoutPath( 'common/parts/head.tpl' ) );
    $autosearch = $helper->renderModule('pavautosearch');
?>

<body class="<?php echo $class; ?> <?php echo $helper->getPageClass();?> layout-<?php echo $template_layout; ?>">
<div class="row-offcanvas row-offcanvas-left">
<!-- header -->
<header class="header header-v">
    <nav id="topbar" class="topbar">
        <div class="container">
            <div class="inner">
                <div class="row">
                    <div class="col-md-6 col-sm-5 col-xs-12">
                        <div class="quick-language pull-left">
                            <?php echo $language; ?>
                        </div>
                        <div class="quick-currency pull-left">
                            <?php echo $currency; ?>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-7 col-xs-12">
                        <ul class="list-inline text-right">
                            <li><a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>"><span><?php echo $text_account; ?></span></a></li>
                            <li><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><span><?php echo $text_wishlist; ?></span></a></li>
                            <?php if ($logged) { ?>
                            <li><a href="<?php echo $logout; ?>"><span><?php echo $text_logout; ?></span></a></li>
                            <?php } else { ?>
                            <li><a href="<?php echo $login; ?>"><span><?php echo $text_login; ?></span></a></li>
                            <li><a href="<?php echo $register; ?>"><span><?php echo $text_register; ?></span></a></li>
                            <?php } ?>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </nav>
    <div class="header-middle">
        <div class="container">
            <div class="inner">
                <div class="row">
                    <div class="col-lg-3 col-md-3 col-sm-4 col-xs-12">
                        <!-- logo -->
                        <?php
                        if( isset($_COOKIE[$themeName .'_skin']) && $_COOKIE[$themeName .'_skin'] ){
                          $skin = trim($_COOKIE[$themeName .'_skin']);
                        }
                        ?>
                        <?php if( $logoType=='logo-theme'){ ?>
                        <div id="logo-theme" class="logo">
                          <a href="<?php echo $home; ?>">
                            <?php 
                              if( isset($skin) && $skin !='' ) {
                                $src = HTTP_SERVER.'catalog/view/theme/'.$themeName.'/image/'.$skin.'/logo_theme.png';
                              } else {
                                $src = HTTP_SERVER.'catalog/view/theme/'.$themeName.'/image/logo_theme.png';
                              }                              
                             
                            ?>
                            <img src="<?php echo $src; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive"/>
                          </a>
                        </div>
                        <?php } elseif ($logo) { ?>
                        <div id="logo" class="logo">
                          <a href="<?php echo $home; ?>">
                            <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive"/>
                          </a>
                        </div>
                        <?php } ?>

                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-8 hidden-xs ">
                        <?php
                            if (count($autosearch) && !empty($autosearch)) {
                            echo $autosearch;
                            } else {
                            echo $search;
                            }
                        ?>
                    </div>
                    <div class="col-lg-3 col-md-3 hidden-sm hidden-xs">                        
                        <?php if( $content=$helper->getLangConfig('widget-phone') ) {?>
                            <?php echo $content; ?>
                        <?php } ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="header-bottom">
        <div class="container">
          <div class="inner">
            <div class="row">
              <div class="col-lg-10 col-md-10 col-sm-10 col-xs-2">
                <?php  require( ThemeControlHelper::getLayoutPath( 'common/parts/mainmenu.tpl' ) );   ?>
              </div>
              <div class="col-lg-2 col-md-2 col-sm-2 col-xs-10">
                <div class="pull-right"><?php echo $cart; ?></div>
              </div>
            </div>
          </div>
            
        </div>
    </div>
</header>
<!-- /header -->

  <?php
  /**
  * Showcase modules
  * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
  */
  //$modules = $helper->getCloneModulesInLayout( $blockid, $layoutID );
  $blockid = 'slideshow';
  $blockcls = "";
  $ospans = array(1=>12);
  require( ThemeControlHelper::getLayoutPath( 'common/block-cols-full.tpl' ) );
  ?>
  <?php
  /**
  * Showcase modules
  * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
  */
  $blockid = 'showcase';
  $blockcls = 'hidden-xs hidden-sm';
  $ospans = array(1=>12);
  require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
  ?>
  <?php
  /**
  * promotion modules
  * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
  */
  $blockid = 'promotion';
  $blockcls = "hidden-xs hidden-sm";
  $ospans = array(1=>12, 2=>12);
  require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
  ?>

<div class="maincols">


