alter session set current_schema = MAXDAT;

update corp_etl_list_lkup set OUT_VAR = 'NYSOH-MAIL'
where name = 'MFB_BATCH_CLASS_LIST5';

update corp_etl_list_lkup set OUT_VAR = 'NYSOH-FAX'
where name = 'MFB_BATCH_CLASS_LIST8';

commit;
