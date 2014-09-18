ALTER TABLE emrs_f_enrollment
ADD fpl_percentage NUMBER(22,4);

ALTER TABLE emrs_s_enrollment_stg
ADD fpl_percentage NUMBER(22,4);

ALTER TABLE emrs_d_plan
ADD plan_service_type VARCHAR2(20);

ALTER TABLE emrs_d_sub_program
ADD plan_service_type VARCHAR2(20);