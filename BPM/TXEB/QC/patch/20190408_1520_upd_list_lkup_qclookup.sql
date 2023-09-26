update corp_etl_list_lkup 
set out_var = '1'
 ,value = 'Flag to load all lookup tables'
where name = 'QC_LOOKUP_ALL' and list_type = 'QC';

commit;

