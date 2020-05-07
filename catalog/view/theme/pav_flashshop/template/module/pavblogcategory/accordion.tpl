<div id="blog-accordion" class="panel panel-default panel-v1 pavblog-accordion">
	<div class="panel-heading"><h3 class="panel-title"><?php echo $heading_title; ?></h3></div>
	<div class="panel-body tree-menu">
		<div class="accordion">
			<?php echo $tree;?>
		</div>
	</div>
</div>

<script type="text/javascript">
$('#blog-accordion .level2, .level3, .level4').hide();
$('#blog-accordion .accordion a i').click(function(){
	$('+ ul, + ul ul',$(this).parent()).slideToggle(400);
	$(this).parent().toggleClass('active');
	$(this).html($(this).parent().hasClass('active')?"<span>+</span>":"<span>-</span>");
	return false;
});
</script>