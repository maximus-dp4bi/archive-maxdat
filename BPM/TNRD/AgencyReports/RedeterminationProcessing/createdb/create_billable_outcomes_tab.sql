CREATE TABLE d_billable_outcomes
(app_event_log_id NUMBER
,billable_counter NUMBER
,application_id NUMBER
,application_status_cd VARCHAR2(32)
,program_cd  VARCHAR2(32)
,program_subtype_cd  VARCHAR2(32)
,outcome_cd  VARCHAR2(32)
,outcome_reason_cd  VARCHAR2(32)
,outcome_date DATE
,mi_type VARCHAR2(4000)
,denial_reason VARCHAR2(4000)
,rfe_status_cd VARCHAR2(32)
,staff_name VARCHAR2(112)
,staff_type VARCHAR2(32)
,packet_mailed_date DATE
,received_date DATE
,trmdn_substantive NUMBER
,trmdn_procedural NUMBER
,denial_type VARCHAR2(32)
,billable_date DATE
,previous_reactivation_reason VARCHAR2(1000)
,current_reactivation_reason VARCHAR2(1000)   
,mmis_app_status VARCHAR2(32)
,letter_id NUMBER
,letter_name VARCHAR2(32)
,event_type VARCHAR2(100)
,client_id NUMBER
,app_individual_id NUMBER
,bill_outcome_count NUMBER
) TABLESPACE MAXDAT_DATA;

CREATE INDEX IDX01_BILLOUTCOMES ON d_billable_outcomes(application_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX02_BILLOUTCOMES ON d_billable_outcomes(outcome_cd) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX03_BILLOUTCOMES ON d_billable_outcomes(app_event_log_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX04_BILLOUTCOMES ON d_billable_outcomes(billable_counter) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX05_BILLOUTCOMES ON d_billable_outcomes(TRUNC(outcome_date)) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON D_BILLABLE_OUTCOMES to MAXDAT_READ_ONLY;

