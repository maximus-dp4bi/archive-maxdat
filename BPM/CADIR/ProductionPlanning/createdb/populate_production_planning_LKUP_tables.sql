--Insert into UOW Config 
insert into pp_cfg_unit_of_work values (1, '15_DAY_WAITING_QUEUE', 'N', 'Minutes',17, 'CAL', 30, '15 Day Waiting Period Queue');
insert into pp_cfg_unit_of_work values (2, 'CASE_CLOSING', 'N', 'Minutes',1, 'BUS', 3, 'Case Closing');
insert into pp_cfg_unit_of_work values (3, 'CASE_CREATION', 'N', 'Minutes',1, 'BUS', 3, 'Case Creation');
insert into pp_cfg_unit_of_work values (4, 'CLINICAL_CONSULTANT', 'N', 'Minutes',4, 'BUS', 15, 'Clinical Consultant');
insert into pp_cfg_unit_of_work values (5, 'FDL', 'N', 'Minutes',1, 'BUS', 3, 'Final Determination Letter');
insert into pp_cfg_unit_of_work values (6, 'INTERNAL_EXPERT', 'N', 'Minutes',4, 'BUS', 10, 'Internal Expert Review');
insert into pp_cfg_unit_of_work values (7, 'PANEL_SCHED_EXPERT_REVIEW', 'N', 'Minutes',6, 'CAL', 15, 'Expert Review');
insert into pp_cfg_unit_of_work values (8, 'PANEL_SCHED_RECEIVING', 'N', 'Minutes',1, 'BUS', 15, 'Panel Scheduling Incoming');
insert into pp_cfg_unit_of_work values (9, 'PANEL_SCHED_SENDING', 'N', 'Minutes',1, 'BUS', 3, 'Panel Scheduling Sending');
insert into pp_cfg_unit_of_work values (10, 'PRELIMINARY_REVIEW', 'N', 'Minutes',1, 'BUS', 3, 'Preliminary Review');
insert into pp_cfg_unit_of_work values (11, 'TERMINATION', 'N', 'Minutes',1, 'BUS', 3, 'Termination');
insert into pp_cfg_unit_of_work values (12, 'TWO_DAY_LETTER_QUEUE', 'N', 'Minutes',16, 'CAL', 30, 'Two Day Letter');
insert into pp_cfg_unit_of_work values (13, 'MRT', 'N', 'Minutes',4, 'BUS', 15, 'MRT');
--select * from pp_d_unit_of_work

--Insert into UOW Lookup
insert into pp_d_unit_of_work values (1, '15_DAY_WAITING_QUEUE', 'Minutes',17, '15 Day Waiting Period Queue');
insert into pp_d_unit_of_work values (2, 'CASE_CLOSING', 'Minutes',1, 'Case Closing');
insert into pp_d_unit_of_work values (3, 'CASE_CREATION', 'Minutes',1, 'Case Creation');
insert into pp_d_unit_of_work values (4, 'CLINICAL_CONSULTANT', 'Minutes',4, 'Clinical Consultant');
insert into pp_d_unit_of_work values (5, 'FDL', 'Minutes',1, 'Final Determination Letter');
insert into pp_d_unit_of_work values (6, 'INTERNAL_EXPERT', 'Minutes',4, 'Internal Expert Review');
insert into pp_d_unit_of_work values (7, 'PANEL_SCHED_EXPERT_REVIEW', 'Minutes',6, 'Expert Review');
insert into pp_d_unit_of_work values (8, 'PANEL_SCHED_RECEIVING', 'Minutes',1, 'Panel Scheduling Incoming');
insert into pp_d_unit_of_work values (9, 'PANEL_SCHED_SENDING', 'Minutes',1, 'Panel Scheduling Sending');
insert into pp_d_unit_of_work values (10, 'PRELIMINARY_REVIEW', 'Minutes',1, 'Preliminary Review');
insert into pp_d_unit_of_work values (11, 'TERMINATION', 'Minutes',1, 'Termination');
insert into pp_d_unit_of_work values (12, 'TWO_DAY_LETTER_QUEUE', 'Minutes',16, 'Two Day Letter');
insert into pp_d_unit_of_work values (13, 'MRT', 'Minutes',4, 'MRT');

