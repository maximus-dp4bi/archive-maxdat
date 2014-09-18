--------------------------------------------------------
--  Constraints for Table EMRS_D_ADDRESS
--------------------------------------------------------

  ALTER TABLE "EMRS_D_ADDRESS" ADD CONSTRAINT "ADDRESSPK" PRIMARY KEY ("ADDRESS_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;
