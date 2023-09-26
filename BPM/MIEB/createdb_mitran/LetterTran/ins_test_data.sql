insert into d_tran_header(project_code,program_code, tran_date) values ('MIEB','MEDICAID',to_date('8/3/2022','mm/dd/yyyy'));
insert into d_tran_header(project_code,program_code, tran_date) values ('MIEB','MEDICAID',to_date('8/10/2022','mm/dd/yyyy'));



insert into d_tran_events(event_date,event_name,tran_ref_table,tran_ref_pkid, filename, ltr_source_code) 
values(to_date('8/3/2020','mm/dd/yyyy'),'TRAN_INIT','D_TRAN_HEADER',2, 'aug0322.xls','MAXEB');
insert into d_tran_events(event_date,event_name,tran_ref_table,tran_ref_pkid, filename, ltr_source_code) 
values(to_date('8/3/2020','mm/dd/yyyy'),'TRAN_JOBID_ASSIGNED','D_TRAN_HEADER',2,'aug0322.xls','MAXEB');
insert into d_tran_events(event_date,event_name,tran_ref_table,tran_ref_pkid, filename, ltr_source_code) 
values(to_date('8/5/2020','mm/dd/yyyy'),'TRAN_CONFIRMATION_RCVD_FROM_EYR','D_TRAN_HEADER',2,'aug0322_ready.xls','MAXEB');
insert into d_tran_events(event_date,event_name,tran_ref_table,tran_ref_pkid, filename, ltr_source_code) 
values(to_date('8/8/2020','mm/dd/yyyy'),'TRAN_SENT_TO_EYR_QA','D_TRAN_HEADER',2,'Transmittal Approved_080322.xls','MAXEB');
insert into d_tran_events(event_date,event_name,tran_ref_table,tran_ref_pkid, filename, ltr_source_code) 
values(to_date('8/10/2020','mm/dd/yyyy'),'TRAN_MAILED_BY_EYR','D_TRAN_HEADER',2,'Transmittal Approved_080322_mailed.xls','MAXEB');

insert into d_tran_events(event_date,event_name,tran_ref_table,tran_ref_pkid, filename, ltr_source_code) 
values(to_date('8/10/2020','mm/dd/yyyy'),'TRAN_INIT','D_TRAN_HEADER',4, 'aug1022.xls','MAXEB');
insert into d_tran_events(event_date,event_name,tran_ref_table,tran_ref_pkid, filename, ltr_source_code) 
values(to_date('8/10/2020','mm/dd/yyyy'),'TRAN_JOBID_ASSIGNED','D_TRAN_HEADER',4,'aug1022.xls','MAXEB');
insert into d_tran_events(event_date,event_name,tran_ref_table,tran_ref_pkid, filename, ltr_source_code) 
values(to_date('8/12/2020','mm/dd/yyyy'),'TRAN_CONFIRMATION_RCVD_FROM_EYR','D_TRAN_HEADER',4,'aug1022_eyr_conf.xls','MAXEB');
insert into d_tran_events(event_date,event_name,tran_ref_table,tran_ref_pkid, filename, ltr_source_code) 
values(to_date('8/14/2020','mm/dd/yyyy'),'TRAN_SENT_TO_EYR_QA','D_TRAN_HEADER',4,'Transmittal Approved_081022.xls','MAXEB');



select * from d_tran_events;

delete d_tran_Events where tran_ref_table like '%HEADER%';


select * from d_tran_header;

delete d_tran_header;

select * from d_letter_definition;

select * from d_subprogram;
select letter_invoice_group_code, letter_invoice_group_name, description, report_label, effective_from_date, effective_thru_date from d_letter_invoice_group_sv;
select letter_invoice_group_code, letter_definition_id, program_con_xwalk_code, letter_type_name, description, report_label, effective_from_date, effective_thru_date from d_letter_type_sv;
insert into d_tran_detail
  (tran_header_id, subprogram_code, tran_job_id, lmdef_id, ltr_filename, requested_qty, resent, preqa_eyr_ltr_filename, preqa_eyr_ltr_qty, preqa_eyr_extra, qa_abort_userid, qa_split_qty, qa_rejected_qty, qa_comments, qa_signed, qa_date, qa_userid, eyr_mailed_date, eyr_mailed_qty, eyr_ps_checked, eyr_ps_comments, invoiced, invoiced_date, comments, form_created_by, form_updated_by)
