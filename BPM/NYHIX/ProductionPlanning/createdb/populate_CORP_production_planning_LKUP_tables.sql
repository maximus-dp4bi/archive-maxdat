--Insert into UOW Config 
insert into maxdat.pp_cfg_unit_of_work values (1, 'NYHIX_HSDE1', 'N', 'Minutes',2, 'BUS', 15, 'HSDE1');
insert into maxdat.pp_cfg_unit_of_work values (2, 'NYHIX_HSDE2', 'N', 'Minutes',2, 'BUS', 3, 'HSDE2');
insert into maxdat.pp_cfg_unit_of_work values (3, 'NYHIX_IMAGING_KQC', 'N', 'Minutes',1, 'BUS', 2, 'Imaging and K-QC');
insert into maxdat.pp_cfg_unit_of_work values (4, 'NYHIX_SHOPAPP', 'N', 'Minutes',2, 'CAL', 15, 'SHOP');
insert into maxdat.pp_cfg_unit_of_work values (5, 'NYHIX_DOCRES_ACCTCORR', 'N', 'Minutes',1, 'CAL', 3, 'Account Correction');
insert into maxdat.pp_cfg_unit_of_work values (6, 'NYHIX_COMPLAINT', 'N', 'Minutes',7, 'CAL', 10, 'Complaints');
insert into maxdat.pp_cfg_unit_of_work values (7, 'NYHIX_APPEAL', 'N', 'Minutes',2, 'CAL', 3, 'Appeals');
insert into maxdat.pp_cfg_unit_of_work values (8, 'NYHIX_DATAENTRY', 'N', 'Minutes',3, 'CAL', 15, 'Data Entry');
insert into maxdat.pp_cfg_unit_of_work values (9, 'NYHIX_DOCRES1', 'N', 'Minutes',1, 'CAL', 2, 'Doc Resolution 1');
insert into maxdat.pp_cfg_unit_of_work values (10, 'NYHIX_DOCRES2', 'N', 'Minutes',7, 'CAL', 15, 'Doc Resolution 2');
insert into maxdat.pp_cfg_unit_of_work values (11, 'NYHIX_LINKING', 'N', 'Minutes',1, 'CAL', 3, 'Linking');
insert into maxdat.pp_cfg_unit_of_work values (12, 'NYHIX_SHOPFM', 'N', 'Minutes',7, 'CAL', 15, 'FM');
insert into maxdat.pp_cfg_unit_of_work values (13, 'NYHIX_OTHER', 'N', 'Minutes',7, 'CAL', 15, 'Other');
insert into maxdat.pp_cfg_unit_of_work values (14, 'NYHIX_QC', 'N', 'Minutes',2, 'CAL', 3, 'QC');

--Insert into UOW Lookup
insert into maxdat.pp_d_unit_of_work values (1, 'NYHIX_HSDE1', 'Minutes',2, 'HSDE1');
insert into maxdat.pp_d_unit_of_work values (2, 'NYHIX_HSDE2', 'Minutes',2, 'HSDE2');
insert into maxdat.pp_d_unit_of_work values (3, 'NYHIX_IMAGING_KQC', 'Minutes',1, 'Imaging and K-QC');
insert into maxdat.pp_d_unit_of_work values (4, 'NYHIX_SHOPAPP', 'Minutes',2, 'SHOP');
insert into maxdat.pp_d_unit_of_work values (5, 'NYHIX_DOCRES_ACCTCORR', 'Minutes',1, 'Account Correction');
insert into maxdat.pp_d_unit_of_work values (6, 'NYHIX_COMPLAINT', 'Minutes',7, 'Complaints');
insert into maxdat.pp_d_unit_of_work values (7, 'NYHIX_APPEAL', 'Minutes',2, 'Appeals');
insert into maxdat.pp_d_unit_of_work values (8, 'NYHIX_DATAENTRY', 'Minutes',3, 'Data Entry');
insert into maxdat.pp_d_unit_of_work values (9, 'NYHIX_DOCRES1', 'Minutes',1, 'Doc Resolution 1');
insert into maxdat.pp_d_unit_of_work values (10, 'NYHIX_DOCRES2', 'Minutes',7, 'Doc Resolution 2');
insert into maxdat.pp_d_unit_of_work values (11, 'NYHIX_LINKING', 'Minutes',1, 'Linking');
insert into maxdat.pp_d_unit_of_work values (12, 'NYHIX_SHOPFM', 'Minutes',7, 'FM');
insert into maxdat.pp_d_unit_of_work values (13, 'NYHIX_OTHER', 'Minutes',7, 'Other');
insert into maxdat.pp_d_unit_of_work values (14, 'NYHIX_QC', 'Minutes',2, 'QC');

