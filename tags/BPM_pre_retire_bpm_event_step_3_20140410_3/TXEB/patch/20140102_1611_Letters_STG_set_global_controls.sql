/*
Created on 31-Dec-2013 by Raj A.
Process: TXEB Run Initialization
Setting the Letters_Start_Date and Letters_Last_Update_Date to 12/31/2013 3PM, as the 4.8M letters data was loaded on at 3PM after a cleanup and reload. After this script,
the hourly cron job will pick up new letters and update to the letters.
*/
UPDATE corp_etl_control
   SET VALUE = to_date('2013/12/31 15:00:00','yyyy/mm/dd hh24:mi:ss')
 WHERE name = 'LETTERS_START_DATE';  
 
 UPDATE corp_etl_control
   SET VALUE = to_date('2013/12/31 15:00:00','yyyy/mm/dd hh24:mi:ss')
 WHERE name = 'LETTERS_LAST_UPDATE_DATE';
COMMIT;