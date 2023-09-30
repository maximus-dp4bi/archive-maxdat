


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
 
commit;

INSERT INTO PP_D_SOURCE SELECT 1, 'NYHIX MANAGE WORK STG', 'New York HIX MAXDAT Manage Work Staging Table - Task Create Date to Complete Date' FROM DUAL;
INSERT INTO PP_D_SOURCE SELECT 2, 'NYHIX MAIL/FAX BATCH STG', 'New York HIX MAXDAT Mail/Fax Batch Staging Table - Review Batch Start Date to End Date.' FROM DUAL;
INSERT INTO PP_D_SOURCE SELECT 3, 'NYHIX MAIL/FAX BATCH SCAN', 'New York HIX MAXDAT Mail/Fax Batch Staging Table - Activity Scan Start to Scan End.' FROM DUAL;
COMMIT;

INSERT INTO PP_D_SOURCE_REF_TYPE SELECT 1, 'TASK TYPE', 1 FROM DUAL;
INSERT INTO PP_D_SOURCE_REF_TYPE SELECT 2, 'BATCH TYPE', 2 FROM DUAL;
INSERT INTO PP_D_SOURCE_REF_TYPE SELECT 3, 'BATCH CLASS', 3 FROM DUAL;
commit;


INSERT INTO PP_D_UOW_SOURCE_REF SELECT 1, 1, 2, 'Application Only', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 2, 2, 2, 'Verification Documents Only', 'BATCH TYPE', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 3, 3, 2, 'Scan Incoming', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 4, 4, 1, 'DPR - SHOP Employer Task', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 5, 5, 1, 'DPR - Account Correction', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 6, 7, 1, 'Existing Appeal', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 7, 6, 1, 'DPR - Complaint', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 8, 7, 1, 'Appeal', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 9, 7, 1, 'IDR Incident Open', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 10, 7, 1, 'Appeal Incident Open', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 11, 7, 1, 'Refer to ES-C', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 12, 7, 1, 'Schedule Hearing', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 13, 8, 1, 'Data Entry Task', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
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
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 36, 2, 1, 'Data Entry-SHOP Employer Task', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 37, 2, 1, 'Data Entry-SHOP Employee Task', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 38, 2, 1, 'Link Doc Set QC Task', 'TASK ID', TO_DATE('20130701','YYYYMMDD'), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
commit;

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


BEGIN
  FOR RECS IN (WITH DAYS AS
                  (SELECT TRUNC(SYSDATE) + ROWNUM missing_date
                    FROM ALL_OBJECTS
                   WHERE ROWNUM < 3000)
                 SELECT DAYS.missing_date FROM DAYS) LOOP
    insert into PP_D_DATES
      (D_DATE,
       d_month,
       d_month_name,
       d_day,
       d_day_name,
       d_day_of_week,
       d_day_of_month,
       d_day_of_year,
       d_year,
       d_month_num,
       d_week_of_year,
       D_WEEK_OF_MONTH,
       WEEKEND_FLAG)
    values
      (RECS.missing_date,
       to_char(RECS.missing_date, 'Mon'),
       to_char(RECS.missing_date, 'FMMonth'),
       to_char(RECS.missing_date, 'Dy'),
       to_char(RECS.missing_date, 'Day'),
       to_char(RECS.missing_date, 'D'),
       to_char(RECS.missing_date, 'DD'),
       to_char(RECS.missing_date, 'DDD'),
       to_char(RECS.missing_date, 'YYYY'),
       to_char(RECS.missing_date, 'MM'),
       to_char(RECS.missing_date, 'IW'),
       TO_CHAR(RECS.missing_date, 'W'),
       case when TO_CHAR(RECS.missing_date, 'D') in ('1', '7') then 'Y' else 'N' end);
  end loop;
  commit;

end;


/