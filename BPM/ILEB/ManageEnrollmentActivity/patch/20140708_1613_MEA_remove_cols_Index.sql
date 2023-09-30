/*
Created on 08-Jul-2014 by Raj A.
Description:
This script was created in an effort to reduce the number of updates to the Stage table. As of now, because of the age_in_calendar_days and 
UPD1_230, 240 250 and 260 there are some unnecessary updates. Removed them from the ManageEnroll_Apply_UPD_Rules_to_WIP.ktr
*/
alter table corp_etl_manage_enroll_wip drop column age_in_business_days;
alter table corp_etl_manage_enroll_wip drop column age_in_calendar_days;

create index IDX_MEA_BPM_Inst_Stat    on CORP_ETL_MANAGE_ENROLL (instance_status);