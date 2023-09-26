delete sc_goal
where goal_id between 21 and 28;

commit;

delete sc_performance_tracker
where pt_id between 21 and 341;

commit;

delete sc_corrective_action
where ca_id between 21 and 71;

commit;