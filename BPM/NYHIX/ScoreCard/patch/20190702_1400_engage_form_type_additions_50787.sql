-- NYHIX-50787
set define off;

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (760,'QC_NYSOH_EE_Doc Mgmt_v3.0','QC','E&E','script',sysdate, to_date('01-JUL-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (761,'QC_NYSOH_EE_Data Entry in MAXe_v1.0','QC','E&E','script',sysdate, to_date('08-JUL-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (762,'QC_NYSOH_EE_Data Entry in KOFAX_V1.0','QC','E&E','script',sysdate, to_date('08-JUL-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (763,'QC_NYSOH_EE_Research_v4.0','QC','E&E','script',sysdate, to_date('08-JUL-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (764,'Supe Review_QC_NYSOH_EE_Doc Mgmt_v3.0','QCT','QCT','script',sysdate, to_date('08-JUL-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (765,'Supe Review_QC_NYSOH_EE_Data Entry in MAXe_v1.0','QCT','QCT','script',sysdate, to_date('08-JUL-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (766,'Supe Review_QC_NYSOH_EE_Data Entry in KOFAX_V1.0','QCT','QCT','script',sysdate, to_date('08-JUL-2019','DD-MON-YYYY'), null);

insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID, EVALUATION_FORM, SCORECARD_SCORE_TYPE, SCORECARD_GROUP, CREATE_BY, CREATE_DATETIME, START_DATE, END_DATE)
 values (767,'Supe Review_QC_NYSOH_EE_Research_v4.0','QCT','QCT','script',sysdate, to_date('08-JUL-2019','DD-MON-YYYY'), null);
commit;
