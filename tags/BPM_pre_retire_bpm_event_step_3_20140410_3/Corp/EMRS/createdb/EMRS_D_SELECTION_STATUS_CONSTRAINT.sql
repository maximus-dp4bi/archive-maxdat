--------------------------------------------------------
--  Constraints for Table EMRS_D_SELECTION_STATUS
--------------------------------------------------------

  ALTER TABLE "EMRS_D_SELECTION_STATUS" ADD CONSTRAINT "SLCTSTATUSPK" PRIMARY KEY ("SELECTION_STATUS_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;
