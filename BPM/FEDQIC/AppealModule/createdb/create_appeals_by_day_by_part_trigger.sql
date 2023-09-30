create or replace trigger TRG_AIU_D_MW_APPEAL_INSTANCE
after insert or update on D_MW_APPEAL_INSTANCE
for each row
declare
  v_termination_date date := null;
  v_old_termination_date date := null;
  v_update_flag number := null;
begin   
  if inserting then
    v_termination_date := coalesce (:new.closed_date, :new.cancelled_date, :new.withdrawn_date);	    
    update  F_APPEALS_BY_DAY_BY_PART 
        set creation_count = case when d_date = trunc(:new.create_date) then creation_count +1 else creation_count end,
        completion_count = case when d_date = trunc(:new.complete_date) then completion_count + 1 else completion_count end,
        timely_appeals_count = case when (d_date = trunc(:new.complete_date)) and (:new.complete_date <= :new.deadline_date) 
            then timely_appeals_count + 1 else timely_appeals_count end,
        untimely_appeals_count = case when ((d_date = trunc(:new.complete_date)) and (:new.complete_date > :new.deadline_date)) 
            then untimely_appeals_count + 1 else untimely_appeals_count end,
        closed_count = case when d_date = trunc(:new.closed_date) then closed_count + 1 else closed_count end,
        cancellation_count = case when d_date = trunc(:new.cancelled_date) then cancellation_count + 1 else cancellation_count end,
        withdrawn_count = case when d_date = trunc(:new.withdrawn_date) then withdrawn_count +1 else withdrawn_count end,
        termination_count = case when d_date = trunc(v_termination_date) then termination_count + 1 else termination_count end,
        inventory_count = case when ((v_termination_date is null) or (d_date < trunc(v_termination_date))) then inventory_count + 1 
            else inventory_count end,
        sla_inventory_count = case when ((v_termination_date is null) or (d_date < trunc(v_termination_date))) 
            and ((:new.complete_date is null) or (d_date < trunc(:new.complete_date))) then sla_inventory_count + 1 
            else sla_inventory_count end,
        last_update_date = sysdate
    where ((:new.create_date is null) or (d_date >= trunc(:new.create_date)))
    and ((v_termination_date is null) or (d_date <= trunc(v_termination_date)))
    and appeal_part_id = :new.appeal_part_id;
  end if;
  if updating then
    select 
        case when (decode(:old.create_date, :new.create_date,1,0)=0
        or decode(:old.complete_date, :new.complete_date,1,0)=0
        or decode(:old.closed_date, :new.closed_date,1,0)=0
        or decode(:old.cancelled_date, :new.cancelled_date,1,0)=0
        or decode(:old.withdrawn_date, :new.withdrawn_date,1,0)=0
        or decode(:old.deadline_date, :new.deadline_date,1,0)=0
        or decode(:old.appeal_part_id, :new.appeal_part_id,1,0)=0
        ) then 1 else 0 end
    into  v_update_flag from dual;
    if ( v_update_flag = 1) then
    v_old_termination_date := coalesce (:old.closed_date, :old.cancelled_date, :old.withdrawn_date);	
    v_termination_date := coalesce (:new.closed_date, :new.cancelled_date, :new.withdrawn_date);    
    update  F_APPEALS_BY_DAY_BY_PART 
        set creation_count = case when (decode(trunc(:old.create_date), trunc(:new.create_date),1,0)=0 or decode(:old.appeal_part_id, :new.appeal_part_id,1,0)=0) then 
            (case when d_date = trunc(:old.create_date) then creation_count -1
                when d_date = trunc(:new.create_date) then creation_count + 1 
                else creation_count end)
            else creation_count end,
        completion_count = case when (decode(trunc(:old.complete_date), trunc(:new.complete_date),1,0)=0 or decode(:old.appeal_part_id, :new.appeal_part_id,1,0)=0) then 
            (case when d_date = trunc(:old.complete_date) then completion_count - 1
                when d_date = trunc(:new.complete_date) then completion_count + 1 
                else completion_count end)
            else completion_count end,
        closed_count = case when (decode(trunc(:old.closed_date), trunc(:new.closed_date),1,0)=0  or decode(:old.appeal_part_id, :new.appeal_part_id,1,0)=0) then
            (case when d_date = trunc(:old.closed_date) then closed_count - 1
                when d_date = trunc(:new.closed_date) then closed_count + 1 
                else closed_count end)
                else closed_count end,
        cancellation_count = case when (decode(trunc(:old.cancelled_date), trunc(:new.cancelled_date),1,0)=0 or decode(:old.appeal_part_id, :new.appeal_part_id,1,0)=0) then
            (case when d_date = trunc(:old.cancelled_date) then cancellation_count - 1
                when d_date = trunc(:new.cancelled_date) then cancellation_count + 1 
                else cancellation_count end)
            else cancellation_count end,
        withdrawn_count = case when (decode(trunc(:old.withdrawn_date), trunc(:new.withdrawn_date),1,0)=0 or decode(:old.appeal_part_id, :new.appeal_part_id,1,0)=0) then 
            (case when d_date = trunc(:old.withdrawn_date) then withdrawn_count - 1 
                when decode(:old.withdrawn_date, :new.withdrawn_date,1,0)=0  and d_date = trunc(:new.withdrawn_date) then withdrawn_count + 1 
                else withdrawn_count end)
            else withdrawn_count end,
        termination_count = case when (decode(trunc(v_old_termination_date), trunc(v_termination_date),1,0)=0 or decode(:old.appeal_part_id, :new.appeal_part_id,1,0)=0) then   
            (case when d_date = trunc(v_old_termination_date) then termination_count - 1
                when decode(v_old_termination_date, v_termination_date,1,0)=0  and d_date = trunc(v_termination_date) then termination_count + 1 
                else termination_count end)
            else termination_count end,
        timely_appeals_count = case 
            when ( decode(:old.complete_date, :new.complete_date,1,0)=0 or decode(:old.deadline_date, :new.deadline_date,1,0)=0 or decode(:old.appeal_part_id, :new.appeal_part_id,1,0)=0) then
            (case when ( (d_date = trunc(:old.complete_date)) and (:old.complete_date <= :old.deadline_date)   )
                and ( (:new.complete_date is null or d_date != trunc(:new.complete_date)) 
                    or (:new.deadline_date is null or :new.complete_date > :new.deadline_date) )
                then timely_appeals_count - 1            
                when ( (d_date = trunc(:new.complete_date)) and (:new.complete_date <= :new.deadline_date)   )
                    and ( (:old.complete_date is null or d_date != trunc(:old.complete_date)) 
                        or (:old.deadline_date is null or :old.complete_date > :old.deadline_date) )
                then timely_appeals_count + 1
            else timely_appeals_count
            end)
        else timely_appeals_count
        end,
        untimely_appeals_count = case 
            when ( decode(:old.complete_date, :new.complete_date,1,0)=0 or decode(:old.deadline_date, :new.deadline_date,1,0)=0 or decode(:old.appeal_part_id, :new.appeal_part_id,1,0)=0) then
                (case when ((d_date = trunc(:old.complete_date)) and (:old.complete_date > :old.deadline_date))
                    and ( (:new.complete_date is null or d_date != trunc(:new.complete_date))     
                        or ( :new.deadline_date is null or :new.complete_date <= :new.deadline_date) ) 
                then untimely_appeals_count - 1

                when ((d_date = trunc(:new.complete_date)) and (:new.complete_date > :new.deadline_date))
                    and ( (:old.complete_date is null or d_date != trunc(:old.complete_date))     
                        or ( :old.deadline_date is null or :old.complete_date <= :old.deadline_date) ) 
                then untimely_appeals_count + 1
                else untimely_appeals_count
                end)
            else untimely_appeals_count
            end,
        inventory_count = case when (decode(:old.create_date, :new.create_date,1,0)=0  or decode(v_old_termination_date, v_termination_date,1,0)=0 or decode(:old.appeal_part_id, :new.appeal_part_id,1,0)=0) then 
            (case when ((:old.create_date is null) or (d_date >= trunc(:old.create_date)))
                and ((v_old_termination_date is null) or (d_date < trunc(v_old_termination_date)))
                and ( ((:new.create_date is not null) and (d_date < trunc(:new.create_date))) 
                    or ((v_termination_date is not null) and (d_date >= trunc(v_termination_date))) )
                then inventory_count - 1 
                when ((:new.create_date is null) or (d_date >= trunc(:new.create_date)))
                    and ((v_termination_date is null) or (d_date < trunc(v_termination_date)))
                    and ( ((:old.create_date is not null) and (d_date < trunc(:old.create_date))) 
                        or ((v_old_termination_date is not null) and (d_date >= trunc(v_old_termination_date))))
                then inventory_count + 1
                else inventory_count
                end)
            else inventory_count
            end,
        sla_inventory_count = case 
            when (
                    decode(:old.create_date, :new.create_date,1,0)=0  
                    or decode(v_old_termination_date, v_termination_date,1,0)=0
                    or decode(:old.complete_date, :new.complete_date,1,0)=0 
                    or decode(:old.appeal_part_id, :new.appeal_part_id,1,0)=0
                ) then
                (case when ( 
                            ( (:old.create_date is null) or (d_date >= trunc(:old.create_date)) )
                            and ( (v_old_termination_date is null) or (d_date < trunc(v_old_termination_date)) )
                            and ( (:old.complete_date is null) or (d_date < trunc(:old.complete_date)) )  
                            )
                        and ( 
                                ( (:new.create_date is not null) and (d_date < trunc(:new.create_date)) ) 
                                    or ( (v_termination_date is not null) and (d_date >= trunc(v_termination_date)) )
                                    or ( (:new.complete_date is not null) and (d_date >= trunc(:new.complete_date)) ) 
                            )
                then sla_inventory_count - 1 
                when ( 
                        ( (:new.create_date is null) or (d_date >= trunc(:new.create_date)) )
                        and ( (v_termination_date is null) or (d_date < trunc(v_termination_date)) )
                        and ( (:new.complete_date is null) or (d_date < trunc(:new.complete_date)) ) 
                    )
                and ( 
                        ( (:old.create_date is not null) and (d_date < trunc(:old.create_date)) ) 
                            or ( (v_old_termination_date is not null) and (d_date >= trunc(v_old_termination_date)) )
                            or ( (:old.complete_date is not null) and (d_date >= trunc(:old.complete_date)) )
                    )
            then sla_inventory_count + 1
            else sla_inventory_count
            end)
            else sla_inventory_count
            end,
        last_update_date = sysdate
    where ((:old.create_date is null) or (d_date >= trunc(:old.create_date)) or (:new.create_date is null) or (d_date >= trunc(:new.create_date)) )
    and ((v_old_termination_date is null) or (d_date <= trunc(v_old_termination_date)) or (v_termination_date is null) or (d_date <= trunc(v_termination_date)))
    and appeal_part_id = :new.appeal_part_id;
  end if;
  end if;
end;
/
