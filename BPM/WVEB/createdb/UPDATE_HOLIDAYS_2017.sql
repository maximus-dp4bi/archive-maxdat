-- 2017

Insert into EB.HOLIDAYS
   (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, 
    CREATE_TS)    
  SELECT MAX(HOLIDAY_ID) + 1, 2017, to_date('01/02/2017', 'mm/dd/yyyy'), 'New Year''s Day', '121', 
  trunc(sysdate)  
  from EB.HOLIDAYS;
COMMIT;
  
Insert into EB.HOLIDAYS
   (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, 
    CREATE_TS)   
  SELECT MAX(HOLIDAY_ID) + 1, 2017, to_date('01/16/2017', 'mm/dd/yyyy'), 'Martin Luther King Day', '121', 
  trunc(sysdate) 
  from EB.HOLIDAYS;
COMMIT;

Insert into EB.HOLIDAYS
   (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, 
    CREATE_TS)   
  SELECT MAX(HOLIDAY_ID) + 1, 2017, to_date('02/20/2017', 'mm/dd/yyyy'), 'President''s Day', '121', 
  trunc(sysdate) 
  from EB.HOLIDAYS;
COMMIT;

Insert into EB.HOLIDAYS
   (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, 
    CREATE_TS)   
  SELECT MAX(HOLIDAY_ID) + 1, 2017, to_date('05/29/2017', 'mm/dd/yyyy'), 'Memorial Day', '121', 
  trunc(sysdate) 
  from EB.HOLIDAYS;
COMMIT;

Insert into EB.HOLIDAYS
   (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, 
    CREATE_TS)   
  SELECT MAX(HOLIDAY_ID) + 1, 2017, to_date('06/20/2017', 'mm/dd/yyyy'), 'West Virginia Day', '121', 
  trunc(sysdate) 
  from EB.HOLIDAYS;
COMMIT;
    
Insert into EB.HOLIDAYS
   (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, 
    CREATE_TS)   
  SELECT MAX(HOLIDAY_ID) + 1, 2017, to_date('07/04/2017', 'mm/dd/yyyy'), 'Independence Day', '121', 
  trunc(sysdate) 
  from EB.HOLIDAYS;
COMMIT;

Insert into EB.HOLIDAYS
   (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, 
    CREATE_TS)   
  SELECT MAX(HOLIDAY_ID) + 1, 2017, to_date('09/04/2017', 'mm/dd/yyyy'), 'Labor Day', '121', 
  trunc(sysdate) 
  from EB.HOLIDAYS;
COMMIT;

Insert into EB.HOLIDAYS
   (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, 
    CREATE_TS)   
  SELECT MAX(HOLIDAY_ID) + 1, 2017, to_date('10/09/2017', 'mm/dd/yyyy'), 'Columbus Day', '121', 
  trunc(sysdate) 
  from EB.HOLIDAYS;
COMMIT;

Insert into EB.HOLIDAYS
   (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, 
    CREATE_TS)   
  SELECT MAX(HOLIDAY_ID) + 1, 2017, to_date('11/10/2017', 'mm/dd/yyyy'), 'Veteran''s Day', '121', 
  trunc(sysdate) 
  from EB.HOLIDAYS;
COMMIT;

Insert into EB.HOLIDAYS
   (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, 
    CREATE_TS)   
  SELECT MAX(HOLIDAY_ID) + 1, 2017, to_date('11/23/2017', 'mm/dd/yyyy'), 'Thanksgiving Day', '121', 
  trunc(sysdate) 
  from EB.HOLIDAYS;
COMMIT;

Insert into EB.HOLIDAYS
   (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, 
    CREATE_TS)   
  SELECT MAX(HOLIDAY_ID) + 1, 2017, to_date('11/24/2017', 'mm/dd/yyyy'), 'Day after Thanksgiving', '121', 
  trunc(sysdate) 
  from EB.HOLIDAYS;
COMMIT;

Insert into EB.HOLIDAYS
   (HOLIDAY_ID, HOLIDAY_YEAR, HOLIDAY_DATE, DESCRIPTION, CREATED_BY, 
    CREATE_TS)   
  SELECT MAX(HOLIDAY_ID) + 1, 2017, to_date('12/25/2017', 'mm/dd/yyyy'), 'Christmas Day', '121', 
  trunc(sysdate) 
  from EB.HOLIDAYS;
COMMIT;
