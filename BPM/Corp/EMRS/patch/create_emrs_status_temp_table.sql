CREATE TABLE emrs_t_client_status_temp
(client_number NUMBER(*,0)
 ,plan_type_id NUMBER(*,0)
 ,sub_program_id NUMBER(*,0)
 ,enrollment_status_id NUMBER(*,0)
 ,eligibility_status_code VARCHAR2(1))
 TABLESPACE MAXDAT_DATA;
  
CREATE INDEX IDX2_CLIENTELIG ON emrs_d_client_plan_eligibility(client_number, plan_type_id,sub_program_id) TABLESPACE MAXDAT_INDX;            

CREATE INDEX IDX3_CLIENTELIG ON emrs_d_client_plan_eligibility(date_created) TABLESPACE MAXDAT_INDX;            

CREATE INDEX IDX2_CLIENTENRL ON emrs_d_client_plan_enrl_status(client_number, plan_type_id) TABLESPACE MAXDAT_INDX;           

CREATE INDEX IDX3_CLIENTENRL ON emrs_d_client_plan_enrl_status(date_created) TABLESPACE MAXDAT_INDX;           

CREATE INDEX IDX1_ENROLLMENT ON emrs_f_enrollment(source_record_id) TABLESPACE MAXDAT_INDX;            

CREATE INDEX IDX1_ENROLLSTG ON emrs_s_enrollment_stg(SOURCE_SELECTION_RECORD_ID) TABLESPACE MAXDAT_INDX;            

CREATE INDEX IDX1_CLIENTSTATUS_TEMP ON emrs_t_client_status_temp(client_number, plan_type_id) TABLESPACE MAXDAT_INDX;           