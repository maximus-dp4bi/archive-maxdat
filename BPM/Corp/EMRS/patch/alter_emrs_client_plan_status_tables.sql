ALTER TABLE emrs_d_client_plan_eligibility
MODIFY (version number(*,0)
        ,client_plan_eligibility_id number(*,0)
        ,plan_type_id number(*,0)
        ,sub_program_id number(*,0)
        ,source_record_id number(*,0)
        ,client_number number(*,0));


ALTER TABLE emrs_d_client_plan_enrl_status
MODIFY (CLIENT_ENROLL_STATUS_ID number(*,0)
        ,plan_type_id number(*,0)
        ,enrollment_status_id number(*,0)
        ,current_enrollment_status_id number(*,0)
        ,client_number number(*,0)
        ,source_record_id number(*,0));