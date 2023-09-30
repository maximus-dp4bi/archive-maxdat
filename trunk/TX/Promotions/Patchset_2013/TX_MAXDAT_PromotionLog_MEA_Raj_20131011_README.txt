--------------------------------------------------------------------	
CONTACT_NAME:	Raj A.
CONTACT_NUMBER:	(O)512-533-5143; (M)361-228-5588

If there are error in any one of the following scripts please stop and notify the contact name above, otherwise it creates more clean up for all of us.

1.Copy the below kettle script (*.kjb, *.ktr) from 
  svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/ManageEnrollmentActivity 
  OR 
  svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_MEA_KETTLE_CORP_20131011_RAJ_5
  to:/u25/ETL_Scripts/UAT/scripts/ManageEnrollmentActivity

1.1 ManageEnroll_Fetch_HPC_Letters.ktr
1.2 ManageEnroll_Fetch_EMI_Letters.ktr
1.3 ManageEnroll_set_MAX_Update_TS_HPC_EMI.ktr
1.4 ManageEnroll_WIP_to_BPM_StageTable.ktr
1.5 ManageEnroll_Apply_UPD_Rules_to_WIP.ktr
1.6 ProcessManageEnroll_RUNALL.kjb


2. Download the following files 
           from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DB_MEA_20131011_RAJ_3
	   or 
	   from svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageEnrollmentActivity/patch
	   
       and run them in Maxdat Database in the same order as below.

       If any script fails then stop and let the Developer, (Raj A.) know.  

	 1. populate_CORP_ETL_CONTROL_1011.sql
 	 2. populate_CORP_ETL_LIST_LKUP_1011.sql
             
3. kickoff MEA RUNALL i.e., ProcessManageEnroll_RUNALL_ONCE_A_DAY.kjb manually.
 	
--------------------------------------------------------------------