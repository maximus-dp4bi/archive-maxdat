/*
Created on 16-Dec-2013 by Raj A.
Project: TXEB
Process: Process Letters.
Related script: 20131216_1833_Clean_Impacted_Instances.sql

Description:
This script should be run after the script, 20131216_1833_Clean_Impacted_Instances.sql is run.
*/
insert into corp_etl_proc_letters
select * from corp_etl_proc_letters_BKP_UPD;
commit;