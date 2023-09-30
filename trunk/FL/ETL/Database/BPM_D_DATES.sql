--------------------------------------------------------
--  File created - Thursday-September-12-2013   
--------------------------------------------------------
DROP TABLE "BPM_D_DATES";
--------------------------------------------------------
--  DDL for Table BPM_D_DATES
--------------------------------------------------------

  CREATE TABLE "BPM_D_DATES" 
  ("D_DATE" DATE,
 "D_MONTH" VARCHAR2(12),
 "D_MONTH_NAME" VARCHAR2(36),
 "D_DAY" VARCHAR2(12),
 "D_DAY_NAME" VARCHAR2(36),
 "D_DAY_OF_WEEK" VARCHAR2(1),
 "D_DAY_OF_MONTH" VARCHAR2(2),
 "D_DAY_OF_YEAR" VARCHAR2(3),
 "D_YEAR" VARCHAR2(4),
 "D_MONTH_NUM" VARCHAR2(2),
 "D_WEEK_OF_YEAR" VARCHAR2(2),
 "D_WEEK_OF_MONTH" VARCHAR2(1),
 "WEEKEND_FLAG" CHAR(1))
/
--------------------------------------------------------
--  DDL for Index BPM_D_DATES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BPM_D_DATES_PK" ON "BPM_D_DATES" ("D_DATE")
/
--------------------------------------------------------
--  Constraints for Table BPM_D_DATES
--------------------------------------------------------

  ALTER TABLE "BPM_D_DATES" ADD CONSTRAINT "BPM_D_DATES_PK" PRIMARY KEY ("D_DATE") ENABLE
/
