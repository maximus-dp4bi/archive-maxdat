-- NYHIX-50163
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (756,'QC_NYSOH_CC_Telephone Inquiry_Statewide CC_v4.2','QC','CC','script',sysdate, to_date('01-JUN-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (757,'Supe Review_QC_NYSOH_CC_Telephone Inquiry_Statewide CC_v4.2','QCT','QCT','script',sysdate, to_date('01-JUN-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (758,'QC_NYSOH_CC_Small Business Marketplace_v2.0','QC','CC','script',sysdate, to_date('01-JUN-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (759,'Supe Review_QC_NYSOH_CC_Small Business Marketplace_v2.0','QCT','QCT','script',sysdate, to_date('01-JUN-2019','DD-MON-YYYY'), null);

commit;
