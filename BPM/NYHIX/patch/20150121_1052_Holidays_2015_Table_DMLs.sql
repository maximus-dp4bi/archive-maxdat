/*
Created on 01/21/2015 by Raj A.
Description: Updating calendar (HOLIDAYS table) in MAXDAT based on the NYHIX project calendar.
*/
insert into MAXDAT.HOLIDAYS (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, CREATE_TS, UPDATED_BY, UPDATE_TS)
values (364, 2015, to_date('01-01-2015', 'dd-mm-yyyy'), 'New Years Day', 'MAXDAT', sysdate, 'MAXDAT', sysdate);
insert into MAXDAT.HOLIDAYS (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, CREATE_TS, UPDATED_BY, UPDATE_TS)
values (365, 2015, to_date('19-01-2015', 'dd-mm-yyyy'), 'Martin Luther King Jr Day', 'MAXDAT', sysdate, 'MAXDAT', sysdate);
insert into MAXDAT.HOLIDAYS (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, CREATE_TS, UPDATED_BY, UPDATE_TS)
values (366, 2015, to_date('16-02-2015', 'dd-mm-yyyy'), 'Presidents Day', 'MAXDAT', sysdate, 'MAXDAT', sysdate);
insert into MAXDAT.HOLIDAYS (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, CREATE_TS, UPDATED_BY, UPDATE_TS)
values (367, 2015, to_date('25-05-2015', 'dd-mm-yyyy'), 'Memorial Day', 'MAXDAT', sysdate, 'MAXDAT', sysdate);
insert into MAXDAT.HOLIDAYS (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, CREATE_TS, UPDATED_BY, UPDATE_TS)
values (368, 2015, to_date('03-07-2015', 'dd-mm-yyyy'), 'Independence Day', 'MAXDAT', sysdate, 'MAXDAT', sysdate);
insert into MAXDAT.HOLIDAYS (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, CREATE_TS, UPDATED_BY, UPDATE_TS)
values (369, 2015, to_date('07-09-2015', 'dd-mm-yyyy'), 'Labor Day', 'MAXDAT', sysdate, 'MAXDAT', sysdate);
insert into MAXDAT.HOLIDAYS (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, CREATE_TS, UPDATED_BY, UPDATE_TS)
values (370, 2015, to_date('12-10-2015', 'dd-mm-yyyy'), 'Columbus Day', 'MAXDAT', sysdate, 'MAXDAT', sysdate);
insert into MAXDAT.HOLIDAYS (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, CREATE_TS, UPDATED_BY, UPDATE_TS)
values (371, 2015, to_date('11-11-2015', 'dd-mm-yyyy'), 'Veterans Day', 'MAXDAT', sysdate, 'MAXDAT', sysdate);
insert into MAXDAT.HOLIDAYS (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, CREATE_TS, UPDATED_BY, UPDATE_TS)
values (372, 2015, to_date('26-11-2015', 'dd-mm-yyyy'), 'Thanksgiving', 'MAXDAT', sysdate, 'MAXDAT', sysdate);
insert into MAXDAT.HOLIDAYS (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, CREATE_TS, UPDATED_BY, UPDATE_TS)
values (373, 2015, to_date('25-12-2015', 'dd-mm-yyyy'), 'Christmas Day', 'MAXDAT', sysdate, 'MAXDAT', sysdate);
commit;