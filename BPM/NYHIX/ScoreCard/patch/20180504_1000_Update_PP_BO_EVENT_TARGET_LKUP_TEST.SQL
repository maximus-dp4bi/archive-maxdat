update MAXDAT.PP_BO_EVENT_TARGET_LKUP 
set scorecard_flag = 'Y'
where event_id = 1070
and end_date is null;

commit;

exec DP_SCORECARD.PP_WFM_BACK_OFFICE_LOAD_PKG.LOAD_SC_PROD_AND_SMRY();
