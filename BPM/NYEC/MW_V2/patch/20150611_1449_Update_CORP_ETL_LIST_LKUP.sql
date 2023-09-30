--Load 2 months of data

update corp_etl_list_lkup
   set out_var = 'and create_date >= ''01-OCT-2014'' and create_date <= ''31-MAR-2015'''
where name = 'MW_V2_ADD_TO_WHERE_CLAUSE';

commit;

