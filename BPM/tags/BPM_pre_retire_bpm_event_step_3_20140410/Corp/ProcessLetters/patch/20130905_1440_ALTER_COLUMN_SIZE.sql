ALTER TABLE letters_stg modify (letter_status varchar2(256));
ALTER TABLE letters_stg modify (program varchar2(256));
ALTER TABLE letters_stg modify (RETURN_REASON varchar2(256));
ALTER TABLE letters_stg modify (LETTER_REJECT_REASON varchar2(256));
ALTER TABLE letters_stg modify (LANGUAGE varchar2(256));

ALTER TABLE corp_etl_proc_letters modify (status varchar2(256));
ALTER TABLE corp_etl_proc_letters modify (program varchar2(256));
ALTER TABLE corp_etl_proc_letters modify (RETURN_REASON varchar2(256));
ALTER TABLE corp_etl_proc_letters modify (REJECT_REASON varchar2(256));
ALTER TABLE corp_etl_proc_letters modify (LANGUAGE varchar2(256));
ALTER TABLE corp_etl_proc_letters modify (ERROR_REASON varchar2(256));
ALTER TABLE corp_etl_proc_letters modify (TRANSMIT_FILE_NAME varchar2(1000));
ALTER TABLE corp_etl_proc_letters modify (LETTER_RESP_FILE_NAME varchar2(1000));

ALTER TABLE corp_etl_proc_letters_oltp modify (status varchar2(256));
ALTER TABLE corp_etl_proc_letters_oltp modify (program varchar2(256));
ALTER TABLE corp_etl_proc_letters_oltp modify (RETURN_REASON varchar2(256));
ALTER TABLE corp_etl_proc_letters_oltp modify (REJECT_REASON varchar2(256));
ALTER TABLE corp_etl_proc_letters_oltp modify (LANGUAGE varchar2(256));
ALTER TABLE corp_etl_proc_letters_oltp modify (ERROR_REASON varchar2(256));
ALTER TABLE corp_etl_proc_letters_oltp modify (TRANSMIT_FILE_NAME varchar2(1000));
ALTER TABLE corp_etl_proc_letters_oltp modify (LETTER_RESP_FILE_NAME varchar2(1000));

ALTER TABLE corp_etl_proc_letters_wip_bpm modify (status varchar2(256));
ALTER TABLE corp_etl_proc_letters_wip_bpm modify (program varchar2(256));
ALTER TABLE corp_etl_proc_letters_wip_bpm modify (RETURN_REASON varchar2(256));
ALTER TABLE corp_etl_proc_letters_wip_bpm modify (REJECT_REASON varchar2(256));
ALTER TABLE corp_etl_proc_letters_wip_bpm modify (LANGUAGE varchar2(256));
ALTER TABLE corp_etl_proc_letters_wip_bpm modify (ERROR_REASON varchar2(256));
ALTER TABLE corp_etl_proc_letters_wip_bpm modify (TRANSMIT_FILE_NAME varchar2(1000));
ALTER TABLE corp_etl_proc_letters_wip_bpm modify (LETTER_RESP_FILE_NAME varchar2(1000));

ALTER TABLE D_PL_CURRENT modify (letter_status varchar2(256));
ALTER TABLE D_PL_CURRENT modify (RETURN_REASON varchar2(256));
ALTER TABLE D_PL_CURRENT modify (REJECTION_REASON varchar2(256));
ALTER TABLE D_PL_CURRENT modify (REQUEST_ERROR_REASON varchar2(256));
ALTER TABLE D_PL_CURRENT modify (LANGUAGE varchar2(256));
ALTER TABLE D_PL_CURRENT modify (PROGRAM varchar2(256));
ALTER TABLE D_PL_CURRENT modify (TRANSMITTED_FILE_NAME varchar2(1000));
ALTER TABLE D_PL_CURRENT modify (LETTER_RESPONSE_FILE_NAME varchar2(1000));

create or replace view D_PL_CURRENT_SV as
select * from D_PL_CURRENT
with read only;

ALTER TABLE D_PL_LETTER_STATUS modify (letter_status varchar2(256));

create or replace view D_PL_LETTER_STATUS_SV as
select * from D_PL_LETTER_STATUS
with read only;