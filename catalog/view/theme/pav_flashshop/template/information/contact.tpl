<?php
    $config = $sconfig;
    $theme  = $themename;
    $themeConfig = (array)$config->get('themecontrol');
?>
<?php  echo $header; ?>

<div class="main-columns container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
  <div class="container-inside">
    <div class="row"><?php echo $column_left; ?>
      <?php if ($column_left && $column_right) { ?>
      <?php $class = 'col-sm-6'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
      <?php $class = 'col-sm-9'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php } ?>
      <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
        <h3><?php echo $text_location; ?></h3>
        <div class="contact-location hidden-xs">
          <div id="contact-map"></div>
        </div>
        <?php if ($locations) { ?>
        <h3><?php echo $text_store; ?></h3>
        <div class="panel-group" id="accordion">
          <?php foreach ($locations as $location) { ?>
          <div class="panel panel-default">
            <div class="panel-heading">
              <h4 class="panel-title"><a href="#collapse-location<?php echo $location['location_id']; ?>" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"><?php echo $location['name']; ?> <i class="fa fa-caret-down"></i></a></h4>
            </div>
            <div class="panel-collapse collapse" id="collapse-location<?php echo $location['location_id']; ?>">
              <div class="panel-body">
                <div class="row">
                  <?php if ($location['image']) { ?>
                  <div class="col-sm-3">
                    <img src="<?php echo $location['image']; ?>" alt="<?php echo $location['name']; ?>" title="<?php echo $location['name']; ?>" class="img-thumbnail" />
                  </div>
                  <?php } ?>
                  <div class="col-sm-3">
                    <strong><?php echo $location['name']; ?></strong><br />
                    <address>
                    <?php echo $location['address']; ?>
                    </address>
                    <?php if ($location['geocode']) { ?>
                    <a href="https://maps.google.com/maps?q=<?php echo urlencode($location['geocode']); ?>&hl=en&t=m&z=15" target="_blank" class="btn btn-info"><i class="fa fa-map-marker"></i> <?php echo $button_map; ?></a>
                    <?php } ?>
                  </div>
                  <div class="col-sm-3">
                    <strong><?php echo $text_telephone; ?></strong><br>
                    <?php echo $location['telephone']; ?><br />
                    <br />
                    <?php if ($location['fax']) { ?>
                    <strong><?php echo $text_fax; ?></strong><br>
                    <?php echo $location['fax']; ?>
                    <?php } ?>
                  </div>
                  <div class="col-sm-3">
                    <?php if ($location['open']) { ?>
                    <strong><?php echo $text_open; ?></strong><br />
                    <?php echo $location['open']; ?><br />
                    <br />
                    <?php } ?>
                    <?php if ($location['comment']) { ?>
                    <strong><?php echo $text_comment; ?></strong><br />
                    <?php echo $location['comment']; ?>
                    <?php } ?>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <?php } ?>
        </div>
        <?php } ?>

        <div class="contact-us">
          <?php
            $html = html_entity_decode($themeConfig['contact_customhtml'][$config->get('config_language_id')]);
            $c = 0;
            $c2 = 8;
          ?>
          <div class="panel panel-success">
            <div class="panel-heading">
              <h3 class="panel-title"><?php echo $heading_title; ?></h3>
            </div>
            <div class="panel-body">
              <?php if( !empty($html) ) { ?>
              <div class="panel-contact-custom">
                <?php echo $html; ?>
              </div>
              <?php } ?>
              <div class="margin-top-40">
                <div class="col-md-5 table-responsive">
                  <table class="info-table">
                    <tbody>
                      <tr class="info-table-row">
                         <th class="info-table-icon"><i class="fa fa-long-arrow-right"></i></th>
                         <td class="info-table-content"><?php echo $store; ?></td>
                      </tr>
                      <tr class="info-table-row">
                         <th class="info-table-icon"><i class="fa fa-map-marker"></i></th>
                         <td class="info-table-content">
                          <?php echo $address; ?>
                          <?php if ($geocode) { ?>
                            <a href="https://maps.google.com/maps?q=<?php echo urlencode($geocode); ?>&hl=en&t=m&z=15" target="_blank" class="btn btn-info"><i class="fa fa-map-marker"></i> <?php echo $button_map; ?></a>
                          <?php } ?>
                         </td>
                      </tr>
                      <tr class="info-table-row">
                         <th class="info-table-icon"><i class="fa fa-phone"></i></th>
                         <td class="info-table-content"><?php echo $telephone; ?></td>
                      </tr><!-- 
                      <tr class="info-table-row">
                         <th class="info-table-icon"><i class="fa fa-fax"></i></th>
                         <td class="info-table-content"><?php echo $fax; ?></td>
                      </tr>
                      <tr class="info-table-row">
                         <th class="info-table-icon"><i class="fa fa-folder-open"></i></th>
                         <td class="info-table-content"> <?php echo $open; ?></td>
                      </tr>
                      <tr class="info-table-row">
                         <th class="info-table-icon"><i class="fa fa-commenting-o"></i></th>
                         <td class="info-table-content"><?php echo $comment; ?></td>
                      </tr> -->
                    </tbody>
                  </table>
                </div>
                <div class="col-md-7">
                  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
                    <fieldset>
                      <h4 style="margin-top: 0px;"><?php echo $text_contact; ?></h4>
                      <div class="form-group required">
                        <label class="col-sm-2 hidden control-label" for="input-name"><?php echo $entry_name; ?></label>
                        <div class="col-sm-12">
                          <input placeholder="<?php echo $entry_name; ?>" type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
                          <?php if ($error_name) { ?>
                          <div class="text-danger"><?php echo $error_name; ?></div>
                          <?php } ?>
                        </div>
                      </div>
                      <div class="form-group required">
                        <label class="col-sm-2 hidden control-label" for="input-email"><?php echo $entry_email; ?></label>
                        <div class="col-sm-12">
                          <input placeholder="<?php echo $entry_email; ?>" type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />
                          <?php if ($error_email) { ?>
                          <div class="text-danger"><?php echo $error_email; ?></div>
                          <?php } ?>
                        </div>
                      </div>
                      <div class="form-group required">
                        <label class="col-sm-2 hidden control-label" for="input-enquiry"><?php echo $entry_enquiry; ?></label>
                        <div class="col-sm-12">
                          <textarea placeholder="<?php echo $entry_enquiry; ?>" name="enquiry" rows="4" id="input-enquiry" class="form-control"><?php echo $enquiry; ?></textarea>
                          <?php if ($error_enquiry) { ?>
                          <div class="text-danger"><?php echo $error_enquiry; ?></div>
                          <?php } ?>
                        </div>
                      </div>
                      <!-- <?php echo $captcha; ?> -->
                    </fieldset>
                    <div class="buttons">
                      <div class="pull-right">
                        <input class="btn btn-success" type="submit" value="<?php echo $button_submit; ?>" />
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>


        <?php echo $content_bottom; ?></div>
      <?php echo $column_right; ?></div>
  </div>
