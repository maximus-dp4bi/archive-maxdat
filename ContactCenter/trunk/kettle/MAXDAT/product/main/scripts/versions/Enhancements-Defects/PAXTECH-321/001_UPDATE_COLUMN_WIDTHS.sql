alter session set current_schema = cisco_enterprise_cc;

alter table cc_f_acd_agent_interval
  modify (
    contacts_abandoned number(12,0),
    contacts_handled number(12,0),
    contacts_offered number(12,0),
    contacts_transferred number(12,0),
    stddev_handle_time number(14,2)
);

alter table cc_s_acd_agent_interval
  modify (
    contacts_handled number(12,0),
    contacts_abandoned number(12,0),
    contacts_offered number(12,0),
    contacts_transferred number(12,0)
);

alter table cc_f_acd_queue_interval
  modify (
    service_level_answered_count number(12,0),
    agent_error_count number(12,0),
    network_default_routed number(12,0),
    calls_on_hold number(12,0),
    calls_given_force_disconnect number(12,0),
    return_ring number(12,0),
    short_abandons number(12,0),
    calls_rona number(12,0),
    contacts_abandoned number(12,0),
    abandon_threshold number(12,0),
    contacts_offered number(12,0),
    incomplete_calls number(12,0),
    return_release number(12,0),
    outflow_contacts number(12,0),
    calls_routed_non_agent number(12,0),
    error_count number(12,0),
    icr_default_routed number(12,0),
    contact_inventory_jeopardy number(12,0),
    contacts_transferred number(12,0),
    contacts_received_from_ivr number(12,0),
    contact_inventory number(12,0),
    contacts_blocked number(12,0),
    max_calls_queued number(12,0),
    return_busy number(12,0),
    calls_answered number(12,0),
    contacts_handled number(12,0),
    short_calls number(12,0),
    calls_given_route_to number(12,0)
);

alter table cc_s_acd_queue_interval
  modify (
    return_ring number(12,0),
    agent_error_count number(12,0),
    contacts_received_from_ivr number(12,0),
    contacts_blocked number(12,0),
    return_release number(12,0),
    short_calls number(12,0),
    short_abandons number(12,0),
    error_count number(12,0),
    contact_inventory number(12,0),
    outflow_contacts number(12,0),
    calls_given_force_disconnect number(12,0),
    contacts_abandoned number(12,0),
    contact_inventory_jeopardy number(12,0),
    service_level_answered_count number(12,0),
    network_default_routed number(12,0),
    return_busy number(12,0),
    calls_routed_non_agent number(12,0),
    calls_rona number(12,0),
    contacts_transferred number(12,0),
    calls_answered number(12,0),
    max_calls_queued number(12,0),
    contacts_handled number(12,0),
    incomplete_calls number(12,0),
    calls_on_hold number(12,0),
    contacts_offered number(12,0),
    abandon_threshold number(12,0),
    calls_given_route_to number(12,0),
    icr_default_routed number(12,0)
);

alter table cc_f_actuals_queue_interval
  modify (
    contacts_abandoned number(12,0),
    contacts_transferred number(12,0),
    calls_routed_non_agent number(12,0),
    calls_given_route_to number(12,0),
    return_ring number(12,0),
    calls_answered number(12,0),
    incomplete_calls number(12,0),
    short_calls number(12,0),
    return_busy number(12,0),
    icr_default_routed number(12,0),
    short_abandons number(12,0),
    error_count number(12,0),
    return_release number(12,0),
    service_level_answered_count number(12,0),
    calls_on_hold number(12,0),
    contacts_offered number(12,0),
    network_default_routed number(12,0),
    outflow_contacts number(12,0),
    max_calls_queued number(12,0),
    calls_rona number(12,0),
    calls_given_force_disconnect number(12,0),
    contact_inventory number(12,0),
    contact_inventory_jeopardy number(12,0),
    contacts_received_from_ivr number(12,0),
    contacts_handled number(12,0),
    contacts_blocked number(12,0),
    agent_error_count number(12,0),
    service_level_abandoned number(14,2),
    abandon_threshold number(12,0)
);

