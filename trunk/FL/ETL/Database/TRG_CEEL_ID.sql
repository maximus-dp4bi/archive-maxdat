--------------------------------------------------------
--  File created - Thursday-April-25-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger TRG_CEEL_ID
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "FLCST0_MAXDAT"."TRG_CEEL_ID" before insert on "CORP_ETL_ERROR_LOG"    for each row begin     if inserting then       if :NEW."CEEL_ID" is null then          select CEEL_ID_SEQ.nextval into :NEW."CEEL_ID" from dual;       end if;    end if; end;
/
ALTER TRIGGER "FLCST0_MAXDAT"."TRG_CEEL_ID" ENABLE;
