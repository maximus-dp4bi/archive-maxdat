--------------------------------------------------------
--  File created - Thursday-June-27-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HOLIDAYS
--------------------------------------------------------

  CREATE TABLE "HOLIDAYS" ("HOLIDAY_ID" NUMBER, 
  "CREATED_BY" VARCHAR2(80), 
  "HOLIDAY_YEAR" NUMBER(4,0), 
  "DESCRIPTION" VARCHAR2(128),
  "CREATE_TS" DATE,
  "UPDATED_BY" VARCHAR2(80),
  "UPDATE_TS" DATE, 
  "HOLIDAY_DATE" DATE) ;
/
--------------------------------------------------------
--  DDL for Index HOLIDAYS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "HOLIDAYS_PK" ON "HOLIDAYS" ("HOLIDAY_ID") ;
/
--------------------------------------------------------
--  Constraints for Table HOLIDAYS
--------------------------------------------------------

  ALTER TABLE "HOLIDAYS" MODIFY ("HOLIDAY_ID" NOT NULL ENABLE);
  ALTER TABLE "HOLIDAYS" ADD CONSTRAINT "HOLIDAYS_PK" PRIMARY KEY ("HOLIDAY_ID") ENABLE;
/
--------------------------------------------------------
--  DDL for Trigger HOLIDAYS_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "HOLIDAYS_TRG" before insert on "HOLIDAYS"    for each row begin    
  if inserting then       
     if :NEW."HOLIDAY_ID" is null then          
        select HOLIDAYS_SEQ.nextval into :NEW."HOLIDAY_ID" from dual;
     end if;
  end if;
  end;
/
ALTER TRIGGER "HOLIDAYS_TRG" ENABLE;
/
