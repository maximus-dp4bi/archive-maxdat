
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



Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Missed Appt Date missing','Appt Date Missing','ORDER_BY_DEFAULT','10',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR1','Invalid Outreach Request - Missed Appt Date missing','Reminder Appt Date Missing','ORDER_BY_DEFAULT','10',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Claims 1 year','Claims 1 Year','ORDER_BY_DEFAULT','20',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Client has selection','Client Has Selection','ORDER_BY_DEFAULT','30',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Client Not Found','Client Not Found','ORDER_BY_DEFAULT','40',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Client Age not 2-18','Client Between 2-18','ORDER_BY_DEFAULT','40',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Medicaid Not Elig','Client is Medicaid Eligible - Not Ortho','ORDER_BY_DEFAULT','45',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Client not SSI','Client Not SSI','ORDER_BY_DEFAULT','50',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Client Over 21','Client Over 21','ORDER_BY_DEFAULT','60',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR1','Invalid Outreach Request - Client Over 21','Client Over 21 - Not Ortho','ORDER_BY_DEFAULT','70',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Provider type not Medical','Provider Type Medical','ORDER_BY_DEFAULT','70',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Client enrolled 1E','Client Reenrolled 1E','ORDER_BY_DEFAULT','80',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Script Delivered Within 30 days','HCO BASIC IN 30 Days','ORDER_BY_DEFAULT','90',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Invalid Referral Type','Extra Effort Invalid Request','ORDER_BY_DEFAULT','92',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Missed Appt too old','Missed Appt - Too Old','ORDER_BY_DEFAULT','100',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Dup Missed Appt','Client Missed Appointment Duplicate','ORDER_BY_DEFAULT','110',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Script Delivered Within 30','Script Delivered Within 30 days','ORDER_BY_DEFAULT','120',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Client not TANF Certified/Pending','Client TANF Certified/Pending','ORDER_BY_DEFAULT',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR','Invalid Outreach Request - Outreach attempted thru Chip case','Valid Outreach Request cannot be created from Chip case.','ORDER_BY_DEFAULT',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CO_EVENT_VALIDATION','CO_VALIDATION_ERROR1','Invalid Outreach Request - Medicaid Not Elig','Client Eligibility Status Changed','ORDER_BY_DEFAULT',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
commit;                                                                                                                                                                                    



commit;