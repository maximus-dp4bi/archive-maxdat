create or replace view OHIO_PROVIDER_DP4BI_PROD_DB.PUBLIC.D_PM_MANAGED_CARE_PLAN_DETAILS_SV(
	REG_MCP_PG_AFFILIATION_ID,
	REG_MCP_PG_AFFILIATION_DETAIL_ID,
	REG_ID,
	PG_RECORD_TYPE_CODE,
	MCO_RECORD_TYPE_CODE,
	PLAN_NAME,
	PG_RECORD_TYPE,
	SERVICE_LOCATION_TYPE,
	PG_TRACKING_NUMBER,
	SL_TRACKING_NUMBER,
	PROVIDER_GROUP_TRACKING_NUMBER,
	GROUP_LOCATION_TRACKING_NUMBER,
	HEALTH_CENTER_TRACKING_NUMBER,
	MEDICAID_ID,
	START_DATE,
	END_DATE,
	PROGRAM_CODE,
	PROGRAM_TYPE,
	IS_PCP,
	PANEL_CAPACITY,
	PANEL_PCP_COUNT,
	NPI,
	PRN,
	NAME,
	SL_COUNTY_CODE,
	SL_COUNTY_NAME,
	SL_COUNTY_REGION,
	CREATE_DATE_TIME,
	CREATE_DATE,
	PRIMARY_SPECIALTY_TRACKING_NUMBER,
	SPECIALTY_COUNTY_CODE,
	SPECIALTY_COUNTY_NAME,
	SPECIALTY_COUNTY_REGION,
	MYCARE_REPORTING_COUNTY_CODE,
	MYCARE_COUNTY_NAME,
	MYCARE_COUNTY_REGION,
	PRIMARY_MITS_PROVIDER_TYPE_ID,
	PRIMARY_PROVIDER_TYPE,
	SECONDARY_MITS_PROVIDER_TYPE_ID,
	SECONDARY_PROVIDER_TYPE,
	PRIMARY_MITS_SPECIALTY_TYPE_ID,
	PRIMARY_SPECIALTY_NAME,
	MITS_SPECIALTIES,
	SL_SPECIALTY_NAME,
	BH_PRACTITIONER_INDICATOR,
	BH_SERVICES_INDICATOR,
	OHIORISE_BH_SERVICES_INDICATOR,
	MAT_SERVICES_INDICATOR,
	UNCOMMON_PCP_INDICATOR,
	WAIVER_SERVICES_INDICATOR,
	SPECIALTY_WAIVER_CATEGORY,
	OHIORISE_WAIVER_SERVICES_INDICATOR,
	OHIORISE_SPECIALTY_WAIVER_CATEGORY,
	DENTAL_SERVICES_INDICATOR,
	VISION_SERVICES_INDICATOR,
	MITS_SPECIALTY_CODE,
	SL_ZIP
) as 
 --PG/SL
  SELECT distinct
  pg.reg_mcp_pg_affiliation_id 
 ,sl.reg_mcp_pg_affiliation_detail_id
 ,pg.reg_id
 ,pg.pg_record_type_id pg_record_type_code
 ,sl.mco_record_type_code
 ,COALESCE(psd.plan_name,p.plan_name,p2.plan_name) plan_name
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
  ,spec.specialty_type_name as mits_specialties --sl.mits_specialties  --***SPECIALTIES
  ,spec.specialty_type_name sl_specialty_name --slspt.specialty_type_name sl_specialty_name
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
  ,spec.mmis_specialty_type_id mits_specialty_code
  ,sl.zip