commit;


--Insert into Geography Config
insert into maxdat.pp_cfg_geography_config
  (cfg_geography_config_id, site_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values
  (1, 'ALBANY', 'EAST', 'NY', 'ALBANY COUNTY', NULL, 'US', TRUNC(SYSDATE-1), TO_DATE('07/07/7777','MM/DD/YYYY'));


INSERT INTO MAXDAT.PP_CFG_PROGRAM_CONFIG
    (CFG_PROGRAM_CONFIG_ID, PROGRAM_NAME)
  VALUES
    (1,'NY HBE');

--PROVINCE  
INSERT INTO MAXDAT.PP_D_PROVINCE
  (PROVINCE_ID, PROVINCE_NAME)
VALUES
  (1, 'ALBANY COUNTY');
--SITE
INSERT INTO MAXDAT.PP_D_SITE
  (SITE_ID, SITE_NAME)
VALUES
  (1, 'ALBANY');
--DISTRICT
INSERT INTO MAXDAT.PP_D_DISTRICT
  (DISTRICT_ID, DISTRICT_NAME)
VALUES
  (1, NULL);
--STATE
INSERT INTO MAXDAT.PP_D_STATE
  (STATE_ID, STATE_NAME)
VALUES
  (1, 'NY');
--REGION
INSERT INTO MAXDAT.PP_D_REGION
  (REGION_ID, REGION_NAME)
VALUES
  (1, 'EAST');
--COUNTRY  
INSERT INTO MAXDAT.PP_D_COUNTRY
  (COUNTRY_ID, COUNTRY_NAME)
VALUES
  (1, 'US');
--GEO MASTER  
INSERT INTO MAXDAT.PP_D_GEOGRAPHY_MASTER
  (GEOGRAPHY_MASTER_ID, GEOGRAPHY_NAME, COUNTRY_ID, STATE_ID, PROVINCE_ID, DISTRICT_ID, REGION_ID, SITE_ID)
VALUES
  (1, 'NYHIX', 1, 1, 1, 1, 1, 1);    
  
COMMIT;  

insert into maxdat.pp_d_program
  (program_id, program_name)
values
  (1, 'NY HBE');
  
  


insert into maxdat.pp_d_segment
  (segment_id, segment_name)
values
  (1, 'Health Services');

  
insert into maxdat.pp_d_project
  (project_id, project_name, segment_id)
values
  (1, 'NY Health Benefits Exchange', 1);
  
  
insert into maxdat.pp_d_production_plan
  (pp_id, production_plan_name, production_plan_description, project_id, program_id, geography_master_id, effective_date, end_date, pp_create_date, pp_last_update_date)
values
  (1, 'NYHIX_PROD_PLAN', 'NYHIX_PROD_PLAN', 1, 1, 1, SYSDATE, TO_DATE('07/07/7777','MM/DD/YYYY'), SYSDATE, SYSDATE);
  
COMMIT;    
  
  
  
  
  
--Insert into Project Config  
insert into maxdat.pp_cfg_project_config
  (cfg_project_config_id, segment_name, project_name, program_name, create_date, last_update_date)
values
  (1, 'Health Services', 'NY Health Benefits Exchange', 'NY HBE', sysdate, sysdate);


  

--Insert into Production Plan 
insert into maxdat.pp_cfg_production_plan
  (cfg_production_plan_id, cfg_geography_config_id, cfg_project_config_id, production_plan_name, production_plan_description, effective_date, end_date, create_date, last_update_date)
values
  (1, 1, 1, 'NYHIX_PROD_PLAN', 'NYHIX_PROD_PLAN', TRUNC(SYSDATE-1), null, SYSDATE, SYSDATE);
  
INSERT INTO MAXDAT.PP_CFG_SOURCE_CONFIG
  (CFG_SOURCE_CONFIG_ID, SOURCE_NAME, SOURCE_DESCRIPTION)
VALUES
  (1, 'NYHIX MANAGE WORK STG', 'New York HIX MAXDAT Manage Work Staging Table - Task Create Date to Completed Date.');

INSERT INTO MAXDAT.PP_CFG_SOURCE_CONFIG
  (CFG_SOURCE_CONFIG_ID, SOURCE_NAME, SOURCE_DESCRIPTION)
VALUES
  (2, 'NYHIX MAIL/FAX BATCH STG', 'New York HIX MAXDAT Mail/Fax Batch Staging Table - Review Batch Start Date to End Date.');
  
INSERT INTO MAXDAT.PP_CFG_SOURCE_CONFIG
  (CFG_SOURCE_CONFIG_ID, SOURCE_NAME, SOURCE_DESCRIPTION)
VALUES
  (3, 'NYHIX MAIL/FAX BATCH SCAN', 'New York HIX MAXDAT Mail/Fax Batch Staging Table - Activity Scan Start to Scan End.');  
  
--Insert into Forecast File Control 
insert into maxdat.pp_cfg_forecast_file_control
  (cfg_forecast_file_control_id, cfg_production_plan_id, file_location, inventory_filename, volume_filename, enabled, create_date, last_update_date)
values
  (1, 1, '/u01/maximus/maxdat-prd/NYHIX/ETL/Processing/ProductionPlanning/Forecast/', 'PP_NYHIX_INV_INI.TXT', 'PP_NYHIX_VOL_INI.TXT', 'Y', sysdate, sysdate);
  
--insert into maxdat.pp_cfg_actuals_file_control
  (cfg_actuals_file_control_id, project_id, program_id, geography_master_id, file_location, actuals_filename, enabled, create_date, last_update_date)
values
  (1, 1, 1, 1, '/u01/maximus/maxdat-prd/NYHIX/ETL/Processing/ProductionPlanning/Actuals/', 'PP_NYHIX_ACTUALS.TXT', 'Y', SYSDATE, SYSDATE);

  commit;
  /  
  
  
INSERT INTO MAXDAT.PP_D_DATES
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
  
  COMMIT;
  
  




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
 

INSERT INTO PP_D_SOURCE SELECT 1, 'NYHIX MANAGE WORK STG', 'New York HIX MAXDAT Manage Work Staging Table - Task Create Date to Complete Date' FROM DUAL;
INSERT INTO PP_D_SOURCE SELECT 2, 'NYHIX MAIL/FAX BATCH STG', 'New York HIX MAXDAT Mail/Fax Batch Staging Table - Review Batch Start Date to End Date.' FROM DUAL;
INSERT INTO PP_D_SOURCE SELECT 3, 'NYHIX MAIL/FAX BATCH SCAN', 'New York HIX MAXDAT Mail/Fax Batch Staging Table - Activity Scan Start to Scan End.' FROM DUAL;
COMMIT;
INSERT INTO PP_D_SOURCE_REF_TYPE SELECT 1, 'TASK TYPE', 1 FROM DUAL;
INSERT INTO PP_D_SOURCE_REF_TYPE SELECT 2, 'BATCH TYPE', 2 FROM DUAL;
INSERT INTO PP_D_SOURCE_REF_TYPE SELECT 3, 'BATCH CLASS', 3 FROM DUAL;



INSERT INTO PP_D_UOW_SOURCE_REF SELECT 1, 1, 2, 'Application Only', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 2, 2, 2, 'Verification Documents Only', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 3, 3, 3, 'Scan Incoming', 'BATCH CLASS', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 4, 4, 1, 'DPR - SHOP Employer Task', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 5, 5, 1, 'DPR - Account Correction', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 6, 7, 1, 'Existing Appeal', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 7, 6, 1, 'DPR - Complaint', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 8, 7, 1, 'Appeal', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 9, 7, 1, 'IDR Incident Open', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 10, 7, 1, 'Appeal Incident Open', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 11, 7, 1, 'Refer to ES-C', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 12, 7, 1, 'Schedule Hearing', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 14, 8, 1, 'Application In Process', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 15, 9, 1, 'HSDE-QC VHT', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 16, 9, 1, 'DPR - Free Form Follow-Up', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 17, 10, 1, 'Returned Mail Data Entry Task', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 18, 10, 1, 'Returned Mail - Application', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 19, 10, 1, 'DPR - Orphan Document', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 20, 9, 1, 'DPR - Wrong Program', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 21, 11, 1, 'Link Document Set', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 22, 12, 1, 'Financial Management', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 23, 12, 1, 'FM Returned Mail', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 24, 13, 1, 'Other', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 25, 14, 1, 'NYHBE MAXIMUS QC Task', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 26, 1, 2, 'Application + Verification Documents', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL; 
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 27, 1, 2, 'Renewals Only', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL; 
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 28, 1, 2, 'Renewals + Verification Documents', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 29, 2, 2, 'Employer/Employee  Application Only', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL; 
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 30, 2, 2, 'Employer/Employee Application + Verification Documents', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 31, 2, 2, 'Returned Mail', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL; 
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 32, 2, 2, 'Incident', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 33, 2, 2, 'Non Standard', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 34, 2, 1, 'DPR - SHOP Employee Task', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 35, 2, 1, 'Data Entry-Verification Document Task', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 38, 2, 1, 'Link Doc Set QC Task', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 39, 5, 1, 'DPR - Other', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 40, 5, 1, 'DPR - Doc/Form Type Mismatch Task ', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 41, 5, 1, 'DPR - Document Problem Resolution', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;


CREATE OR REPLACE VIEW PP_D_UOW_MW_SV AS
   SELECT USR.UOW_ID, USR.SOURCE_REF_VALUE AS TASK_TYPE
   FROM PP_D_SOURCE_REF_TYPE SRT
   INNER JOIN PP_D_SOURCE S ON SRT.SOURCE_ID = S.SOURCE_ID
   INNER JOIN PP_D_UOW_SOURCE_REF USR ON SRT.SOURCE_REF_TYPE_ID =
   USR.SOURCE_REF_TYPE_ID
   WHERE S.SOURCE_NAME = 'NYHIX MANAGE WORK STG'
   AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE';

   CREATE OR REPLACE VIEW PP_D_UOW_MFB_SCAN_SV AS
   SELECT USR.UOW_ID, USR.SOURCE_REF_VALUE AS BATCH_CLASS
   FROM PP_D_SOURCE_REF_TYPE SRT
   INNER JOIN PP_D_SOURCE S ON SRT.SOURCE_ID = S.SOURCE_ID
   INNER JOIN PP_D_UOW_SOURCE_REF USR ON SRT.SOURCE_REF_TYPE_ID =
   USR.SOURCE_REF_TYPE_ID
   WHERE S.SOURCE_NAME = 'NYHIX MAIL/FAX BATCH SCAN'
   AND SRT.SOURCE_REF_TYPE_NAME = 'BATCH CLASS';

   CREATE OR REPLACE VIEW PP_D_UOW_MFB_RVW_SV AS
   SELECT USR.UOW_ID, USR.SOURCE_REF_VALUE AS BATCH_TYPE
   FROM PP_D_SOURCE_REF_TYPE SRT
   INNER JOIN PP_D_SOURCE S ON SRT.SOURCE_ID = S.SOURCE_ID
   INNER JOIN PP_D_UOW_SOURCE_REF USR ON SRT.SOURCE_REF_TYPE_ID =
   USR.SOURCE_REF_TYPE_ID
   WHERE S.SOURCE_NAME = 'NYHIX MAIL/FAX BATCH STG'
   AND SRT.SOURCE_REF_TYPE_NAME = 'BATCH TYPE';  

COMMIT;

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