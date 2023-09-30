/*
v1 Raj A.  10/14/2015   This file was created to provide initial deploy instructions for MW V2. 

*/
1. NYHIX MW V2 was deployed by NYHIX-11578. Please refer the ticket for guidance. Also refer BPM Developer's guide.

2. TNRD MW V2 was deployed by MAXDAT-2723 (db scripts) MAXDAT-2724 (Kettle scripts).  Please refer the ticket for guidance.

3. Below are the database scripts that have to be deployed.

----Below five scripts are needed for initial deploy of a new project. 
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb/create_ETL_initialize_tables.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb/create_ETL_initialize_triggers.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb/create_ETL_initialize_views.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb/BPM_LAST_ETL_RUN_SV.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/createdb/populate_BPM_PROJECT_LKUP.sql

----MW_V2
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MW_V2/createdb/create_ETL_MW_V2_tables.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MW_V2/createdb/SemanticModel_MW_V2.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MW_V2/createdb/create_ETL_MW_V2_sequences.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MW_V2/createdb/create_ETL_MW_V2_triggers.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MW_V2/createdb/create_ETL_MW_V2_views.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/MW_V2/createdb/create_ETL_MW_V2_views.sql  --> Project-specific
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MW_V2/createdb/populate_CORP_ETL_CONTROL.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MW_V2/createdb/populate_D_MW_V2_TASK_TYPE.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MW_V2/createdb/populate_lkup_tables.sql 
svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/MW_V2/createdb/populate_lkup_tables.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MW_V2/createdb/populate_Dimensions.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MW_V2/createdb/CORP_ETL_MW_V2_pkg.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MW_V2/createdb/MW_V2_pkg.sql