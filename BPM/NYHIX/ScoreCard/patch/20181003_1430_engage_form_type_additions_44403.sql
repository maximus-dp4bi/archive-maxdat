-- NYHIX-44403
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (688,'QC_NYSOH_CC_Individual Marketplace_v3.1','QC','CC','script',sysdate, to_date('09-OCT-2018','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (689,'Supe Review_QC_NYSOH_CC_Individual Marketplace_v3.1','QCT','QCT','script',sysdate, to_date('09-OCT-2018','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (690,'QC_NYSOH_EE_Account Review Unit_v2.1','QC','E&E','script',sysdate, to_date('09-OCT-2018','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (691,'Supe Review_QC_NYSOH_EE_Account Review Unit_v2.1','QCT','QCT','script',sysdate, to_date('09-OCT-2018','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (692,'QC_NYSOH_EE_Verification Docs_v4.1','QC','E&E','script',sysdate, to_date('09-OCT-2018','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (693,'Supe Review_QC_NYSOH_EE_Verification Docs_v4.1','QCT','QCT','script',sysdate, to_date('09-OCT-2018','DD-MON-YYYY'), null);

commit;
