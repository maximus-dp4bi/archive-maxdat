***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB Kettle Scripts and DB Scripts
----------------
2013/09/06 Saraswathi Konidena    - Created

******************************************************************************************************


------------------------------
1. Kettle scripts SECTION
------------------------------

Replace if these already exist

Deploy all files from  AS_ProcessIncidents_20130906_SARA_1.zip 
OR 

Deploy the following from svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ProcessIncidents
TO \scripts\ProcessIncidents directory

Set_global_variables.ktr
Set_Status_Variables.ktr
ProcessInc_STG_Insert.ktr
ProcessInc_Set_LastIncID_CntrlVariable.ktr
ProcessInc_Set_Inc_look_back_days.ktr
ProcessInc_Get_LastIncID_CntrlVariable.ktr
Process_Incidents_Updates8_AND_9_From_OLTP_STG_to_WIP_STG.ktr
Process_Incidents_Updates5_AND_6_AND_7_From_OLTP_STG_to_WIP_STG.ktr
Process_Incidents_Updates3_AND_4_From_OLTP_STG_to_WIP_STG.ktr
Process_Incidents_Updates1_AND_2_From_OLTP_STG_to_WIP_STG.ktr
Process_Incidents_RUN_ALL.ktr
Process_Incidents_Job_Completed.ktr
Process_Incidents_Final_Updates_From_WIP_STG_to_BPM.ktr
Apply_UPD10_rules_and_load_to_PROCESS_INCIDENTS_WIP_BPM.ktr

Deploy the following from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/ProcessIncidents
TO \scripts\ProcessIncidents directory

Get_Updates_From_OLTP_TX.ktr
ProcessInc_CaptureNewInc_OLTP_TX.ktr

Remove (delete) the following files from 
\scripts\ProcessIncidents directory

Process_Incidents_Updates3_AND_4_From_OLTP_STG_to_WIP_STG_TX.ktr
Process_Incidents_Updates5_AND_6_AND_7_From_OLTP_STG_to_WIP_STG_TX.ktr


------------------------------
2. Database scripts SECTION
------------------------------

Deploy all files from  DB_ProcessIncidents_20130906_SARA_1.zip 

OR

Download the following file from svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ProcessIncidents/createdb
and see run instructions below

populate_CORP_ETL_CONTROL.sql


Download the following file from svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ProcessIncidents/createdb
and see run instructions below

populate_CORP_ETL_LIST_LKUP_TX.sql

Run the following in the promotional instance in the following order:

populate_CORP_ETL_CONTROL.sql
populate_CORP_ETL_LIST_LKUP_TX.sql
