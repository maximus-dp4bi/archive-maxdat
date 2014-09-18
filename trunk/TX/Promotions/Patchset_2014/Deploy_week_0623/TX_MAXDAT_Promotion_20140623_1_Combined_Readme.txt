***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 06/23/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/06/23 Sara                571.294.6487             AMP- Deploy get_dates_and_flatten_project_facts job, shell and cron(TESTED IN UAT)
2014/06/23 Raj A.              361-228-5588  
                                             
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh
Disable cron - cron_tx_run_emrs_medenrl.sh
Disable cron-  cron_tx_run_contcent_flatten.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

       *******************************************************************************************	
    
        ------------------------------------------------------------------------------------

  	    
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
		Sara (Contact Center)
        --------------------------------------------------------------------
	  	Download AS_ContactCenter_20140623_Sara_1.zip            
	  	Deploy the follow files to the appropriate path            
	  	            
	      UAT       /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional
	      PRODSUPP  /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional
	      PROD    /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional
	  		             
	  	get_dates_and_flatten_project_facts.kjb
         

	--------------------------------------------------------------------
       *******************************************************************************************
 
       *******************************************************************************************	
		Raj A. (Manage Enrollment Activity)
        --------------------------------------------------------------------
	  	Download AS_MEA_20140623_Raj_9            
	  	Deploy the follow files to the appropriate path            
	  	            
	      UAT       /dtxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
	      PRODSUPP  /ttxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
	      PROD      /ptxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
	  		             
	  	ManageEnroll_set_RUN_RUNALL_TODAY.ktr
         

	--------------------------------------------------------------------
       *******************************************************************************************	

-----------------------
3. UNIX SCRIPT SECTION
-----------------------

      **********************************************************************************************
         Sara (Contact Center)
        --------------------------------------------------------------------
	  	Download AS_ContactCenter_20140623_Sara_1.zip            
	  	Deploy the follow files to the appropriate path            
	  	            
	      UAT       /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin      
	      PRODSUPP  /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin            
	      PROD    /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin            
	  		             
	  	run_tx_get_dates_and_flatten_contact_center.sh            
	  	            
	    **Run dos2unix for the following List            
		run_tx_get_dates_and_flatten_contact_center.sh	      
			      
		** chmod 755	      
	  	chmod 755 run_tx_get_dates_and_flatten_contact_center.sh	
	  	 
           UAT	    /dtxe4t/3rdparty/cron_files	            
	   PRD SUPP /ttxe4t/3rdparty/cron_files            
	   PRD      /ptxe4t/3rdparty/cron_files	      
	 	      
	 cron_tx_run_get_dates_and_flatten_cc.sh	      
			      
		**Run dos2unix for the following List	      
		cron_tx_run_get_dates_and_flatten_cc.sh	      
			      
		** chmod 755	      
	  chmod 755 cron_tx_run_get_dates_and_flatten_cc.sh	      
       	--------------------------------------------------------------------
       	*********************************************************************************************
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
None

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.
     
     
   	
1.  --- Schedule get dates and flatten contact center cron job
   Schedule    cron_tx_run_get_dates_and_flatten_cc.sh to run every 15 minutes       
   
2.Deploy the following file to the appropriate path:

      UAT    dtxe4t/3rdparty/mots/files/Inbound
  PRD SUPP   ttxe4t/3rdparty/mots/files/Inbound
      PRD    ptxe4t/3rdparty/mots/files/Inbound
  
  
  mots_export_dates.csv
  
 3. Add the following variable to the .profile file
   UAT            
   MAXDAT_MOTS_FILES=/dtxe4t/3rdparty/mots/files
   export MAXDAT_MOTS_FILES
   
   PRD SUPP       
   MAXDAT_MOTS_FILES=/ttxe4t/3rdparty/mots/files
   export MAXDAT_MOTS_FILES
   
   PRD            
   MAXDAT_MOTS_FILES=/ptxe4t/3rdparty/mots/files 
   export MAXDAT_MOTS_FILES
   
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
Enable cron-  cron_tx_run_contcent_flatten.sh
