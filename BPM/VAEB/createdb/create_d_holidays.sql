alter session set current_schema=maxdat_support;

create table d_holidays as select * from eb.holidays where holiday_year = 2022;

grant select on d_holidays to maxdat_reports;
grant select on d_holidays to maxdatsupport_read_only;
grant select, insert, update, delete on d_holidays to maxdatsupport_oltp_siud;
grant select on d_holidays to maxdatreport_Read_only;


insert into maxdat_support.d_holidays
  (holiday_id, holiday_year, holiday_date, description, created_by, create_ts, updated_by, update_ts, excluded_processes)
values
 (100, 2023, to_Date('1/2/2023','mm/dd/yyyy'), 'New Years Day', user, sysdate, user, sysdate, null);
insert into maxdat_support.d_holidays
  (holiday_id, holiday_year, holiday_date, description, created_by, create_ts, updated_by, update_ts, excluded_processes)
values
 (101, 2023, to_Date('1/16/2023','mm/dd/yyyy'), 'MLK Day  Monday', user, sysdate, user, sysdate, null);
insert into maxdat_support.d_holidays
  (holiday_id, holiday_year, holiday_date, description, created_by, create_ts, updated_by, update_ts, excluded_processes)
values
 (102, 2023, to_Date('2/20/2023','mm/dd/yyyy'),'Presidents Day', user, sysdate, user, sysdate, null);
insert into maxdat_support.d_holidays
  (holiday_id, holiday_year, holiday_date, description, created_by, create_ts, updated_by, update_ts, excluded_processes)
values
 (103, 2023, to_Date('5/30/2023','mm/dd/yyyy'),'Memorial Day', user, sysdate, user, sysdate, null);
insert into maxdat_support.d_holidays
  (holiday_id, holiday_year, holiday_date, description, created_by, create_ts, updated_by, update_ts, excluded_processes)
values
 (104, 2023, to_Date('6/19/2023','mm/dd/yyyy'),'Juneteenth', user, sysdate, user, sysdate, null);
insert into maxdat_support.d_holidays
  (holiday_id, holiday_year, holiday_date, description, created_by, create_ts, updated_by, update_ts, excluded_processes)
values
 (105, 2023, to_Date('7/4/2023','mm/dd/yyyy'),'Independence Day', user, sysdate, user, sysdate, null);
insert into maxdat_support.d_holidays
  (holiday_id, holiday_year, holiday_date, description, created_by, create_ts, updated_by, update_ts, excluded_processes)
values
 (106, 2023, to_Date('9/4/2023','mm/dd/yyyy'),'Labor Day', user, sysdate, user, sysdate, null);
insert into maxdat_support.d_holidays
  (holiday_id, holiday_year, holiday_date, description, created_by, create_ts, updated_by, update_ts, excluded_processes)
values
 (107, 2023, to_Date('10/9/2023','mm/dd/yyyy'),'Columbus Day', user, sysdate, user, sysdate, null);
insert into maxdat_support.d_holidays
  (holiday_id, holiday_year, holiday_date, description, created_by, create_ts, updated_by, update_ts, excluded_processes)
values
 (108, 2023, to_Date('11/12/2023','mm/dd/yyyy'),'Veterans Day', user, sysdate, user, sysdate, null);
insert into maxdat_support.d_holidays
  (holiday_id, holiday_year, holiday_date, description, created_by, create_ts, updated_by, update_ts, excluded_processes)
values
 (109, 2023, to_Date('11/23/2023','mm/dd/yyyy'),'Thanksgiving' , user, sysdate, user, sysdate, null);
insert into maxdat_support.d_holidays
  (holiday_id, holiday_year, holiday_date, description, created_by, create_ts, updated_by, update_ts, excluded_processes)
values
 (110, 2023, to_Date('11/24/2023','mm/dd/yyyy'),'Day After Thanksgiving', user, sysdate, user, sysdate, null);
insert into maxdat_support.d_holidays
  (holiday_id, holiday_year, holiday_date, description, created_by, create_ts, updated_by, update_ts, excluded_processes)
values
 (111, 2023, to_Date('11/7/2023','mm/dd/yyyy'),'Election Day', user, sysdate, user, sysdate, null);
insert into maxdat_support.d_holidays
  (holiday_id, holiday_year, holiday_date, description, created_by, create_ts, updated_by, update_ts, excluded_processes)
values
 (112, 2023, to_Date('12/25/2023','mm/dd/yyyy'),'Christmas', user, sysdate, user, sysdate, null);
commit;
