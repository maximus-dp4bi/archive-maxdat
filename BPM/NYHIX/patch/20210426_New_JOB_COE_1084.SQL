--------------------------------------------------------
-- DML for Table SC_HIERARCHY_JOB_LEVEL_LKUP
-- new job_code 1084
--------------------------------------------------------

insert into DP_SCORECARD.SC_HIERARCHY_JOB_LEVEL_LKUP 
   	JOB_LEVEL , 
	JOB_CODE , 
	OWNER_DATE , 
	DELETE_DATE , 
	EFFECTIVE_DATE , 
	END_DATE 
   ) 
values (
1, 									--JOB_LEVEL
1084, 								--	JOB_CODE
to_date('20190506','yyyymmdd'), 	--OWNER_DATE
null,								--DELETE_DATE
to_date('20190506','yyyymmdd'),		--EFFECTIVE_DATE
null,								--END_DATE
);

Commit;
   
