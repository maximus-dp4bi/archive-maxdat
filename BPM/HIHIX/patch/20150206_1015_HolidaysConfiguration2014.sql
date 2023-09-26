insert into holidays (holiday_id ,holiday_year, holiday_date, description , created_by, create_ts, updated_by, update_ts)
values (SEQ_HOLIDAY_ID.nextVAL, '2014',to_date('03/26/2014','mm/dd/yyyy') ,'Kuhio Day', user, sysdate, user, sysdate);

insert into holidays (holiday_id ,holiday_year, holiday_date, description , created_by, create_ts, updated_by, update_ts)
values (SEQ_HOLIDAY_ID.nextVAL, '2014',to_date('04/18/2014','mm/dd/yyyy') ,'Good Friday', user, sysdate, user, sysdate);

insert into holidays (holiday_id, holiday_year, holiday_date, description , created_by, create_ts, updated_by, update_ts)
values (SEQ_HOLIDAY_ID.nextVAL, '2014',to_date('06/11/2014','mm/dd/yyyy') ,'Kamehameha Day', user, sysdate, user, sysdate);

insert into holidays (holiday_id, holiday_year, holiday_date, description , created_by, create_ts, updated_by, update_ts)
values (SEQ_HOLIDAY_ID.nextVAL, '2014',to_date('08/8/2014','mm/dd/yyyy') ,'Closed due to Hurricane', user, sysdate, user, sysdate);

insert into holidays (holiday_id, holiday_year, holiday_date, description , created_by, create_ts, updated_by, update_ts)
values (SEQ_HOLIDAY_ID.nextVAL, '2014',to_date('08/15/2014','mm/dd/yyyy') ,'Admissions Day', user, sysdate, user, sysdate);

delete from holidays where holiday_year = 2014 and description = 'Columbus Day'; -- columbus day

commit;