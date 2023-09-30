***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/10/02 A.Antonio - Creation.

******************************************************************************************************


-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/patch
	-- or DB_EMRS_20131004_ARLENE_13.zip

	20131004_1335_cleanup_dup_enrl_fact.sql
	20131004_1332_alter_EMRS_tables.sql
	

-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20131004_ARLENE_22.zip


DEPLOY to <MAXDAT_ETL_PATH> directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts

Check_ChildJob_Stat.ktr
Check_ParentJob_Stat.ktr
Setup_ChildJob_Log.ktr
Setup_ParentJob_Log.ktr
Update_ChildJob_Log_Error.ktr
Update_ParentJob_Log_Error.ktr


DEPLOY TO <MAXDAT_ETL_PATH> /EnrollmentDataEMRS directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS

FACT_Load_ENROLLMENTS.ktr
FACT_Compare_ENROLLMENTS.ktr
UPDATE_EMRS_JobStatus.ktr
ETL_Load_Selection_Transactions.kjb
ETL_Load_Address.kjb
ETL_Load_Enrollment_Notification.kjb
ETL_Load_Client_Enroll_Status.kjb
ETL_Load_Client_Eligibility.kjb
ETL_Load_Clients.kjb
ETL_Load_Cases.kjb
ETL_Load_PROVIDERS.kjb
ETL_Load_AA_Dimensions.kjb
UPDATE_EMRSChild_JobStatus.ktr

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS

ETL_Enrollment.kjb
ETL_Load_Dimension_Lookups.kjb
ETL_Load_Enrollment_Fact.kjb
STG_Load_S_ENROLLMENTS.ktr