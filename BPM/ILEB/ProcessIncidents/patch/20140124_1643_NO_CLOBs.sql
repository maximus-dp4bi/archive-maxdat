/*
Created on 24-Jan-2014 by Raj A.
Description:
While working on the TX process Incidents, MAXDAT team decided that going forward the ETL stage tables, Semantic and Events all should have NO CLOBs; 
only varchar2(4000). ILEB needs the CLOB data in the columns, so before dropping the CLOB columns move data into the varchar2(4000) columns. 
For Corp code: ETL will NOT update these varchar2(4000) columns.
*/
 alter table corp_etl_process_incidents
add action_comments_2 varchar2(4000);

 alter table PROCESS_INCIDENTS_OLTP
add action_comments_2 varchar2(4000);

 alter table PROCESS_INCIDENTS_WIP_BPM
add action_comments_2 varchar2(4000);

update corp_etl_process_incidents
   set action_comments_2 = dbms_lob.substr( action_comments, 4000,1)
;
commit;

 alter table corp_etl_process_incidents
 drop column action_comments; 
  
 alter table PROCESS_INCIDENTS_OLTP
 drop column action_comments;

 alter table PROCESS_INCIDENTS_WIP_BPM
 drop column action_comments;

  alter table corp_etl_process_incidents
rename column action_comments_2 to action_comments;

 alter table PROCESS_INCIDENTS_OLTP
rename column action_comments_2 to action_comments;

 alter table PROCESS_INCIDENTS_WIP_BPM
rename column action_comments_2 to action_comments;