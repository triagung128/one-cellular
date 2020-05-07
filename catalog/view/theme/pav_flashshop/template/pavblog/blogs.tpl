<?php  echo $header; ?>

<div class="main-columns container">

    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>
	<div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-md-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-md-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-md-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?> page-pavblog">

		<?php echo $content_top; ?>
		<h1><?php echo $heading_title; ?></h1>
		<!-- Start Div Content -->
		<div class="pav-header text-right">
			<a href="<?php echo $latest_rss;?>"><span class="fa fa-rss text-warning"></span></a>
		</div>
		<div class="pav-filter-blogs">
			<div class="pav-blogs">
				<?php $cols = $cat_columns_leading_blogs;

				if( count($leading_blogs) ) { ?>
					<div class="leading-blogs clearfix">
						<?php foreach( $leading_blogs as $key => $blog ) { $key = $key + 1;?>
						<div class="pavcol<?php echo $cols;?>">
						<?php require( '_item.tpl' ); ?>
						</div>
						<?php if( ( $key%$cols==0 || $cols == count($leading_blogs)) ){ ?>
							<div class="clearfix"></div>
						<?php } ?>
						<?php } ?>
					</div>
				<?php } ?>
				<?php
					$cols = $cat_columns_secondary_blogs;
					$cols = !empty($cols)?$cols:1;
					if ( count($secondary_blogs) ) { ?>
					<div class="secondary clearfix">

						<?php foreach( $secondary_blogs as $key => $blog ) {  $key = $key+1; ?>
						<div class="pavcol<?php echo $cols;?>">
						<?php require( '_item.tpl' ); ?>
						</div>
						<?php if( ( $key%$cols==0 || $cols == count($leading_blogs)) ){ ?>
							<div class="clearfix"></div>
						<?php } ?>
						<?php } ?>
					</div>
				<?php } ?>

				<div class="pav-pagination pagination space-top-30"><?php echo $pagination;?></div>
			</div>
		</div>
		<!-- End Div Content -->
		<?php echo $content_bottom; ?></div>

		<!-- End Div Row -->
		<?php echo $column_right; ?></div>

</div><!-- End Div Container -->
<?php echo $footer; ?>