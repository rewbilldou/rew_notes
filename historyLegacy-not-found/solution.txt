Just run these two queries:

1. ALTER TABLE  `history_events` CHANGE  `type`  `type` ENUM(  'Action',  'Create',  'Update',  'Delete',  'Email',  'Phone',  'Text',  'LegacyNote' ) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ;

2. UPDATE `history_events` SET `type`='LegacyNote' WHERE `subtype`='LegacyHistory';