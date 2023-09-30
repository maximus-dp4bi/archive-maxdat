CREATE TABLE d_app_reconsideration_data
(application_id NUMBER(18)
 ,app_receipt_date DATE
 ,application_status VARCHAR2(32)
 ,ftp_ltr_letter_id NUMBER
 ,ftp_ltr_mailed_date DATE 
 ,term_ltr_letter_id NUMBER
 ,term_ltr_mailed_date DATE
 ,ftp_ltr_response_due_date DATE
 ,term_ltr_response_due_date DATE
 ,mi_de_task_id NUMBER
 ,mi_de_task_create_date DATE
 ,latest_document_id NUMBER
 ,latest_document_type VARCHAR2(64)
 ,latest_doc_receipt_date DATE
 ) TABLESPACE MAXDAT_DATA;
 
 CREATE INDEX IDX01_DAPPRECONDATA ON d_app_reconsideration_data(application_id) TABLESPACE MAXDAT_INDX;

 
 GRANT SELECT ON d_app_reconsideration_data to MAXDAT_READ_ONLY;
 
 