FROM ohpnm_dp4bi.reg_mcp_pg_affiliation pg
  LEFT JOIN ohpnm_dp4bi.reg_mcp_pg_affiliation_detail sl ON pg.reg_mcp_pg_affiliation_id = sl.reg_mcp_pg_affiliation_id
  LEFT JOIN 
	(
	select distinct sl1.reg_mcp_pg_affiliation_detail_id, slspt1.specialty_type_id,slspt1.specialty_type_name,slspt1.mmis_specialty_type_id
	from ohpnm_dp4bi.reg_mcp_pg_affiliation a1
	JOIN ohpnm_dp4bi.reg_mcp_pg_affiliation_detail sl1 ON a1.reg_mcp_pg_affiliation_id=SL1.reg_mcp_pg_affiliation_id
	LEFT JOIN ohpnm_dp4bi.REG_MCP_PG_AFFILIATION_DETAIL_SPECIALTY ds1 on sl1.reg_mcp_pg_affiliation_detail_id = ds1.reg_mcp_pg_affiliation_detail_id
	LEFT JOIN ohpnm_dp4bi.specialty_type slspt1 ON slspt1.specialty_type_id = TRIM(REPLACE(REPLACE(ds1.specialty_type_id,'B',''),'|', '')) --slspt1.mmis_specialty_type_id = TRIM(REPLACE(REPLACE(ds1.specialty_type_id,'B',''),'|', ''))
	where slspt1.specialty_type_id is not null
	) spec ON sl.reg_mcp_pg_affiliation_detail_id = spec.reg_mcp_pg_affiliation_detail_id
  LEFT JOIN ohpnm_dp4bi.reg_mcp_pg_affiliation_detail stsl ON pg.primary_specialty_tracking_number = stsl.tracking_number
  LEFT JOIN ohpnm_dp4bi.submitter_id_mcp_xref sxr ON pg.reg_id = sxr.reg_id
  LEFT JOIN ohpnm_dp4bi.mcp_plans_submitter_details psd ON sxr.submitter_id = psd.submitter_id  
  LEFT JOIN ohpnm_dp4bi.mcpn_file m ON pg.mcpn_file_id = m.mcpn_file_id
  LEFT JOIN ohpnm_dp4bi.cfg_plan_types p ON SUBSTR(m.mcpn_file_name,3,3) = p.plan_id
  LEFT JOIN ohpnm_dp4bi.cfg_plan_types p2 ON SUBSTR(sl.tracking_number,1,3) = p2.plan_id
  LEFT JOIN ohpnm_dp4bi.cfg_program_types pt ON pt.program_code  = sl.program_code
  LEFT JOIN ohpnm_dp4bi.county crr ON sl.county_code = crr.mmis_county_code AND crr.state_abbreviation = 'OH'
  LEFT JOIN ohpnm_dp4bi.county_region crg ON UPPER(crg.county_name) = UPPER(TRIM(REPLACE(crr.county_name,'County','')))              
  --LEFT JOIN ohpnm_dp4bi.mycare_county_region crg ON sl.county_code=crg.mmis_mycare_county_region_id 
  
  LEFT JOIN ohpnm_dp4bi.county crs ON stsl.county_code = crs.mmis_county_code AND crs.state_abbreviation = 'OH'
  LEFT JOIN ohpnm_dp4bi.county_region crgs ON UPPER(crgs.county_name) = UPPER(TRIM(REPLACE(crs.county_name,'County','')))
  --LEFT JOIN ohpnm_dp4bi.mycare_county_region crgs ON stsl.county_code=crgs.mmis_mycare_county_region_id 
  
  LEFT JOIN ohpnm_dp4bi.county crmc ON pg.mycare_reporting_county_code = crmc.mmis_county_code AND crmc.state_abbreviation = 'OH'
  --LEFT JOIN ohpnm_dp4bi.county_region crgmc ON UPPER(crgmc.county_name) = UPPER(TRIM(REPLACE(crmc.county_name,'County',''))) 
  LEFT JOIN ohpnm_dp4bi.mycare_county_region crgmc ON crmc.mmis_county_code=crgmc.mmis_mycare_county_region_id 
  LEFT JOIN (SELECT DISTINCT mmis_provider_type_id, provider_type_name
             FROM ohpnm_dp4bi.provider_type) ptp ON ptp.mmis_provider_type_id = TO_CHAR(pg.primary_mits_provider_type_id)
  LEFT JOIN (SELECT DISTINCT mmis_provider_type_id, provider_type_name
             FROM ohpnm_dp4bi.provider_type) pts ON pts.mmis_provider_type_id = TO_CHAR(pg.secondary_mits_provider_type_id)    
  LEFT JOIN ohpnm_dp4bi.specialty_type pspt ON pspt.mmis_specialty_type_id = pg.primary_mits_specialty_type_id  
  LEFT JOIN ohpnm_dp4bi.specialty_type slspt ON  slspt.mmis_specialty_type_id = TRIM(REPLACE(REPLACE(sl.mits_specialties,'B',''),'|', ''))
  --LEFT JOIN ohpnm_dp4bi.specialty_type slspt ON  slspt.mmis_specialty_type_id = TRIM(REPLACE(REPLACE(spec.mmis_specialty_type_id,'B',''),'|', ''))
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk bhpi 
   ON (pg.primary_mits_specialty_type_id = bhpi.mits_specialty_code OR  spec.mmis_specialty_type_id = bhpi.mits_specialty_code ) AND bhpi.include_in_report = 'BH_PRACTITIONER'
 --  ON (pg.primary_mits_specialty_type_id = bhpi.mits_specialty_code OR  slspt.mmis_specialty_type_id = bhpi.mits_specialty_code ) AND bhpi.include_in_report = 'BH_PRACTITIONER'
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk bhsi 
   ON (pg.primary_mits_specialty_type_id = bhsi.mits_specialty_code OR  spec.mmis_specialty_type_id = bhsi.mits_specialty_code ) AND bhsi.include_in_report = 'BH_SERVICES'   
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk orbhsi 
   ON (pg.primary_mits_specialty_type_id = orbhsi.mits_specialty_code OR  spec.mmis_specialty_type_id = orbhsi.mits_specialty_code ) AND orbhsi.include_in_report = 'OHIORISE_BH_SERVICES'   
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk msi 
   ON (pg.primary_mits_specialty_type_id = msi.mits_specialty_code OR  spec.mmis_specialty_type_id = msi.mits_specialty_code ) AND msi.include_in_report = 'MAT_SERVICES' 
 --  ON (pg.primary_mits_specialty_type_id = msi.mits_specialty_code OR  slspt.mmis_specialty_type_id = msi.mits_specialty_code ) AND msi.include_in_report = 'MAT_SERVICES'    
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk upi 
   ON  (pg.primary_mits_specialty_type_id = upi.mits_specialty_code OR  spec.mmis_specialty_type_id = upi.mits_specialty_code )
     AND (pg.primary_mits_provider_type_id = upi.provider_type_code OR pg.secondary_mits_provider_type_id = upi.mits_specialty_code )
     AND upi.include_in_report = 'UNCOMMON_PCP'     
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk wsi 
   ON (pg.primary_mits_specialty_type_id = wsi.mits_specialty_code OR  spec.mmis_specialty_type_id = wsi.mits_specialty_code ) AND wsi.include_in_report = 'WAIVER_SERVICES'
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk orwsi 
   ON (pg.primary_mits_specialty_type_id = orwsi.mits_specialty_code OR  spec.mmis_specialty_type_id = orwsi.mits_specialty_code ) AND orwsi.include_in_report = 'OHIORISE_WAIVER_SERVICES' 
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk dsi 
   ON (pg.primary_mits_specialty_type_id = dsi.mits_specialty_code OR  spec.mmis_specialty_type_id = dsi.mits_specialty_code ) AND dsi.include_in_report = 'DENTAL_SERVICES'  
  LEFT JOIN ohpnm_dp4bi.cfg_mits_specialty_report_xwalk vsi 
   ON (pg.primary_mits_specialty_type_id = vsi.mits_specialty_code OR  spec.mmis_specialty_type_id = vsi.mits_specialty_code ) AND vsi.include_in_report = 'VISION_SERVICES';