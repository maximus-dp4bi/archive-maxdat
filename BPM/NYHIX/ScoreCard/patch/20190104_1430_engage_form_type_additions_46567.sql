-- NYHIX-46567
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (715,'QC_NYSOH_EE_Account Review Unit_v2.3','QC','E&E','script',sysdate, to_date('07-JAN-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (716,'QC_NYSOH_CC_Individual Marketplace_v3.3','QC','CC','script',sysdate, to_date('07-JAN-2019','DD-MON-YYYY'), null);

commit;
