CREATE SEQUENCE "EMRS_SEQ_ALERT_ID" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 86401 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_ALERT_ID" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE PUBLIC SYNONYM EMRS_D_ALERT FOR EMRS_D_ALERT;

GRANT SELECT ON "EMRS_D_ALERT" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE VIEW EMRS_D_ALERT_SV 
AS
SELECT alert_id
 ,source_record_id
 ,case_number
 ,client_number
 ,message
 ,source_alert_start_date
 ,source_alert_end_date
 ,void_ind
 ,system_alert_ind
 ,ref_type
 ,ref_id
 ,lock_id
 ,record_count
 ,alert_handler
 ,record_date
 ,record_time
 ,record_name 
 ,modified_date
 ,modified_time
 ,modified_name
 ,date_updated
 ,date_created
 ,created_by
 ,updated_by
FROM emrs_d_alert; 

CREATE OR REPLACE PUBLIC SYNONYM EMRS_D_ALERT_SV FOR EMRS_D_ALERT_SV;

GRANT SELECT ON EMRS_D_ALERT_SV TO "MAXDAT_READ_ONLY";