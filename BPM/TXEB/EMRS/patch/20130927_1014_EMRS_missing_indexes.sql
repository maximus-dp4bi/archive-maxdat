CREATE INDEX IDX1_CLIENTELIG ON EMRS_D_CLIENT_PLAN_ELIGIBILITY(client_number) TABLESPACE MAXDAT_INDX; 

CREATE INDEX IDX2_CLIENTELIG ON emrs_d_client_plan_eligibility(client_number, plan_type_id) TABLESPACE MAXDAT_INDX;            

CREATE INDEX IDX3_CLIENTELIG ON emrs_d_client_plan_eligibility(date_created) TABLESPACE MAXDAT_INDX;            

CREATE INDEX IDX1_CLIENTENRL ON EMRS_D_CLIENT_PLAN_ENRL_STATUS(client_number) TABLESPACE MAXDAT_INDX;  

CREATE INDEX IDX2_CLIENTENRL ON emrs_d_client_plan_enrl_status(client_number, plan_type_id) TABLESPACE MAXDAT_INDX;           

CREATE INDEX IDX3_CLIENTENRL ON emrs_d_client_plan_enrl_status(date_created) TABLESPACE MAXDAT_INDX;           

CREATE INDEX IDX1_ADDRESS ON emrs_d_address(source_record_id) TABLESPACE MAXDAT_INDX;  

CREATE INDEX IDX1_ENROLLMENT ON emrs_f_enrollment(source_record_id) TABLESPACE MAXDAT_INDX; 

