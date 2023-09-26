---- NYHIX-42101
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(673, 'OPS_NYSOH_CC_Small Business Marketplace_v1.4','QC','CC','script',sysdate, to_date('11-JUL-2018','DD-MON-YYYY'), null);
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(674,'Supe Review_OPS_NYSOH_CC_Small Business Marketplace_v1.4','QCT','QCT','script',sysdate,to_date('11-JUL-2018','DD-MON-YYYY'), null);

commit;
