---- NYHIX-36883
set define off;



insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(590, 'FPBP QC Quality Checklist_Downstate v1.0', 'QC', 'FPBP', 'script',sysdate,to_date('01-JAN-2018','DD-MON-YYYY'),null);
 
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(591, 'FPBP QC Quality Checklist_Upstate v1.0', 'QC', 'FPBP', 'script',sysdate,to_date('01-JAN-2018','DD-MON-YYYY'),null);
 
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(592, 'FPBP Fair Hearings Quality Checklist v1.0', 'QC', 'FPBP', 'script',sysdate,to_date('01-JAN-2018','DD-MON-YYYY'),null);
 
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE) 
 values(593, 'FPBP Agency Conference Quality Checklist v1.0', 'QC', 'FPBP', 'script',sysdate,to_date('01-JAN-2018','DD-MON-YYYY'),null);
 
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE) 
 values(594, 'FPBP Research Quality Checklist v1.0', 'QC', 'FPBP', 'script',sysdate,to_date('01-JAN-2018','DD-MON-YYYY'),null);
 
commit;


