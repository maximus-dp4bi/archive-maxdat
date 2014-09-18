--------------------------------------------------------
--  Constraints for Table EMRS_D_ZIPCODE
--------------------------------------------------------

  ALTER TABLE "EMRS_D_ZIPCODE" ADD CONSTRAINT "ZIPCODEPK" PRIMARY KEY ("ZIPCODE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;
