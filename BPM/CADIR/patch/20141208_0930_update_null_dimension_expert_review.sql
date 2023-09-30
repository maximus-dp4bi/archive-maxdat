update s_crs_imr_expert_review
set IMR_EXPERT_LICENSE_CODE = 'na'
where IMR_EXPERT_LICENSE_CODE is null ;

commit;