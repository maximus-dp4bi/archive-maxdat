***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 08/25/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/08/25 Austin Baker        843.259.1955  TXEB-3200 MAXDAT - export MAXDAT call center 07/16 data

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
			UAT		nohup /dtxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/run_flatten_contact_center.sh 2014/07/16 2014/07/16 &
			
		-------------------------------------------------------------------------------------------
		*******************************************************************************************
		
----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     
	 Please attach the resulting .zip file located in '/dtxe4t/3rdparty/mots/files/' to the JIRA ticket (TXEB - 3318)
	 - it should resemble something similar to 'Enrollment_Broker_[currentDate]_[currentTime].zip'
     
   
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron_tx_run_contcent_flatten.sh cron job 
