***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 08/18/2014
----------------
Date       Developer           PHONE         Jira           Reason/Description
---------- ------------------- ------------  -----------    ---------------------------------------------
2014/08/18 Austin Baker        843-259-1955  MAXDAT - 1612  MAXDAT - exporting data to AMP to correct unknown program/project records

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------



-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

 
-----------------------
2. KETTLE FILES SECTION
-----------------------

     *******************************************************************************************
              Austin (Contact Center)
     -------------------------------------------------------------------------------------------
    	Download AS_CC_20140818_Austin_1.zip
	Deploy the following files to the appropriate path
	  PRD      DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/ 
		flatten_CC_F_AGENT_BY_DATE.ktr
	  
	  PRD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/utility/
		get_missing_file_dates.ktr

    -------------------------------------------------------------------------------------------
    *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
       
       
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       
       *******************************************************************************************	
              Austin (Contact Center)
       -------------------------------------------------------------------------------------------
		- execute the following to run an instance of exporting data to AMP
		PRD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_flatten_contact_center.sh 2014/03/31 2014/04/04 &
		PRD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_flatten_contact_center.sh 2014/06/19 2014/06/20 &
		PRD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_flatten_contact_center.sh 2014/06/23 2014/06/27 &
		PRD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_flatten_contact_center.sh 2014/07/07 2014/07/11 &
		PRD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_flatten_contact_center.sh 2014/07/14 2014/07/16 &
       	
       -------------------------------------------------------------------------------------------
       *******************************************************************************************


----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.
     
	
----------------------------
6. Enable Cron Jobs 
----------------------------


