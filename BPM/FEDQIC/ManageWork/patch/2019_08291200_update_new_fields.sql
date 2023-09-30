pdate maxdat.d_mw_task_instance set handle_time = (complete_date - curr_claim_date)*24;

update maxdat.d_mw_task_instance ti set ti.previous_task_type_id = (select ti2.task_type_id from maxdat.d_mw_task_instance ti2 where ti.source_reference_id = ti2.source_reference_id and ti.parent_task_id = ti2.task_id);



