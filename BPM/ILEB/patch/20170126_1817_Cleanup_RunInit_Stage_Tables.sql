/*
Created on 01/26/2017.
Per ILEB-6353, cleaning up tables for a reload of data from 12/25/2016.
*/
TRUNCATE TABLE STEP_INSTANCE_STG;
TRUNCATE TABLE LETTERS_STG;
TRUNCATE TABLE CLIENT_ENROLL_STATUS_STG;
TRUNCATE TABLE SELECTION_TXN_STG;
TRUNCATE TABLE CLIENT_SUPPLEMENTARY_INFO_STG;

--Global variable setting to load step_instance_stg table.
UPDATE CORP_ETL_CONTROL
  SET value = '156974822'
WHERE NAME = 'MW_LAST_STEP_INST_HIST_ID'; 

--Global variable setting to load letters_stg table.
Update corp_etl_control
   set value = to_char(to_date('2016/12/25 00:00:00','yyyy/mm/dd hh24:mi:ss'),'yyyy/mm/dd hh24:mi:ss')
  where name = 'LETTERS_LAST_UPDATE_DATE';

--Global variable setting for Client_Enroll_Status_Stg table.
 UPDATE corp_etl_control
   SET VALUE = to_char(to_date('2016/12/25 00:00:00','yyyy/mm/dd hh24:mi:ss'),'yyyy/mm/dd hh24:mi:ss')
  WHERE NAME = 'MAX_UPDATE_TS_CLNT_ENRL_STAT';

--Global variable setting for Selection_txn_Stg table.
UPDATE corp_etl_control
   SET VALUE = to_char(to_date('2016/12/25 00:00:00','yyyy/mm/dd hh24:mi:ss'),'yyyy/mm/dd hh24:mi:ss')
 WHERE name = 'MAX_UPDATE_TS_SELECTION_TXN';
 
--Global variable setting for Client_Supplementary_Info_Stg table.
UPDATE corp_etl_control
  SET VALUE = to_char(to_date('2016/12/25 00:00:00','yyyy/mm/dd hh24:mi:ss'),'yyyy/mm/dd hh24:mi:ss')
where name = 'MAX_UPDATE_TS_CLNT_SUPPL_INFO';
commit;