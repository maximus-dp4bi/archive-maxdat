***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 09/08/2014
----------------
Date       Developer           PHONE         Jira          Reason/Description
---------- ------------------- ------------- ---------     ---------------------------------------------
2014/09/15 Cecil Beeland       843-259-6092  MAXDAT-1706    MAXDAT - Master ticket - deploy DB connectivity updates to AMP export ETL
2014/09/15 Sara                571-294-6487                 Deploy modified cron files
                                             TXEB-3092      Scorecard - Add Time to Agent and Timeout Calls to MAXdat
2014/09/15 Brian Thai          210-722-3895  TXEB-2649      Client Outreach one-time event extract from OLTP
2014/09/15 Mayuresh B          201.328.5695  TXEB-2579      Commnuity Outreach-Add new attr to Comm Activity table


***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron_tx_run_adhoc_contcent.sh 
Disable cron_tx_run_contcent.sh 
Disable cron_tx_run_contcent_flatten.sh 
Disable cron_tx_run_contcent_forecast.sh 
Disable cron_tx_run_get_dates_and_flatten_cc.sh 
Disable cron_tx_run_load_timeout_calls.sh 
Disable cron - manage_scheduled_contact_center_jobs.sh
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_bpm_daily.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	



      ******************************************************************************************	
              ( Sara - Contact Center)
       -------------------------------------------------------------------------------------------
       	** Unzip DB_ContactCenter_20140911_Sara_1.zip
        ** Run in the order specified below.
       
 		 001_ALTER_CC_S_DETAIL.sql
               
       -------------------------------------------------------------------------------------------
       *******************************************************************************************


       *******************************************************************************************	
        B.Thai (Client Outreach one-time event extract)
        --------------------------------------------------------------------
	** Unzip DB_20140915_CO_Brian_1.zip
        ** Run in the order specified below.

        20140910_0753_CO_create_temp_tab.sql

	--------------------------------------------------------------------
       *******************************************************************************************	

	*******************************************************************************************	
        Mayuresh B.(Community Outreach)
        ------------------------------------------------------------------------------------
	** Unzip DB_CommunityOutreach_20140915_Mayuresh_1.zip
        ** Run in the order specified below.

        20140911_add_contact_f_lname_attr.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************

execute MAXDAT_ADMIN.STARTUP_JOBS;

        
-----------------------
2. KETTLE FILES SECTION
-----------------------

    *******************************************************************************************
              Cecil (Contact Center)
    -------------------------------------------------------------------------------------------
    	Download AS_CC_20140904_Austin_1.zip
		svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2014/Deploy_week_0915/AS_CC_20140904_Austin_1.zip

	Deploy the following files to the appropriate path
	  ProdSupp  DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/ 
	  PROD      DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/ 

		flatten_CC_F_AGENT_BY_DATE.ktr
	  
 	  ProdSupp  DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional/
	  PROD      DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional/

		flatten_MAXDAT_tables.kjb

    -------------------------------------------------------------------------------------------
    *******************************************************************************************
    
    *******************************************************************************************	
                  Sara(Contact Center)
         -------------------------------------------------------------------------------------------
    
         ****Download AS_ContactCenter_20140911_Sara_1.zip
           	Deploy the following files to the appropriate path****
           	
        ProdSupp  ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/
        PROD      ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/
		
		load_timeout_calls.ktr
		Load_Time_To_Agent.ktr
               	
           	
        -------------------------------------------------------------------------------------------
    *******************************************************************************************

       *******************************************************************************************	
        B.Thai (Client Outreach one-time event extract)
        --------------------------------------------------------------------
	Download AS_20140915_CO_Brian_1.zip
	Deploy the follow files to the appropriate path
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

        Onetime_ClientOutreach_CPW_Pop_Temp.ktr

	--------------------------------------------------------------------
       *******************************************************************************************

	*******************************************************************************************	
        Mayuresh B.(Community Outreach)
	--------------------------------------------------------------------
	Download AS_CommunityOutreach_20140915_Mayuresh_1.zip
	Deploy the follow files to the appropriate path
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/CommunityOutreach
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/CommunityOutreach 

	CommunityOutreach_Act_OltpDetails.ktr
	CommunityOutreach_Act_Update1.ktr
	CommunityOutreach_Activity_temp_to_BPMupdate.ktr
	CommunityOutreach_Actv_Chld_Copy_to_temp.ktr
	CommunityOutreach_CaptureCommunityActivitiesDetailsChild.ktr
	CommunityOutreach_CaptureCommunityActivity_INS3.ktr
	CommunityOutreach_CommActivity_RunAll.kjb
	--------------------------------------------------------------------
       *******************************************************************************************		
       
-----------------------
3. UNIX SCRIPT SECTION
-----------------------
			

***************************************************************************************************************
                   Sara (Contact Center)
