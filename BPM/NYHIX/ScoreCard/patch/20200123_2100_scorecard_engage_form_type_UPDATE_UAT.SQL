Alter session set current_schema=dp_scorecard;

update dp_scorecard.engage_form_type 
set evaluation_form='QC_NYSOH_EE_Verification Docs_v4.4'
where form_type_id=798;

COMMIT;





