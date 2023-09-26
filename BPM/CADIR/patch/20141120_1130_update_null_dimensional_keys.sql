update s_crs_imr
set CLOSED_REASON_ID = 0
where CLOSED_REASON_ID is null ;

update s_crs_imr
set CLAIM_PRIORITY_ID = 0
where CLAIM_PRIORITY_ID is null ;

update s_crs_imr
set CLAIM_ADMIN_STATE_ID = 0
where CLAIM_ADMIN_STATE_ID is null ;

update s_crs_imr
set EDI_CONTRIBUTOR_ID = 0
where EDI_CONTRIBUTOR_ID is null ;

update s_crs_imr
set TERMINATION_REASON_ID = 0
where TERMINATION_REASON_ID is null ;

commit;