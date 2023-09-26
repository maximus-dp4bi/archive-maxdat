---- NYHIX-36128
set define off;

update dp_scorecard.engage_form_type set end_date = to_date('31-OCT-2017', 'DD-MON-YYYY')
where evaluation_form  in
('QC_NYSOH_EE_Verification Docs_v3.3_LSC Added',
'Supe Review_QC_NYSOH_EE_Verification Docs_v3.3_LSC Added',
'QC_NYSOH_EE_Linking_v1.5',
'Supe Review_QC_NYSOH_EE_Linking_v1.5');

commit;

Insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values (537,'QC_NYSOH_EE_Verification Docs_v3.3_Pilot','QC','E&E','script',to_date('01-NOV-17','DD-MON-YYYY'),to_date('01-NOV-17','DD-MON-YYYY'),null);
Insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values (538,'Supe Review_QC_NYSOH_EE_Verification Docs_v3.3_Pilot','QCT','QCT','script',to_date('01-NOV-17','DD-MON-YYYY'),to_date('01-NOV-17','DD-MON-YYYY'),null);
Insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values (539,'QC_NYSOH_EE_Linking_v1.6','QC','E&E','script',to_date('01-NOV-17','DD-MON-YYYY'),to_date('01-NOV-17','DD-MON-YYYY'),null);
Insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values (540,'Supe Review_QC_NYSOH_EE_Linking_v1.6','QCT','QCT','script',to_date('01-NOV-17','DD-MON-YYYY'),to_date('01-NOV-17','DD-MON-YYYY'),null);
Insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values (541,'QC_NYSOH_EE_HSDEQC_VDocs_v1.0','QC','E&E','script',to_date('01-NOV-17','DD-MON-YYYY'),to_date('01-NOV-17','DD-MON-YYYY'),null);
Insert into dp_scorecard.ENGAGE_FORM_TYPE (FORM_TYPE_ID,EVALUATION_FORM,SCORECARD_SCORE_TYPE,SCORECARD_GROUP,CREATE_BY,CREATE_DATETIME,START_DATE,END_DATE)
 values (542,'Supe Review_QC_NYSOH_EE_HSDEQC_VDocs_v1.0','QCT','QCT','script',to_date('01-NOV-17','DD-MON-YYYY'),to_date('01-NOV-17','DD-MON-YYYY'),null);
commit;


