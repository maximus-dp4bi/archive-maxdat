CREATE OR REPLACE Procedure UpdateSupervisor
   ( in_person_id number, in_employee_id number, in_supervisor_id number )

IS
   v_pid number;

   cursor c1 is
   SELECT person_id
     FROM d_supervisor
    WHERE person_id = in_person_id;


BEGIN

   open c1;
   fetch c1 into v_pid;


   if  v_pid > 0 then
     update d_supervisor
         set employee_id          = in_employee_id,
             supervisor_person_id = in_supervisor_id,
             last_update_ts       = sysdate,
             create_ts            = sysdate
       where person_id = in_person_id;

   else

     insert into d_supervisor
        (person_id, employee_id, supervisor_person_id, last_update_ts, create_ts)
      values
        (in_person_id, in_employee_id, in_supervisor_id, sysdate, sysdate);

   end if;

   commit;

   close c1;

END;


/

