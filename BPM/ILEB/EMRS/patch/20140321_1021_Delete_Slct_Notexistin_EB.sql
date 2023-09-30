DECLARE
 CURSOR enrl_cur IS
    SELECT f.enrollment_id
      ,f.enrollment_group_id
      ,f.source_record_id selection_segment_id
       ,client_number client_id
       ,case_number case_id
       ,provider_number network_id
       ,managed_care_start_date start_date
       ,managed_care_end_Date end_date
       ,enrollment_status_change_date     
    FROM emrs_f_enrollment f
    WHERE trunc(date_created) <= to_date('03/20/2014','mm/dd/yyyy')
    AND NOT EXISTS(SELECT 1 FROM emrs_s_enrollment_stg_adhoc s WHERE f.source_record_id = s.source_selection_record_id);
   
   TYPE t_enrl_tab IS TABLE OF enrl_cur%ROWTYPE INDEX BY PLS_INTEGER;
    enrl_tab t_enrl_tab;
    v_bulk_limit NUMBER := 5000;     
BEGIN
   OPEN enrl_cur;
   LOOP
     FETCH enrl_cur BULK COLLECT INTO enrl_tab LIMIT v_bulk_limit;
     EXIT WHEN enrl_tab.COUNT = 0; -- Exit when missing rows

     FOR indx IN 1 .. enrl_tab.COUNT LOOP     

       DELETE FROM emrs_d_enrollment_notification
       WHERE enrollment_group_id = enrl_tab(indx).enrollment_group_id;    
         
       DELETE FROM emrs_f_enrollment
       WHERE enrollment_id = enrl_tab(indx).enrollment_id;
     
    END LOOP;
    COMMIT;
  END LOOP;
  COMMIT;
END;
/

INSERT INTO emrs_f_enrollment (source_record_id
      ,client_number
      ,case_number
      ,provider_number
      ,managed_care_start_date
      ,managed_care_end_date
      ,enrollment_status_change_date
      ,number_count
      ,cost_share_start_date
      ,cost_share_end_date
      ,co_pay_amount
      ,enrollment_fee_assessed
      ,enrollment_fee_assessed_date
      ,enrollment_fee_paid
      ,enrollment_fee_paid_date
      ,met_cost_share_cap_date
      ,enrollment_fee_frequency
      ,chip_annual_enroll_date
      ,certification_date
      ,medicaid_recertification_date
      ,eligibility_receipt_date
      ,source_table_name
      ,people_in_family
      ,county_id
      ,csda_id
      ,coverage_category_id
      ,enrollment_action_status_id
      ,fpl_id
      ,plan_id
      ,program_id
      ,risk_group_id
      ,stat_in_grp_id
      ,sub_program_id
      ,aid_category_id
      ,citizenship_id      
      ,selection_source_id      
      ,selection_reason_id      
      ,language_code_id
      ,date_period_id
      ,time_period_id
      ,change_reason_id
      ,term_reason_code_id
	    ,race_id
	    ,provider_type_id
      ,plan_type_id
      ,fpl_percentage)
SELECT source_selection_record_id source_record_id
      ,source_client_id client_number
      ,source_case_id case_number
      ,source_network_id provider_number
      ,s.managed_care_start_date
      ,s.managed_care_end_date
      ,s.enrollment_status_change_date
      ,s.number_count
      ,s.cost_share_start_date
      ,s.cost_share_end_date
      ,s.co_pay_amount
      ,s.enrollment_fee_assessed
      ,s.enrollment_fee_assessed_date
      ,s.enrollment_fee_paid
      ,s.enrollment_fee_paid_date
      ,s.met_cost_share_cap_date
      ,s.enrollment_fee_frequency
      ,s.chip_annual_enroll_date
      ,s.certification_date
      ,s.medicaid_recertification_date
      ,s.eligibility_receipt_date
      ,s.source_table_name
      ,s.people_in_family
      ,COALESCE(edc.county_id,0) county_id
      ,COALESCE(eds.csda_id,0) csda_id
      ,COALESCE(ecc.coverage_category_id,0) coverage_category_id
      ,COALESCE(eda.enrollment_action_status_id,0) enrollment_action_status_id
      ,COALESCE(edf.fpl_id,0) fpl_id
      ,COALESCE(edp.plan_id,edpu.plan_id,0) plan_id
      ,COALESCE(edpr.program_id,0) program_id
      ,COALESCE(edrg.risk_group_id,0) risk_group_id
      ,COALESCE(edsg.status_in_group_id,0) stat_in_grp_id
      ,COALESCE(edsp.sub_program_id,0) sub_program_id
      ,COALESCE(edac.aid_category_id,0) aid_category_id
      ,COALESCE(edcs.citizenship_id,0) citizenship_id      
      ,COALESCE(edss.selection_source_id,0) selection_source_id      
      ,COALESCE(edsr.selection_reason_id,0) selection_reason_id      
      ,COALESCE(edl.language_code_id,0) language_code_id
      ,COALESCE(eddr.date_period_id,0) date_period_id
      ,COALESCE(edtr.time_period_id,0) time_period_id
      ,COALESCE(edcr.change_reason_id,0) change_reason_id
      ,COALESCE(edmr.term_reason_code_id,0) term_reason_code_id
	  ,COALESCE(edre.race_id,0) race_id
	  ,COALESCE(edpt.provider_type_id,0) provider_type_id
      ,COALESCE(edpp.plan_type_id,0) plan_type_id
      ,s.fpl_percentage
