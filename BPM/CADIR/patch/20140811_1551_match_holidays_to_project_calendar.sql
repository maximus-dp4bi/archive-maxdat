-- Script to fix CADIR holidays  DWD 8/11/14
-- Add Cesar Chavez Day Observed
INSERT INTO holidays VALUES (501,2014,to_date('31-mar-2014','DD-MON-YYYY'),'Cesar Chavez Day Observed','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
INSERT INTO holidays VALUES (502,2015,to_date('31-mar-2015','DD-MON-YYYY'),'Cesar Chavez Day Observed','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
INSERT INTO holidays VALUES (503,2016,to_date('31-mar-2016','DD-MON-YYYY'),'Cesar Chavez Day Observed','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
INSERT INTO holidays VALUES (504,2017,to_date('31-mar-2017','DD-MON-YYYY'),'Cesar Chavez Day Observed','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
INSERT INTO holidays VALUES (505,2018,to_date('31-mar-2018','DD-MON-YYYY'),'Cesar Chavez Day Observed','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
INSERT INTO holidays VALUES (506,2019,to_date('01-apr-2019','DD-MON-YYYY'),'Cesar Chavez Day Observed','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
INSERT INTO holidays VALUES (507,2020,to_date('31-mar-2020','DD-MON-YYYY'),'Cesar Chavez Day Observed','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
-- Add Day afrer thanksgiving
INSERT INTO holidays VALUES (508,2014,to_date('28-nov-2014','DD-MON-YYYY'),'Day after Thanksgiving','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
INSERT INTO holidays VALUES (509,2015,to_date('27-nov-2015','DD-MON-YYYY'),'Day after Thanksgiving','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
INSERT INTO holidays VALUES (510,2016,to_date('25-nov-2016','DD-MON-YYYY'),'Day after Thanksgiving','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
INSERT INTO holidays VALUES (511,2017,to_date('24-nov-2017','DD-MON-YYYY'),'Day after Thanksgiving','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
INSERT INTO holidays VALUES (512,2018,to_date('23-nov-2018','DD-MON-YYYY'),'Day after Thanksgiving','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
INSERT INTO holidays VALUES (513,2019,to_date('29-nov-2019','DD-MON-YYYY'),'Day after Thanksgiving','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
INSERT INTO holidays VALUES (514,2020,to_date('27-nov-2020','DD-MON-YYYY'),'Day after Thanksgiving','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);

-- Remove Columbus Day
DELETE FROM holidays WHERE DESCRIPTION = 'Columbus Day';

-- Fix President's Day  (really messed up)
UPDATE holidays SET DESCRIPTION = 'Presidents Day'
   WHERE DESCRIPTION = 'Washingtons Birthday';
UPDATE holidays SET DESCRIPTION = 'Presidents Day'
   WHERE DESCRIPTION = 'Washington Birthday';
UPDATE holidays SET DESCRIPTION = 'Presidents Day'
   WHERE DESCRIPTION = 'Washington''s Birthday (Observed)';
INSERT INTO holidays VALUES (515,2015,to_date('16-feb-2015','DD-MON-YYYY'),'Presidents Day','MAXDAT',SYSDATE,'MAXDAT',SYSDATE);
COMMIT;