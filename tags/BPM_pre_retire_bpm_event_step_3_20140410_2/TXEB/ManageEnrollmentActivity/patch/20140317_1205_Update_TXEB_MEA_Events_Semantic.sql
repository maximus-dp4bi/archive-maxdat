/*
Created on 17-Mar-20134by Raj A.

Description:
BPM events are retired. So, only BPM ETL stage & Semantic dimension and facts  will be truncated now.
*/

truncate table corp_etl_Manage_enroll;
truncate table corp_etl_Manage_enroll_oltp;
truncate table corp_etl_Manage_enroll_wip;

--------------------------------------------------------------------------------------
-- Remove from BPM Semantic.
truncate table F_ME_BY_DATE;
alter table F_ME_BY_DATE drop constraint FMEBD_DMECUR_FK;

truncate table D_ME_CURRENT;
alter table F_ME_BY_DATE add constraint FMEBD_DMECUR_FK foreign key (ME_BI_ID) references D_ME_CURRENT (ME_BI_ID);
--------------------------------------------------------------------------------------