commit;


--Insert into Geography Config
insert into pp_cfg_geography_config
  (cfg_geography_config_id, site_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values
  (1, 'Folsom', 'WEST', 'CA', 'Sacramento County', NULL, 'US', TRUNC(SYSDATE-1), TO_DATE('07/07/7777','MM/DD/YYYY'));


INSERT INTO PP_CFG_PROGRAM_CONFIG
    (CFG_PROGRAM_CONFIG_ID, PROGRAM_NAME)
  VALUES
    (1,'IMR');

--PROVINCE  
INSERT INTO PP_D_PROVINCE
  (PROVINCE_ID, PROVINCE_NAME)
VALUES
  (1, 'Sacramento County');
--SITE
INSERT INTO PP_D_SITE
  (SITE_ID, SITE_NAME)
VALUES
  (1, 'Folsom');
--DISTRICT
INSERT INTO PP_D_DISTRICT
  (DISTRICT_ID, DISTRICT_NAME)
VALUES
  (1, NULL);
--STATE
INSERT INTO PP_D_STATE
  (STATE_ID, STATE_NAME)
VALUES
  (1, 'CA');
--REGION
INSERT INTO PP_D_REGION
  (REGION_ID, REGION_NAME)
VALUES
  (1, 'WEST');
--COUNTRY  
INSERT INTO PP_D_COUNTRY
  (COUNTRY_ID, COUNTRY_NAME)
VALUES
  (1, 'US');
--GEO MASTER  
INSERT INTO PP_D_GEOGRAPHY_MASTER
  (GEOGRAPHY_MASTER_ID, GEOGRAPHY_NAME, COUNTRY_ID, STATE_ID, PROVINCE_ID, DISTRICT_ID, REGION_ID, SITE_ID)
VALUES
  (1, 'CADIR', 1, 1, 1, 1, 1, 1);    
  
insert into pp_d_program
  (program_id, program_name)
values
  (1, 'IMR');
  
insert into pp_d_segment
  (segment_id, segment_name)
values
  (1, 'Health Services');
  
insert into pp_d_project
  (project_id, project_name, segment_id)
values
  (1, 'CADIR', 1);
    
insert into pp_d_production_plan
  (pp_id, production_plan_name, production_plan_description, project_id, program_id, geography_master_id, effective_date, end_date, pp_create_date, pp_last_update_date)
values
  (1, 'CADIR_PROD_PLAN', 'CADIR_PROD_PLAN', 1, 1, 1, SYSDATE, TO_DATE('07/07/7777','MM/DD/YYYY'), SYSDATE, SYSDATE);
  

--Insert into Project Config  
insert into pp_cfg_project_config
  (cfg_project_config_id, segment_name, project_name, program_name, create_date, last_update_date)
values
  (1, 'Health Services', 'CADIR', 'IMR', sysdate, sysdate);

--Insert into Production Plan 
insert into pp_cfg_production_plan
  (cfg_production_plan_id, cfg_geography_config_id, cfg_project_config_id, production_plan_name, production_plan_description, effective_date, end_date, create_date, last_update_date)
values
  (1, 1, 1, 'CADIR_PROD_PLAN', 'CADIR Production Planning', TRUNC(SYSDATE-1), null, SYSDATE, SYSDATE);

INSERT INTO PP_CFG_SOURCE_CONFIG
  (CFG_SOURCE_CONFIG_ID, SOURCE_NAME, SOURCE_DESCRIPTION)
VALUES
  (1, 'MANAGE WORK STG', 'California MAXDAT Manage Work Staging Table - Task Create Date to Completed Date.');
  
--Insert into Forecast File Control 
insert into pp_cfg_forecast_file_control
  (cfg_forecast_file_control_id, cfg_production_plan_id, file_location, inventory_filename, volume_filename, enabled, create_date, last_update_date)
values
(1, 1, '/u01/maximus/maxdat-prd/CADIR/Processing/ProductionPlanning/Forecast/', 'PP_CADIR_INV_INI.TXT', 'PP_CADIR_VOL_INI.TXT', 'Y', sysdate, sysdate); 

  --(1, 1, '/u01/maximus/maxdat-uat/CADIR/Processing/ProductionPlanning/Forecast/', 'PP_CADIR_INV_INI.TXT', 'PP_CADIR_VOL_INI.TXT', 'Y', sysdate, sysdate); --UAT
--  (1, 1, '/u01/maximus/maxdat-dev/CADIR/Processing/ProductionPlanning/Forecast/', 'PP_CADIR_INV_INI.TXT', 'PP_CADIR_VOL_INI.TXT', 'Y', sysdate, sysdate); --DEV
--  (1, 1, '/u01/maximus/maxdat-prd/CADIR/Processing/ProductionPlanning/Forecast/', 'PP_CADIR_INV_INI.TXT', 'PP_CADIR_VOL_INI.TXT', 'Y', sysdate, sysdate); --PROD
  
insert into pp_cfg_actuals_file_control
  (cfg_actuals_file_control_id, project_id, program_id, geography_master_id, file_location, actuals_filename, enabled, create_date, last_update_date)
values
(1, 1, 1, 1, '/u01/maximus/maxdat-prd/CADIR/Processing/ProductionPlanning/Actuals/', 'PP_CADIR_ACTUALS.TXT', 'Y', SYSDATE, SYSDATE); 
--  (1, 1, 1, 1, '/u01/maximus/maxdat-dev/CADIR/Processing/ProductionPlanning/Actuals/', 'PP_CADIR_ACTUALS.TXT', 'Y', SYSDATE, SYSDATE); --DEV
 -- (1, 1, 1, 1, '/u01/maximus/maxdat-uat/CADIR/Processing/ProductionPlanning/Actuals/', 'PP_CADIR_ACTUALS.TXT', 'Y', SYSDATE, SYSDATE); --UAT 
--  (1, 1, 1, 1, '/u01/maximus/maxdat-prd/CADIR/Processing/ProductionPlanning/Actuals/', 'PP_CADIR_ACTUALS.TXT', 'Y', SYSDATE, SYSDATE); --PROD 

commit;

INSERT INTO PP_D_DATES
  (D_DATE,
   D_MONTH,
   D_MONTH_NAME,
   D_DAY,
   D_DAY_NAME,
   D_DAY_OF_WEEK,
   D_DAY_OF_MONTH,
   D_DAY_OF_YEAR,
   D_YEAR,
   D_MONTH_NUM,
   D_WEEK_OF_YEAR,
   D_WEEK_OF_MONTH,
   WEEKEND_FLAG)
SELECT D_DATE,
       D_MONTH,
       D_MONTH_NAME,
       D_DAY,
       D_DAY_NAME,
       D_DAY_OF_WEEK,
       D_DAY_OF_MONTH,
       D_DAY_OF_YEAR,
       D_YEAR,
       D_MONTH_NUM,
       D_WEEK_OF_YEAR,
       D_WEEK_OF_MONTH,
       WEEKEND_FLAG
  FROM BPM_D_DATES;


INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(0,12,'AM','12 AM','00:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(1,1,'AM','1 AM','01:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(2,2,'AM','2 AM','02:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(3,3,'AM','3 AM','03:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(4,4,'AM','4 AM','04:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(5,5,'AM','5 AM','05:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(6,6,'AM','6 AM','06:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(7,7,'AM','7 AM','07:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(8,8,'AM','8 AM','08:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(9,9,'AM','9 AM','09:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(10,10,'AM','10 AM','10:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(11,11,'AM','11 AM','11:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(12,12,'PM','12 PM','12:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(13,1,'PM','1 PM','13:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(14,2,'PM','2 PM','14:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(15,3,'PM','3 PM','15:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(16,4,'PM','4 PM','16:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(17,5,'PM','5 PM','17:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(18,6,'PM','6 PM','18:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(19,7,'PM','7 PM','19:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(20,8,'PM','8 PM','20:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(21,9,'PM','9 PM','21:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(22,10,'PM','10 PM','22:00');
INSERT INTO PP_D_HOURS(D_HOUR,HOUR12,AM_PM, TIME_OF_DAY12, TIME_OF_DAY24) VALUES(23,11,'PM','11 PM','23:00');  

INSERT INTO PP_D_SOURCE SELECT 1, 'MANAGE WORK STG', 'California MAXDAT Manage Work Staging Table - Task Create Date to Complete Date' FROM DUAL;

INSERT INTO PP_D_SOURCE_REF_TYPE SELECT 1, 'TASK TYPE', 1 FROM DUAL;


INSERT INTO PP_D_UOW_SOURCE_REF SELECT 1, 1, 1, '15 Day Waiting Period Queue', 'TASK ID', TO_DATE('20140417','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 2, 2, 1, 'Ready to Close Queue', 'TASK ID', TO_DATE('20140417','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 3, 3, 1, 'caseCreation', 'TASK ID', TO_DATE('20140417','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 4, 4, 1, 'Clinical Consultant Queue', 'TASK ID', TO_DATE('20140417','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 5, 5, 1, 'Final Determination Letter Queue', 'TASK ID', TO_DATE('20140417','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 6, 6, 1, 'Internal Expert Reviewer Queue', 'TASK ID', TO_DATE('20140417','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 7, 7, 1, 'Pending Expert Review Queue', 'TASK ID', TO_DATE('20140417','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 8, 8, 1, 'mprRouting', 'TASK ID', TO_DATE('20140417','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 9, 9, 1, 'Panel Scheduling Queue', 'TASK ID', TO_DATE('20140417','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 10, 10, 1, 'Preliminary Reviewer Queue', 'TASK ID', TO_DATE('20140417','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 11, 11, 1, 'Termination Queue', 'TASK ID', TO_DATE('20140417','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 12, 12, 1, 'Two Day Letter Queue', 'TASK ID', TO_DATE('20140417','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 14, 13, 1, 'Document Review Queue', 'TASK ID', TO_DATE('20140417','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;




CREATE OR REPLACE VIEW PP_D_UOW_MW_SV AS
   SELECT USR.UOW_ID, USR.SOURCE_REF_VALUE AS TASK_TYPE
   FROM PP_D_SOURCE_REF_TYPE SRT
   INNER JOIN PP_D_SOURCE S ON SRT.SOURCE_ID = S.SOURCE_ID
   INNER JOIN PP_D_UOW_SOURCE_REF USR ON SRT.SOURCE_REF_TYPE_ID =
   USR.SOURCE_REF_TYPE_ID
   WHERE S.SOURCE_NAME = 'MANAGE WORK STG'
   AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE';


commit;
---FUTURE DATES
BEGIN
   FOR RECS IN 
     (
WITH DAYS AS
(SELECT TRUNC(SYSDATE) + ROWNUM missing_date
 FROM ALL_OBJECTS
 WHERE ROWNUM < 4000)
SELECT
  DAYS.missing_date
FROM
  DAYS
  ) LOOP
insert into PP_D_DATES 
        (D_DATE,d_month,d_month_name,d_day,d_day_name,
         d_day_of_week,d_day_of_month,d_day_of_year,d_year,d_month_num,
         d_week_of_year,D_WEEK_OF_MONTH,WEEKEND_FLAG)
      values 
        (RECS.missing_date,to_char(RECS.missing_date,'Mon'),to_char(RECS.missing_date,'FMMonth'),to_char(RECS.missing_date,'Dy'), to_char(RECS.missing_date,'Day'),
         to_char(RECS.missing_date,'D'),to_char(RECS.missing_date,'DD'),to_char(RECS.missing_date,'DDD'),to_char(RECS.missing_date,'YYYY'),to_char(RECS.missing_date,'MM'),
         to_char(RECS.missing_date,'IW'),TO_CHAR(RECS.missing_date,'W'),case when TO_CHAR(RECS.missing_date,'D') in('1','7') then 'Y' else 'N' end);
    end loop;
    commit;
    
  end;

/
