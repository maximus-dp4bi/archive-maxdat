
/* Soundra 7/18/2016
Update AMP Export Crosswalk of CHAT
*/
update cc_a_list_lkup set list_type = 'ACD,CHAT' where name = 'AMPEXP_METRIC_SOURCE_LIST' and value in ('WEB_CHATS_CREATED','WEB_CHATS_HANDLED');