</div>
<?php // Jquery googlemap api v3?>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&language=en"></script>
    <script type="text/javascript" src="catalog/view/javascript/gmap/gmap3.min.js"></script>
    <script type="text/javascript" src="catalog/view/javascript/gmap/gmap3.infobox.js"></script>
    <script type="text/javascript">
        var mapDiv, map, infobox;
        var lat = <?php echo isset($themeConfig['location_latitude'])?$themeConfig['location_latitude']:'40.705423'; ?>;
        var lon = <?php echo isset($themeConfig['location_longitude'])?$themeConfig['location_longitude']:'-74.008616'; ?>;
        jQuery(document).ready(function($) {
            mapDiv = $("#contact-map");
            mapDiv.height(400).gmap3({
                map:{
                    options:{
                        center:[lat,lon],
                        zoom: 15,
                        scrollwheel: false
                    }
                },
                marker:{
                    values:[
                        {latLng:[lat, lon], data:"<?php echo isset($themeConfig['location_address'])?$themeConfig['location_address']:'79-99 Beaver Street, New York, NY 10005, USA'; ?>"},
                    ],
                    options:{
                        draggable: false
                    },
                    events:{
                          mouseover: function(marker, event, context){
                            var map = $(this).gmap3("get"),
                                infowindow = $(this).gmap3({get:{name:"infowindow"}});
                            if (infowindow){
                                infowindow.open(map, marker);
                                infowindow.setContent(context.data);
                            } else {
                                $(this).gmap3({
                                infowindow:{
                                    anchor:marker,
                                    options:{content: context.data}
                                }
                              });
                            }
                        },
                        mouseout: function(){
                            var infowindow = $(this).gmap3({get:{name:"infowindow"}});
                            if (infowindow){
                                infowindow.close();
                            }
                        }
                    }
                }
            });
        });
    </script>
<?php //end contact map ?>
<?php echo $footer; ?>