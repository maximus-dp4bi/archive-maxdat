-- NYHIX-49665
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (751,'Supe Review QC_NYSOH_EE_Verification Docs_v4.3','QCT','QCT','script',sysdate, to_date('08-MAY-2019','DD-MON-YYYY'), null);

commit;
