---- JIRA (NYHIX-31355) Engage Form Type Table Additions (2017-05-12)
delete from DP_SCORECARD.ENGAGE_FORM_TYPE  where form_type_id in (537,538);
commit;

update DP_SCORECARD.ENGAGE_FORM_TYPE 
where form_type_id = 535 set evaluation_form = 'QC_NYSOH_EE_Verification Docs_v3.3_LSC Added'

update DP_SCORECARD.ENGAGE_FORM_TYPE 
where form_type_id = 536 set evaluation_form = 'Supe Review_QC_NYSOH_EE_Verification Docs_v3.3_LSC Added'

commit;