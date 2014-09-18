***** MODIFICATION HISTORY ****************************************************************************
Instructions for Client Outreach initial deployment and adhoc run
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/01/31 A. Antonio   916-832-8644   	     Load another set of data for Client Outreach


***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh

-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

       *******************************************************************************************	
        Arlene Antonio (Client Outreach)
        ------------------------------------------------------------------------------------
	** Unzip DB_ClientOutreach_20140131_Arlene_3.zip
        ** Run in the order specified below.

        1.20140131_1154_ins_corp_etl_control_min_max_coid.sql
	        
        ------------------------------------------------------------------------------------
       *******************************************************************************************

        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
         Arlene Antonio (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20140131_Arlene_4.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

	Client_Outreach_INS1.ktr
	Client_Outreach_INS2.ktr
	Client_Outreach_copy_TEMP.ktr
	Client_Outreach_Get_CntrlVariable.ktr
	ClientOUtreach_JobRun_var.ktr
	ClientOutreach_runall.kjb
	Client_Outreach_UPD24.ktr
	Client_Outreach_get_OLTP_Human_Task.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------

	*******************************************************************************************	
	--------------------------------------------------------------------
       DOwnload AS_ClientOutreach_20140131_Arlene_5.zip 

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

		tx_run_bpm.sh
		
	Run dos2unix for the following List 
		tx_run_bpm.sh
		
	chmod 755 tx_run_bpm.sh
	--------------------------------------------------------------------
	*******************************************************************************************	


----------------------------
4. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh