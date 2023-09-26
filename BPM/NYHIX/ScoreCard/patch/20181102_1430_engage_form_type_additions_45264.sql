-- NYHIX-45264
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (698,'QC_NYSOH_CC_Individual Marketplace_v3.2','QC','CC','script',sysdate, to_date('07-NOV-2018','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (699,'Supe Review_QC_NYSOH_CC_Individual Marketplace_v3.2','QCT','QCT','script',sysdate, to_date('07-NOV-2018','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (700,'Supe Review_QC_NYSOH_EE_Account Review Unit_v2.2','QCT','QCT','script',sysdate, to_date('07-NOV-2018','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (701,'QC_NYSOH_EE_Account Review Unit_v2.2','QC','E&E','script',sysdate, to_date('07-NOV-2018','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (702,'QC_NYSOH_EE_Verification Docs_v4.1','QC','E&E','script',sysdate, to_date('05-NOV-2018','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (703,'Supe Review_QC_NYSOH_EE_Verification Docs_v4.1','QCT','QCT','script',sysdate, to_date('05-NOV-2018','DD-MON-YYYY'), null);

commit;
