---NYHIX-37890

update Maxdat.corp_etl_control 
set value = 100018548 
WHERE NAME = 'MW_LAST_STEP_INST_HIST_ID';

commit;
