insert into CORP_ETL_CONTROL columns (NAME,VALUE_TYPE,VALUE,DESCRIPTION)
values ('DWC_MONTHLYFILE_START_DT','M','20180201','Start Date of Monthly file generation.');

insert into CORP_ETL_CONTROL columns (NAME,VALUE_TYPE,VALUE,DESCRIPTION)
values ('DWC_MONTHLYFILE_END_DT','M','20180302','End Date of Monthly file generation.');

insert into CORP_ETL_CONTROL columns (NAME,VALUE_TYPE,VALUE,DESCRIPTION)
values ('M_DWC_CASE_FILENAME','V','IMR_CASES_','DWC monthly filename to load case Information.');

insert into CORP_ETL_CONTROL columns (NAME,VALUE_TYPE,VALUE,DESCRIPTION)
values ('M_DWC_PARTICIPANT_FILENAME','V','IMR_PARTICIPANTS_','DWC monthly filename to load participant Information.');

insert into CORP_ETL_CONTROL columns (NAME,VALUE_TYPE,VALUE,DESCRIPTION)
values ('M_DWC_TREATMENT_REQS_FILENAME','V','IMR_TREATMENT_REQS_','DWC monthly filename to load treatment requests.');

commit;





