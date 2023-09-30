/*
Created by Raj A. 11/03/2015
Description:
While working on initial deployment for TNRD Process Letters, made columns changes to the below tables. As these tables are corp propagating to NYHIX project too.
Refer to the master ticket, NYHIX-18388, if needed.
Refer to MAXDAT-2773 for TNRD PL.
*/
ALTER TABLE letters_stg                    MODIFY letter_type VARCHAR2(4000);
ALTER TABLE corp_etl_proc_letters          MODIFY letter_type VARCHAR2(4000);
ALTER TABLE corp_etl_proc_letters_oltp     MODIFY letter_type VARCHAR2(4000);
ALTER TABLE corp_etl_proc_letters_wip_bpm  MODIFY letter_type VARCHAR2(4000);
ALTER TABLE d_pl_current                   MODIFY letter_type VARCHAR2(4000);

ALTER TABLE d_pl_current                  MODIFY sla_category VARCHAR2(4000); 

--letters_stg.letter_status is already 256 Bytes; therefore, commented out.
--ALTER TABLE letters_stg                   MODIFY letter_status VARCHAR2(256);
ALTER TABLE corp_etl_proc_letters         MODIFY status VARCHAR2(256);
ALTER TABLE corp_etl_proc_letters_oltp    MODIFY status VARCHAR2(256);
ALTER TABLE corp_etl_proc_letters_wip_bpm MODIFY status VARCHAR2(256);
ALTER TABLE d_pl_current                  MODIFY letter_status VARCHAR2(256);
ALTER TABLE D_PL_LETTER_STATUS            MODIFY letter_status varchar2(256);