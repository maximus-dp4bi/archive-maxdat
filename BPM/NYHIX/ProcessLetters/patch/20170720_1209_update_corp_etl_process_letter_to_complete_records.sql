--These updates will affect 77581 records in PRD and 38 in UAT that have missing data from the MAXe system

update MAXDAT.CORP_ETL_PROC_LETTERS
set gwf_outcome = 'M'
,   instance_status = 'Complete'
,   complete_dt = mailed_dt
WHERE INSTANCE_STATUS = 'Active'
AND STATUS = 'Mailed';

commit;

update MAXDAT.CORP_ETL_PROC_LETTERS
set gwf_outcome = 'R'
,   gwf_work_required = 'N'
,   instance_status = 'Complete'
,   reject_reason = 'NYHIX-32927'
,   complete_dt = letter_resp_file_dt
WHERE INSTANCE_STATUS = 'Active'
AND STATUS = 'Rejected'
;

commit;

-- This update will affect 179 PRD and 286 UAT records that have been manually completed but, the stage_done_date was not set

Update MAXDAT.CORP_ETL_PROC_LETTERS
set STAGE_DONE_DATE = COMPLETE_DT
WHERE INSTANCE_STATUS = 'Complete'
AND STAGE_DONE_DATE IS NULL; 

commit;