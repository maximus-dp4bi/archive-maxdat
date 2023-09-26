CREATE TABLE F_APPEAL_TASKS_BY_DAY
   (
        ATD_DPT_ID NUMBER NOT NULL,
        D_DATE DATE NOT NULL,
        APPEAL_PART_ID NUMBER(10, 0) NOT NULL,
        TASK_TYPE_ID NUMBER NOT NULL,
        creation_count number,
        inventory_count number,
        completion_count number,
        cancellation_count number,
        LAST_UPDATE_DATE DATE
    )   tablespace MAXDAT_DATA ;

  alter table F_APPEAL_TASKS_BY_DAY add constraint ATD_DPT_PK primary key (ATD_DPT_ID)
  using index tablespace MAXDAT_INDX;

create index FATD_D_DATE on F_APPEAL_TASKS_BY_DAY ("D_DATE") online tablespace MAXDAT_INDX parallel compute statistics;
create index FATD_APART on F_APPEAL_TASKS_BY_DAY ("APPEAL_PART_ID") online tablespace MAXDAT_INDX parallel compute statistics;
create index FATD_TT on F_APPEAL_TASKS_BY_DAY ("TASK_TYPE_ID") online tablespace MAXDAT_INDX parallel compute statistics;

--create index FATD_DPT on F_APPEAL_TASKS_BY_DAY ("D_DATE","APPEAL_PART_ID","TASK_TYPE_ID") online tablespace MAXDAT_INDX parallel compute statistics;


Grant select on F_APPEAL_TASKS_BY_DAY to MAXDAT_READ_ONLY;

CREATE SEQUENCE  SEQ_ATBD_DPT_ID  
MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

commit;

insert into corp_etl_control values ('APPEAL_TASKS_CUBE_SPAN','N',183,'Span in days for appeal tasks by day cube to include data', sysdate, sysdate);
commit;

delete f_appeal_tasks_by_day;
insert into F_APPEAL_TASKS_BY_DAY
(ATD_DPT_ID,
D_DATE,
APPEAL_PART_ID,
TASK_TYPE_ID,
creation_count,
inventory_count,
completion_count,
cancellation_count,
LAST_UPDATE_DATE)
SELECT 
SEQ_ATBD_DPT_ID.nextVal, res.*, sysdate as last_update_date from
(select
bdd.d_date
,ap.part_id
,t.status_id
,sum(0) as creation_count
,sum(0) as inventory_count
,sum(0) as completion_count
,sum(0) as cancellation_count
FROM D_DATES bdd
CROSS JOIN D_APPEAL_STATUSES t
CROSS JOIN d_appeal_parts ap
WHERE bdd.D_DATE >= TRUNC((SYSDATE - (select value from corp_etl_control where name = 'APPEAL_TASKS_CUBE_SPAN')),'MONTH')  
group by bdd.d_date, ap.part_id, t.status_id
order by bdd.d_date, ap.part_id,t.status_id) res;

commit;

CREATE OR REPLACE VIEW MAXDAT.F_MW_APPEAL_TASKS_BY_DAY_SV AS
SELECT 
ATD_DPT_ID
,d_date
,appeal_part_id
,parts.part_name as appeal_part
,task_type_id
,tts.status_name as task_type
,creation_count
,inventory_count
,completion_count
,cancellation_count
,last_update_date
FROM F_APPEAL_TASKS_BY_DAY
LEFT OUTER JOIN D_APPEAL_PARTS parts ON APPEAL_PART_ID = parts.PART_ID
LEFT OUTER JOIN D_APPEAL_STATUSES tts ON TASK_TYPE_ID = tts.STATUS_ID
WHERE D_DATE >= TRUNC((SYSDATE - (select value from corp_etl_control where name = 'APPEAL_TASKS_CUBE_SPAN')),'MONTH')    
order by d_date, appeal_part_id;

GRANT SELECT ON MAXDAT.F_MW_APPEAL_TASKS_BY_DAY_SV TO MAXDAT_READ_ONLY;




