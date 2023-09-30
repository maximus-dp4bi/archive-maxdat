--------------------------------------------------------
--  DDL for Index ENROLL_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ENROLL_PK" ON "EMRS_F_ENROLLMENT" ("ENROLLMENT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;

  CREATE INDEX IDX1_ENROLLMENT ON emrs_f_enrollment(source_record_id) TABLESPACE MAXDAT_INDX;            

  CREATE INDEX IDX2_ENRLCASENUM ON EMRS_F_ENROLLMENT(CASE_NUMBER) TABLESPACE MAXDAT_INDX;

  CREATE INDEX IDX3_ENRLPROVIDERNUM ON EMRS_F_ENROLLMENT(PROVIDER_NUMBER) TABLESPACE MAXDAT_INDX;

  CREATE INDEX IDX4_ENRLCLIENTNUM ON EMRS_F_ENROLLMENT(CLIENT_NUMBER) TABLESPACE MAXDAT_INDX;
  
  CREATE INDEX IDX5_ENRLSTARTDT ON EMRS_F_ENROLLMENT(MANAGED_CARE_START_DATE) TABLESPACE MAXDAT_INDX;
  
  CREATE INDEX IDX6_ENRLENDDT ON EMRS_F_ENROLLMENT(MANAGED_CARE_END_DATE) TABLESPACE MAXDAT_INDX;