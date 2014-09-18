***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/11/14 Mayuresh Bhalekar - Added Job Statistics and fixed ORA-01722.

******************************************************************************************************

-----------------------
1. KETTLE FILES SECTION
-----------------------
Download AS_MEA_KETTLE_CORP_20131114_MAYURESH_7.zip
OR
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/ManageEnrollmentActivity
Files from

and Deploy the follow files to the appropriate path
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity  
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity  
PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity 



ManageEnroll_Cancel_Dt_NEW_ENRL_PKT.ktr
ManageEnroll_Cancel_Dt_NO_LONGER_ELIG.ktr
ManageEnroll_MainJob_completed.ktr
ProcessManageEnroll_RUNALL.kjb