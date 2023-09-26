select max(holiday_id) from holidays where holiday_date = to_date('2022-11-24 00:00:00','yyyy-mm-dd hh24:mi:ss');
order by holiday_date desc;
select seq_holiday_id.nextval from dual;
declare
vlimit number := 500;
begin
  for i in 21..405 loop select seq_holiday_id.nextval into vlimit from dual; end loop;
end;


insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2022-11-24 00:00:00','yyyy-mm-dd hh24:mi:ss'),'Thanksgiving Day',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2022-11-25 00:00:00','yyyy-mm-dd hh24:mi:ss'),'Day After Thanksgiving',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2022-12-26 00:00:00','yyyy-mm-dd hh24:mi:ss'),'Christmas Day ( Observed ) ',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2022-12-30 00:00:00','yyyy-mm-dd hh24:mi:ss'),'',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2023-01-02 00:00:00','yyyy-mm-dd hh24:mi:ss'),'New Year Day',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2023-01-16 00:00:00','yyyy-mm-dd hh24:mi:ss'),'Dr.Martin Luther King Day',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2023-02-20 00:00:00','yyyy-mm-dd hh24:mi:ss'),'Presidents Day',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2023-05-29 00:00:00','yyyy-mm-dd hh24:mi:ss'),'Memorial Day',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2023-06-19 00:00:00','yyyy-mm-dd hh24:mi:ss'),'Juneteenth',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2023-07-04 00:00:00','yyyy-mm-dd hh24:mi:ss'),'Independence Day',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2023-09-04 00:00:00','yyyy-mm-dd hh24:mi:ss'),'Labor Day',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2023-11-10 00:00:00','yyyy-mm-dd hh24:mi:ss'),'Veterans Day',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2023-11-23 00:00:00','yyyy-mm-dd hh24:mi:ss'),'',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2023-11-24 00:00:00','yyyy-mm-dd hh24:mi:ss'),'Thanksgiving Day',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2023-11-25 00:00:00','yyyy-mm-dd hh24:mi:ss'),'Day After Thanksgiving',user,sysdate,user,sysdate);

insert into HOLIDAYS (HOLIDAY_ID,HOLIDAY_YEAR,HOLIDAY_DATE,DESCRIPTION,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS)
VALUES (SEQ_HOLIDAY_ID.nextval,2022,to_date('2023-12-26 00:00:00','yyyy-mm-dd hh24:mi:ss'),'Christmas Day ( Observed ) ',user,sysdate,user,sysdate);

commit;
