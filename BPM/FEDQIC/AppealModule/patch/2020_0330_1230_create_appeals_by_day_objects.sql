CREATE TABLE F_APPEALS_BY_DAY_BY_PART
   (
        ABD_DP_ID NUMBER NOT NULL,
        D_DATE DATE NOT NULL,
        APPEAL_PART_ID NUMBER(10, 0) NOT NULL,
        creation_count number,
        inventory_count number,
        sla_inventory_count number,
        completion_count number,
        closed_count number,
        cancellation_count number,
        withdrawn_count number,
        termination_count number,
        timely_appeals_count number,
        untimely_appeals_count number,
        LAST_UPDATE_DATE DATE
    )   tablespace MAXDAT_DATA ;

  alter table F_APPEALS_BY_DAY_BY_PART add constraint ABD_DP_PK primary key (ABD_DP_ID)
  using index tablespace MAXDAT_INDX;

create index FABD_D_DATE on F_APPEALS_BY_DAY_BY_PART ("D_DATE") online tablespace MAXDAT_INDX parallel compute statistics;
create index FABD_APART on F_APPEALS_BY_DAY_BY_PART ("APPEAL_PART_ID") online tablespace MAXDAT_INDX parallel compute statistics;
create index FABD_LUPDATE on F_APPEALS_BY_DAY_BY_PART ("LAST_UPDATE_DATE") online tablespace MAXDAT_INDX parallel compute statistics;

Grant select on F_APPEALS_BY_DAY_BY_PART to MAXDAT_READ_ONLY;

CREATE SEQUENCE  SEQ_ABD_DP_ID  
MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

commit;


insert into F_APPEALS_BY_DAY_BY_PART 
(ABD_DP_ID,
D_DATE,
APPEAL_PART_ID,
creation_count,
inventory_count,
sla_inventory_count,
completion_count,
closed_count,
cancellation_count,
withdrawn_count,
termination_count,
timely_appeals_count,
untimely_appeals_count,
LAST_UPDATE_DATE)
SELECT 
SEQ_ABD_DP_ID.nextVal, res.*, sysdate as last_update_date from
(select
bdd.d_date
,a.appeal_part_id
,sum(0) as creation_count
,sum(0) as inventory_count
,sum(0) as sla_inventory_count
,sum(0) as completion_count
,sum(0) as closed_count
,sum(0) as cancellation_count
,sum(0) as withdrawn_count
,sum(0) as termination_count
,sum(0) as timely_appeals_count
,sum(0) as untimely_appeals_count
FROM D_DATES bdd
JOIN D_MW_APPEAL_INSTANCE a
  ON  (
       ((a.create_date is null) OR (bdd.D_DATE >= TRUNC(a.CREATE_DATE)))
       AND (
                ((closed_date is null) OR (bdd.d_date <= trunc(closed_date))) AND
 		((cancelled_date is null) OR (bdd.d_date <= trunc(cancelled_date))) AND
     		((withdrawn_date is null) OR (bdd.d_date <= trunc(withdrawn_date)))
            )
    )
WHERE bdd.D_DATE >= TRUNC((SYSDATE - (select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')),'MONTH')    
group by bdd.d_date, a.appeal_part_id
order by bdd.d_date, a.appeal_part_id) res;

commit;

CREATE OR REPLACE VIEW MAXDAT.F_MW_APPEALS_BY_DAY_SV AS
SELECT 
ABD_DP_ID
,d_date
,appeal_part_id
,parts.part_name as appeal_part
,creation_count
,inventory_count
,sla_inventory_count
,completion_count
,closed_count
,cancellation_count
,withdrawn_count
,termination_count
,timely_appeals_count
,untimely_appeals_count
,last_update_date
FROM F_APPEALS_BY_DAY_BY_PART
LEFT OUTER JOIN D_APPEAL_PARTS parts ON APPEAL_PART_ID = parts.PART_ID
WHERE D_DATE >= TRUNC((SYSDATE - (select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')),'MONTH')    
order by d_date, appeal_part_id;

GRANT SELECT ON MAXDAT.F_MW_APPEALS_BY_DAY_SV TO MAXDAT_READ_ONLY;




