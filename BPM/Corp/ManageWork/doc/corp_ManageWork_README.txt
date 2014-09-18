***** MODIFICATION HISTORY ****************************************************************************
2013/07/26 Devin  - Created
Manage Work ETL   should have all db objects that are specific to the Manage Work Workbook
These items should also be  Corporate meaning  the are the same across all EB and ATS products
2013/10/29 B. Thai - MAXDAT-850 Sweep of grants and synonyms. Step #13 no longer needed.
13. create_ETL_ManageWork_grants_public_syn.sql
----------------


******************************************************************************************************

Run order (svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageWork/createdb and (project) svn://rcmxapp1d.maximus.com/maxdat/BPM/{project}/ManageWork/createdb

 1.  create_ETL_ManageWork_tables.sql

 2.  create_ETL_ManageWork_sequences.sql

 3.  create_ETL_ManageWork_views.sql

 4.  SemanticModel_Manage_Work.sql
  
 5.  CORP_ETL_MANAGE_WORK_pkg.sql

 6.  MANAGE_WORK_pkg.sql

 7.  populate_CORP_ETL_CONTROL.sql

 8.  populate_lkup_tables.sql

 9. (project) populate_BPM_EVENT_MASTER.sql

10. create_ETL_ManageWork_triggers.sql

11. insert_MW_list_lkup_status_order.sql


