-- NYHIX-53408
set define off;


insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (780,'QC_NYSOH_CC_Task Team_v3.5','QC','CC','script',sysdate, to_date('01-OCT-2019','DD-MON-YYYY'), null);

commit;
