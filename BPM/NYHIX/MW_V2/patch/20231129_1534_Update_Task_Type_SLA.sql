update maxdat.d_task_types
set sla_jeopardy_days = 25,
    sla_days = 30
where task_name = 'Multiple Applications';
-- Update D_TASK_TYPES IAW FEATURE 36456
update maxdat.d_task_types
set sla_jeopardy_days = 2,
    sla_days = 5
where task_name = 'Authorized Representative Task';

update maxdat.d_task_types
set sla_jeopardy_days = 2,
    sla_days = 5
where task_name = 'Authorized Representative- Upload';

update maxdat.d_task_types
set sla_jeopardy_days = 25,
    sla_days = 30
where task_name = 'DPR - Application-Missing Data';

update maxdat.d_task_types
set sla_jeopardy_days = 6,
    sla_days = 8
where task_name = 'Returned Mail';

update maxdat.d_task_types
set sla_jeopardy_days = 25,
    sla_days = 30
where task_name = 'DPR - Application in Process';

update maxdat.d_task_types
set sla_jeopardy_days = 1,
    sla_days = 3
where task_name = 'DPR - Existing Appeal';

update maxdat.d_task_types
set sla_jeopardy_days = 2,
    sla_days = 5
where task_name = 'Relink Request';

update maxdat.d_task_types
set sla_jeopardy_days = 2,
    sla_days = 5
where task_name = 'Large Font Notice Request';

update maxdat.d_task_types
set sla_jeopardy_days = 2,
    sla_days = 5
where task_name = 'Application Assessment';

update maxdat.d_task_types
set sla_jeopardy_days = 3,
    sla_days = 2
where task_name = 'DPR - Nav/CAC ID Proofing';

update maxdat.d_task_types
set sla_jeopardy_days = 2,
    sla_days = 5
where task_name = 'Application Rejection';

COMMIT;