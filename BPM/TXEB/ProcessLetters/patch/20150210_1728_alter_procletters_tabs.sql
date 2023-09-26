/*
Created on 04-Mar-2015 by Raj A.
Description: 
1. Per TXEB-4610, adding staff_id columns to the TXEB Process Letters stage tables, Semantic
2. Adding Staff_Key_LKUP table. Idea is to join the Created_By_ID (etc..) to the Staff_Key_Lkup in the Semantic view.
3. Adding Error_count, Last_errored_date and Reject_flag.
4. Adding corp_etl_list_lkup lookups.
*/
alter table corp_etl_proc_letters
add (new_letter_request_id NUMBER 
    ,assd_resolve_resp     DATE
    ,ased_resolve_resp     DATE
    ,asf_resolve_resp      VARCHAR2(1)	
	,error_count           NUMBER
    ,last_errored_date     DATE
	,last_error_fixed_by   VARCHAR2(80)
    ,reject_flag           VARCHAR2(1)
	,created_by_id         VARCHAR2(80)
    ,last_updated_by_id    VARCHAR2(80)
    ,cancel_by_id          VARCHAR2(80)
);
    
alter table CORP_ETL_PROC_LETTERS_OLTP 
add (new_letter_request_id NUMBER 
    ,assd_resolve_resp     DATE
    ,ased_resolve_resp     DATE
    ,asf_resolve_resp      VARCHAR2(1)	
	,error_count           NUMBER
    ,last_errored_date     DATE
    ,last_error_fixed_by   VARCHAR2(80)
	,reject_flag           VARCHAR2(1)
	,created_by_id         VARCHAR2(80)
    ,last_updated_by_id    VARCHAR2(80)
    ,cancel_by_id          VARCHAR2(80)
	,OBE_status_date       date
);
    
alter table CORP_ETL_PROC_LETTERS_OLTP_T 
add (new_letter_request_id NUMBER 
    ,assd_resolve_resp     DATE
    ,ased_resolve_resp     DATE
    ,asf_resolve_resp      VARCHAR2(1)	
	,error_count           NUMBER
    ,last_errored_date     DATE
    ,last_error_fixed_by   VARCHAR2(80)
	,reject_flag           VARCHAR2(1)
	,created_by_id         VARCHAR2(80)
    ,last_updated_by_id    VARCHAR2(80)
    ,cancel_by_id          VARCHAR2(80)
);      
    
alter table CORP_ETL_PROC_LETTERS_WIP_BPM  
add (new_letter_request_id NUMBER 
    ,assd_resolve_resp     DATE
    ,ased_resolve_resp     DATE
    ,asf_resolve_resp      VARCHAR2(1)	
	,error_count           NUMBER
    ,last_errored_date     DATE
	,last_error_fixed_by   VARCHAR2(80)
    ,reject_flag           VARCHAR2(1)
	,created_by_id         VARCHAR2(80)
    ,last_updated_by_id    VARCHAR2(80)
    ,cancel_by_id          VARCHAR2(80)
);        


alter table CORP_ETL_PROC_LETTERS_WIP_T  
add (new_letter_request_id NUMBER 
    ,assd_resolve_resp     DATE
    ,ased_resolve_resp     DATE
    ,asf_resolve_resp      VARCHAR2(1)	
	,error_count           NUMBER
    ,last_errored_date     DATE
	,last_error_fixed_by   VARCHAR2(80)
    ,reject_flag           VARCHAR2(1)
	,created_by_id         VARCHAR2(80)
    ,last_updated_by_id    VARCHAR2(80)
    ,cancel_by_id          VARCHAR2(80)
);

alter table d_pl_current
add (new_letter_request_id   NUMBER 
    ,resolve_resp_start_date DATE
    ,resolve_resp_end_date   DATE
    ,resolve_resp_flag       VARCHAR2(1)	
	,error_count             NUMBER
    ,last_errored_date       DATE
	,last_error_fixed_by     VARCHAR2(80)
    ,letter_rejected_flag    VARCHAR2(1)
	,created_by_id           VARCHAR2(80)
    ,last_updated_by_id      VARCHAR2(80)
    ,cancel_by_id            VARCHAR2(80)
);

alter table corp_etl_proc_letters
drop (assd_create_route_work,
      ased_create_route_work,
      asf_create_route_work);

alter table CORP_ETL_PROC_LETTERS_OLTP 
drop (assd_create_route_work,
      ased_create_route_work,
      asf_create_route_work);

alter table CORP_ETL_PROC_LETTERS_OLTP_T 
drop (assd_create_route_work,
      ased_create_route_work,
      asf_create_route_work);

alter table CORP_ETL_PROC_LETTERS_WIP_BPM  
drop (assd_create_route_work,
      ased_create_route_work,
      asf_create_route_work);

alter table CORP_ETL_PROC_LETTERS_WIP_T  
drop (assd_create_route_work,
      ased_create_route_work,
      asf_create_route_work);

alter table d_pl_current
drop (create_route_work_start_date,
      create_route_work_end_date,
      create_route_work_flag);
      
create or replace view D_PL_CURRENT_SV as
select * 
from D_PL_CURRENT
with read only;

create or replace public synonym D_PL_CURRENT_SV for D_PL_CURRENT_SV;
grant select on D_PL_CURRENT_SV to MAXDAT_READ_ONLY;

create table STAFF_KEY_LKUP
(
staff_id  number,
staff_key varchar2(80)
);

Grant select on STAFF_KEY_LKUP to MAXDAT_READ_ONLY;
create or replace public synonym STAFF_KEY_LKUP for STAFF_KEY_LKUP;

--Letter Statuses
 Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_STATUS_REQ','LETTER_STATUS','''Requested''',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Requested Letter status - used in update rules',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_STATUS_ERR','LETTER_STATUS','''Errored''',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Error Letter status - used in update rules',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_STATUS_SENT','LETTER_STATUS','''Sent''',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Sent Letter status - used in update rules',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_STATUS_REJ','LETTER_STATUS','''Rejected by Mailhouse''',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Rejected Letter status - used in update rules',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_STATUS_CANC','LETTER_STATUS','''Canceled''',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Canceled Letter status - used in update rules',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_STATUS_OTHR','LETTER_STATUS','''Voided'',''Combined Similar Requests''',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Other Letter statuses for canceling letter requests - used in update rules',SYSDATE,SYSDATE);

commit;