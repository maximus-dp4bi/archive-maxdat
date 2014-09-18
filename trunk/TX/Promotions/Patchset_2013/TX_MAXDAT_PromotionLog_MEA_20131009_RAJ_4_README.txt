--------------------------------------------------------------------	
CONTACT_NAME:	Raj A.
CONTACT_NUMBER:	(O)512-533-5143; (M)361-228-5588

If there are error in any one of the following scripts please stop and notify the contact name above, otherwise it creates more clean up for all of us.

1.Copy the below kettle script (*.kjb, *.ktr) from 
  svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/ManageEnrollmentActivity 
  OR 
  svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_MEA_KETTLE_CORP_20131009_RAJ_4
  to:/u25/ETL_Scripts/UAT/scripts/ManageEnrollmentActivity

1.1 ManageEnroll_Fetch_Fee_AA_due_date.ktr


2.Run the below in Maxdat Database (TXEBMXDU/TXEBMXDP). 

   Download the following files 
       from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DB_MEA_20131009_RAJ_2
	   or 
       from svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ManageEnrollmentActivity/patch/create_ETL_ManageEnroll_indexes_10092013.sql 


3. Run the below KTR manually to gather statistics of all ETL and stage tables.
   /u25/ETL_Scripts/UAT/scripts/ManageEnrollmentActivity/ManageEnroll_STATS_All_STG_tables.ktr

4. Kickoff the ProcessManageEnroll_RUNALL_ONCE_A_DAY.kjb manually.    	
--------------------------------------------------------------------