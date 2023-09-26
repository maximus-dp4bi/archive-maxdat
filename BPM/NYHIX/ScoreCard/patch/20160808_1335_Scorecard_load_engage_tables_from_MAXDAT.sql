-- Load Engage tables in DP_SCORECARD from MAXDAT and then drop MAXDAT tables

ALTER SESSION SET CURRENT_SCHEMA = MAXDAT;
show errors;

insert into DP_SCORECARD.ENGAGE_FORM_TYPE
select * from ENGAGE_FORM_TYPE;

insert into DP_SCORECARD.ENGAGE_ACTUALS
select * from ENGAGE_ACTUALS;

commit;

drop trigger TRG_BIU_ENGAGE_ACTUALS;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='ENGAGE_FORM_TYPE';
   if c = 1 then
      execute immediate 'drop table ENGAGE_FORM_TYPE cascade constraints';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='ENGAGE_ACTUALS_STG';
   if c = 1 then
      execute immediate 'drop table ENGAGE_ACTUALS_STG cascade constraints';
   end if;
end;
/
 
declare  c int;
begin
   select count(*) into c from user_tables where table_name ='ENGAGE_ACTUALS';
   if c = 1 then
      execute immediate 'drop table ENGAGE_ACTUALS cascade constraints';
   end if;
end;
/
