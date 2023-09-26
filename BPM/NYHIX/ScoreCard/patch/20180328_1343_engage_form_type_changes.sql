---- NYHIX-38418
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(603, 'FPBP Agency Conference Quality Checklist v1.1', 'QC', 'FPBP', 'script',sysdate,to_date('02-APR-2018','DD-MON-YYYY'),null);
 
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(604, 'QC_FPBP_Phone_Supe Checklist v1.0', 'QC', 'FPBP', 'script',sysdate,to_date('02-APR-2018','DD-MON-YYYY'),null);
 
commit;