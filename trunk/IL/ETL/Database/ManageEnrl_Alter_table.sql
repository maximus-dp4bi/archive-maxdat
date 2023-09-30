/*
Created on 31-Jul-2013 by Raj A.
Business Process: Manage Enrollment Activity.
*/
alter table corp_etl_manage_enroll
modify (
first_followup_id varchar2(37),
second_followup_id varchar2(37),
third_followup_id varchar2(37),
fourth_followup_id varchar2(37)
);

alter table corp_etl_manage_enroll_oltp
modify (
first_followup_id varchar2(37),
second_followup_id varchar2(37),
third_followup_id varchar2(37),
fourth_followup_id varchar2(37)
);

alter table corp_etl_manage_enroll_wip
modify (
first_followup_id varchar2(37),
second_followup_id varchar2(37),
third_followup_id varchar2(37),
fourth_followup_id varchar2(37)
);