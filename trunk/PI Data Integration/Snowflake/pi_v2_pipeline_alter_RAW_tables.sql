use role SYSADMIN;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema RAW;

--SELECT 'ALTER TABLE raw.' || table_name || ' ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT ''INSERT'' );' FROM PUBLIC.d_pi_tables ORDER BY table_name;
--SELECT 'ALTER TABLE raw.' || table_name || ' ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT ''?'' );' FROM PUBLIC.d_pi_tables ORDER BY table_name;

ALTER TABLE raw.audio_quality ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.billable_usage ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.configuration_objects ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.contact_center_settings ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.conversation_attributes ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.conversations ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.conversations_detail ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.conversations_summary ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.dialer_detail ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.dialer_preview_detail ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.divisions ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.evaluation_calibrations ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.evaluation_forms ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.evaluations ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.flow_outcomes ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.groups_membership ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.locations ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.mysql_audits ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.participants ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.primary_presence ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.queue_configuration ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.queues_membership ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.routing_status ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.segments ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.session_summary ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.sessions ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.user_details ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.user_locations ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.user_roles ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.user_skills ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.wfm_activity_codes ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.wfm_day_metrics ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.wfm_historical_actuals ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.wfm_historical_exceptions ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.wfm_management_unit_configuration ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.wfm_schedule ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );
ALTER TABLE raw.wrapup_mapping ADD (INGESTIONDMLOPERATION		VARCHAR(200)	NOT NULL	DEFAULT 'INSERT' );

ALTER TABLE raw.audio_quality ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.billable_usage ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.configuration_objects ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.contact_center_settings ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.conversation_attributes ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.conversations ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.conversations_detail ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.conversations_summary ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.dialer_detail ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.dialer_preview_detail ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.divisions ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.evaluation_calibrations ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.evaluation_forms ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.evaluations ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.flow_outcomes ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.groups_membership ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.locations ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.mysql_audits ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.participants ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.primary_presence ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.queue_configuration ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.queues_membership ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.routing_status ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.segments ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.session_summary ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.sessions ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.user_details ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.user_locations ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.user_roles ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.user_skills ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.wfm_activity_codes ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.wfm_day_metrics ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.wfm_historical_actuals ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.wfm_historical_exceptions ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.wfm_management_unit_configuration ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.wfm_schedule ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
ALTER TABLE raw.wrapup_mapping ADD (INGESTIONSOURCE		VARCHAR(500)	NOT NULL	DEFAULT '?' );
