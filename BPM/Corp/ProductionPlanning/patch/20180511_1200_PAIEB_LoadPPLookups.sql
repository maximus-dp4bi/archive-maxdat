INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(0,12,'AM','12 AM','00:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(1,1,'AM','1 AM','01:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(2,2,'AM','2 AM','02:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(3,3,'AM','3 AM','03:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(4,4,'AM','4 AM','04:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(5,5,'AM','5 AM','05:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(6,6,'AM','6 AM','06:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(7,7,'AM','7 AM','07:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(8,8,'AM','8 AM','08:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(9,9,'AM','9 AM','09:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(10,10,'AM','10 AM','10:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(11,11,'AM','11 AM','11:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(12,12,'PM','12 PM','12:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(13,1,'PM','1 PM','13:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(14,2,'PM','2 PM','14:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(15,3,'PM','3 PM','15:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(16,4,'PM','4 PM','16:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(17,5,'PM','5 PM','17:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(18,6,'PM','6 PM','18:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(19,7,'PM','7 PM','19:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(20,8,'PM','8 PM','20:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(21,9,'PM','9 PM','21:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(22,10,'PM','10 PM','22:00');
INSERT INTO pa_ieb.PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(23,11,'PM','11 PM','23:00');  
 

--COMMIT;

--/

---PAST DATES
BEGIN
   FOR RECS IN 
     (


WITH DAYS AS
(SELECT TRUNC(SYSDATE) - ROWNUM missing_date
 FROM ALL_OBJECTS
 WHERE ROWNUM < 3000)
SELECT
  DAYS.missing_date
FROM
  DAYS
  ) LOOP
insert into pa_ieb.PP_D_DATES 
        (D_DATE,d_month,d_month_name,d_day,d_day_name,
         d_day_of_week,d_day_of_month,d_day_of_year,d_year,d_month_num,
         d_week_of_year,D_WEEK_OF_MONTH,WEEKEND_FLAG)
      values 
        (RECS.missing_date,to_char(RECS.missing_date,'Mon'),to_char(RECS.missing_date,'FMMonth'),to_char(RECS.missing_date,'Dy'), to_char(RECS.missing_date,'Day'),
         to_char(RECS.missing_date,'D'),to_char(RECS.missing_date,'DD'),to_char(RECS.missing_date,'DDD'),to_char(RECS.missing_date,'YYYY'),to_char(RECS.missing_date,'MM'),
         to_char(RECS.missing_date,'IW'),TO_CHAR(RECS.missing_date,'W'),case when TO_CHAR(RECS.missing_date,'D') in('1','7') then 'Y' else 'N' end);
    end loop;
   -- commit;
    
  end;
  
---CURRENT DATE
BEGIN
   FOR RECS IN 
     (


WITH DAYS AS
(SELECT TRUNC(SYSDATE) missing_date
 FROM DUAL)
SELECT
  DAYS.missing_date
FROM
  DAYS
  ) LOOP
insert into pa_ieb.PP_D_DATES 
        (D_DATE,d_month,d_month_name,d_day,d_day_name,
         d_day_of_week,d_day_of_month,d_day_of_year,d_year,d_month_num,
         d_week_of_year,D_WEEK_OF_MONTH,WEEKEND_FLAG)
      values 
        (RECS.missing_date,to_char(RECS.missing_date,'Mon'),to_char(RECS.missing_date,'FMMonth'),to_char(RECS.missing_date,'Dy'), to_char(RECS.missing_date,'Day'),
         to_char(RECS.missing_date,'D'),to_char(RECS.missing_date,'DD'),to_char(RECS.missing_date,'DDD'),to_char(RECS.missing_date,'YYYY'),to_char(RECS.missing_date,'MM'),
         to_char(RECS.missing_date,'IW'),TO_CHAR(RECS.missing_date,'W'),case when TO_CHAR(RECS.missing_date,'D') in('1','7') then 'Y' else 'N' end);
    end loop;
    -- commit;
    
  end;  
  
---FUTURE DATES
BEGIN
   FOR RECS IN 
     (


WITH DAYS AS
(SELECT TRUNC(SYSDATE) + ROWNUM missing_date
 FROM ALL_OBJECTS
 WHERE ROWNUM < 3000)
SELECT
  DAYS.missing_date
FROM
  DAYS
  ) LOOP
insert into pa_ieb.PP_D_DATES 
        (D_DATE,d_month,d_month_name,d_day,d_day_name,
         d_day_of_week,d_day_of_month,d_day_of_year,d_year,d_month_num,
         d_week_of_year,D_WEEK_OF_MONTH,WEEKEND_FLAG)
      values 
        (RECS.missing_date,to_char(RECS.missing_date,'Mon'),to_char(RECS.missing_date,'FMMonth'),to_char(RECS.missing_date,'Dy'), to_char(RECS.missing_date,'Day'),
         to_char(RECS.missing_date,'D'),to_char(RECS.missing_date,'DD'),to_char(RECS.missing_date,'DDD'),to_char(RECS.missing_date,'YYYY'),to_char(RECS.missing_date,'MM'),
         to_char(RECS.missing_date,'IW'),TO_CHAR(RECS.missing_date,'W'),case when TO_CHAR(RECS.missing_date,'D') in('1','7') then 'Y' else 'N' end);
    end loop;
    -- commit;
    
  end;  


--/


--Insert into Geography Config
insert into pa_ieb.pp_cfg_geography_config
  (cfg_geography_config_id, site_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values
  (1, 'Pennsylvania', 'East', 'PA', NULL, NULL, 'US', TRUNC(SYSDATE-1), TO_DATE('07/07/7777','MM/DD/YYYY'));


INSERT INTO pa_ieb.PP_CFG_PROGRAM_CONFIG
    (CFG_PROGRAM_CONFIG_ID, PROGRAM_NAME)
  VALUES
    (1,'PA IEB');

--PROVINCE  
INSERT INTO pa_ieb.PP_D_PROVINCE
  (PROVINCE_ID, PROVINCE_NAME)
VALUES
  (1, NULL);
--SITE
INSERT INTO pa_ieb.PP_D_SITE
  (SITE_ID, SITE_NAME)
VALUES
  (1, 'Pennsylvania');
--DISTRICT
INSERT INTO pa_ieb.PP_D_DISTRICT
  (DISTRICT_ID, DISTRICT_NAME)
VALUES
  (1, NULL);
--STATE
INSERT INTO pa_ieb.PP_D_STATE
  (STATE_ID, STATE_NAME)
VALUES
  (1, 'PA');
--REGION
INSERT INTO pa_ieb.PP_D_REGION
  (REGION_ID, REGION_NAME)
VALUES
  (1, 'East');
--COUNTRY  
INSERT INTO pa_ieb.PP_D_COUNTRY
  (COUNTRY_ID, COUNTRY_NAME)
VALUES
  (1, 'US');
--GEO MASTER  
INSERT INTO pa_ieb.PP_D_GEOGRAPHY_MASTER
  (GEOGRAPHY_MASTER_ID, GEOGRAPHY_NAME, COUNTRY_ID, STATE_ID, PROVINCE_ID, DISTRICT_ID, REGION_ID, SITE_ID)
VALUES
  (1, 'PAIEB', 1, 1, 1, 1, 1, 1);    
  

insert into pa_ieb.pp_d_program
  (program_id, program_name)
values
  (1, 'Independent Enrollment Broker');

insert into pa_ieb.pp_d_segment
  (segment_id, segment_name)
values
  (1, 'Enrollment Services');

  
insert into pa_ieb.pp_d_project
  (project_id, project_name, segment_id)
values
  (1, 'PA IEB', 1);
  
  
insert into pa_ieb.pp_d_production_plan
  (pp_id, production_plan_name, production_plan_description, project_id, program_id, geography_master_id, effective_date, end_date, pp_create_date, pp_last_update_date)
values
  (1, 'PAIEB_PROD_PLAN', 'PA IEB Production Planning', 1, 1, 1, SYSDATE, TO_DATE('07/07/7777','MM/DD/YYYY'), SYSDATE, SYSDATE);
  
--COMMIT;    
  
  
insert into pa_ieb.pp_cfg_project_config
  (cfg_project_config_id, segment_name, project_name, program_name, create_date, last_update_date)
values
  (1, 'Enrollment Services', 'PA IEB', 'Independent Enrollment Broker', sysdate, sysdate);


insert into pa_ieb.pp_cfg_production_plan
  (cfg_production_plan_id, cfg_geography_config_id, cfg_project_config_id, production_plan_name, production_plan_description, effective_date, end_date, create_date, last_update_date)
values
  (1, 1, 1, 'PAIEB_PROD_PLAN', 'PA IEB Production Planning', TRUNC(SYSDATE-1), null, SYSDATE, SYSDATE);
  
INSERT INTO pa_ieb.PP_CFG_SOURCE_CONFIG
  (CFG_SOURCE_CONFIG_ID, SOURCE_NAME, SOURCE_DESCRIPTION)
VALUES
  (1, 'MANAGE WORK STG', 'Decision Point Manage Work Staging Table - Task Create Date to Complete Date');

 
--Insert into Forecast File Control 
insert into pa_ieb.pp_cfg_forecast_file_control
  (cfg_forecast_file_control_id, cfg_production_plan_id, file_location, inventory_filename, volume_filename, enabled, create_date, last_update_date)
values
  (1, 1, '/u01/maximus/maxdat-uat/PA/Processing/ProductionPlanning/Forecast/', 'PP_PAIEB_INV_INI.TXT', 'PP_PAIEB_VOL_INI.TXT', 'Y', sysdate, sysdate);
  
insert into pa_ieb.pp_cfg_actuals_file_control
  (cfg_actuals_file_control_id, project_id, program_id, geography_master_id, file_location, actuals_filename, enabled, create_date, last_update_date)
values
  (1, 1, 1, 1, '/u01/maximus/maxdat-uat/PA/Processing/ProductionPlanning/Actuals/', 'PP_PAIEB_ACTUALS.TXT', 'Y', SYSDATE, SYSDATE); 
  

INSERT INTO pa_ieb.PP_D_SOURCE SELECT 1, 'MANAGE WORK STG', 'Decision Point Manage Work Staging Table - Task Create Date to Complete Date' FROM DUAL;

INSERT INTO pa_ieb.PP_D_SOURCE_REF_TYPE SELECT 1, 'TASK TYPE', 1 FROM DUAL;

Insert into pa_ieb.PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (1,'PAIEB_REFERRAL','N','Minutes',3,'CAL',365,'Referral');
Insert into pa_ieb.PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (2,'PAIEB_NEW_APP','N','Minutes',2,'CAL',365,'New Application');
Insert into pa_ieb.PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (3,'PAIEB_PC_LCD','N','Minutes',2,'CAL',365,'PC/LCD');
Insert into pa_ieb.PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (4,'PAIEB_APP_REVIEW','N','Minutes',2,'CAL',365,'Application Review');
Insert into pa_ieb.PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (5,'PAIEB_EB_IVA','N','Minutes',3,'CAL',365,'EB/IVA');
Insert into pa_ieb.PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (6,'PAIEB_MMS_READY','N','Minutes',14,'CAL',365,'MMS Ready');
Insert into pa_ieb.PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (7,'PAIEB_FINANCIAL_APPROVAL','N','Minutes',5,'CAL',365,'Financial Approval');
Insert into pa_ieb.PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (8,'PAIEB_DATA_ENTRY','N','Minutes',1,'CAL',365,'Data Entry');
Insert into pa_ieb.PP_CFG_UNIT_OF_WORK (CFG_UOW_ID,UNIT_OF_WORK_NAME,HOURLY_FLAG,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,AGE_DAYS_TYPE,INV_AVG_AGE,LABEL) values (9,'PAIEB_FINAL_MAIL_ENROLLED','N','Minutes',2,'CAL',365,'Final Mailing(Enrolled)');


Insert into pa_ieb.PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (1,'PAIEB_REFERRAL','Minutes',3,'Referral');
Insert into pa_ieb.PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (2,'PAIEB_NEW_APP','Minutes',2,'New Application');
Insert into pa_ieb.PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (3,'PAIEB_PC_LCD','Minutes',2,'PC/LCD');
Insert into pa_ieb.PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (4,'PAIEB_APP_REVIEW','Minutes',2,'Application Review');
Insert into pa_ieb.PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (5,'PAIEB_EB_IVA','Minutes',3,'EB/IVA');
Insert into pa_ieb.PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (6,'PAIEB_MMS_READY','Minutes',14,'MMS Ready');
Insert into pa_ieb.PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (7,'PAIEB_FINANCIAL_APPROVAL','Minutes',5,'Financial Approval');
Insert into pa_ieb.PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (8,'PAIEB_DATA_ENTRY','Minutes',1,'Data Entry');
Insert into pa_ieb.PP_D_UNIT_OF_WORK (UOW_ID,UNIT_OF_WORK_NAME,HANDLE_TIME_UNIT,JEOPARDY_INV_AGE,LABEL) values (9,'PAIEB_FINAL_MAIL_ENROLLED','Minutes',2,'Final Mailing(Enrolled)');


Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (1,1,1,'Application Data Entry','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),60001);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (2,1,1,'Close Application Task','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),60005);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (3,2,1,'COMPASS Data Entry Task','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),32504);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (4,2,1,'Get Pending MCI from eCIS','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),40137225);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (5,3,1,'Check SAMS Documentation Task','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),60016);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (6,3,1,'Verify Missing Information Task','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),60003);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (7,4,1,'Application Review','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),60002);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (8,5,1,'Send OLTL HCBS Denial Notice','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),40137214);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (9,5,1,'HCBS Denial Task','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),32503);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (10,6,1,'Finalize SC Agency Task','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),60007);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (11,6,1,'Finalize SC Agency - Delay Task','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),32331);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (12,6,1,'Plan Data Entry - Delay Task','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),32521);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (13,6,1,'Compile Delayed Transition Tasks','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),60012);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (14,6,1,'Update Delayed Enrollment Information Task','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),40137223);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (15,6,1,'Received Confirmed Discharge','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),40137226);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (16,7,1,'Financial Waiver Mismatch Task','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),60009);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (17,7,1,'Plan Data Entry - No Delay Task','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),60004);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (18,7,1,'Complete Application Task','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),60008);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (19,8,1,'Add generic Task Type as placeholder','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),110);
Insert into pa_ieb.PP_D_UOW_SOURCE_REF (USR_ID,UOW_ID,SOURCE_REF_TYPE_ID,SOURCE_REF_VALUE,SOURCE_REF_DETAIL_IDENTIFIER,EFFECTIVE_DATE,END_DATE,SOURCE_REF_ID) values (20,9,1,'Compile Final Mailing Packet Task','TASK ID',to_date('01/01/2015','MM/DD/YYYY'),to_date('07/07/2077','MM/DD/YYYY'),60011);



/*CREATE OR REPLACE VIEW PP_D_UOW_MW_SV AS
   SELECT USR.UOW_ID, USR.SOURCE_REF_VALUE AS TASK_TYPE
   FROM PP_D_SOURCE_REF_TYPE SRT
   INNER JOIN PP_D_SOURCE S ON SRT.SOURCE_ID = S.SOURCE_ID
   INNER JOIN pa_ieb.PP_D_UOW_SOURCE_REF USR ON SRT.SOURCE_REF_TYPE_ID =
   USR.SOURCE_REF_TYPE_ID
   WHERE S.SOURCE_NAME = 'NYHIX MANAGE WORK STG'
   AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE';*/


--COMMIT;

--/
