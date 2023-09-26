/*
Created by on 11/3/2015 by Raj A.
Changed column size for Letter_Type and SLA_Category to 4000 to match source system column size, Letter_Definition.Description.
*/
ALTER TABLE corp_etl_proc_letters MODIFY letter_type VARCHAR2(4000);
ALTER TABLE corp_etl_proc_letters_oltp MODIFY letter_type VARCHAR2(4000);
ALTER TABLE corp_etl_proc_letters_wip_bpm MODIFY letter_type VARCHAR2(4000);
ALTER TABLE d_pl_current MODIFY letter_type VARCHAR2(4000);
ALTER TABLE d_pl_current MODIFY sla_category VARCHAR2(4000);