CREATE TABLE D_DELIVERY_RULES
(drule_id   NUMBER(18,0)
 ,Delivery_rule varchar2(100)
 , frequency varchar2(20) NOT NULL
 , run_weekday varchar2(20)
 , run_month varchar2(20)
 , run_date varchar2(10)
 , run_time varchar2(10)
 , if_holiday_run_next varchar2(1)
 , effective_from_date DATE not null
 ,effective_thru_date DATE not null
) TABLESPACE MAXDAT_DATA;

create public synonym D_DELIVERY_RULES for maxdat.D_DELIVERY_RULES;

create sequence seq_drule_id start with 1 increment by 1;

alter table D_DELIVERY_RULES add constraint drule_chk_frequency check (frequency in ('DAILY','HOURLY','MONTHLY','WEEKLY'));

GRANT SELECT ON D_DELIVERY_RULES TO MAXDAT_READ_ONLY;

alter table D_DELIVERY_RULES add constraint D_DELIVERY_RULES_PK primary key (DRULE_ID) using index tablespace MAXDAT_INDX;

create or replace view D_DELIVERY_RULES_SV as
select * 
from D_DELIVERY_RULES
with read only;


grant select on D_DELIVERY_RULES_SV to MAXDAT_READ_ONLY;
