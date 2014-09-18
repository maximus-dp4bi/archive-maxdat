CREATE TABLE emrs_s_client_status_stg
(client_enroll_status_id NUMBER(*,0)
 ,client_number NUMBER(*,0)
 ,date_of_Validity_start DATE
 ,date_of_validity_end DATE
 ,version NUMBER(*,0)
 ,source_record_id NUMBER(*,0)
 ,plan_type_cd VARCHAR2(32)
 ,enroll_status_cd VARCHAR2(32)
 ,program_cd VARCHAR2(32)
 ,upd_client_enroll_status_id NUMBER(*,0))
 SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "MAXDAT_DATA" ;
  
 CREATE INDEX IDX1_ENRLSTATUSSTG ON emrs_s_client_status_stg(SOURCE_RECORD_ID) TABLESPACE MAXDAT_INDX;            
 CREATE INDEX IDX2_ENRLSTATUSSTG ON emrs_s_client_status_stg(CLIENT_NUMBER,PLAN_TYPE_CD) TABLESPACE MAXDAT_INDX;            