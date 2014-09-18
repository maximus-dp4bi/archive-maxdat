***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB Kettle Scripts and DB Scripts
----------------
2013/09/08 Saraswathi Konidena    - Created

******************************************************************************************************


------------------------------
1. Kettle scripts SECTION
------------------------------

1.Stop the cron job

2. Replace if these already exist

Deploy all files from  AS_ProcessIncidents_20130906_SARA_4.zip 
OR 

Deploy the following from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/ProcessIncidents
TO \scripts\ProcessIncidents directory

Get_Updates_From_OLTP_TX.ktr
ProcessInc_CaptureNewInc_OLTP_TX.ktr


------------------------------
2. Database scripts SECTION
------------------------------

3. 1.Stop the jobs by executing

  execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;

4. Deploy all files from  DB_ProcessIncidents_20130906_SARA_4.zip 

OR

Download and run the following file from svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ProcessIncidents/patch
and see run instructions below

20130909_1511_fix_for_MAXDAT723.sql

 
5. Start the jobs by executing

   execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
   
6.Start the cron job     
   

   

