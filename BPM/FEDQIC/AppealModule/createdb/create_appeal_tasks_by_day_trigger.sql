create or replace trigger TRG_AIU_D_MW_TASK_INSTANCE
after insert or update on D_MW_TASK_INSTANCE
for each row
declare
  v_termination_date date := null;
  v_old_termination_date date := null;
  v_update_flag number := null;
v_create_date_new date := null;
v_create_date_old date := null;
v_complete_date_new date := null;
v_complete_date_old date := null;
v_cancel_date_new date := null;
v_cancel_date_old date := null;
v_appeal_part_id_new number := null;
v_appeal_part_id_old number := null;
begin   
  if inserting then
begin
select ap.appeal_part_id into v_appeal_part_id_new from d_mw_appeal_instance ap where ap.appeal_id = :new.source_reference_id;
EXCEPTION WHEN NO_DATA_FOUND THEN
begin
select part_id into v_appeal_part_id_new
from d_appeal_parts
where part_name = :new.part 
and (start_date is null or start_date <= trunc(sysdate))
and (end_date is null or end_date > trunc(sysdate));
EXCEPTION WHEN NO_DATA_FOUND THEN
v_appeal_part_id_new := null;
end;
end; 

    v_termination_date := trunc(coalesce (:new.complete_date, :new.cancel_work_date));	    
    v_create_date_new := trunc(:new.create_date);
    update  F_APPEAL_TASKS_BY_DAY 
        set creation_count = case when d_date = v_create_date_new then creation_count +1 else creation_count end,
        completion_count = case when d_date = trunc(:new.complete_date) then completion_count + 1 else completion_count end,
        cancellation_count = case when d_date = trunc(:new.cancel_work_date) then cancellation_count + 1 else cancellation_count end,
        inventory_count = case when ((v_termination_date is null) or (d_date < trunc(v_termination_date))) then inventory_count + 1 
            else inventory_count end,
        last_update_date = sysdate
    where ((d_date >= v_create_date_new))
    and ((v_termination_date is null) or (d_date <= v_termination_date))
    and appeal_part_id = v_appeal_part_id_new
    and task_type_id = :new.task_type_id;
  end if;
  if updating then
    select 
        case when (decode(:old.create_date, :new.create_date,1,0)=0
        or decode(:old.complete_date, :new.complete_date,1,0)=0
        or decode(:old.cancel_work_date, :new.cancel_work_date,1,0)=0
        or decode(:old.part, :new.part,1,0)=0
        or decode(:old.task_type_id, :new.task_type_id,1,0)=0        
        ) then 1 else 0 end
    into  v_update_flag from dual;
    if ( v_update_flag = 1) then
