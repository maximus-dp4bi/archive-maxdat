--select value from corp_etl_control where name = 'DELTEK_FILE_NAME'

insert into corp_etl_control
values(
'DELTEK_FILE_NAME',--name
'V',--value type
'DELTEK_HOURS.xls',--value
'name of file to be processed for Deltek hours',--description
sysdate,--created
sysdate);
commit;