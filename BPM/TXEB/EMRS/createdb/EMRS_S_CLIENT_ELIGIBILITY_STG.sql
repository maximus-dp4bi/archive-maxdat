CREATE TABLE emrs_s_client_eligibility_stg
(client_plan_eligibility_id NUMBER(*,0)
 ,client_number NUMBER(*,0)
 ,date_of_Validity_start DATE
 ,date_of_validity_end DATE
 ,version NUMBER(*,0)
 ,source_record_id NUMBER(*,0)
 ,plan_type_cd VARCHAR2(32)
 ,sub_program_code VARCHAR2(32)
 ,eligibility_status_code VARCHAR2(32)
 ,program_cd VARCHAR2(32)
 ,upd_client_plan_elig_id NUMBER(*,0)
 ,reasons VARCHAR2(256)
 ,mvx_core_reason VARCHAR2(256)
 ,sub_status_codes VARCHAR2(32)
 ,disposition_cd VARCHAR2(32))
 SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "MAXDAT_DATA" ;
  
 CREATE INDEX IDX1_ELIGSTG ON emrs_s_client_eligibility_stg(SOURCE_RECORD_ID) TABLESPACE MAXDAT_INDX;            
 CREATE INDEX IDX2_ELIGSTG ON emrs_s_client_eligibility_stg(CLIENT_NUMBER,PLAN_TYPE_CD,SUB_PROGRAM_CODE) TABLESPACE MAXDAT_INDX;            