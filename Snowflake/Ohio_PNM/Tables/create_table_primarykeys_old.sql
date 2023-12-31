use database OHIO_PROVIDER_DP4BI_DEV_DB;
use schema OHPNM_DP4BI_DEV;

alter table application_fee_payment_type add primary key (payment_type_id);
alter table application_fee_waiver_reason add primary key (application_fee_waiver_reason_id);
alter table application_status add primary key (application_status_id);
alter table application_type add primary key (application_type_id);
alter table aspnet_roles add primary key (RoleId);
alter table aspnet_users add primary key (UserId);
alter table aspnet_usersinroles add primary key (UserId, RoleId);
alter table a_credentialing add primary key (a_credentialing_id);
alter table a_wf_step add primary key (a_wf_step_id);
alter table communicationevent_party_reg_xref add primary key (communication_event_id, reg_id);
alter table communication_event add primary key (communication_event_id);
alter table communication_event_type add primary key (communication_event_type_id);
alter table county add primary key (county_id);
alter table county_region add primary key (county_region_id);
alter table credentialing add primary key (credentialing_id);
alter table credentialing_provider_specialty_type add primary key (credentialing_provider_specialty_type_id);
alter table credentialing_provider_specialty_type_mapping add primary key (mmis_provider_type, mmis_specialty_type, ha_standard, ha_orp, boardcert_standard);
alter table credentialing_provider_type add primary key (credentialing_provider_type_id);
alter table credentialing_result add primary key (credentialing_result_id);
alter table credentialing_status add primary key (credentialing_status_id);
alter table credential_activity add primary key (credential_activity_id);
alter table email add primary key (communication_event_id);
alter table enroll_status add primary key (enroll_status_id);
alter table languages_spoken add primary key (languages_spoken_id);
alter table mail add primary key (mail_id);
alter table provider_risk_level add primary key (provider_risk_level_id);
alter table provider_type add primary key (provider_type_id);
alter table registration add primary key (reg_id);
alter table registration_status_type add primary key (registration_status_type_id);
alter table registration_user_xref add primary key (reg_id, userid);
alter table reg_address add primary key (reg_address_id);
alter table reg_application add primary key (reg_application_id);
alter table reg_application_fee add primary key (reg_application_fee_id);
alter table reg_background_check add primary key (reg_background_check_id);
alter table reg_credentialing add primary key (reg_credentialing_id);
alter table reg_language add primary key (reg_language_id);
alter table reg_medicaid add primary key (reg_medicaid_id);
alter table reg_medicare add primary key (reg_medicare_id);
alter table reg_owner add primary key (reg_owner_id);
alter table reg_program_status_type add primary key (reg_program_status_type_id);
alter table reg_provider add primary key (reg_id);
alter table reg_provider_disenrollment add primary key (reg_provider_disenrollment_id);
alter table reg_provider_note_xref add primary key (reg_id, reg_page_type_id, provider_note_id);
alter table reg_provider_services_status_type add primary key (reg_provider_services_status_type_id);
alter table reg_provider_status_type add primary key (reg_provider_status_type_id);
alter table reg_screening add primary key (reg_screening_id);
alter table reg_specialty add primary key (reg_specialty_id);
alter table screening add primary key (screening_id);
alter table screening_activity add primary key (screening_activity_id);
alter table screening_activity_default_template add primary key (screening_activity_default_template_id);
alter table screening_activity_owner_template add primary key (screening_activity_owner_template_id);
alter table screening_activity_risk_level_template add primary key (screening_activity_risk_level_template_id);
alter table screening_activity_status add primary key (screening_activity_status_id);
alter table screening_activity_type add primary key (screening_activity_type_id);
alter table screening_activity_type_status_xref add primary key (screening_activity_type_status_id);
alter table screening_activity_type_url add primary key (screening_activity_type_url_id);
alter table screening_adverse_action add primary key (screening_adverse_action_id);
alter table screening_event_type add primary key (screening_event_type_id);
alter table screening_method add primary key (screening_method_id);
alter table screening_result add primary key (screening_result_id);
alter table screening_status add primary key (screening_status_id);
alter table site_visit add primary key (site_visit_id);
alter table site_visit_attempt add primary key (site_visit_attempt_id);
alter table site_visit_attempt_status add primary key (site_visit_attempt_status_id);
alter table site_visit_attempt_type add primary key (site_visit_attempt_type_id);
alter table site_visit_findings add primary key (site_visit_findings_id);
alter table site_visit_method add primary key (site_visit_method_id);
alter table site_visit_recommendation add primary key (site_visit_recommendation_id);
alter table site_visit_result add primary key (site_visit_result_id);
alter table site_visit_screening add primary key (site_visit_screening_id);
alter table site_visit_screening_status add primary key (site_visit_screening_status_id);
alter table site_visit_screening_type add primary key (site_visit_screening_type_id);
alter table site_visit_status add primary key (site_visit_status_id);
alter table site_visit_type add primary key (site_visit_type_id);
alter table specialty_type add primary key (specialty_type_id);
alter table user_account_information add primary key (userid);
alter table user_agent_reg_xref add primary key (user_agent_reg_xref_id);
alter table user_agent_role_xref add primary key (agent_role_xref_id);
alter table wf_action add primary key (action_id);
alter table wf_parameter add primary key (parameter_id);
alter table wf_process add primary key (process_id);
alter table wf_step add primary key (step_id);
alter table wf_task add primary key (task_id);
alter table wf_task_group add primary key (task_id, group_name);
alter table wf_workflow add primary key (workflow_id);
alter table a_reg_application add primary key (a_reg_application_id);
alter table application_fee_new add primary key (reg_application_fee_id,reg_id);