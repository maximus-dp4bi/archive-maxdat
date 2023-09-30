update maxdat.corp_etl_control set value = 1 where name = 'INCIDENT_HEADER_STAT_HIST_ID_START';
update maxdat.corp_etl_control set value = 9999999999999 where name ='INCIDENT_HEADER_STAT_HIST_ID_END';
commit;