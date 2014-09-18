update cc_c_activity_type set Activity_Type_Category ='Other Not Ready' where activity_type_name in (
'x Eligibility Specialist A.','Account Review Unit / Non-Task','Mailroom','Data Entry - Verification Document','KOFAX Mail QC','Free Form Follow-Up',
'Irate Client','Awaiting Written Withdrawal','Fire Drill/ Evacuation','Returned Mail','Identity Proofing','Awaiting Documentation','Document Management QC',
'Un-Scheduled Break','Flex Time','Authorized Rep','Application Missing Information','Awaiting Validity Check');

update cc_c_activity_type set Activity_Type_Category ='Training' where activity_type_name in ('UPK Training','Pipkins Modification UPK',
'Quality Training','Complaint Training');

update cc_c_activity_type set Activity_Type_Category ='Available' where activity_type_name in ('Appeals','CSS II - SHOP Bilingual');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.8.0',100,'100_UPDATE_CC_C_ACTIVITY_TYPE');

COMMIT;

















