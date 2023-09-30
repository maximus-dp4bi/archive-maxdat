--------------------------------------------------------
--  File created - Thursday-September-12-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View D_HOLIDAYS_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "D_HOLIDAYS_SV" ("CREATED_BY",
 "HOLIDAY_YEAR",
 "DESCRIPTION",
 "CREATE_TS",
 "UPDATED_BY",
 "UPDATE_TS",
 "HOLIDAY_ID",
 "HOLIDAY_DATE") 
 AS SELECT "CREATED_BY",
"HOLIDAY_YEAR",
"DESCRIPTION",
"CREATE_TS",
"UPDATED_BY",
"UPDATE_TS",
"HOLIDAY_ID",
"HOLIDAY_DATE" 
    
FROM HOLIDAYS;
/
