update corp_etl_control
set value = '2015/12/01 00:00:00'
where name in('APPHEADER_LAST_UPDATE_DATE','DOCSET_LAST_UPDATE_DATE','APPDOCDATA_LAST_UPDATE_DATE');

commit;