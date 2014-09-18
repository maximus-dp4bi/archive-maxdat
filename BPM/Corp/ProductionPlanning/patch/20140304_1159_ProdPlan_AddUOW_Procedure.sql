

CREATE OR REPLACE Procedure MAXDAT.PP_AddUnitOfWork
(    in_uow_name IN varchar2,
     in_hourly_flag IN varchar2,
     in_handle_time_unit IN varchar2,
     in_jeopardy_inv_age IN number,
     in_age_days_type IN varchar2,
     in_inv_avg_age IN number,
     in_label IN varchar2
)

IS
   v_next_uow_id number;

   cursor c1 is
   SELECT max(cfg_uow_id) + 1 as next_uow_id FROM PP_CFG_UNIT_OF_WORK;

BEGIN

   open c1;
   fetch c1 into v_next_uow_id;

   if c1%notfound then
      v_next_uow_id := 1;
   end if;

   insert into pp_cfg_unit_of_work
     (cfg_uow_id, unit_of_work_name, hourly_flag, handle_time_unit, jeopardy_inv_age, age_days_type, inv_avg_age, label)
   values
     (v_next_uow_id, in_uow_name, in_hourly_flag, in_handle_time_unit, in_jeopardy_inv_age, in_age_days_type, in_inv_avg_age, in_label);

   insert into pp_d_unit_of_work
     (uow_id, unit_of_work_name, handle_time_unit, jeopardy_inv_age, label)
   values
     (v_next_uow_id, in_uow_name, in_handle_time_unit, in_jeopardy_inv_age, in_label);


   commit;

   close c1;

END;




/
