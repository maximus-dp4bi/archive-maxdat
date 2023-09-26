create or replace view OHIO_PROVIDER_DP4BI_PROD_DB.PUBLIC.D_PM_FACILITY_AFFILIATION_DETAILS_SV(
	REG_MCP_AFFILIATION_ID,
	REG_ID,
	PLAN_NAME,
	MCO_RECORD_TYPE_CODE,
	FACILITY_TYPE,
	TRACKING_NUMBER,
	START_DATE,
	END_DATE,
	HOSPITAL_NUMBER,
	MEDICAID_ID,
	PROGRAM_CODE,
	PROGRAM_TYPE,
	IS_PCP,
	PANEL_CAPACITY,
	PANEL_PCP_COUNT,
	NPI,
	COUNTY_CODE,
	COUNTY_NAME,
	MITS_SPECIALTY,
	NAME,
	COUNTY_REGION,
	CREATE_DATE_TIME,
	CREATE_DATE
) as
SELECT fa.reg_mcp_affiliation_id
  ,fa.reg_id
  ,COALESCE(psd.plan_name,p.plan_name) plan_name
  ,fa.mco_record_type_code
  ,CASE WHEN fa.mco_record_type_code = 1 THEN 'Hospital'
        WHEN fa.mco_record_type_code = 2 THEN 'Health Center'
        WHEN fa.mco_record_type_code = 3 THEN 'Nursing Facility'
        WHEN fa.mco_record_type_code = 4 THEN 'Inpatient Psychiatric Facility'
     ELSE 'Unknown' END facility_type
  ,fa.tracking_number
  ,fa.start_date
  ,fa.end_date
  ,fa.hospital_number
  ,fa.medicaid_id
  ,fa.program_code
  ,pt.program_type
  ,CASE WHEN fa.is_pcp = 0 THEN 0 ELSE 1 END is_pcp
  ,COALESCE(fa.panel_capacity,fd.panel_capacity) panel_capacity
  ,COALESCE(fa.panel_pcp_count,fd.panel_pcp_count) panel_pcp_count
  ,fa.npi
  ,COALESCE(fa.county_code,ra.county,fd.county_code) county_code
  ,TRIM(REPLACE(crr.county_name,'County','')) county_name
  ,fa.mits_specialty  
  ,COALESCE(fa.name,rp.name) name
  ,crg.county_region 
  ,fa.created_on_date_time create_date_time
  ,CAST(fa.created_on_date_time AS DATE) create_date  
FROM OHPNM_DP4BI.reg_mcp_affiliation fa
  LEFT JOIN OHPNM_DP4BI.reg_mcp_pg_affiliation_detail fd ON fa.tracking_number = fd.health_center_tracking_number
  LEFT JOIN OHPNM_DP4BI.submitter_id_mcp_xref sxr ON fa.reg_id = sxr.reg_id
  LEFT JOIN OHPNM_DP4BI.mcp_plans_submitter_details psd ON sxr.submitter_id = psd.submitter_id
  LEFT JOIN OHPNM_DP4BI.mcpn_file m ON fa.mcpn_file_id = m.mcpn_file_id
  LEFT JOIN OHPNM_DP4BI.cfg_plan_types p ON SUBSTR(m.mcpn_file_name,3,3) = p.plan_id
  LEFT JOIN OHPNM_DP4BI.cfg_program_types pt ON pt.program_code  = fa.program_code
  LEFT JOIN OHPNM_DP4BI.reg_service_location rsl ON fa.medicaid_id = rsl.medicaid_id
  LEFT JOIN OHPNM_DP4BI.reg_provider rp ON rsl.reg_id = rp.reg_id
  LEFT JOIN (SELECT ra.*
             FROM OHPNM_DP4BI.reg_address ra 
               JOIN OHPNM_DP4BI.address_type addrt ON ra.address_type_id = addrt.address_type_id
             WHERE address_type_name = 'SERVICE LOC') ra ON rp.reg_id = ra.reg_id
  LEFT JOIN OHPNM_DP4BI.county crr ON COALESCE(fa.county_code,ra.county,fd.county_code) = crr.mmis_county_code AND crr.state_abbreviation = 'OH'
  LEFT JOIN OHPNM_DP4BI.county_region crg ON UPPER(crg.county_name) = UPPER(TRIM(REPLACE(crr.county_name,'County','')))              
 
;