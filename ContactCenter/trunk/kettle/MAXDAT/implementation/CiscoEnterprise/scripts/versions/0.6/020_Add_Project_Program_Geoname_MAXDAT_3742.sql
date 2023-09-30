/*
Created on 06/30/2016 by Raj A.
Description: MAXDAT-3742. Added three columns to the Staging table.
*/
ALTER TABLE cc_s_ivr_response ADD project_name VARCHAR2(50);
ALTER TABLE cc_s_ivr_response ADD program_name VARCHAR2(50);
ALTER TABLE cc_s_ivr_response ADD GEOGRAPHY_NAME VARCHAR2(250);