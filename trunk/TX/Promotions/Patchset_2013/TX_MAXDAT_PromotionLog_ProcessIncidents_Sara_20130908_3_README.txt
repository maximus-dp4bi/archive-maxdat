***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB Kettle Scripts and DB Scripts
----------------
2013/09/06 Saraswathi Konidena    - Created

******************************************************************************************************

------------------------------
1. Database scripts SECTION
------------------------------

1.Stop the jobs by executing

  execute process_bpm_queue_job_control.shutdown_jobs;

2. Deploy all files from  DB_ProcessIncidents_20130906_SARA_3.zip 

OR


Download and run the following file from svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ProcessIncidents/createdb
and see run instructions below

DPY_PROCESS_INCIDENTS_pkg.sql

Download and run the following file from svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ProcessIncidents/patch
and see run instructions below

20130908_1640_make_process_bueq_id_null.sql

Run the following in the promotional instance in the following order:

20130908_1640_make_process_bueq_id_null.sql
DPY_PROCESS_INCIDENTS_pkg.sql


3. Start the jobs by executing

   execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

   

