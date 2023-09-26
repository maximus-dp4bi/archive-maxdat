/*
Created by Raj A. 11/04/2015
Description: A patch script for TNRD Process Letters.
(1) Modifying Letter_Status column size to match source system.
(2) Below alter should be part of MAXDAT-2773. I missed it there; therefore, deploying now.
*/
ALTER TABLE letters_stg                    MODIFY letter_type VARCHAR2(4000);

--letters_stg.letter_status is already 256 Bytes; therefore, commented out below.
--ALTER TABLE letters_stg                   MODIFY letter_status VARCHAR2(256);
ALTER TABLE corp_etl_proc_letters         MODIFY status VARCHAR2(256);
ALTER TABLE corp_etl_proc_letters_oltp    MODIFY status VARCHAR2(256);
ALTER TABLE corp_etl_proc_letters_wip_bpm MODIFY status VARCHAR2(256);
ALTER TABLE d_pl_current                  MODIFY letter_status VARCHAR2(256);
ALTER TABLE D_PL_LETTER_STATUS            MODIFY letter_status varchar2(256);