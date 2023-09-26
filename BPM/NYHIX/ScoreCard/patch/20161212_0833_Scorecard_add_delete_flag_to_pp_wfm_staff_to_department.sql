alter table dp_scorecard.pp_wfm_staff_to_department add (delete_flag varchar2(1) default 'N');
drop trigger "DP_SCORECARD"."BIU_PP_WFM_JOB_CLASS";
drop trigger "DP_SCORECARD"."BIU_PP_WFM_STAFF_TO_OFFICE";

commit;
