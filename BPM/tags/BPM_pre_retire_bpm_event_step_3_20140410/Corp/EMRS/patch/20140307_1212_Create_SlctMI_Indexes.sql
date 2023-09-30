CREATE INDEX "SLCTMI_SLCTTRANS_FK_I" ON "EMRS_D_SELECTION_MISSING_INFO" ("SELECTION_TRANSACTION_ID") TABLESPACE "MAXDAT_INDX" ;

CREATE INDEX "SLCTMI_REJREASON_FK_I" ON "EMRS_D_SELECTION_MISSING_INFO" ("REJECTION_ERROR_REASON_ID") TABLESPACE "MAXDAT_INDX" ;

CREATE INDEX "SLCTMI_ENRERRORCODE_FK_I" ON "EMRS_D_SELECTION_MISSING_INFO" ("ENROLLMENT_ERROR_CODE_ID") TABLESPACE "MAXDAT_INDX" ;
