/*
Created on 21-Jul-2014 by Raj A.
NYHIX has some error reasons for letters greater the existing size of 100. So, changed to 4000 to match the Letter_STG.error_codes
Same is the reason for County_Code.
*/
alter table corp_etl_proc_letters modify error_reason varchar2(4000);
alter table corp_etl_proc_letters_oltp modify error_reason varchar2(4000);
alter table corp_etl_proc_letters_wip_bpm modify error_reason varchar2(4000);
alter table d_pl_current modify REQUEST_ERROR_REASON varchar2(4000);

alter table corp_etl_proc_letters modify COUNTY_CODE varchar2(64);
alter table corp_etl_proc_letters_oltp modify COUNTY_CODE varchar2(64);
alter table corp_etl_proc_letters_wip_bpm modify COUNTY_CODE varchar2(64);
alter table d_pl_current modify COUNTY_CODE varchar2(64);