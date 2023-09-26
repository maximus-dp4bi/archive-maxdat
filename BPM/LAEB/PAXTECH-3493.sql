PAXTECH-3493.sql 

update CORP_ETL_CONTROL 
SET VALUE =(SELECT TO_CHAR(MAX(create_ts),'yyyy/mm/dd HH24:mi:ss') from d_letter_request_link)
where name = 'MAX_LETTER_LINK_CREATE_DATE';

update CORP_ETL_CONTROL 
set VALUE =(SELECT TO_CHAR(MAX(update_ts),'yyyy/mm/dd HH24:mi:ss') from d_letter_request_link)
where name = 'MAX_LETTER_LINK_UPDATE_DATE';
Commit;