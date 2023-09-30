***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 06/30/2014
----------------
Date       Developer           PHONE         Jira       		Reason/Description
---------- ------------------- ------------- --------- 			---------------------------------------------
2014/06/30 Sumi      		916.425.6258  TXEB-2707 and TXEB-2363  	Jeopardy and timeliness driven by letter type
2014/06/30 Sara                 571.294.6487  TXEB-2781 MAXDAT CC - Agent by Date fact data not classified by Project or Program  

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh
Disable cron - cron_tx_run_emrs_medenrl.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	

       *******************************************************************************************	
        Sumi (Process Letters)
        ------------------------------------------------------------------------------------
	** Unzip DB_ProcessLetter_20140630_Sumi_1.zip
        ** Run in the order specified below.

        20140516_1100_TX_ProcessLetters.sql
        20140611_1100_TX_ProcessLetters_new_letter_types.sql
        PROCESS_LETTERS_pkg.sql
               
        ------------------------------------------------------------------------------------
       *******************************************************************************************	
       
execute MAXDAT_ADMIN.STARTUP_JOBS;

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

       *******************************************************************************************	
                 	           
       	  	Sara (Contact Center)
               ------------------------------------------------------------------------------------
               	** Unzip DB_ContactCenter_20140630_Sara_1.zip
                ** Run in the order specified below.
               
                     100_DELETE_DUPLICATES_IN_CC_C_LOOKUP_PRD.sql
         	    
               
               ------------------------------------------------------------------------------------
       *******************************************************************************************

        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        (Developer create this block for each AS zip)
	--------------------------------------------------------------------
	
	--------------------------------------------------------------------
       *******************************************************************************************	

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
 **********************************************************************************************
         Sara (Contact Center)
        --------------------------------------------------------------------
	  	Download AS_ContactCenter_20140630_Sara_1.zip            
	  	Deploy the follow files to the appropriate path            
	  	            
           UAT	    /dtxe4t/3rdparty/cron_files	            
	   PRD SUPP /ttxe4t/3rdparty/cron_files            
	   PRD      /ptxe4t/3rdparty/cron_files	      
	 	      
	 cron_tx_run_adhoc_contcent.sh	      
			      
		**Run dos2unix for the following List	      
		cron_tx_run_adhoc_contcent.sh	      
			      
		** chmod 755	      
	  chmod 755 cron_tx_run_adhoc_contcent.sh	      
       	--------------------------------------------------------------------
*********************************************************************************************		
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

UAT        nohup /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
PRD SUPP   nohup /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
PRD        nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &


----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.
     
1.  --- Schedule cron_tx_run_adhoc_contcent cron job
   Schedule    cron_tx_run_adhoc_contcent.sh to run every hour on the 45th minute       
   
UAT        45 * * * * /dtxe4t/3rdparty/cron_files/cron_tx_run_adhoc_contcent.sh > /dtxe4t/ETL_Logs/logs/ContactCenter/`uname -n`_contcent.log 2>&1
PRD SUPP   45 * * * * /ttxe4t/3rdparty/cron_files/cron_tx_run_adhoc_contcent.sh > /ttxe4t/ETL_Logs/logs/ContactCenter/`uname -n`_contcent.log 2>&1
PRD        45 * * * * /ptxe4t/3rdparty/cron_files/cron_tx_run_adhoc_contcent.sh > /ptxe4t/ETL_Logs/logs/ContactCenter/`uname -n`_contcent.log 2>&1     

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
