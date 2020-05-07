<?php

$query['pavmegamenu'][]  = "DELETE FROM `".DB_PREFIX ."setting` WHERE `code`='pavmegamenu' and `key` = 'pavmegamenu_module'";

$query['pavmegamenu'][]  = "DELETE FROM `".DB_PREFIX ."setting` WHERE `code`='pavmegamenu_params' and `key` = 'params'";
$query['pavmegamenu'][] =  "
INSERT INTO `".DB_PREFIX ."setting` (`setting_id`, `store_id`, `code`, `key`, `value`, `serialized`) VALUES

(0, 0, 'pavmegamenu_params', 'pavmegamenu_params', '[{\"submenu\":1,\"subwidth\":1000,\"id\":117,\"align\":\"aligned-fullwidth\",\"group\":0,\"cols\":1,\"rows\":[{\"cols\":[{\"widgets\":\"wid-32\",\"colwidth\":3},{\"widgets\":\"wid-33\",\"colwidth\":3},{\"widgets\":\"wid-34\",\"colwidth\":3},{\"widgets\":\"wid-38\",\"colwidth\":3}]}]},{\"id\":120,\"group\":0,\"cols\":1,\"submenu\":1,\"align\":\"aligned-left\",\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"id\":126,\"group\":0,\"cols\":1,\"submenu\":1,\"align\":\"aligned-left\",\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]}]', 0);

";

$query['pavverticalmenu'][]  = "DELETE FROM `".DB_PREFIX ."setting` WHERE `code`='pavverticalmenu_params' and `key` = 'params'";
$query['pavverticalmenu'][] ="INSERT INTO `".DB_PREFIX ."setting` (`setting_id`, `store_id`, `code`, `key`, `value`, `serialized`) VALUES

(0, 0, 'pavverticalmenu_params', 'params', '[{\"submenu\":1,\"subwidth\":650,\"id\":49,\"group\":0,\"cols\":1,\"rows\":[{\"cols\":[{\"widgets\":\"wid-17\",\"colwidth\":12}]}]},{\"submenu\":1,\"id\":48,\"group\":0,\"cols\":1,\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"id\":62,\"group\":0,\"cols\":1,\"submenu\":1,\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]}]', 0);

";


$query['pavblog'][] ="
INSERT INTO `".DB_PREFIX ."layout_route` (`layout_route_id`, `layout_id`, `store_id`, `route`) VALUES
(321, 14, 0, 'pavblog/%');
";
$query['pavblog'][] ="
INSERT INTO `".DB_PREFIX ."layout` (`layout_id`, `name`) VALUES
(14, 'Pav Blog');
";
?>