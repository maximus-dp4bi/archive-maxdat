
update corp_etl_list_lkup set out_var = '1' where  name = 'QC_LOOKUP_ALL' and list_type = 'QC';
update corp_etl_list_lkup set out_var = '1' where  name = 'QC_TRAN_ALL' and list_type = 'QC';
commit;
