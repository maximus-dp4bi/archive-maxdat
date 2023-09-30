-- NYHIX-52217
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (774,'QC_NYSOH_EE_Account Review Unit_v2.5','QC','E&E','script',sysdate, to_date('03-SEP-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (775,'Supe Review_QC_NYSOH_EE_Account Review Unit_v2.5','QCT','QCT','script',sysdate, to_date('03-SEP-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (776,'QC_NYSOH_CC_Individual Marketplace_v3.5','QC','CC','script',sysdate, to_date('03-SEP-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (777,'Supe Review_QC_NYSOH_CC_Individual Marketplace_v3.5','QCT','QCT','script',sysdate, to_date('03-SEP-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (778,'QC_NYSOH_CC_Telephone Inquiry_Statewide CC_v4.3','QC','CC','script',sysdate, to_date('03-SEP-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (779,'Supe Review_QC_NYSOH_CC_Telephone Inquiry_Statewide CC_v4.3','QCT','QCT','script',sysdate, to_date('03-SEP-2019','DD-MON-YYYY'), null);

commit;
