CREATE OR REPLACE Procedure UpdateSupervisor
   ( in_person_id number, in_employee_id number, in_supervisor_id number, in_exempt_flag varchar2 )

IS
   v_pid number;

   cursor c1 is
   SELECT person_id
     FROM d_supervisor
    WHERE person_id = in_person_id;


BEGIN

   open c1;
   fetch c1 into v_pid;

   if  v_pid > 0 and in_employee_id > 0 then
     update d_supervisor
         set employee_id          = in_employee_id,
             last_update_ts       = sysdate,
             create_ts            = sysdate
       where person_id = in_person_id;
   end if;

   if  v_pid > 0 and in_supervisor_id > 0 then
     update d_supervisor
         set supervisor_person_id = in_supervisor_id,
             last_update_ts       = sysdate,
             create_ts            = sysdate
       where person_id = in_person_id;
   end if;

   if v_pid <= 0 or v_pid is null then
     insert into d_supervisor
        (person_id, employee_id, supervisor_person_id, last_update_ts, create_ts)
      values
        (in_person_id,
        CASE WHEN in_employee_id > 0 THEN in_employee_id else NULL END,
        CASE WHEN in_supervisor_id > 0 THEN in_supervisor_id else NULL END,
        sysdate,
        sysdate);
   end if;

   if in_exempt_flag='N' or in_exempt_flag='Y' then
      update d_person set exempt_flag = in_exempt_flag where person_id = in_person_id;
   end if;

   commit;

   close c1;

END;
