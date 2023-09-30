# Format:
# minutes_of_hour hours_of_day days_of_month months_of_year days_of_the_week command_to_execute
#NYHIX-14317
0 2-22 * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/nyhix_run_bpm.sh  | sed "s/^/$(date)/ " > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/nyhix_run_bpm_`date '+\%Y\%m\%d_\%H\%M\%S'`.log
# NYHIX-1938
10,25,40,55 * * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/nyhix_run_planning.sh | sed "s/^/$(date)/ " > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/nyhix_run_planning_`date '+\%Y\%m\%d_\%H\%M\%S'`.log
#NYHIX-4353
0 2-22 * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/nyhix_run_mfd.sh  | sed "s/^/$(date)/ " > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/nyhix_run_mfd_`date '+\%Y\%m\%d_\%H\%M\%S'`.log
#NYHIX-10633
#0 2-22 * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/nyhix_run_mfd_v2.sh | sed "s/^/$(date)/ " >> /u01/maximus/maxdat-prd/NYHIX/ETL/logs/nyhix_run_mfd_v2.sh.log
#NYHIX-9556
#15 * * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/ContactCenter/main/bin/manage_scheduled_contact_center_jobs.sh > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/ContactCenter/`uname -n`_contcent.log 2>&1
#20 * * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/ContactCenter/`uname -n`_contcent.log 2>&1
#NYHIX-10094
# NYHIX-10931 - Disabled temp.
#0 03 * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/ContactCenter/main/bin/run_exec_load_ivr_data.sh > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/ContactCenter/`uname -n`_contcent.log 2>&1
#MAXDAT-1721
15 0,6-23 * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/Run_PP_BO_RUNALL.sh > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/Run_PP_BO_RUNALL.log 2>&1
00 19 * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/Run_PP_Actuals_AHT_RUNALL.sh > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/Run_PP_Actuals_AHT_RUNALL.log 2>&1
#NYHIX-10860
00 01 * * 1 /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/nyhix_run_load_process_metrics.sh > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/nyhix_run_load_process_metrics.log 2>&1
#NYHIX-14508
#00 06 * * *  /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/ContactCenter/main/bin/load_New_Queue_Flag_for_Alert.sh > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/ContactCenter/load_New_Queue_Flag_for_Alert.out 2>&1
#NYHIX-22914 for every hour
0 23 * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/Run_PP_WFM_RUNALL.sh | sed "s/^/$(date)/ " > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/Run_PP_WFM_RUNALL_`date '+\%Y\%m\%d_\%H\%M\%S'`.log
#NYHIX-15292 files older than 30 days removed
00 02 * * * find /u01/maximus/maxdat-prd/NYHIX/ETL/logs -mtime +30 -exec rm {} \; > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/removed.log 2>&1
#NYHIX-32899
0 5,7,9,11,13,15,17,19,21 * * 1-6 /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/nyhix_run_mailfaxbatch.sh | sed "s/^/$(date)/ " > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/nyhix_run_mailfaxbatch_`date '+\%Y\%m\%d_\%H\%M\%S'`.log
0 9,11,13,15,17,19,21 * * 0 /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/nyhix_run_mailfaxbatch.sh | sed "s/^/$(date)/ " > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/nyhix_run_mailfaxbatch_`date '+\%Y\%m\%d_\%H\%M\%S'`.log
#NYHIX-17536
0 22 * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/MFD_Run_Init_DAILY/DLY_NYHIX_Run_Init_MFD.sh >> /u01/maximus/maxdat-prd/NYHIX/ETL/logs/DLY_NYHIX_Run_Init_MFD.sh.log
#NYHIX-26978
00 06 * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/nyhix_run_engage_load.sh | sed "s/^/$(date)/ " > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/nyhix_run_engage_load_`date '+\%Y\%m\%d_\%H\%M\%S'`.log
#NYHIX-22985
45 07 * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/nyhix_run_dp_scorecard_load.sh | sed "s/^/$(date)/ " > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/nyhix_run_dp_scorecard_load_`date '+\%Y\%m\%d_\%H\%M\%S'`.log
#NYHIX-30944
00 06 * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/nyhix_run_sc_pp_wfm_tables_load.sh | sed "s/^/$(date)/ " > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/nyhix_run_sc_pp_wfm_tables_load_`date '+\%Y\%m\%d_\%H\%M\%S'`.log
00 * * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/nyhix_run_egain_load.sh | sed "s/^/$(date)/ " > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/nyhix_run_egain_load_`date '+\%Y\%m\%d_\%H\%M\%S'`.log 2>&1
#NYHIX-38103
00 01 * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/pp_wfm_task_bo_30D_SYNC.sh | sed "s/^/$(date)/ " > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/pp_wfm_task_bo_30D_SYNC.sh_`date '+\%Y\%m\%d_\%H\%M\%S'`.log
45 01 * * * /u01/maximus/maxdat-prd/NYHIX/ETL/scripts/nyhix_run_pp_wfm_task_audit.sh | sed "s/^/$(date)/ " > /u01/maximus/maxdat-prd/NYHIX/ETL/logs/nyhix_run_pp_wfm_task_audit_`date '+\%Y\%m\%d_\%H\%M\%S'`.log
#Ansible: log_purge
#0 3 * * * /u01/app/appadmin/scripts/log_purge.sh
