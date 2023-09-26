update corp_etl_control
set value = 1
where name = 'LETTERS_STG_LOOK_BACK_DAYS';

commit;