v_create_date_new := trunc(:new.create_date);
v_create_date_old := trunc(:old.create_date);
v_complete_date_new := trunc(:new.complete_date);
v_complete_date_old := trunc(:old.complete_date);
v_cancel_date_new := trunc(:new.cancel_work_date);
v_cancel_date_old := trunc(:old.cancel_work_date);
v_old_termination_date := coalesce (v_complete_date_old, v_cancel_date_old);
v_termination_date := coalesce (v_complete_date_new, v_cancel_date_new); 
begin
select ap.appeal_part_id into v_appeal_part_id_new from d_mw_appeal_instance ap where ap.appeal_id = :new.source_reference_id;
EXCEPTION WHEN NO_DATA_FOUND THEN
begin
select part_id into v_appeal_part_id_new
from d_appeal_parts
where part_name = :new.part 
and (start_date is null or start_date <= trunc(sysdate))
and (end_date is null or end_date > trunc(sysdate));
EXCEPTION WHEN NO_DATA_FOUND THEN
v_appeal_part_id_new := null;
end;
end; 
begin
select ap.appeal_part_id into v_appeal_part_id_old from d_mw_appeal_instance ap where ap.appeal_id = :old.source_reference_id;
EXCEPTION WHEN NO_DATA_FOUND THEN
begin
select part_id into v_appeal_part_id_old
from d_appeal_parts
where part_name = :old.part 
and (start_date is null or start_date <= trunc(sysdate))
and (end_date is null or end_date > trunc(sysdate));
EXCEPTION WHEN NO_DATA_FOUND THEN
v_appeal_part_id_old := null;
end;
end; 
      update  F_APPEAL_TASKS_BY_DAY 
        set creation_count = case when (decode(v_create_date_old,v_create_date_new,1,0)=0 
        or decode(v_appeal_part_id_old, v_appeal_part_id_new,1,0)=0  or decode(:old.task_type_id, :new.task_type_id,1,0)=0) then 
            (case when d_date = v_create_date_old and appeal_part_id = v_appeal_part_id_old and task_type_id = :old.task_type_id then creation_count -1
                when d_date = v_create_date_new and appeal_part_id = v_appeal_part_id_new and task_type_id = :new.task_type_id then creation_count + 1 
                else creation_count end)
            else creation_count end,
        completion_count = case when (decode(v_complete_date_old, v_complete_date_new,1,0)=0 
        or decode(v_appeal_part_id_old, v_appeal_part_id_new,1,0)=0 or decode(:old.task_type_id, :new.task_type_id,1,0)=0) then 
            (case when d_date = v_complete_date_old and appeal_part_id = v_appeal_part_id_old and task_type_id = :old.task_type_id then completion_count - 1
                when d_date = v_complete_date_new and appeal_part_id = v_appeal_part_id_new and task_type_id = :new.task_type_id then completion_count + 1 
                else completion_count end)
            else completion_count end,
        cancellation_count = case when (decode(v_cancel_date_old, v_cancel_date_new,1,0)=0 
        or decode(v_appeal_part_id_old, v_appeal_part_id_new,1,0)=0 or decode(:old.task_type_id, :new.task_type_id,1,0)=0) then
            (case when d_date = v_cancel_date_old and appeal_part_id = v_appeal_part_id_old and task_type_id = :old.task_type_id then cancellation_count - 1
                when d_date = v_cancel_date_new and appeal_part_id = v_appeal_part_id_new and task_type_id = :new.task_type_id then cancellation_count + 1 
                else cancellation_count end)
            else cancellation_count end,
        inventory_count = case when (decode(v_create_date_old, v_create_date_new,1,0)=0  or decode(v_old_termination_date, v_termination_date,1,0)=0 
        or decode(v_appeal_part_id_old, v_appeal_part_id_new,1,0)=0 or decode(:old.task_type_id, :new.task_type_id,1,0)=0) then 
            (case 
when (((v_create_date_old is null) or (d_date >= v_create_date_old))
                and ((v_old_termination_date is null) or (d_date < v_old_termination_date))
                and appeal_part_id = v_appeal_part_id_old and task_type_id = :old.task_type_id)                  
and  (( ((v_create_date_new is not null) and (d_date < v_create_date_new)) 
                    or ((v_termination_date is not null) and (d_date >= v_termination_date)) )
                  or (appeal_part_id != v_appeal_part_id_new or task_type_id != :new.task_type_id )) 
                then inventory_count - 1                
when (((v_create_date_new is null) or (d_date >= v_create_date_new))
                    and ((v_termination_date is null) or (d_date < v_termination_date))
                      and appeal_part_id = v_appeal_part_id_new and task_type_id = :new.task_type_id)
and ( (((v_create_date_old is not null) and (d_date < v_create_date_old)) 
                        or ((v_old_termination_date is not null) and (d_date >= v_old_termination_date)))
       or (appeal_part_id != v_appeal_part_id_old or task_type_id != :old.task_type_id))            
                then inventory_count + 1
                else inventory_count
                end)
            else inventory_count
            end,
        last_update_date = sysdate
    where ((d_date >= v_create_date_old) or (d_date >= v_create_date_new) )
    and ((v_old_termination_date is null) or (d_date <= v_old_termination_date) or (v_termination_date is null) or (d_date <= v_termination_date))
    and ((appeal_part_id = v_appeal_part_id_new and task_type_id = :new.task_type_id) or (appeal_part_id = v_appeal_part_id_old and task_type_id = :old.task_type_id));
  end if;
  end if;
end;
/