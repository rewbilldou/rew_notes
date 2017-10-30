# How to grab all agent valid ids from CMS database

```php
$db=DB::get();
$ids=array();
$agent_ids=$db->fetchAll("SELECT `agent_id` FROM `agents`");
if(!empty($agent_ids)){
	foreach($agent_ids as $id){
		if($id['agent_id']!='')
		$ids[]=str_replace(array('{"crmls":"','"}'),array('',''),$id['agent_id']);
	}
}
```