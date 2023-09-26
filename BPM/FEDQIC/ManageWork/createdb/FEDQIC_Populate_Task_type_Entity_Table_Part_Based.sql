insert into maxdat.d_bpm_task_type_entity (task_type_id, entity_id)
(select to_number(e2.task_type_id || 1578), e2.entity_id from maxdat.d_bpm_task_type_entity e2);

insert into maxdat.d_bpm_task_type_entity
(select to_number(e2.task_type_id || 1579), e2.entity_id from maxdat.d_bpm_task_type_entity e2
where not e2.task_type_id like '%1578');

insert into maxdat.d_bpm_task_type_entity
(select to_number(e2.task_type_id || 1580), e2.entity_id from maxdat.d_bpm_task_type_entity e2
where not e2.task_type_id like '%1578' and not e2.task_type_id like '%1579');

insert into maxdat.d_bpm_task_type_entity
(select to_number(e2.task_type_id || 1581), e2.entity_id from maxdat.d_bpm_task_type_entity e2
where not e2.task_type_id like '%1578' and not e2.task_type_id like '%1579' and not e2.task_type_id like '%1580');

insert into maxdat.d_bpm_task_type_entity
(select to_number(e2.task_type_id || 9286944), e2.entity_id from maxdat.d_bpm_task_type_entity e2
where not e2.task_type_id like '%1578' and not e2.task_type_id like '%1579' and not e2.task_type_id like '%1580' and not e2.task_type_id like '%1581');


commit;

----------------------------------------------------------------------------
--undo

delete maxdat.d_bpm_task_type_entity 
where task_type_id like '%1578'
or task_type_id like '%1579'
or task_type_id like '%1580' 
or task_type_id like '%1581' 
or task_type_id like '%9286944';