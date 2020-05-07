<?php
	$config = $sconfig;
    $theme  = $themename;
    $themeConfig = (array)$config->get('themecontrol');
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/deal_collection.tpl';
?>
<?php echo $header; ?>

<div class="main-columns container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
	<div class="row">
		<?php echo $column_left; ?>
	    <?php if ($column_left && $column_right) { ?>
	    <?php $class = 'col-md-6'; ?>
	    <?php } elseif ($column_left || $column_right) { ?>
	    <?php $class = 'col-md-9'; ?>
	    <?php } else { ?>
	    <?php $class = 'col-md-12'; ?>
	    <?php } ?>
		<div id="sidebar-main" class="<?php echo $class; ?>">
			<div id="content">
				<div class="pavdeals tab-group">
					<ul class="nav nav-tabs deals-option margin-bottom-40 text-center">
						<?php foreach ($head_titles as $item): ?>
						<?php if ($item['active']): ?>
						<li class="active"><a href="<?php echo $item['href'];?>"><?php echo $item['text'];?></a></li>
						<?php else: ?>
						<li><a href="<?php echo $item['href'];?>"><?php echo $item['text'];?></a></li>
						<?php endif; ?>
						<?php endforeach; ?>
					</ul>
					<!-- Deal Option -->
					<!-- Fillter Product -->
					<?php if (count($products) > 0): ?>
                    <div class="no-space-row">
					<div class="row filter">
						<div class="col-md-2">
							<div class="btn-group display group-switch hidden-xs">
								<button type="button" id="list-view" class="btn-switch" data-toggle="tooltip" title="<?php echo $objlang->get("button_list"); ?>"><i class="zmdi zmdi-format-list-bulleted"></i></button>
		            			<button type="button" id="grid-view" class="btn-switch active" data-toggle="tooltip" title="<?php echo $objlang->get("button_grid"); ?>"><i class="zmdi zmdi-border-all"></i></button>
							</div>
						</div>

						<div class="col-md-1 text-right">
							<label class="control-label" for="input-sort"><?php echo $objlang->get('text_sort'); ?></label>
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
							<label class="control-label" for="input-limit"><?php echo $objlang->get('text_limit'); ?></label>
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
						</div><!--end limit-->
						<div class="col-md-2 text-right">
							<label class="control-label" for="input-category"><?php echo $objlang->get('text_category'); ?></label>
						</div>
						<div class="col-md-2 text-right">
							<select id="input-category" class="form-control input-sm" name="category_id" onchange="location = this.value;">
								<option value="<?php echo $href_default;?>"><?php echo $objlang->get("text_category_all"); ?></option>
								<?php foreach ($categories as $category_1) { ?>
								<?php if ($category_1['category_id'] == $category_id) { ?>
								<option value="<?php echo $category_1['href']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $category_1['href']; ?>"><?php echo $category_1['name']; ?></option>
								<?php } ?>
								<?php foreach ($category_1['children'] as $category_2) { ?>
								<?php if ($category_2['child_id'] == $category_id) { ?>
								<option value="<?php echo $category_2['href']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $category_2['href']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
								<?php } ?>

								<?php if (isset($category_2['children'])) { ?>
								<?php foreach ($category_2['children'] as $category_3) { ?>
								<?php if ($category_3['child_id'] == $category_id) { ?>
								<option value="<?php echo $category_3['href']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $category_3['href']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
								<?php } ?>
								<?php } //endforeach categories_2?>
								<?php } //endif endforeach categories_2?>

								<?php } //endforeach categories_1?>
								<?php } //endforeach categories_0?>
							</select>
						</div><!--end category-->
					</div>
                    </div>
					<?php endif; ?>
					<!-- List Product -->
					<?php if (count($products) > 0): ?>
					<?php require( $productLayout );  ?>
					<?php endif; ?>

				</div><!-- end div deals -->
				<div class="row">
					<?php if (empty($products)): ?>
					<div class="col-sm-6 text-left"><?php echo $objlang->get('text_not_empty');?></div>
					<div class="col-sm-6 text-right">
						<div class="buttons">
							<div class="pull-right"><a href="<?php echo $objurl->link('common/home'); ?>" class="btn btn-default"><?php echo $objlang->get('button_continue'); ?></a></div>
						</div>
					</div>
					<?php endif; ?>
				</div>
			</div><!-- end div #content -->
		</div>
		<?php echo $column_right; ?>
	</div>
</div><!-- end div .container -->
<?php echo $footer; ?>
