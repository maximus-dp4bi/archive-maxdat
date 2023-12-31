
/* Soundra 4/20/2016
List of AMP Export Projects and their available sources. All projects need ACD, Additional non-mandatory sources are configured.
*/
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_PROJECT_SOURCE_LIST','ACD,IVR','MIEB','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_PROJECT_SOURCE_LIST','ACD','KS CH','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_PROJECT_SOURCE_LIST','ACD','MD HIX','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_PROJECT_SOURCE_LIST','ACD','KSLW','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_PROJECT_SOURCE_LIST','ACD','WC HS','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_PROJECT_SOURCE_LIST','ACD','MD EB','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
--Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
--values (seq_cc_cell_id.Nextval,'AMPEXP_PROJECT_SOURCE_LIST','ACD,WFM','ILEB','ACD,WFM',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);


/* Soundra 4/20/2016
List of Metrics and the sources they need. All metrics need ACD, so it is not explicitly stored. Only metrics which need non-mandatory sources are configured.
*/

Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD,IVR', 'CALLS_CONTAINED_IN_IVR','IVR',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD,WFM','AT_WORK_NOT_HANDLING_CONTACTS_PERCENTAGE','WFM',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD,WFM','Total Utilization (Availability)','WFM',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD,WFM','UNPLANNED_ABSENTEEISM_PERCENTAGE','WFM',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD,WFM','PLANNED_ABSENTEEISM_PERCENTAGE','WFM',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD,WFM','PLANNED_UNPAID_ABSENTEEISM_PERCENTAGE','WFM',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD,WFM','MAX_NUMBER_OF_AGENTS_IN_TRAINING','WFM',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD,WFM','MAX_NUMBER_OF_AGENTS_SCHEDULED_TO_HANDLE_CONTACTS','WFM',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
 
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','AB Rate','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','AHT','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','ASA','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','AVERAGE_ABANDON_WAIT_TIME','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','CALLS_HANDLED','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD,IVR','Calls Arriving','IVR',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','Calls Offered','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','DAYS_OF_OPERATION','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','MAX_HANDLE_TIME','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','MAX_NUMBER_OF_AGENTS_AVAILABLE_TO_HANDLE_CONTACTS','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','MAX_SPEED_TO_ANSWER','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','OUTBOUND_CALLS_ATTEMPTED','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','Occupancy','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','PEAK_DAY_PERCENTAGE','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
/*Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','VOICE_MAILS_CREATED','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD','VOICE_MAILS_HANDLED','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);*/ -- removed as per MAXDAT- 3466
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD,CHAT','WEB_CHATS_CREATED','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CC_A_LIST_LKUP (CC_CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (seq_cc_cell_id.Nextval,'AMPEXP_METRIC_SOURCE_LIST','ACD,CHAT','WEB_CHATS_HANDLED','ACD',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
