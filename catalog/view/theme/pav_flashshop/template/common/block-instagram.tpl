<?php

$i_title = $helper->getLangConfig('i_title');
$config  = (array)$sconfig->get('themecontrol');

$default = array(
    'i_username'  => "1213565508",
    'i_token' => "1213565508.1677ed0.e31553e458274a178d41daa1968e9671",
);
$config = array_merge($default, $config);

// get user name http://jelled.com/instagram/lookup-user-id
$user_id= $config['i_username'];
// get token //http://instagram.pixelunion.net/
$access_token = $config['i_token'];

$url = "https://api.instagram.com/v1/users/".$user_id."/media/recent?access_token=".$access_token;

$ch = curl_init($url);

curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 20);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

$json = curl_exec($ch);

curl_close($ch);
$result = json_decode($json);
//echo "<pre>"; print_r($result); die;
?>
<div class="panel panel-default instagram">
    <div class="panel-heading">
        <h5 class="panel-title"><span><?php echo $objlang->get("Instagram"); ?></span></h5>
    </div>
    <div class="panel-body">
    <?php $i=0; foreach ($result->data as $post) {if($i<6) { ?>
    	<a class="instagram-unit" target="_blank" href="<?php echo $post->link;?>">
    		<img alt="img" style="width: 80px; height: 80px; padding: 5px;" src="<?php echo $post->images->low_resolution->url;?>"/>
    	</a>
    <?php }  $i++; } ?>
    </div>
</div>