---------------------------------------------------------------------------------------------------------------

        Download AS_ContactCenter_20140911_Sara_2.zip
       	Deploy the follow files to the appropriate path
       
       
       ProdSupp      DEPLOY TO PATH ttxe4t/3rdparty/cron_files
       PROD          DEPLOY TO PATH ptxe4t/3rdparty/cron_files
         
         cron_tx_run_adhoc_contcent.sh 
         cron_tx_run_contcent.sh 
         cron_tx_run_contcent_flatten.sh 
         cron_tx_run_contcent_forecast.sh 
         cron_tx_run_get_dates_and_flatten_cc.sh
         cron_tx_run_load_timeout_calls.sh  
         
          
	 **Run dos2unix for the following List	      
	 
         cron_tx_run_adhoc_contcent.sh 
         cron_tx_run_contcent.sh 
         cron_tx_run_contcent_flatten.sh 
         cron_tx_run_contcent_forecast.sh 
         cron_tx_run_get_dates_and_flatten_cc.sh
         cron_tx_run_load_timeout_calls.sh	
	  			      
	** chmod 755	      
	  chmod 755  cron_tx_run_adhoc_contcent.sh 
          chmod 755  cron_tx_run_contcent.sh 
          chmod 755  cron_tx_run_contcent_flatten.sh 
	  chmod 755  cron_tx_run_contcent_forecast.sh 
	  chmod 755  cron_tx_run_get_dates_and_flatten_cc.sh
	  chmod 755  cron_tx_run_load_timeout_calls.sh	

----------------------------------------------------------------------------------------------------------
*************************************************************************************************************			


       *******************************************************************************************	
        B.Thai (Client Outreach one-time event extract)
        --------------------------------------------------------------------
	Download AS_20140915_CO_Brian_1.zip
	Deploy the follow files to the appropriate path
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

        Onetime_ClientOutreach_CPW_Call_Update.sh
	
	**Run dos2unix for the following List
	dos2unix Onetime_ClientOutreach_CPW_Call_Update.sh

         chmod 755 Onetime_ClientOutreach_CPW_Call_Update.sh

	--------------------------------------------------------------------
       *******************************************************************************************	
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

       *******************************************************************************************	
              Cecil (Contact Center)
       -------------------------------------------------------------------------------------------
		- execute the following scripts sequentially after each completes
			- Note:  Each script may take up to 1h 30m each
		PROD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/run_flatten_contact_center.sh 2014/08/01 2014/08/09 &
		PROD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/run_flatten_contact_center.sh 2014/08/10 2014/08/16 &
		PROD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/run_flatten_contact_center.sh 2014/08/17 2014/08/23 &
		PROD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/run_flatten_contact_center.sh 2014/08/24 2014/08/31 &
       	
       -------------------------------------------------------------------------------------------
       *******************************************************************************************
       
       *******************************************************************************************	
                     Sara (Contact Center)
              -------------------------------------------------------------------------------------------
             
              	PROD          nohup ptxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/run_load_timeout_calls.sh &
              -------------------------------------------------------------------------------------------
       *******************************************************************************************

       *******************************************************************************************	
       B.Thai (Client Outreach one-time shell)
        --------------------------------------------------------------------------------------------
        --Execute Onetime_ClientOutreach_CPW_Call_Update.sh which updated CLient Outreach new attribute values
	ProdSupp         nohup /ttxe4t/ETL_Scripts/scripts/Onetime_ClientOutreach_CPW_Call_Update.sh &
	PROD             nohup /ptxe4t/ETL_Scripts/scripts/Onetime_ClientOutreach_CPW_Call_Update.sh &
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	


----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
1.Create the following folders:

 ProdSupp      

	ttxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin
	ttxe4t/ETL_Scripts/scripts/ContactCenter/main/archive

 PROD   
        ptxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin
	ptxe4t/ETL_Scripts/scripts/ContactCenter/main/archive

 
 
2.COPY ALL the files from   

   ProdSupp
    FROM   ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
    TO     ttxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin
   
   PROD   
    FROM    ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
    TO      ptxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin 

3.Move all the files

  ProdSupp
    FROM   ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
    TO     ttxe4t/ETL_Scripts/scripts/ContactCenter/main/archive
  
  PROD
    FROM   ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
    TO     ptxe4t/ETL_Scripts/scripts/ContactCenter/main/archive     

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron_tx_run_adhoc_contcent.sh 
Enable cron_tx_run_contcent.sh 
Enable cron_tx_run_contcent_flatten.sh 
Enable cron_tx_run_contcent_forecast.sh 
Enable cron_tx_run_get_dates_and_flatten_cc.sh 
Enable cron_tx_run_load_timeout_calls.sh c
Enable cron - manage_scheduled_contact_center_jobs.sh

NOTE :  The jobs below can be enabled even if the adhoc scripts are still running
	
	Enable cron - cron_tx_run_bpm.sh
	Enable cron - cron_tx_run_bpm_daily.sh