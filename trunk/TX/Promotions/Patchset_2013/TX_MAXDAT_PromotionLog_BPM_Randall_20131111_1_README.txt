***** MODIFICATION HISTORY ****************************************************************************
Instructions to install DB Scripts
----------------
2013/11/11 Randall Kolb    - Created

******************************************************************************************************



------------------------------
1. Database scripts SECTION
------------------------------

Run as Oracle user MAXDAT:

1. Stop the jobs by executing

  execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;

2. Deploy all files from DB_BPM_20131111_Randall_1.zip 


20131101_1451_MW_fact_view.sql
20131108_1104_MFDOC_fact_view.sql
20131108_1403_MJ_fact_view.sql
20131106_1507_SCI_fact_view.sql
20131111_1429_COR_fact_view.sql
20131111_1437_CMOR_fact_view.sql
20131111_1356_TXEB_PL_fact_view.sql
20131111_1408_TXEB_ME_fact_view.sql

3. Start the jobs by executing

  execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
