 CREATE OR REPLACE VIEW public.D_PM_MANAGED_CARE_PLAN_DETAILS_SV AS
 --PG/SL
  SELECT pg.reg_mcp_pg_affiliation_id
 ,sl.reg_mcp_pg_affiliation_detail_id
 ,pg.reg_id
 ,pg.pg_record_type_id pg_record_type_code
 ,sl.mco_record_type_code
 ,COALESCE(psd.plan_name,p.plan_name) plan_name
 ,CASE WHEN pg.pg_record_type_id = 1 THEN 'Provider'
       WHEN pg.pg_record_type_id = 2 THEN 'Group'       
     ELSE 'Unknown' END pg_record_type
 ,CASE WHEN sl.mco_record_type_code = 1 THEN 'Provider Location'
       WHEN sl.mco_record_type_code = 2 THEN 'Group Location'
       WHEN sl.mco_record_type_code = 3 THEN 'Provider Health Center'
       WHEN sl.mco_record_type_code = 4 THEN 'Provider Group Location'
     ELSE 'Unknown' END service_location_type
  ,pg.tracking_number pg_tracking_number
  ,sl.tracking_number sl_tracking_number
  ,sl.provider_group_tracking_number
  ,sl.group_location_tracking_number
  ,sl.health_center_tracking_number
  ,pg.medicaid_id
  ,pg.start_date
  ,pg.end_date
  ,sl.program_code
  ,pt.program_type
  ,CASE WHEN sl.is_pcp = 0 THEN 0 ELSE 1 END is_pcp
  ,sl.panel_capacity panel_capacity
  ,sl.panel_pcp_count panel_pcp_count
  ,pg.npi
  ,pg.prn
  ,pg.name
  ,sl.county_code sl_county_code
  ,TRIM(REPLACE(crr.county_name,'County','')) sl_county_name
  ,crg.county_region sl_county_region
  ,pg.created_on_date_time create_date_time
  ,CAST(pg.created_on_date_time AS DATE) create_date
  ,pg.primary_specialty_tracking_number
  ,stsl.county_code specialty_county_code
  ,TRIM(REPLACE(crs.county_name,'County','')) specialty_county_name
  ,crgs.county_region specialty_county_region
  ,pg.mycare_reporting_county_code
  ,TRIM(REPLACE(crmc.county_name,'County','')) mycare_county_name
  ,crgmc.county_region mycare_county_region    
  ,pg.primary_mits_provider_type_id
  ,ptp.provider_type_name primary_provider_type
  ,pg.secondary_mits_provider_type_id
  ,pts.provider_type_name secondary_provider_type
  ,pg.primary_mits_specialty_type_id
  ,pspt.specialty_type_name primary_specialty_name
  ,sl.mits_specialties
  ,slspt.specialty_type_name sl_specialty_name
  ,CASE WHEN (sl.mco_record_type_code != 4 OR (sl.mco_record_type_code = 4 AND pg.primary_mits_provider_type_id NOT IN('84','95'))  )      
      AND bhpi.mits_specialty_code IS NOT NULL   THEN 'Y'        
    ELSE 'N' END bh_practitioner_indicator
  ,CASE WHEN bhsi.mits_specialty_code IS NOT NULL THEN 'Y' ELSE 'N' END bh_services_indicator  
  ,CASE WHEN orbhsi.mits_specialty_code IS NOT NULL THEN 'Y' 
     ELSE 'N' END ohiorise_bh_services_indicator
  ,CASE WHEN msi.mits_specialty_code IS NOT NULL THEN 'Y' ELSE 'N' END mat_services_indicator   
  ,CASE WHEN upi.mits_specialty_code IS NOT NULL THEN 'Y' ELSE 'N' END uncommon_pcp_indicator   
  ,CASE WHEN wsi.mits_specialty_code IS NOT NULL THEN 'Y' ELSE 'N' END waiver_services_indicator    
  ,CASE WHEN wsi.mits_specialty_code IS NOT NULL THEN wsi.specialty_waiver_category ELSE NULL END specialty_waiver_category
  ,CASE WHEN orwsi.mits_specialty_code IS NOT NULL THEN 'Y' ELSE 'N' END ohiorise_waiver_services_indicator    
  ,CASE WHEN orwsi.mits_specialty_code IS NOT NULL THEN orwsi.specialty_waiver_category ELSE NULL END ohiorise_specialty_waiver_category 
  ,CASE WHEN dsi.mits_specialty_code IS NOT NULL THEN 'Y' ELSE 'N' END dental_services_indicator    
  ,CASE WHEN vsi.mits_specialty_code IS NOT NULL THEN 'Y' ELSE 'N' END vision_services_indicator    
