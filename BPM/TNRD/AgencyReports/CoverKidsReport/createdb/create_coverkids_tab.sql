CREATE TABLE COVERKIDS_APPROVAL_STG(application_id NUMBER
            ,app_individual_id  NUMBER
            ,client_id NUMBER
            ,case_id NUMBER
            ,create_date DATE
            ,cumulative_ind VARCHAR2(1)
            ,letter_mailed_date DATE
				    ,effective_date_str VARCHAR2(10)
				    ,directive VARCHAR2(20)
            ,home_phone_number VARCHAR2(20)
            ,home_phone_type_cd VARCHAR2(2)
            ,st_reported_phone VARCHAR2(20)
            ,st_phone_type_cd VARCHAR2(2)
            ,other_phone_number VARCHAR2(20)
            ,other_phone_type VARCHAR2(2)
            ,pregnancy VARCHAR2(1)
            ,income_amount NUMBER
            ,income_frequency VARCHAR2(15)
            ,household_size NUMBER
            ) TABLESPACE MAXDAT_DATA;
                                    
CREATE INDEX CKIDS_APPR_IDX01 ON COVERKIDS_APPROVAL_STG(application_id) TABLESPACE MAXDAT_INDX;  
CREATE INDEX CKIDS_APPR_IDX02 ON coverkids_approval_stg(letter_mailed_date) TABLESPACE MAXDAT_INDX;
CREATE INDEX CKIDS_APPR_IDX03 ON coverkids_approval_stg(create_date) TABLESPACE MAXDAT_INDX;
CREATE INDEX CKIDS_APPR_IDX04 ON coverkids_approval_stg(cumulative_ind) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON COVERKIDS_APPROVAL_STG to MAXDAT_READ_ONLY;