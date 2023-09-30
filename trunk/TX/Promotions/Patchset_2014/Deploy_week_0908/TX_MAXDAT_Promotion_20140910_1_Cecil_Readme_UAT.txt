***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 09/01/2014
----------------
Date       Developer           PHONE         Jira           Reason/Description
---------- ------------------- ------------  -----------    ---------------------------------------------
2014/09/10 Cecil Beeland        843-259-6092  TXEB - 3506    TXEB UAT v1.5.2 - Clean Up UAT data and resend AMP exports

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------

Disable cron - cron_tx_run_contcent.sh
Disable cron - manage_scheduled_contact_center_jobs.sh
Disable cron - run_exec_flatten_contact_center.sh
Disable cron - cron_tx_run_contcent_flatten.sh cron job 

-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

        
       *******************************************************************************************	
             Cecil (Contact Center)
       -------------------------------------------------------------------------------------------
       	** Unzip DB_UAT_CC_20140910_Cecil_1.zip
        ** Run in the order specified below.
       
		   200_CLEAN_UP_TX_UAT_DATA.sql
               
       -------------------------------------------------------------------------------------------
       *******************************************************************************************

 
-----------------------
2. KETTLE FILES SECTION
-----------------------


-----------------------
3. UNIX SCRIPT SECTION
-----------------------


       
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

       *******************************************************************************************	
              Cecil (Contact Center)
       -------------------------------------------------------------------------------------------
		- execute the following scripts sequentially after each completes
			- Note:  Each script may take multiple hours to complete
			
		UAT		nohup  /dtxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/manage_adhoc_contact_center_jobs.sh &
			
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

Enable cron - cron_tx_run_contcent.sh
Enable cron - manage_scheduled_contact_center_jobs.sh
Enable cron - run_exec_flatten_contact_center.sh
Enable cron - cron_tx_run_contcent_flatten.sh cron job 
