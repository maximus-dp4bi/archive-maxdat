
update  MAXDAT.CORP_ETL_LIST_LKUP
set out_var = 'NYSOH_NoPrep_FAX'
where out_var = 'NYSOH_INT_NoPrep_FAX';

commit;

update  MAXDAT.CORP_ETL_LIST_LKUP
set Value = 'These are the NYEC PROD Batch Classes'
where out_var in 
('NYHO-FAX',
'NYHO-FPBP-FAX',
'NYHO-FPBP-MAIL',
'NYHO-MAIL-FPBP'); 
 
commit;