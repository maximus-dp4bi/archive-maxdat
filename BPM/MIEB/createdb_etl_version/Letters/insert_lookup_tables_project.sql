insert into d_PROJECT (PROJECT_CODE
,   PROJECT_NAME
,  REPORT_LABEL 
,   PROJECT_CATEGORY 
,   ACTIVE_INACTIVE 
,   START_DATE  
,   END_DATE 
)
values ('MIEB','MIEB','MI EB',null,'A',to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));
--select * from d_PROJECT_sv;


commit;
