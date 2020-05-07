<?php  echo $header; ?>


<div class="main-columns container ">

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
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>

		<!-- <h2><?php echo $blog['title'];?></h2> -->
		<div class="blog-meta">
			<ul class="list-inline">
				<li>
					<?php if( $blog_show_author ) { ?>
					<span class="author"><i class="zmdi zmdi-account-o zmdi-hc-fw text-primary"></i><?php echo $blog['author'];?></span>
					<?php } ?>
				</li>
				<li>
					<?php if( $blog_show_category ) { ?>
					<span class="publishin">
						<i class="zmdi zmdi-folder-outline zmdi-hc-fw text-primary"></i>
						<a class="color" href="<?php echo $blog['category_link'];?>" title="<?php echo $blog['category_title'];?>"><?php echo $blog['category_title'];?></a>
					</span>
					<?php } ?>
				</li>

				<li>
					<?php if( $blog_show_created ) { ?>
					<span class="created"><i class="zmdi zmdi-time zmdi-hc-fw text-primary"></i> <?php echo $blog['created'];?></span>
					<?php } ?>
				</li>
				<li>
					<?php if( $blog_show_hits ) { ?>
					<span class="hits"><i class="zmdi zmdi-bookmark-outline zmdi-hc-fw text-primary"></i> <?php echo $blog['hits'];?></span>
					<?php } ?>
				</li>

				<li>
					<?php if( $blog_show_comment_counter ) { ?>
					<span class="comment_count"><i class="zmdi zmdi-comment-outline zmdi-hc-fw text-primary"></i> <?php echo $blog['comment_count'];?></span>
					<?php } ?>
				</li>
			</ul>
		</div>
		<!-- Start Div Content -->
		<div class="pav-blogs">
		<?php if( $blog['thumb_large'] ) { ?>
			<div class="text-center">
				<img alt="<?php echo $blog['title'];?>" class="img-responsive margin-bottom-20" src="<?php echo $blog['thumb_large'];?>" title="<?php echo $blog['title'];?>"/>
			</div>
		<?php } ?>
		<div class="clearfix"></div>

			<div class="blog-content space-top-20">
				<div class="description"><?php echo $description;?></div>
				<div class="content-wrap">
				<?php echo $content;?>
				</div>
				<?php if( $blog['video_code'] ) { ?>
				<div class="pav-video"><?php echo html_entity_decode($blog['video_code'], ENT_QUOTES, 'UTF-8');?></div>
				<?php } ?>
			</div>
			<div class="clearfix"></div>


			 <?php if( !empty($tags) ) { ?>
			 <div class="blog-tags">
				<b><?php echo $objlang->get('text_tags');?></b>
				<?php 	$i = 1; foreach( $tags as $tag => $tagLink ) { ?>
					<a class="color" href="<?php echo $tagLink; ?>" title="<?php echo $tag; ?>"><?php echo $tag; ?></a> <?php if($i<count($tags)) { echo ","; }; ?>
				<?php $i++; }  ?>
				<hr>
			 </div>
			 <?php } ?>

			 <div class="row">
				<?php if( !empty($samecategory) ) { ?>
				<div class="col-sm-6 col-lg-6 col-sm-6 col-xs-12">
					<h4><?php echo $objlang->get('text_in_same_category');?></h4>
					<ul class="list-arrow">
						<?php foreach( $samecategory as $item ) { ?>
						<li><a href="<?php echo $objurl->link('pavblog/blog',"blog_id=".$item['blog_id']);?>"><?php echo $item['title'];?></a></li>
						<?php } ?>
					</ul>
				</div>
				<?php } ?>
				<?php if( !empty($related) ) { ?>
				<div class="col-sm-6 col-lg-6 col-sm-6 col-xs-12">
					<h4><?php echo $objlang->get('text_in_related_by_tag');?></h4>
					<ul class="list-arrow">
						<?php foreach( $related as $item ) { ?>
						<li><a href="<?php echo $objurl->link('pavblog/blog',"blog_id=".$item['blog_id']);?>"><?php echo $item['title'];?></a></li>
						<?php } ?>
					</ul>
				</div>
				<?php } ?>
			</div>

			<div class="pav-comment">
					<?php if( $blog_show_comment_form ) { ?>
						<?php if( $comment_engine == 'diquis' ) { ?>
				    <div id="disqus_thread"></div>
					<script type="text/javascript">
						//CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE
						var disqus_shortname = '<?php echo $config->get('diquis_account');?>'; // required: replace example with your forum shortname

						//DON'T EDIT BELOW THIS LINE
						(function() {
							var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
							dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
							(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
						})();
					</script>
					<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
					<a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>

						<?php } elseif( $comment_engine == 'facebook' ) { ?>
					<div id="fb-root"></div>
					<script>(function(d, s, id) {
					  var js, fjs = d.getElementsByTagName(s)[0];
					  if (d.getElementById(id)) {return;}
					  js = d.createElement(s); js.id = id;
					  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=<?php echo $config->get("facebook_appid");?>";
					  fjs.parentNode.insertBefore(js, fjs);
					}(document, 'script', 'facebook-jssdk'));</script>
					<div class="fb-comments" data-href="<?php echo $link; ?>"
							data-num-posts="<?php echo $config->get("comment_limit");?>" data-width="<?php echo $config->get("facebook_width")?>">
					</div>
					<?php }else { ?>
						<?php if( count($comments) ) { ?>
						<h4><?php echo $objlang->get('text_list_comments'); ?></h4>
						<div class="pave-listcomments">
							<?php foreach( $comments as $comment ) {  $default='';?>
							<div class="comment-item media clearfix" id="comment<?php echo $comment['comment_id'];?>">
								<div class="media-left">
									<img src="<?php echo "http://www.gravatar.com/avatar/" . md5( strtolower( trim( $comment['email'] ) ) ) . "?d=" . urlencode( $default ) . "&s=60" ?>"/>
								</div>
								<div class="comment-wrap media-right">
									<div class="comment-meta">
									<span class="comment-created"><?php echo $objlang->get('text_created');?> <span><?php echo $comment['created'];?></span></span>
									<span class="comment-postedby"><?php echo $objlang->get('text_postedby');?> <span><?php echo $comment['user'];?></span></span>
									<span class="comment-link"><a href="<?php echo $link;?>#comment<?php echo $comment['comment_id'];?>"><?php echo $objlang->get('text_comment_link');?></a></span>
									</div>
									<?php echo $comment['comment'];?>
								</div>
							</div>
							<?php } ?>
							<div class="pagination">
								<?php echo $pagination;?>
							</div>
						</div>
						<?php } ?>
						<h4><?php echo $objlang->get("text_leave_a_comment");?></h4>
						<form action="<?php echo $comment_action;?>" method="post" id="comment-form" class="form-horizontal space-top-20">
							<fieldset>

								<div class="message" style="display:none"></div>
								<div class="form-group required">
									<div class="col-sm-6">
										<input class="form-control margin-bottom-20" type="text" name="comment[user]" value="" placeholder="<?php if(isset($value) && $value){ echo $value; }else{ echo "Full Name";} ?>" id="comment-user"/>
									</div>
									<div class="col-sm-6">
										<input class="form-control margin-bottom-20" type="text" name="comment[email]" value="" placeholder="<?php if(isset($value) && $value){ echo $value; }else{ echo "Email";} ?>" id="comment-email"/>
									</div>
								</div>
								<div class="form-group required">
									<div class="col-sm-12">
										<textarea class="form-control" name="comment[comment]" placeholder="<?php if(isset($value) && $value){ echo $value; }else{ echo "Comment... ";} ?>" id="comment-comment"></textarea>
									</div>
								</div>


								<?php if ($site_key) { ?>
										<div class="form-group">
											<div class="col-sm-12">
											<div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
												<?php if ($error_captcha) { ?>
												<div class="text-danger"><?php echo $error_captcha; ?></div>
												<?php } ?>
											</div>
										</div>
									<?php } ?>
								<input type="hidden" name="comment[blog_id]" value="<?php echo $blog['blog_id']; ?>" />
								<div class="buttons">
		                            <button class="btn btn-primary" type="submit">
										<span><?php echo $objlang->get('text_submit');?></span>
									</button>
		                    	</div>
							</fieldset>
						</form>
						<script type="text/javascript">
							$( "#comment-form .message" ).hide();
							$("#comment-form").submit( function(){
								$.ajax( {type: "POST",url:$("#comment-form").attr("action"),data:$("#comment-form").serialize(), dataType: "json",}).done( function( data ){
									if( data.hasError ){
										$( "#comment-form .message" ).html( data.message ).show();
									}else {
										location.href='<?php echo str_replace("&amp;","&",$link);?>';
									}
								} );
								return false;
							} );

						</script>
					<?php } ?>
				<?php } ?>
			</div> <!-- end pav-comment -->
		</div> <!-- end pav-blog -->
		<!-- End Div Content -->
		<?php echo $content_bottom; ?></div>

		<!-- End Div Row -->
		<?php echo $column_right; ?></div>

</div><!-- End Div Container -->
<?php echo $footer; ?>