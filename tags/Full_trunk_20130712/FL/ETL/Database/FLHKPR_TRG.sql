--------------------------------------------------------
--  File created - Thursday-April-25-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger FLHKPR_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "FLCST0_MAXDAT"."FLHKPR_TRG" before insert on "FLHK_ETL_PROCESS_LETTERS"    for each row begin     if inserting then       if :NEW."PK_ID" is null then          select SEQ_FLHKPR.nextval into :NEW."PK_ID" from dual;       end if;    end if; end;
/
ALTER TRIGGER "FLCST0_MAXDAT"."FLHKPR_TRG" ENABLE;
