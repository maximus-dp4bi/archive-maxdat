---- NYHIX-40650
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(660, 'QC_NYSOH_EE_Verification Docs_v3.3','QC','E&E','script',sysdate, to_date('01-MAY-2018','DD-MON-YYYY'), null);
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(661,'Supe Review_QC_NYSOH_EE_Verification Docs_v3.3','QCT','QCT','script',sysdate,to_date('01-MAY-2018','DD-MON-YYYY'), null);
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(662, 'OPS_NYSOH_CC_Small Business Marketplace_v1.3','QC','CC','script',sysdate,to_date('01-MAY-2018','DD-MON-YYYY'), null);
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(663,'Supe Review_OPS_NYSOH_CC_Small Business Marketplace_v1.3','QCT','QCT','script',sysdate,to_date('01-MAY-2018','DD-MON-YYYY'), null);
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(664, 'OPS_NYSOH_CC_Web Chat_v2.1','QC','CC','script',sysdate,to_date('01-MAY-2018','DD-MON-YYYY'), null);
insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values(665,'Supe Review_OPS_NYSOH_CC_Web Chat_v2.1','QCT','QCT','script',sysdate,to_date('01-MAY-2018','DD-MON-YYYY'), null);

commit;
