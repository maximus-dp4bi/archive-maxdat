-- NYHIX-54398
set define off;

DELETE From dp_scorecard.ENGAGE_FORM_TYPE where FORM_TYPE_ID = 785;
DELETE From dp_scorecard.ENGAGE_FORM_TYPE where FORM_TYPE_ID = 786;


commit;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (785,'QC_NYSOH_EE_Application Processing_v1.4','QC','E&E','script',sysdate, to_date('09-DEC-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (786,'QC_NYSOH_EE_Non-NYSOH Application Processing_v2.0','QC','E&E','script',sysdate, to_date('09-DEC-2019','DD-MON-YYYY'), null);


commit;
