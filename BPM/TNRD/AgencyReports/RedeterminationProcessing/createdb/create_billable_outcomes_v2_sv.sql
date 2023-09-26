drop view d_billable_outcomes_v2_sv;

CREATE OR REPLACE VIEW d_billable_outcomes_sv
AS
SELECT bo.application_id
       ,bo.app_individual_id
       ,CASE WHEN outcome_cd = 'DETERMINED_TO_HAVE_MI' THEN als.report_label ELSE s.report_label END application_status
       ,pt.report_label program
       ,st.report_label determination 
       ,CASE WHEN outcome_cd = 'DETERMINED_TO_HAVE_MI' THEN 'Determined To Have MI' ELSE e.report_label END outcome       
       ,er.report_label outcome_reason
       ,TRUNC(bo.outcome_date) outcome_date
       ,cl.clnt_cin recipient_id
       ,cl.case_cin state_case_id
       ,bo.mi_type
       ,bo.denial_reason
       ,fe.report_label hh_member_status
       ,bo.staff_name
       ,bo.staff_type
       ,bo.packet_mailed_date
       ,bo.received_date   
       ,bo.trmdn_substantive
       ,bo.trmdn_procedural      
       ,bo.denial_type
       ,bo.billable_date
       ,bo.previous_reactivation_reason
       ,bo.current_reactivation_reason    
       ,ah.rcvd_90day_indicator rcvd_after_recon_period
       ,bo.bill_outcome_count
FROM d_billable_outcomes bo
 JOIN app_header_stg ah ON bo.application_id = ah.application_id 
 JOIN app_status_lkup als ON ah.status_cd = als.value
 JOIN client_stg cl ON bo.client_id = cl.client_id
 LEFT JOIN app_status_lkup s ON bo.application_status_cd = s.value 
 LEFT JOIN elig_outcome_lkup e ON bo.outcome_cd = e.value 
 LEFT JOIN program_type_lkup pt ON bo.program_cd = pt.value
 LEFT JOIN subprogram_type_lkup st ON bo.program_subtype_cd = st.value   
 LEFT JOIN elig_outcome_reason_lkup er ON bo.outcome_reason_cd = er.value  
 LEFT JOIN app_rfe_status_lkup fe ON bo.rfe_status_cd = fe.value;
 
 GRANT SELECT ON D_BILLABLE_OUTCOMES_SV to MAXDAT_READ_ONLY;
