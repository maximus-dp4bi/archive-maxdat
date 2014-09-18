--------------------------------------------------------
--  DDL for Table EMRS_D_ENROLLMENT_REJECTION
--------------------------------------------------------

  CREATE TABLE "EMRS_D_ENROLLMENT_REJECTION" 
   (	"ENROLLMENT_ID" NUMBER(22,0), 
	"REJECTION_ERROR_REASON_ID" NUMBER(22,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "MAXDAT_DATA" ;
