create table maxdat_support.HOLIDAYS
  (HOLIDAY_ID   int not null,
   HOLIDAY_YEAR int,
   HOLIDAY_DATE date,
   DESCRIPTION  varchar(128),
   CREATED_BY   varchar(80),
   CREATE_TS    date,
   UPDATED_BY   varchar(80),
   UPDATE_TS    date)
;
GO

alter table maxdat_support.HOLIDAYS add constraint HOLIDAYS_PK primary key (HOLIDAY_ID)
GO
alter table maxdat_support.HOLIDAYS add constraint HOLIDAYS_UK1 unique (HOLIDAY_DATE) 
GO

begin transaction
INSERT INTO maxdat_support.HOLIDAYS(holiday_id,holiday_year,holiday_date,description,created_by,create_ts,updated_by,update_ts)
VALUES(1, 2017, cast('01/02/2017' as date), 'New Year''s Day', 'maxdat',getdate(),'maxdat',getdate())

INSERT INTO maxdat_support.HOLIDAYS(holiday_id,holiday_year,holiday_date,description,created_by,create_ts,updated_by,update_ts)
VALUES(2, 2017, cast('01/16/2017' as date), 'Martin Luther King, Jr. Day', 'maxdat',getdate(),'maxdat',getdate())

INSERT INTO maxdat_support.HOLIDAYS(holiday_id,holiday_year,holiday_date,description,created_by,create_ts,updated_by,update_ts)
VALUES(3, 2017, cast('02/20/2017' as date), 'George Washington''s Birthday / President''s Day', 'maxdat',getdate(),'maxdat',getdate())

INSERT INTO maxdat_support.HOLIDAYS(holiday_id,holiday_year,holiday_date,description,created_by,create_ts,updated_by,update_ts)
VALUES(4, 2017, cast('05/10/2017' as date), 'Confederate Memorial Day', 'maxdat',getdate(),'maxdat',getdate())

INSERT INTO maxdat_support.HOLIDAYS(holiday_id,holiday_year,holiday_date,description,created_by,create_ts,updated_by,update_ts)
VALUES(5, 2017, cast('05/26/2017' as date), 'National Memorial Day', 'maxdat',getdate(),'maxdat',getdate())

INSERT INTO maxdat_support.HOLIDAYS(holiday_id,holiday_year,holiday_date,description,created_by,create_ts,updated_by,update_ts)
VALUES(6, 2017, cast('07/04/2017' as date), 'Independence Day', 'maxdat',getdate(),'maxdat',getdate())

INSERT INTO maxdat_support.HOLIDAYS(holiday_id,holiday_year,holiday_date,description,created_by,create_ts,updated_by,update_ts)
VALUES(7, 2017, cast('09/04/2017' as date), 'Labor Day', 'maxdat',getdate(),'maxdat',getdate())

INSERT INTO maxdat_support.HOLIDAYS(holiday_id,holiday_year,holiday_date,description,created_by,create_ts,updated_by,update_ts)
VALUES(8, 2017, cast('11/10/2017' as date), 'Veterans Day', 'maxdat',getdate(),'maxdat',getdate())

INSERT INTO maxdat_support.HOLIDAYS(holiday_id,holiday_year,holiday_date,description,created_by,create_ts,updated_by,update_ts)
VALUES(9, 2017, cast('11/23/2017' as date), 'Thanksgiving Day', 'maxdat',getdate(),'maxdat',getdate())

INSERT INTO maxdat_support.HOLIDAYS(holiday_id,holiday_year,holiday_date,description,created_by,create_ts,updated_by,update_ts)
VALUES(10, 2017, cast('11/24/2017' as date), 'Day after Thanksgiving Day', 'maxdat',getdate(),'maxdat',getdate())

INSERT INTO maxdat_support.HOLIDAYS(holiday_id,holiday_year,holiday_date,description,created_by,create_ts,updated_by,update_ts)
VALUES(11, 2017, cast('12/22/2017' as date), 'Christmas Eve', 'maxdat',getdate(),'maxdat',getdate())

INSERT INTO maxdat_support.HOLIDAYS(holiday_id,holiday_year,holiday_date,description,created_by,create_ts,updated_by,update_ts)
VALUES(12, 2017, cast('12/25/2017' as date), 'Christmas Day', 'maxdat',getdate(),'maxdat',getdate())

INSERT INTO maxdat_support.HOLIDAYS(holiday_id,holiday_year,holiday_date,description,created_by,create_ts,updated_by,update_ts)
VALUES(13, 2017, cast('12/26/2017' as date), 'Day after Christmas', 'maxdat',getdate(),'maxdat',getdate())

commit transaction