FROM ohpnm_dp4bi.reg_mcp_pg_affiliation pg
  JOIN ohpnm_dp4bi.reg_mcp_pg_affiliation_detail sl ON pg.reg_mcp_pg_affiliation_id = sl.reg_mcp_pg_affiliation_id
  LEFT JOIN ohpnm_dp4bi.reg_mcp_pg_affiliation_detail stsl ON pg.primary_specialty_tracking_number = stsl.tracking_number
  LEFT JOIN ohpnm_dp4bi.submitter_id_mcp_xref sxr ON pg.reg_id = sxr.reg_id
  LEFT JOIN ohpnm_dp4bi.mcp_plans_submitter_details psd ON sxr.submitter_id = psd.submitter_id  
  LEFT JOIN ohpnm_dp4bi.mcpn_file m ON pg.mcpn_file_id = m.mcpn_file_id
  LEFT JOIN ohpnm_dp4bi.cfg_plan_types p ON SUBSTR(m.mcpn_file_name,3,3) = p.plan_id
  LEFT JOIN ohpnm_dp4bi.cfg_program_types pt ON pt.program_code  = sl.program_code
  LEFT JOIN ohpnm_dp4bi.county crr ON sl.county_code = crr.mmis_county_code AND crr.state_abbreviation = 'OH'
  LEFT JOIN ohpnm_dp4bi.county_region crg ON UPPER(crg.county_name) = UPPER(TRIM(REPLACE(crr.county_name,'County','')))              
  LEFT JOIN ohpnm_dp4bi.county crs ON stsl.county_code = crs.mmis_county_code AND crs.state_abbreviation = 'OH'
  LEFT JOIN ohpnm_dp4bi.county_region crgs ON UPPER(crgs.county_name) = UPPER(TRIM(REPLACE(crs.county_name,'County','')))     
  LEFT JOIN ohpnm_dp4bi.county crmc ON pg.mycare_reporting_county_code = crmc.mmis_county_code AND crmc.state_abbreviation = 'OH'
  LEFT JOIN ohpnm_dp4bi.county_region crgmc ON UPPER(crgmc.county_name) = UPPER(TRIM(REPLACE(crmc.county_name,'County',''))) 
  LEFT JOIN (SELECT DISTINCT mmis_provider_type_id, provider_type_name
             FROM ohpnm_dp4bi.provider_type) ptp ON ptp.mmis_provider_type_id = TO_CHAR(pg.primary_mits_provider_type_id)
  LEFT JOIN (SELECT DISTINCT mmis_provider_type_id, provider_type_name
             FROM ohpnm_dp4bi.provider_type) pts ON pts.mmis_provider_type_id = TO_CHAR(pg.secondary_mits_provider_type_id)    
  LEFT JOIN ohpnm_dp4bi.specialty_type pspt ON pspt.mmis_specialty_type_id = pg.primary_mits_specialty_type_id  
  LEFT JOIN ohpnm_dp4bi.specialty_type slspt ON  slspt.mmis_specialty_type_id = TRIM(REPLACE(REPLACE(sl.mits_specialties,'B',''),'|', ''))
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk bhpi 
   ON (pg.primary_mits_specialty_type_id = bhpi.mits_specialty_code OR  slspt.mmis_specialty_type_id = bhpi.mits_specialty_code ) AND bhpi.include_in_report = 'BH_PRACTITIONER'
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk bhsi 
   ON (pg.primary_mits_specialty_type_id = bhsi.mits_specialty_code OR  slspt.mmis_specialty_type_id = bhsi.mits_specialty_code ) AND bhsi.include_in_report = 'BH_SERVICES'   
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk orbhsi 
   ON (pg.primary_mits_specialty_type_id = orbhsi.mits_specialty_code OR  slspt.mmis_specialty_type_id = orbhsi.mits_specialty_code ) AND orbhsi.include_in_report = 'OHIORISE_BH_SERVICES'   
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk msi 
   ON (pg.primary_mits_specialty_type_id = msi.mits_specialty_code OR  slspt.mmis_specialty_type_id = msi.mits_specialty_code ) AND msi.include_in_report = 'MAT_SERVICES'    
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk upi 
   ON  (pg.primary_mits_specialty_type_id = upi.mits_specialty_code OR  slspt.mmis_specialty_type_id = upi.mits_specialty_code )
     AND (pg.primary_mits_provider_type_id = upi.provider_type_code OR pg.secondary_mits_provider_type_id = upi.mits_specialty_code )
     AND upi.include_in_report = 'UNCOMMON_PCP'     
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk wsi 
   ON (pg.primary_mits_specialty_type_id = wsi.mits_specialty_code OR  slspt.mmis_specialty_type_id = wsi.mits_specialty_code ) AND wsi.include_in_report = 'WAIVER_SERVICES'
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk orwsi 
   ON (pg.primary_mits_specialty_type_id = orwsi.mits_specialty_code OR  slspt.mmis_specialty_type_id = orwsi.mits_specialty_code ) AND orwsi.include_in_report = 'OHIORISE_WAIVER_SERVICES' 
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk dsi 
   ON (pg.primary_mits_specialty_type_id = dsi.mits_specialty_code OR  slspt.mmis_specialty_type_id = dsi.mits_specialty_code ) AND dsi.include_in_report = 'DENTAL_SERVICES'  
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk vsi 
   ON (pg.primary_mits_specialty_type_id = vsi.mits_specialty_code OR  slspt.mmis_specialty_type_id = vsi.mits_specialty_code ) AND vsi.include_in_report = 'VISION_SERVICES' ;