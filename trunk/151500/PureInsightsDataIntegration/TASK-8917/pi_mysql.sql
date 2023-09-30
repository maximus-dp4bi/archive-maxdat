select
	(select count(*) from PureCloud.audio_quality) as audio_quality_cnt,
	(select count(*) from PureCloud.billable_usage) as billable_usage_cnt,
	(select count(*) from PureCloud.configuration_objects) as configuration_objects_cnt,
	(select count(*) from PureCloud.contact_center_settings) as contact_center_settings_cnt,
	(select count(*) from PureCloud.conversations) as conversations_cnt,
	(select count(*) from PureCloud.conversations_detail) as conversations_detail_cnt ,
	(select count(*) from PureCloud.conversations_summary) as conversations_summary_cnt,
	(select count(*) from PureCloud.conversation_attributes) as conversations_attributes_cnt,
	(select count(*) from PureCloud.dialer_detail) as dialer_detail_cnt,
	(select count(*) from PureCloud.dialer_preview_detail) as dialer_preview_detail_cnt,
	(select count(*) from PureCloud.divisions) as divisions_cnt,
	(select count(*) from PureCloud.evaluations) as evaluations_cnt,
	(select count(*) from PureCloud.evaluation_calibrations) as evaluation_calibrations_cnt,
    (select count(*) from PureCloud.flow_outcomes) as flow_outcomes_cnt,
    (select count(*) from PureCloud.group_membership) as group_membership_cnt,  -- Table is called groups_membership in PIDI?                                    
    (select count(*) from PureCloud.participants) as participants_cnt,
    (select count(*) from PureCloud.primary_presence) as primary_presence_cnt,
    (select count(*) from PureCloud.queue_membership) as queue_membership_cnt,  -- Table is called queues_membership in PIDI?
    (select count(*) from PureCloud.queue_configuration) as queue_configuration_cnt,
    (select count(*) from PureCloud.queue_interval_aggregates) as queue_interval_aggregates_cnt,
    (select count(*) from PureCloud.routing_status) as routing_status_cnt,
    (select count(*) from PureCloud.segments) as segments_cnt,
	(select count(*) from PureCloud.sessions) as sessions_cnt,
	(select count(*) from PureCloud.session_summary) as session_summary_cnt,
	(select count(*) from PureCloud.user_details) as user_details_cnt,
	(select count(*) from PureCloud.user_locations) as user_locations_cnt,
	(select count(*) from PureCloud.user_roles) as user_roles_cnt,
	(select count(*) from PureCloud.user_skills) as user_skills_cnt,
	(select count(*) from PureCloud.wfm_activity_code_configuration) as wfm_activity_code_configuration_cnt,   -- Table is called wfm_activity_codes in PIDI?                     
	(select count(*) from PureCloud.wfm_day_metrics) as wfm_day_metrics_cnt
from
	dual;