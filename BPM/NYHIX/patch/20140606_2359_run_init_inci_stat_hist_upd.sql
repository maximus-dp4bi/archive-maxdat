alter table INCIDENT_HEADER_STAT_HIST_STG add INCIDENT_STATUS varchar2(80);

delete from INCIDENT_HEADER_STAT_HIST_STG;

update CORP_ETL_CONTROL set value ='2010/04/20 00:00:00'
where name = 'MAX_UPDATE_TS_INCIDENT_STTAUS_HIST';

commit;