alter table cc_s_acd_interval
  modify (
    network_default_routed number(12,0),
    service_level_abandoned number(14,2),
    contacts_handled number(12,0),
    error_count number(12,0),
    agent_error_count number(12,0),
    contacts_transferred number(12,0),
    return_busy number(12,0),
    outflow_contacts number(12,0),
    short_calls number(12,0),
    calls_on_hold number(12,0),
    contact_inventory number(12,0),
    contact_inventory_jeopardy number(12,0),
    return_release number(12,0),
    contacts_blocked number(12,0),
    calls_given_force_disconnect number(12,0),
    calls_given_route_to number(12,0),
    max_calls_queued number(12,0),
    calls_rona number(12,0),
    contacts_offered number(12,0),
    calls_routed_non_agent number(12,0),
    return_ring number(12,0),
    abandon_threshold number(12,0),
    contacts_abandoned number(12,0),
    calls_answered number(12,0),
    service_level_answered_count number(12,0),
    incomplete_calls number(12,0),
    short_abandons number(12,0),
    icr_default_routed number(12,0),
    contacts_received_from_ivr number(12,0),
    calls_abandoned_period_1 number(12,0),
    calls_abandoned_period_2 number(12,0),
    calls_abandoned_period_3 number(12,0),
    calls_abandoned_period_4 number(12,0),
    calls_abandoned_period_5 number(12,0),
    calls_abandoned_period_6 number(12,0),
    calls_abandoned_period_7 number(12,0),
    calls_abandoned_period_8 number(12,0),
    calls_abandoned_period_9 number(12,0),
    calls_abandoned_period_10 number(12,0),
    speed_of_answer_period_1 number(12,0),
    speed_of_answer_period_2 number(12,0),
    speed_of_answer_period_3 number(12,0),
    speed_of_answer_period_4 number(12,0),
    speed_of_answer_period_5 number(12,0),
    speed_of_answer_period_6 number(12,0),
    speed_of_answer_period_7 number(12,0),
    speed_of_answer_period_8 number(12,0),
    speed_of_answer_period_9 number(12,0),
    speed_of_answer_period_10 number(12,0)
);

alter table cc_f_actuals_ivr_interval
  modify (
    contacts_contained_in_ivr number(12,0),
    contacts_created number(12,0),
    contacts_offered_to_acd number(12,0)
);

alter table cc_f_agent_by_date
  modify (
    at_work_paid_time number(12,0)
);

alter table cc_f_agent_rtg_grp_interval
  modify (
    internal_seconds number(14,2),
    login_seconds number(14,2),
    external_seconds number(14,2),
    idle_seconds number(14,2),
    not_ready_seconds number(14,2),
    talk_reserve_seconds number(14,2),
    ring_seconds number(14,2),
    talk_seconds number(14,2),
    predictive_talk_seconds number(14,2),
    preview_talk_seconds number(14,2),
    hold_seconds number(14,2),
    wrap_seconds number(14,2)
);

alter table cc_s_agent_rtg_grp_interval
  modify (
    internal_seconds number(14,2),
    login_seconds number(14,2),
    external_seconds number(14,2),
    idle_seconds number(14,2),
    not_ready_seconds number(14,2),
    talk_reserve_seconds number(14,2),
    ring_seconds number(14,2),
    acd_talk_seconds number(14,2),
    predictive_talk_seconds number(14,2),
    preview_talk_seconds number(14,2),
    hold_seconds number(14,2),
    after_call_work_seconds number(14,2)  
);

alter table cc_f_agent_by_date
  modify (
    actual_overtime_minutes number(14,2),
    actual_shift_minutes number(14,2),
    scheduled_shift_minutes number(14,2)
);

alter table cc_s_agent_work_day
  modify (
    actual_overtime_minutes number(14,2),
    actual_shift_minutes number(14,2),
    scheduled_shift_minutes number(14,2)
);