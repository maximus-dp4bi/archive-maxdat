
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTREACH_STATUS','LIST','Outreach Request Initiated','OUTREACH_REQUEST_INITIATED','OUTREACH',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTREACH_STATUS','LIST','Outreach Successful','OUTREACH_REQUEST_SUCCESSFUL','OUTREACH',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTREACH_STATUS','LIST','Outreach Unsuccessful','OUTREACH_REQUEST_UNSUCCESSFUL','OUTREACH',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTREACH_STATUS','LIST','Existing Request - Home Visit','OUTREACH_REQUEST_EXIST_HM_VISIT','OUTREACH',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTREACH_STATUS','LIST','Outreach No Longer Required','OUTREACH_REQUEST_NOT_REQUIRED','OUTREACH',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTREACH_EVENT','LIST','Help Finding Providers','FIND_PROV_HELP','EVENT',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTREACH_STATUS','LIST','Outreach Invalid Request','OUTREACH_INVALID_REQUEST','OUTREACH',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTREACH_EVENT','LIST','Outreach Request Home Visit Failure','OR_HOME_VISIT_FAILURE','EVENT',null,null,null,null,SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTREACH_EVENT','LIST','Outreach Request Home Visit Success','OR_HOME_VISIT_SUCCESS','EVENT',null,null,null,null,SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTREACH_EVENT','LIST','Withdrawn','WITHDRAWN','OUTREACH',null,null,null,null,SYSDATE,SYSDATE);

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'CO_EXTRACT_STATUS'
,'OUTREACH_STATUS'
,'Various incident status to extract for Client Outreach'
,'''Outreach Request Initiated'',''Outreach Successful'',''Outreach Unsuccessful'',''Existing Request - Home Visit'',''Outreach No Longer Required'',''Outreach Invalid Request'',''Withdrawn''' 
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;

commit;