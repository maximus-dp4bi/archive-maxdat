
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'PC_SUPERVISOR_STATUS','INCIDENT_STATUS','Supervisor',null,null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'String to search for when Incident status is Refer to Supervisor',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'PC_STATE_STATUS','INCIDENT_STATUS','State',null,null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'String to search for when Incident status is any of the Refer to State* statuses',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'PC_CLOSE_STATUS','INCIDENT_STATUS','Close',null,null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'String to search for when Incident status is any of the Closed statuses',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'PC_WIHDRAWN_STATUS','INCIDENT_STATUS','Withdrawn',null,null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'String to search for when Incident status is any of the Withdrawn statuses',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'PC_FOLLOWUP_STATUS','INCIDENT_STATUS','Follow up Required',null,null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Follow up Required status',SYSDATE,SYSDATE);                    

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'PC_ERROR_STATUS','INCIDENT_STATUS','Sent In Error',null,null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Sent In Error status',SYSDATE,SYSDATE);

commit;