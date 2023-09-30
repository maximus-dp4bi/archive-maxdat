insert into d_program (PROGRAM_CODE
,   PROGRAM_NAME
,  REPORT_LABEL 
,   PROGRAM_CATEGORY 
,   ACTIVE_INACTIVE 
,   START_DATE  
,   END_DATE 
)
values ('MEDICAID','Medicaid Program','Medicaid',null,'A',to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));
--select * from d_program_sv;

---insert into subprogram

insert into d_subprogram(subprogram_code, subprogram_name, report_label, program_code, start_date, end_date, plan_service_type)
values ('MC','MIChild', 'MIChild','MEDICAID',to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'),null);

insert into d_subprogram(subprogram_code, subprogram_name, report_label, program_code, start_date, end_date, plan_service_type)
values ('MED','Medicaid', 'MA','MEDICAID',to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'),null);

insert into d_subprogram(subprogram_code, subprogram_name, report_label, program_code, start_date, end_date, plan_service_type)
values ('CSHCS','CSHCS', 'CSHCS','MEDICAID',to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'),null);

insert into d_subprogram(subprogram_code, subprogram_name, report_label, program_code, start_date, end_date, plan_service_type)
values ('HMP','Healthy Michigan', 'HMP','MEDICAID',to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'),null);

--- insert into source
insert into D_LETTER_SOURCE_SV(LETTER_SOURCE_CODE, LETTER_SOURCE_NAME, DESCRIPTION, REPORT_LABEL, EFFECTIVE_FROM_DATE, EFFECTIVE_THRU_DATE)
values ('MAXEB','MAXEB','Maximus EB', 'MAXEB', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_LETTER_SOURCE_SV(LETTER_SOURCE_CODE, LETTER_SOURCE_NAME, DESCRIPTION, REPORT_LABEL, EFFECTIVE_FROM_DATE, EFFECTIVE_THRU_DATE)
values ('WDCT','WDCT','Worker DCT', 'WDCT', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_LETTER_SOURCE_SV(LETTER_SOURCE_CODE, LETTER_SOURCE_NAME, DESCRIPTION, REPORT_LABEL, EFFECTIVE_FROM_DATE, EFFECTIVE_THRU_DATE)
values ('OFA','OFA','Oracle Financial System', 'OFA', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_LETTER_SOURCE_SV(LETTER_SOURCE_CODE, LETTER_SOURCE_NAME, DESCRIPTION, REPORT_LABEL, EFFECTIVE_FROM_DATE, EFFECTIVE_THRU_DATE)
values ('ADHOC','ADHOC','Adhoc', 'ADHOC', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_LETTER_SOURCE_SV(LETTER_SOURCE_CODE, LETTER_SOURCE_NAME, DESCRIPTION, REPORT_LABEL, EFFECTIVE_FROM_DATE, EFFECTIVE_THRU_DATE)
values ('EYR','EYR','Mailhouse', 'EYR', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

-- insert MI Health card definition
insert into d_letter_definition(lmdef_id, name, description,report_label, letter_or_form, letter_source_code,effective_from_date,effective_thru_date) 
values (63,'MIHC','MI Health Card','HC','F','MAXEB',to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));


--insert into D_SUBPROGRAM_CON_XWALK

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('CSHCS FA', 'CSHCS First Mailing','CSHCS F - A',63, 'CSHCS','F','A', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('CSHCS RA', 'CSHCS Replacement Mailing','CSHCS R - A',63, 'CSHCS','R','A', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('HMP FK', 'HMP First Mailing','HMP F - K',63, 'HMP','F','K', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('HMP RK', 'HMP Replacement Mailing','HMP R - K',63, 'HMP','R','K', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MC FR', 'MC First Mailing','MC F - R',63, 'MC','F','R', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MC RR', 'MC Replacement Mailing','MC R - R',63, 'MC','R','R', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED FC', 'MED First Mailing C Update Code','MED F - C',63, 'MC','F','C', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED RC', 'MED Replacement Mailing C Update Code','MED R - C',63, 'MC','R','C', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED FE', 'MED First Mailing E Update Code','MED F - E',63, 'MC','F','E', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED RE', 'MED Replacement Mailing C Update Code','MED R - E',63, 'MC','R','E', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED FF', 'MED First Mailing F Update Code','MED F - F',63, 'MC','F','F', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED RF', 'MED Replacement Mailing F Update Code','MED R - F',63, 'MC','R','F', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED FH', 'MED First Mailing H Update Code','MED F - H',63, 'MC','F','H', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED RH', 'MED Replacement Mailing H Update Code','MED R - H',63, 'MC','R','H', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED FG', 'MED First Mailing G Update Code','MED F - G',63, 'MC','F','G', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED RG', 'MED Replacement Mailing G Update Code','MED R - G',63, 'MC','R','G', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED FI', 'MED First Mailing G Update Code','MED F - I',63, 'MC','F','I', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED RI', 'MED Replacement Mailing G Update Code','MED R - I',63, 'MC','R','I', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED FS', 'MED First Mailing G Update Code','MED F - S',63, 'MC','F','S', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_SUBPROGRAM_CON_XWALK(PROGRAM_CON_XWALK_CODE, DESCRIPTION, REPORT_LABEL, lmdef_id, SUBPROGRAM_CODE, CON_STATUS_CODE, CON_UPDATE_CODE, EFFECTIVE_DATE, END_DATE)
values ('MED RS', 'MED Replacement Mailing G Update Code','MED R - S',63, 'MC','R','S', to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

-- insert adjustment reason
insert into D_LETTER_ADJUST_REASON(LETTER_ADJUST_REASON_CODE, name, Description, Report_Label, Effective_From_Date, Effective_Thru_Date)
values ('STATE','STATE','Requested by State','Requested by State',to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_LETTER_ADJUST_REASON(LETTER_ADJUST_REASON_CODE, name, Description, Report_Label, Effective_From_Date, Effective_Thru_Date)
values ('MAILHOUSE','MAILHOUSE','Requested by Mailhouse','Requested by Mailhouse',to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

insert into D_LETTER_ADJUST_REASON(LETTER_ADJUST_REASON_CODE, name, Description, Report_Label, Effective_From_Date, Effective_Thru_Date)
values ('OTHER','OTHER','Other','Other Reason',to_Date('1/1/2007','mm/dd/yyyy'),to_date('7/7/7777','mm/dd/yyyy'));

commit;
