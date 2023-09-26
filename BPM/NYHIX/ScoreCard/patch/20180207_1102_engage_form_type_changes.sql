---- NYHIX-38118
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(597, 'OPS_NYSOH_CC_Individual Marketplace_v2.2', 'QC', 'CC', 'script',sysdate,to_date('09-FEB-2018','DD-MON-YYYY'),null);
 
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(598, 'Supe Review_OPS_NYSOH_CC_Individual Marketplace_v2.2', 'QCT', 'QCT', 'script',sysdate,to_date('09-FEB-2018','DD-MON-YYYY'),null);

commit;