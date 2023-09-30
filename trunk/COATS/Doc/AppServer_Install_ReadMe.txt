1. Instal Kettle Software, 


2. Create Directory for ETL work (Prod)

/u01/maximus/maxdat-prd/CO
/u01/maximus/maxdat-prd/CO/config/ 
/u01/maximus/maxdat-prd/CO/config/.kettle/ 

/u01/maximus/maxdat-prd/CO/ETL 
/u01/maximus/maxdat-prd/CO/ETL/scripts 
/u01/maximus/maxdat-prd/CO/ETL/logs 
/u01/maximus/maxdat-prd/CO/ETL/errors 
/u01/maximus/maxdat-prd/CO/ETL/Processing
/u01/maximus/maxdat-prd/CO/ETL/Processing/ProductionPlanning
/u01/maximus/maxdat-prd/CO/ETL/Processing/ProductionPlanning/Forecast
/u01/maximus/maxdat-prd/CO/ETL/Processing/ProductionPlanning/Forecast/completed
/u01/maximus/maxdat-prd/CO/ETL/Processing/ProductionPlanning/Forecast/processing
/u01/maximus/maxdat-prd/CO/ETL/scripts/ManageWork 
/u01/maximus/maxdat-prd/CO/ETL/scripts/ProductionPlanning
/u01/maximus/maxdat-prd/CO/ETL/scripts/ProductionPlanning/Actuals
/u01/maximus/maxdat-prd/CO/ETL/scripts/ProductionPlanning/Actuals_Import
/u01/maximus/maxdat-prd/CO/ETL/scripts/ProductionPlanning/Forecast
 

3. Create User roles that have Read access to all files created in "scripts", "logs" and "errors" directories and all respective sub directories.

4. Create User roles that have READ and WRITE access to all files created in "/u01/maximus/maxdat-prd/CO/ETL/Processing" and all respective sub directories.

5. Download shared.xml from svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/Config/shared.xml
   and deploy to /u01/maximus/maxdat-prd/CO/config/.kettle

6. Download svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/Config/PRD_kettle.properties to "/u01/maximus/maxdat-prd/CO/config/.kettle"

a. Update the PRD_kettle.properties file to include credentials to connect to OLTP Source and MAXDAT.
b. Rename PRD_kettle.properties  to kettle.properties

7. Download following to "/u01/maximus/maxdat-prd/CO/ETL/scripts"

svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/ETL/Scripts/bpm_Init_check.kjb
svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/ETL/Scripts/Load_OLTP_Lookups.kjb
svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/ETL/Scripts/Load_Step_Instance_Stg.kjb
svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/ETL/Scripts/run_conn_test.kjb
svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/ETL/Scripts/Run_Initialization.kjb

svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/ETL/Scripts/coats_run_bpm.sh
svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/ETL/Scripts/coats_run_planning.sh
svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/ETL/Scripts/coats_run_test_conn.sh
svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/ETL/Scripts/run_kjb.sh
svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/ETL/Scripts/run_ktr.sh

svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/ETL/Scripts/set_maxdat_env_variables_PRD.sh


svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Check_ChildJob_Stat.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Check_ParentJob_Stat.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Client_Supplementary_Info_Stg.kjb
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Load_Client_Supplementary_Info_Stg.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Load_Client_Supplementary_Info_Stg_Onetime.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Load_GRP_STEP_DEF.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Load_GRP_STEP_DEF_DEFAULT.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ManageWork_Capture_OLTP.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ManageWork_Get_Variables.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Process_StandardTaskTypes_Runall.kjb
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Process_STT_Check_ETL_Task_Groups.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Process_STT_Check_Ops_Task_Groups.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Process_STT_Check_SLA_Days.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Process_STT_Check_SLA_Days_Type.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Process_STT_Check_SLA_Jeopardy_Days.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Process_STT_Check_SLA_Target_Days.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Process_STT_Check_Step_Definition.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Process_STT_Set_Variables.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Process_STT_Validations.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Run_manual_Task_Types_Load.sh
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Setup_ChildJob_Log.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Setup_Job_Log.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Setup_ParentJob_Log.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/step_instance_stg_dbl_chk.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/StepInstanceStg_Correct_Chk_Run.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/StepInstanceStg_Correct_Set_Range.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/StepInstanceStg_Daily_Correction.kjb
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Upd_ClientSupplementaryInfo_Var.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/UPD_GROUPS_STG.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/UPD_HOLIDAYS_STG.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/UPD_STAFF_STG.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/UPD_STEPDEF_STG.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Update_ChildJob_Log_Error.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Update_Job_Log_Error.ktr
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/Update_ParentJob_Log_Error.ktr



8. Download all files from 
	
	svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ManageWork
	to directory /u01/maximus/maxdat-prd/CO/ETL/scripts/ManageWork
	
9. Download following from 	
   
   svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ProductionPlanning/PP_Actuals_Import_RUNALL.kjb
   svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ProductionPlanning/PP_Actuals_RUNALL.kjb
   svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ProductionPlanning/PP_Forecast_RUNALL.kjb
   
   to /u01/maximus/maxdat-prd/CO/ETL/scripts/ProductionPlanning
	
10. Download all files from 
 
 	svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ProductionPlanning/Actuals
 	to /u01/maximus/maxdat-prd/CO/ETL/scripts/ProductionPlanning/Actuals
 	
11. Download all files from 
 
 	svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ProductionPlanning/Actuals_Import
 	to /u01/maximus/maxdat-prd/CO/ETL/scripts/ProductionPlanning/Actuals_Import

12. Download all files from 
 
 	svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ProductionPlanning/Forecast
 	to /u01/maximus/maxdat-prd/CO/ETL/scripts/ProductionPlanning/Forecast
 	
 	
13  Rename "set_maxdat_env_variables_PRD.sh" to "set_maxdat_env_variables.sh" under directory "/u01/maximus/maxdat-prd/CO/ETL/scripts"

   This step is dependent on step 1, based on the location of Kettle installation.
   Please make sure correct Kettle installed directory and JAVA home refered in "set_maxdat_env_variables.sh"
  

14. chmod 755 *.sh 

15. execute coats_run_test_conn.sh in "/u01/maximus/maxdat-prd/CO/ETL/scripts" 

16. Download following to "/u01/maximus/maxdat-prd/CO/ETL/scripts" 

svn://rcmxapp1d.maximus.com/maxdat/trunk/COATS/ETL/Scripts/coats_run_Initialization.sh

chmod 755 *.sh 

17. PLEASE WAIT for confirmation, upon successful execution of step 16 

   execute coats_run_bpm.sh in "/u01/maximus/maxdat-prd/CO/ETL/scripts" 

18. PLEASE WAIT for confirmation, upon successful execution of step 17. 
	
	schedule cron job for coats_run_bpm.sh 
	and coats_run_planning.sh