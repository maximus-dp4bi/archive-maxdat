declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_SUMMARY_BO';
   if c = 1 then
      execute immediate 'drop table SC_SUMMARY_BO cascade constraints';
   end if;
end;
/

create table DP_SCORECARD.SC_SUMMARY_BO
(
  staff_id             NUMBER,
  dates_month_num      VARCHAR2(6),
  dates_year           VARCHAR2(41),
  event_name_sort      NUMBER,
  event_name           VARCHAR2(300),
  event_subname_sort   NUMBER,
  event_subname        VARCHAR2(300),
  metric               number
);

grant select on SC_SUMMARY_BO to MAXDAT_READ_ONLY; 
grant ALTER, DELETE, INDEX, INSERT, UPDATE, SELECT, REFERENCES  on SC_SUMMARY_BO to MAXDAT; 
GRANT select, insert, update, delete ON SC_SUMMARY_BO TO MAXDAT_MSTR_TRX_RPT;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_PRODUCTION_BO';
   if c = 1 then
      execute immediate 'drop table SC_PRODUCTION_BO cascade constraints';
   end if;
end;
/

create table DP_SCORECARD.SC_PRODUCTION_BO
(
  staff_id             NUMBER,
  dates                DATE,
  event_name_sort      NUMBER,
  event_name           VARCHAR2(300),
  event_subname_sort   NUMBER,
  event_subname        VARCHAR2(300),
  metric               number
);

grant select on SC_PRODUCTION_BO to MAXDAT_READ_ONLY; 
grant ALTER, DELETE, INDEX, INSERT, UPDATE, SELECT, REFERENCES  on SC_PRODUCTION_BO to MAXDAT; 
GRANT select, insert, update, delete ON SC_PRODUCTION_BO TO MAXDAT_MSTR_TRX_RPT;


