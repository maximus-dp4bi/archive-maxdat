insert into DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_CODE
values (
'1082', 						--JOB_CLASSIFICATION_CODE_ID 
'Task Team Administrators', 	--CODE 
null, 							--DESCRIPTION 
'1030', 						--OWNER_USER 
null, 							--MODIFY_USER 
sysdate,						--OWNER_DATE 
null, 							--MODIFY_DATE 
null							--DELETE_DATE
);

commit;

delete from DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_CODE
where JOB_CLASSIFICATION_CODE_ID  = '1080'
and CODE = 'Quality Assurance Coordinator';

commit;