FROM emrs_s_enrollment_stg_adhoc s
  INNER JOIN emrs_d_time_period edtr
    ON edtr.hour_minute_military = s.create_ts_hrmin
    AND edtr.second = s.create_ts_second
  INNER JOIN emrs_d_date_period eddr
    ON eddr.date_standard_2 = s.create_ts
  LEFT OUTER JOIN emrs_d_program edpr
    ON edpr.program_code =  s.program_type_code 
  LEFT OUTER JOIN emrs_d_sub_program edsp
    ON edsp.sub_program_code = s.sub_program_code
    AND edsp.parent_program_id = edpr.program_id 
  LEFT OUTER JOIN emrs_d_risk_group edrg
    ON edrg.risk_group_code = s.risk_group_code
    AND edrg.managed_care_program = s.program_type_code
  LEFT OUTER JOIN emrs_d_status_in_group edsg
    ON edsg.status_in_group_code = s.status_in_group_code
    AND edsg.managed_care_program = s.program_type_code    
 LEFT OUTER JOIN emrs_d_coverage_category ecc
    ON ecc.coverage_category_code = s.coverage_code
    AND ecc.coverage_category_type = 'COVERAGE'
    AND ecc.managed_care_program = s.program_type_code
  LEFT OUTER JOIN emrs_d_citizenship_status edcs
     ON edcs.citizenship_code = s.citizenship_status_code
     AND edcs.managed_care_program = s.program_type_code    
  LEFT OUTER JOIN emrs_d_enrollment_action_statu eda
    ON eda.enrollment_action_status_code = s.enrollment_action_status_code
    AND eda.managed_care_program = s.program_type_code      
  LEFT OUTER JOIN emrs_d_language edl
    ON edl.language_code  = s.language_code
    AND edl.managed_care_program = s.program_type_code     
  LEFT OUTER JOIN emrs_d_aid_category edac
    ON edac.aid_category_code = s.aid_category_code
    AND edac.managed_care_program = s.program_type_code
  LEFT OUTER JOIN emrs_d_selection_source edss
     ON edss.selection_source_code = s.selection_source_code
     AND edss.managed_care_program = s.program_type_code
  LEFT OUTER JOIN emrs_d_selection_reason edsr
     ON edsr.selection_reason_code = s.selection_reason_code
     AND edsr.managed_care_program = s.program_type_code 
  LEFT OUTER JOIN emrs_d_provider_type edpt
    ON edpt.provider_code = s.provider_type_code
    AND edpt.managed_care_program = s.program_type_code  
  LEFT OUTER JOIN emrs_d_plan_type edpp
    ON edpp.plan_type = s.plan_type_code
    AND edpp.managed_care_program = s.program_type_code     
  LEFT OUTER JOIN emrs_d_race edre
    ON edre.race_code = s.race_code
    AND edre.managed_care_program = s.program_type_code      
  LEFT OUTER JOIN emrs_d_plan edp
    ON edp.plan_code = s.source_plan_code
    AND edp.csda = s.csda_code
    AND edp.managed_care_program = s.program_type_code
  LEFT OUTER JOIN emrs_d_plan edpu
    ON edpu.plan_code = s.source_plan_code
    AND edpu.csda = '0'
    AND edpu.managed_care_program = s.program_type_code    
  LEFT OUTER JOIN emrs_d_care_serv_deliv_area eds
    ON eds.csda_code = s.csda_code 
    AND eds.managed_care_program = s.program_type_code            
  LEFT OUTER JOIN emrs_d_county edc
    ON  edc.county_code =  s.county_code
    AND edc.csdaid =  eds.csda_code
    AND edc.plan_service_type = s.plan_service_type        
  LEFT OUTER JOIN emrs_d_change_reason edcr
    ON edcr.change_reason_code = s.change_reason_code
    AND edcr.change_reason_code_plan = s.source_plan_code
    AND edcr.managed_care_program = s.program_type_code
  LEFT OUTER JOIN emrs_d_termination_reason edmr
    ON edmr.plan_name = s.source_plan_code
    AND edmr.reason_code = s.change_reason_code
    AND edmr.managed_care_program = s.program_type_code      
  LEFT OUTER JOIN emrs_d_federal_poverty_level edf
    ON edf.fpl_number_in_family = s.people_in_family
    AND TO_CHAR(sysdate,'YYYY') = TO_CHAR(fpl_year,'YYYY')
where s.source_selection_record_id in (12398410,12398766);

COMMIT;