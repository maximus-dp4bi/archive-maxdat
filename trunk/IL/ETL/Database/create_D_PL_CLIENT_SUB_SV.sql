create or replace view D_PL_CLIENT_SUB_SV as
select * from CORP_ETL_PROC_LETTERS_CHD
with read only;


