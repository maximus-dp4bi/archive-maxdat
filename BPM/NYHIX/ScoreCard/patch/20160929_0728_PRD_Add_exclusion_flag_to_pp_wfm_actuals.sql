alter table pp_wfm_actuals modify (Exclusion_Flag varchar2(1) default 'N');

Update pp_wfm_actuals
set exclusion_flag = 'N'
where exclusion_flag is null;

commit;


