ALTER SESSION SET CURRENT_SCHEMA = MAXDAT;

Update corp_etl_control
set value = '2015/10/01 00:00:00'
where name = 'LETTERS_LAST_UPDATE_DATE';

commit;

