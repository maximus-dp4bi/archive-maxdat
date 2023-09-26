CREATE TABLE tn_coverkids_exception
(application_id NUMBER
,client_id NUMBER
,case_id NUMBER
,effective_date DATE
,letter_id NUMBER
,directive VARCHAR2(32)
,exception_comments VARCHAR2(2000)
,create_date DATE
,update_date DATE
,created_by VARCHAR2(50)
,updated_by VARCHAR2(50)
,exclude_flag VARCHAR2(1) DEFAULT 'N'
) TABLESPACE MAXDAT_DATA;

GRANT SELECT ON TN_COVERKIDS_EXCEPTION TO MAXDAT_READ_ONLY;

CREATE INDEX IDX01_CKEXCPT ON tn_coverkids_exception(application_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX02_CKEXCPT ON tn_coverkids_exception(client_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX03_CKEXCPT ON tn_coverkids_exception(letter_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX04_CKEXCPT ON tn_coverkids_exception(exclude_flag) TABLESPACE MAXDAT_INDX;
