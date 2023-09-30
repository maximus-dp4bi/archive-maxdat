***** MODIFICATION HISTORY ****************************************************************************

----------------
2013/11/18 B.Thai- Creation for MAXDAT-907 SCI. Insert ETL lookups for Event's manual action categories.

******************************************************************************************************

-----------------------

1. KETTLE FILES SECTION

-----------------------

Download DB_SCI_20131118_BRIAN_8.zip


Files from svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/SupportClientInquiry/

populate_CORP_SCI_ETL_MACTIONS_LKUP.sql



-----------------------

2. KETTLE FILES SECTION

-----------------------

Download AS_SCI_20131118_BRIAN_8.zip


Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts


A. Deploy the follow files to the appropriate path

UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts

ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts

PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

Run_onetime_ClientInquiry_Manual_Events
Run_onetime_CLIENT_INQUIRY_20131118.sh


B. Format shell script for Unix
chmod 777 Run_onetime_CLIENT_INQUIRY_20131118.sh
dos2unix -k -o Run_onetime_CLIENT_INQUIRY_20131118.sh


C. Run the shell script
Run_onetime_CLIENT_INQUIRY_20131118.sh







