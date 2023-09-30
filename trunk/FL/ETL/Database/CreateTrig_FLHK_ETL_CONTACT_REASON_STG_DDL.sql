--------------------------------------------------------
--  File created - Friday-February-02-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger FLHK_ETL_CRS_TRG (Contact Reason Stage)
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "FLCPD0_MAXDAT"."FLHK_ETL_CRS_TRG" 
   before insert on "FLHK_ETL_CONTACT_REASON_STG" 
   for each row 
begin  
   if inserting then 
      if :NEW."FECR_ID" is null then 
         select FLHK_ETL_CRS_SEQ.nextval into :NEW."FECR_ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "FLCPD0_MAXDAT"."FLHK_ETL_CRS_TRG" ENABLE;
