prompt Created on Friday, August 24, 2012 by m18957
set feedback off
set define off
prompt Alter CHECK_STG_APP_STATUS_GROUP constraint...

alter table PROCESS_APP_STG
  drop constraint CHECK_STG_APP_STATUS_GROUP;
alter table PROCESS_APP_STG
  add constraint CHECK_STG_APP_STATUS_GROUP
  check (APP_STATUS_GROUP	IN(	'Renewal Initiated',
'Received',
'In Process',
'Awaiting Missing Information',
'Done',
'Cancelled','VOID'	));

prompt Alter CHECK_APP_STATUS_GROUP constraint...

alter table NYEC_ETL_PROCESS_APP
  drop constraint CHECK_APP_STATUS_GROUP;
alter table NYEC_ETL_PROCESS_APP
  add constraint CHECK_APP_STATUS_GROUP
  check (APP_STATUS_GROUP	IN(	'Renewal Initiated',
'Received',
'In Process',
'Awaiting Missing Information',
'Done',
'Cancelled','VOID'	));

commit;
prompt constraint altered
set feedback on
set define on
prompt Done.