values
  (v_tran_header_id, v_subprogram_code, v_tran_job_id, v_lmdef_id, v_ltr_filename, v_requested_qty, v_resent, v_preqa_eyr_ltr_filename, v_preqa_eyr_ltr_qty, v_preqa_eyr_extra, v_qa_abort_userid, v_qa_split_qty, v_qa_rejected_qty, v_qa_comments, v_qa_signed, v_qa_date, v_qa_userid, v_eyr_mailed_date, v_eyr_mailed_qty, v_eyr_ps_checked, v_eyr_ps_comments, v_invoiced, v_invoiced_date, v_comments, v_form_created_by, v_form_updated_by, v_create_ts, v_update_ts, v_created_by, v_updated_by);
  
  insert into d_tran_detail
  (tran_header_id, subprogram_code, tran_job_id, lmdef_id, ltr_filename, requested_qty)
values
  (v_tran_header_id, v_subprogram_code, v_tran_job_id, v_lmdef_id, v_ltr_filename, v_requested_qty);

insert into d_tran_detail
  (tran_header_id, subprogram_code, tran_job_id, lmdef_id, ltr_filename, requested_qty)
values
(
 2, (select subprogram_code from d_subprogram where upper(tran_name) = upper('MIEnrolls')),149600,  (select lmdef_id from d_letter_definition where upper(report_label) = upper('BCF')), 'LetterRequests20220803.091032000692', 27
);

drop table s_tran_xls_dtls;

select to_number('1003.0') from dual;


select * from s_tran_xls_dtls;
delete s_tran_xls_dtls;

delete d_Tran_detail;

insert into d_tran_detail
  (tran_header_id, subprogram_code, tran_job_id, lmdef_id, ltr_filename, requested_qty, resent, preqa_eyr_ltr_filename
  , preqa_eyr_ltr_qty, preqa_eyr_extra, qa_abort_userid, qa_split_qty, qa_rejected_qty, qa_comments, qa_signed, qa_date
  , qa_userid
  , eyr_mailed_date, eyr_mailed_qty, eyr_ps_checked, eyr_ps_comments)
  (
select 
2 as tran_header_id,
 (select subprogram_code from d_subprogram where upper(tran_name) = upper(col1)) subprogram_code
, trunc(to_number(col2,'9999999.9')) tran_job_id
,  (select lmdef_id from d_letter_definition where upper(report_label) = upper(col4)) lmdef_id
, col5 ltr_filename
, trunc(to_number(col6)) requested_qty
, col7 resent
, col8 preqa_filename
, col9 preqa_qty
, null
, col10 abort
, trunc(to_number(col11)) split_Qty
, trunc(to_number(col12)) reject_qty
, col13 qa_comments
, col14 qa_signed
, null qa_date
, null qa_userid
, to_date(substr(col15,1,10),'yyyy/mm/dd') eyr_date
, trunc(to_number(col16)) eyr_qty
, col17 eyr_ps
, col18 eyr_presort
--, filename
--, fullpath
from s_tran_xls_dtls where rownumber <> 1
and (
--filename like '%Transmittal Approved_081022_saved%'
--or 
filename like '%Transmittal Approved_080322_mailed_saved%'
)
--order by rownumber;
);





create table s_tran_xls_dtls(
xls_header_id number(32)
, fullpath varchar2(100)
, filename varchar2(100)
, rownumber number
, col1 varchar2(1000)
, col2 varchar2(1000)
, col3 varchar2(1000)
, col4 varchar2(1000)
, col5 varchar2(1000)
, col6 varchar2(1000)
, col7 varchar2(1000)
, col8 varchar2(1000)
, col9 varchar2(1000)
, col10 varchar2(1000)
, col11 varchar2(1000)
, col12 varchar2(1000)
, col13 varchar2(1000)
, col14 varchar2(1000)
, col15 varchar2(1000)
, col16 varchar2(1000)
, col17 varchar2(1000)
, col18 varchar2(1000)
, col19 varchar2(1000)
, col20 varchar2(1000)
, col21 varchar2(1000)
, col22 varchar2(1000)
, col23 varchar2(1000)
, col24 varchar2(1000)
, col25 varchar2(1000)
, col26 varchar2(1000)
, col27 varchar2(1000)
, col28 varchar2(1000)
, col29 varchar2(1000)
, col30 varchar2(1000)
)
;
