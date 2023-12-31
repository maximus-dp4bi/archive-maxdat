use database OHIO_PROVIDER_DP4BI_DEV_DB;

use schema OHPNM_DP4BI_DEV;
alter table a_credentialing add primary key (a_credentialing_id);
alter table a_wf_step add primary key (a_wf_step_id);
alter table application_status add primary key (application_status_id);
alter table application_type add primary key (application_type_id);
alter table communication_event add primary key (communication_event_id);
alter table county add primary key (county_id);
alter table county_region add primary key (county_region_id);
alter table credentialing add primary key (credentialing_id);
alter table credentialing_status add primary key (credentialing_status_id);
alter table email add primary key (communication_event_id);
alter table enroll_status add primary key (enroll_status_id);
alter table languages_spoken add primary key (languages_spoken_id);
alter table mail add primary key (mail_id);
alter table MCPN_ERROR_CODE add primary key (MCPN_ERROR_CODE_ID);
alter table MCPN_FILE add primary key (MCPN_FILE_ID);
alter table MCPN_MITS_PROVIDER_TYPE_XREF add primary key(MCPN_MITS_PROVIDER_TYPE_XREF_ID);
alter table MCPN_PROVIDER_TYPES add primary key(MCPN_PROVIDER_TYPES_ID);
alter table provider_risk_level add primary key (provider_risk_level_id);
alter table provider_type add primary key (provider_type_id);
alter table reg_address add primary key (reg_address_id);
alter table reg_application add primary key (reg_application_id);
alter table reg_background_check add primary key (reg_background_check_id);
alter table reg_credentialing add primary key (reg_credentialing_id);
alter table reg_language add primary key (reg_language_id);
alter table REG_MCP_AFFILIATION add primary key(REG_MCP_AFFILIATION_ID);
alter table REG_MCP_AFFILIATION_CAREPLAN add primary key(REG_MCP_AFFILIATION_CAREPLAN_ID);
alter table REG_MCP_AFFILIATION_CAREPLAN_DETAILS add primary key(DETAILS_ID);
alter table REG_MCP_AFFILIATION_LANGUAGE add primary key(REG_MCP_AFFILIATION_LANGUAGE_ID);
alter table REG_MCP_AFFILIATION_SPECIALTY add primary key(REG_MCP_AFFILIATION_SPECIALTY_ID);
alter table REG_MCP_PG_AFFILIATION add primary key(REG_MCP_PG_AFFILIATION_ID);
alter table REG_MCP_PG_AFFILIATION_DETAIL add primary key(REG_MCP_PG_AFFILIATION_DETAIL_ID);
alter table REG_MCP_PG_AFFILIATION_DETAIL_LANGUAGE add primary key(REG_MCP_PG_AFFILIATION_DETAIL_LANGUAGE_ID);
alter table REG_MCP_PG_AFFILIATION_DETAIL_M_SPECIALTY add primary key(REG_MCP_PG_AFFILIATION_DETAIL_M_SPECIALTY_ID);
alter table REG_MCP_PG_AFFILIATION_DETAIL_SPECIALTY add primary key(REG_MCP_PG_AFFILIATION_DETAIL_SPECIALTY_ID);
alter table REG_MCP_PG_AFFILIATION_HOSPITAL_PRIVILEGES add primary key(REG_MCP_PG_AFFILIATION_HOSPITAL_PRIVILEGES_ID);
alter table reg_medicaid add primary key (reg_medicaid_id);
alter table reg_owner add primary key (reg_owner_id);
alter table reg_provider add primary key (reg_id);
alter table reg_screening add primary key (reg_screening_id);
alter table reg_specialty add primary key (reg_specialty_id);
alter table registration add primary key (reg_id);
alter table registration_status_type add primary key (registration_status_type_id);
alter table screening add primary key (screening_id);
alter table screening_activity add primary key (screening_activity_id);
alter table screening_activity_type add primary key (screening_activity_type_id);
alter table screening_method add primary key (screening_method_id);
alter table screening_result add primary key (screening_result_id);
alter table specialty_type add primary key (specialty_type_id);
alter table user_account_information add primary key (userid);
alter table wf_action add primary key (action_id);
alter table wf_parameter add primary key (parameter_id);
alter table wf_process add primary key (process_id);
alter table wf_step add primary key (step_id);
alter table wf_task add primary key (task_id);
alter table wf_workflow add primary key (workflow_id);
alter table mcp_plans_submitter_details add primary key (MCP_PLANS_SUBMITTER_DETAILS_ID);
alter table submitter_id_mcp_xref add primary key (SUBMITTER_ID_MCP_XREF_ID);
alter table reg_modified_status_type add primary key (REG_STATUS_TYPE_ID);
alter table m_specialy_type add primary key (M_SPECIALY_TYPE_ID);
alter table address_type add primary key (ADDRESS_TYPE_ID);
alter table reg_service_location add primary key (REG_SERVICE_LOCATION_ID);
