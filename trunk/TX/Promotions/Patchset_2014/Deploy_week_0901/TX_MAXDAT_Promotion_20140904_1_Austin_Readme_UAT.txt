***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 09/01/2014
----------------
Date       Developer           PHONE         Jira           Reason/Description
---------- ------------------- ------------  -----------    ---------------------------------------------
2014/09/04 Austin Baker        843-259-1955  TXEB - 3414    MAXDAT - deploy DB connectivity updates to AMP export ETL

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------

Disable cron_tx_run_contcent_flatten.sh cron job 

-----------------------
1. DB SCRIPTS SECTION
-----------------------


 
-----------------------
2. KETTLE FILES SECTION
-----------------------

     *******************************************************************************************
              Austin (Contact Center)
     -------------------------------------------------------------------------------------------
    	Download AS_CC_20140904_Austin_1.zip
			svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2014/Deploy_week_0901/AS_CC_20140904_Austin_1.zip
	Deploy the following files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/ 
		flatten_CC_F_AGENT_BY_DATE.ktr
	  
	  UAT     DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional/
		flatten_MAXDAT_tables.kjb

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
		- execute the following scripts sequentially after each completes
			- Note:  Each script may take up to 1h 30m each
		UAT		nohup /dtxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/run_flatten_contact_center.sh 2014/08/01 2014/08/09 &
		UAT		nohup /dtxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/run_flatten_contact_center.sh 2014/08/10 2014/08/16 &
		UAT		nohup /dtxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/run_flatten_contact_center.sh 2014/08/17 2014/08/23 &
		UAT		nohup /dtxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/run_flatten_contact_center.sh 2014/08/24 2014/08/31 &
       	
       -------------------------------------------------------------------------------------------
       *******************************************************************************************

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     
	 
     
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron_tx_run_contcent_flatten.sh cron job 
