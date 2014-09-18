***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 04/22/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/04/22 Sara                571-294-6487  TXEB-2420 Fix AnswerWaitTime column mapping in cc_f_actuals_queue_interval
           C.Rowland           843.408.1358

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - manage_scheduled_contact_center_jobs.sh



-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT



     *******************************************************************************************	
       ( Sara - Contact Center)
        ------------------------------------------------------------------------------------
	** Unzip DB_ContactCenter_20140422_Sara_1_UAT.zip
        ** Run in the order specified below.

        100_INSERT_INTO_CC_A_ADHOC_JOB.sql
        
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************
 
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

Please add the following with passwords (Passwords should be the same as in PRD jdbc.properties file)to jdbc.properties file

#CONTACT CENTER DATA SOURCES

#BLUE PUMPKIN WFM SCHEMA
BluePumpkin/type=javax.sql.DataSource
BluePumpkin/driver=net.sourceforce.jtds.jdbc.Driver
BluePumpkin/url=jdbc:jtds:sqlserver://165.184.99.9/BPMAINDB
BluePumpkin/user=reports1
BluePumpkin/password=[INSERT PASSWORD]

#EB HDS ACD SCHEMA
EBHDS/type=javax.sql.DataSource
EBHDS/driver=net.sourceforge.jtds.jdbc.Driver
EBHDS/url=jdbc:jtds:sqlserver://165.184.99.11/acn_awdb
EBHDS/user=WFM
EBHDS/password=[INSERT PASSWORD]
 
        ****Download AS_ContactCenter_20140421_Sara_1_UAT.zip
       	Deploy the following files to the appropriate path****
       	
    UAT dtxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/jobs/staging/load_production_planning_staging_tables.kjb
    UAT dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/staging/Cisco/load_production_planning_cisco_staging.kjb
        
        

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
 No  changes	
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

       *******************************************************************************************	
       Sara (Contact Center)
        --------------------------------------------------------------------------------------------
	--Execute manage_adhoc_contact_center_jobs.sh
	UAT             nohup dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
	
	--------------------------------------------------------------------------------------------
       *******************************************************************************************

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
  
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - manage_scheduled_contact_center_jobs.sh

