update s_crs_imr_expert_review
set EXPERT_ID = 0
where EXPERT_ID is null ;

update s_crs_imr_expert_review
set EXPERT_TYPE_ID = 0
where EXPERT_TYPE_ID is null ;

update s_crs_imr_expert_review
set RCCMD_EXPERT_SPECIALTY_ID = 0
where RCCMD_EXPERT_SPECIALTY_ID is null ;

update s_crs_imr_expert_review
set ASSGN_EXPERT_SPECIALTY_ID = 0
where ASSGN_EXPERT_SPECIALTY_ID is null ;

update s_crs_imr_issues_in_dispute
set ISSUE_TYPE_ID = 0
where ISSUE_TYPE_ID is null ;

update s_crs_imr_issues_in_dispute
set INELIGIBILE_REASON_ID = 0
where INELIGIBILE_REASON_ID is null ;

update s_crs_imr_issues_in_dispute
set IMR_DECISION_ID = 0
where IMR_DECISION_ID is null ;

update s_crs_imr_decisions
set DECISION_TYPE_ID = 0
where DECISION_TYPE_ID is null ;

update s_crs_imr_decisions
set DECISION_CLOSED_REASON_ID = 0
where DECISION_CLOSED_REASON_ID is null ;

update s_crs_imr_decisions
set TERMINATION_REASON_ID = 0
where TERMINATION_REASON_ID is null ;


commit;