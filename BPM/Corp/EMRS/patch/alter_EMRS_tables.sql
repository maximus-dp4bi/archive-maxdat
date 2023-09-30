ALTER TABLE emrs_d_case
MODIFY csda_code VARCHAR2(32) NULL;

ALTER TABLE emrs_d_plan
DROP CONSTRAINT plan_plan_comb_uk;

ALTER TABLE emrs_d_plan
ADD CONSTRAINT PLAN_PLAN_COMB_UK unique (managed_care_program, csda, source_record_id);

ALTER TABLE emrs_d_plan
ADD (plan_website VARCHAR2(2000)
    ,contact_email_address VARCHAR2(256));

ALTER TABLE emrs_d_enrollment_notification
DROP CONSTRAINT ENROLLMENT_GROUP_PK;

ALTER TABLE emrs_d_selection_transaction
MODIFY (record_time VARCHAR2(10)
	,modified_time VARCHAR2(10)
  ,modified_name VARCHAR2(80));

ALTER TABLE emrs_d_client_plan_eligibility
MODIFY(eligibility_status_code VARCHAR2(80)
      ,current_eligibility_status_cd VARCHAR2(80));


ALTER TABLE emrs_d_termination_reason
MODIFY reason_code VARCHAR2(50);

ALTER TABLE emrs_d_rejection_error_reason
MODIFY related_files VARCHAR2(32);

ALTER TABLE emrs_d_enrollment_action_statu
MODIFY (enrollment_action_status_code VARCHAR2(80)
        ,enrollment_action_status_code_ VARCHAR2(500));

