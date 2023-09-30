--- NYHIX-30404 Engage Form Type Table - Changes
--- 
update DP_SCORECARD.ENGAGE_FORM_TYPE set evaluation_form = 'QC NYSOH Supervisor Review Evaluation Checks v1.0' where form_type_id=474;
update DP_SCORECARD.ENGAGE_FORM_TYPE set evaluation_form = 'QC_FPBP_Doc Management_v2.0' where form_type_id=523;
update DP_SCORECARD.ENGAGE_FORM_TYPE set evaluation_form = 'QC_NYSOH_EE_Account Review Unit_v1.4' where form_type_id=525;
commit;