
 alter table NYHX_ETL_COMPLAINTS_INCIDENTS
add action_comments_2 varchar2(4000);

 alter table NYHX_ETL_COMPL_INCIDENTS_OLTP
add action_comments_2 varchar2(4000);

 alter table NYHX_ETL_COMPL_INCIDN_WIP_BPM
add action_comments_2 varchar2(4000);

update NYHX_ETL_COMPLAINTS_INCIDENTS
   set action_comments_2 = dbms_lob.substr( action_comments, 4000,1)
;
commit;

 alter table NYHX_ETL_COMPLAINTS_INCIDENTS
 drop column action_comments; 
  
 alter table NYHX_ETL_COMPL_INCIDENTS_OLTP
 drop column action_comments;

 alter table NYHX_ETL_COMPL_INCIDN_WIP_BPM
 drop column action_comments;

  alter table NYHX_ETL_COMPLAINTS_INCIDENTS
rename column action_comments_2 to action_comments;

 alter table NYHX_ETL_COMPL_INCIDENTS_OLTP
rename column action_comments_2 to action_comments;

 alter table NYHX_ETL_COMPL_INCIDN_WIP_BPM
rename column action_comments_2 to action_comments;