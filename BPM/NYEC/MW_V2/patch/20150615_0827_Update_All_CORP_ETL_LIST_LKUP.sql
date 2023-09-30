--Load all data

update corp_etl_list_lkup
   set out_var = null
where name = 'MW_V2_ADD_TO_WHERE_CLAUSE';

Update step_instance_stg
     Set MW_V2_PROCESSED = 'Y'
Where create_ts < '1-OCT-2013';

commit;

