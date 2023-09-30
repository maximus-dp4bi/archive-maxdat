create table RA_IMR_DAYS_WITH_EXPERT
( ridwe_id                 number not null,
  expert_lic_name          varchar2(100),
  report_date              date,
  total                    number,
  avg_days_with_expert     number,
  median_days_with_expert  number,
  min_date_sent            date,
  max_date_sent            date,
  create_date              date,
  last_update_date         date)
tablespace MAXDAT_DATA;

-- Add comments to the columns 
comment on column RA_IMR_DAYS_WITH_EXPERT.ridwe_id      is 'PK for this table - not linked';
comment on column RA_IMR_DAYS_WITH_EXPERT.report_date  is 'Reporting day';
comment on column RA_IMR_DAYS_WITH_EXPERT.total        is 'count of cases';

-- Create sequence 
create sequence SEQ_RIDWE_ID
   start with 1 increment by 1;

-- Grant/Revoke object privileges 
grant select on RA_IMR_DAYS_WITH_EXPERT to maxdat_read_only;

-- create trigger
create or replace trigger TRG_BIU_RA_IMR_DAYS_EXPERT
before insert or update on RA_IMR_DAYS_WITH_EXPERT
for each row
begin
  if inserting then
     if :new.RIDWE_ID is null then
        :new.RIDWE_ID := SEQ_RIDWE_ID.nextval;
     end if;
     if :new.CREATE_DATE is null then
        :new.CREATE_DATE := sysdate;
     end if;
  end if;     
  if :new.LAST_UPDATE_DATE is null then
     :new.LAST_UPDATE_DATE := sysdate;
  end if;

end;
/

-- Create table
create table RA_IMR_DAYS_IN_EXPERT_QUEUE
(
  RIDIEQ_ID               number not null,
  queue_name            varchar2(100) ,
  expert_specialty      varchar2(100) ,
  report_date           date ,
  min_assignment_date   date ,
  max_assignment_date   date ,
  avg_in_queue          number,
  median_in_queue       number ,
  min_received_date     date ,
  max_received_date     date ,
  avg_from_recd_date    number ,
  median_from_recd_date number ,
  min_assigned_date     date ,
  max_assigned_date     date ,
  avg_assigned          number ,
  median_assigned       number ,
  total                 number ,
  create_date           date,
  last_update_date      date
)
tablespace MAXDAT_DATA;

-- Add comments to the columns 
comment on column RA_IMR_DAYS_IN_EXPERT_QUEUE.RIDIEQ_ID          is 'PK for this table - not linked';
comment on column RA_IMR_DAYS_IN_EXPERT_QUEUE.avg_in_queue     is 'Averge days spent in queue';
comment on column RA_IMR_DAYS_IN_EXPERT_QUEUE.median_in_queue  is 'Median days spent in queue';

-- Create sequence 
create sequence SEQ_RIDIEQ_ID
   start with 1 increment by 1;

-- Grant/Revoke object privileges 
grant select on RA_IMR_DAYS_IN_EXPERT_QUEUE to maxdat_read_only;

-- create trigger
create or replace trigger TRG_BIU_DAYS_IN_EXPERT_QUEUE  -- identifier too long to use full table name
before insert or update on RA_IMR_DAYS_IN_EXPERT_QUEUE
for each row
begin
  if inserting then
     if :new.RIDIEQ_ID is null then
        :new.RIDIEQ_ID := SEQ_RIDIEQ_ID.nextval;
     end if;
     if :new.CREATE_DATE is null then
        :new.CREATE_DATE := sysdate;
     end if;
  end if;
  if :new.LAST_UPDATE_DATE is null then
     :new.LAST_UPDATE_DATE := sysdate;
  end if;

end;
/

