alter session set current_schema = MAXDAT;

--INCIDENT STATUS HISTORY/ERROR REASON/INCIDENT HISTORY
truncate table INCIDENT_HEADER_STAT_HIST_STG;
truncate table NYHBE_INCIDENT_ERROR_REASON;
truncate table INCIDENT_HISTORY_STG;
truncate table INCIDENT_STATUS_HISTORY;

select to_date(value,'yyyy/mm/dd hh24:mi:ss') as last_successful_run_date
from corp_etl_control
where name = 'MAX_UPDATE_TS_INCIDENT_ERROR_REASON';

select to_number(value, '99999') as look_back_days
from corp_etl_control
where name = 'LOOK_BACK_INCIDENT_ERROR_REASON';

select 
       to_date(value,'yyyy/mm/dd hh24:mi:ss') as last_successful_run_date
from corp_etl_control
where name in('MAX_UPDATE_TS_INCIDENT_STTAUS_HIST','MAX_UPDATE_TS_INCIDENT_ERROR_REASON');

select 
       to_number(value) as look_back_days
from corp_etl_control
where name = 'LOOK_BACK_INCIDENT_STATUS_HIST';

update corp_etl_control
set value = '2014/01/01 00:00:00'
where name in('MAX_UPDATE_TS_INCIDENT_STTAUS_HIST','MAX_UPDATE_TS_INCIDENT_ERROR_REASON');

--COMPLAINTS

select max(a) LastIncID_Processed from 
(
SELECT to_number(Value) a
  FROM corp_etl_control
 WHERE Name = 'PC_LAST_COMPLAINT'
union 
Select Nvl(max(incident_id),0) a from CORP_ETL_COMPLAINTS_INCIDENTS
) ;

select to_number(value) look_back_days
from corp_etl_control
where name='COMP_LOOK_BACK_DAYS';

select to_number(value) Inc_look_back
from corp_etl_control
where name='COMPLAINTS_TO_LOOK_BACK';

update corp_etl_control
set value = '0'
where name in('PC_LAST_COMPLAINT','COMPLAINTS_TO_LOOK_BACK');

update maxdat.corp_etl_control
set value='139'
where name='COMP_LOOK_BACK_DAYS';

alter table F_COMPLAINT_BY_DATE drop constraint FCMPLBD_DCMPLCUR_FK;
truncate table F_COMPLAINT_BY_DATE;
truncate table D_COMPLAINT_CURRENT;
alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLCUR_FK foreign key (CMPL_BI_ID) references D_COMPLAINT_CURRENT (CMPL_BI_ID);

truncate table corp_etl_complaints_incidents;

delete from BPM_UPDATE_EVENT_QUEUE where BSL_ID = 22;

commit;

--IDR

select max(a) LastIncID_Processed from 
(
SELECT to_number(Value) a
  FROM corp_etl_control
 WHERE Name = 'LAST_IDR_INCIDENT_ID'
union 
Select Nvl(max(incident_id),0) a from NYHX_ETL_IDR_INCIDENTS
) ;

select to_number(value) look_back_days
from corp_etl_control
where name='IDR_LOOK_BACK_DAYS';

select to_number(value) Inc_look_back
from corp_etl_control
where name='IDRS_TO_LOOK_BACK';

update corp_etl_control
set value = '0'
where name in('LAST_IDR_INCIDENT_ID','IDRS_TO_LOOK_BACK');

update maxdat.corp_etl_control
set value='300'
where name='IDR_LOOK_BACK_DAYS';


begin
  for cur1 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'F_IDR_BY_DATE') loop
     execute immediate 'ALTER TABLE '||cur1.owner||'.'||cur1.table_name||' MODIFY CONSTRAINT "'||cur1.constraint_name||'" DISABLE ';
  end loop;
end;
/
truncate table MAXDAT.F_IDR_BY_DATE;
truncate table D_IDR_CURRENT;
begin
  for cur2 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'F_IDR_BY_DATE') loop
     execute immediate 'ALTER TABLE '||cur2.owner||'.'||cur2.table_name||' MODIFY CONSTRAINT "'||cur2.constraint_name||'" ENABLE ';
  end loop;
end;
/
truncate table MAXDAT.NYHX_ETL_IDR_INCIDENTS;
truncate table MAXDAT.NYHX_ETL_IDR_INCIDENT_RSN;
DELETE FROM BPM_UPDATE_EVENT_QUEUE
where BSL_ID = 21 ;
commit;