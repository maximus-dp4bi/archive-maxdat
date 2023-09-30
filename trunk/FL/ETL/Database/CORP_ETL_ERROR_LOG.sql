--------------------------------------------------------
--  File created - Wednesday-May-29-2013   
--------------------------------------------------------
DROP TABLE CORP_ETL_ERROR_LOG;
/
--------------------------------------------------------
--  DDL for Table CORP_ETL_ERROR_LOG
--------------------------------------------------------

  CREATE TABLE "CORP_ETL_ERROR_LOG" 
  ("CEEL_ID" NUMBER, "ERR_DATE" DATE DEFAULT sysdate,
  "ERR_LEVEL" VARCHAR2(20) DEFAULT 'CRITICAL', 
  "PROCESS_NAME" VARCHAR2(120), 
  "JOB_NAME" VARCHAR2(120),
  "NR_OF_ERROR" NUMBER, 
  "ERROR_DESC" VARCHAR2(4000),
  "ERROR_FIELD" VARCHAR2(400), 
  "ERROR_CODES" VARCHAR2(400), 
  "CREATE_TS" DATE,
  "UPDATE_TS" DATE, 
  "DRIVER_TABLE_NAME" VARCHAR2(100),
  "DRIVER_KEY_NUMBER" NUMBER) ;
/
   COMMENT ON COLUMN "CORP_ETL_ERROR_LOG"."ERR_DATE" IS 'Date of Error, Defaults to System date';
   COMMENT ON COLUMN "CORP_ETL_ERROR_LOG"."ERR_LEVEL" IS 'Level or error - ABORT,CRITICAL,LOG Defaults to CRITICAL';
   COMMENT ON COLUMN "CORP_ETL_ERROR_LOG"."PROCESS_NAME" IS 'Name of process, this should identify what workbook the error came from';
   COMMENT ON COLUMN "CORP_ETL_ERROR_LOG"."JOB_NAME" IS 'Name of Job or Transformation';
   COMMENT ON COLUMN "CORP_ETL_ERROR_LOG"."NR_OF_ERROR" IS 'Corresponds to the Kettle Error filed of the same name';
   COMMENT ON COLUMN "CORP_ETL_ERROR_LOG"."ERROR_DESC" IS 'Corresponds to the Kettle Error filed of the same name';
   COMMENT ON COLUMN "CORP_ETL_ERROR_LOG"."ERROR_FIELD" IS 'Corresponds to the Kettle Error filed of the same name';
   COMMENT ON COLUMN "CORP_ETL_ERROR_LOG"."ERROR_CODES" IS 'Corresponds to the Kettle Error filed of the same name';
   COMMENT ON COLUMN "CORP_ETL_ERROR_LOG"."DRIVER_TABLE_NAME" IS 'Documents';
   COMMENT ON COLUMN "CORP_ETL_ERROR_LOG"."DRIVER_KEY_NUMBER" IS 'DCN';
/
--------------------------------------------------------
--  DDL for Index CORP_ETL_ERROR_LOG_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CORP_ETL_ERROR_LOG_PK" ON "CORP_ETL_ERROR_LOG" ("CEEL_ID") ;
/
--------------------------------------------------------
--  Constraints for Table CORP_ETL_ERROR_LOG
--------------------------------------------------------

  ALTER TABLE "CORP_ETL_ERROR_LOG" ADD CONSTRAINT "ERR_LEVEL_CHK" CHECK (err_level in ('ABORT','CRITICAL', 'LOG')) ENABLE;
  ALTER TABLE "CORP_ETL_ERROR_LOG" ADD CONSTRAINT "CORP_ETL_ERROR_LOG_PK" PRIMARY KEY ("CEEL_ID") ENABLE;
  ALTER TABLE "CORP_ETL_ERROR_LOG" MODIFY ("UPDATE_TS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_ERROR_LOG" MODIFY ("CREATE_TS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_ERROR_LOG" MODIFY ("JOB_NAME" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_ERROR_LOG" MODIFY ("PROCESS_NAME" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_ERROR_LOG" MODIFY ("ERR_LEVEL" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_ERROR_LOG" MODIFY ("ERR_DATE" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_ERROR_LOG" MODIFY ("CEEL_ID" NOT NULL ENABLE);
/
CREATE SEQUENCE  "SEQ_CEEL_ID"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
/
--------------------------------------------------------
--  DDL for Trigger TRG_BIUR_CORP_ETL_ERROR_LOG
--------------------------------------------------------

 CREATE OR REPLACE TRIGGER "TRG_BIUR_CORP_ETL_ERROR_LOG" 
 BEFORE INSERT OR UPDATE
 ON CORP_ETL_ERROR_LOG
 FOR EACH ROW
Begin
        If Inserting Then
                If :new.ceel_Id Is Null Then
                        Select Seq_ceel_Id.Nextval
                          Into :NEW.ceel_Id
                          From Dual;
                End If;
        IF :NEW.create_ts IS NULL THEN
                   :NEW.create_ts := SYSDATE;
                END IF;
        End If;
        :NEW.update_ts := SYSDATE;
End;
/
ALTER TRIGGER "TRG_BIUR_CORP_ETL_ERROR_LOG" ENABLE;
/
