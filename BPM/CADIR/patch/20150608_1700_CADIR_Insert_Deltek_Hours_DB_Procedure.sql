CREATE OR REPLACE Procedure Insert_Deltek_Hours
   ( in_employee_id in number
   , in_entered_hours in number
   , in_date in date
   , in_pay_type in varchar2
   , in_project_id in varchar2
   , in_user in number )

AS
   v_ddh_id number;

   cursor c1 is
   select ddh_id
  from d_deltek_hours_sv
 where employee_id = in_employee_id
   and project_id = in_project_id
   and pay_type = in_pay_type
   and hours_date = in_date;


BEGIN

   open c1;
   fetch c1 into v_ddh_id;


   if  v_ddh_id > 0 then
     /*do nothing*/
      null;

   else

     insert into d_deltek_hours
        (ddh_id, employee_id, labor_grp_type, last_name, first_name, title, empl_org_id, empl_org_name, approval_name, project_id, project_name
       , org_id, org_name, pay_type, plc_id, hours_date, entered_hours, comments, notes, maxdat_audit_create_dt, maxdat_audit_update_dt, productive_hours, sup_updated)
      select seq_ddh_id.nextval as ddh_id,
      in_employee_id as employee_id,
      labor_grp_type,
      last_name, first_name, title, empl_org_id, empl_org_name, approval_name,
      in_project_id as project_id,
      (select distinct project_name from d_deltek_hours where project_id=in_project_id) as project_name,
      org_id,
      org_name,
      in_pay_type as pay_type,
      plc_id,
      trunc(in_date) as hours_date,
      in_entered_hours as entered_hours,
      null as comments,
       ' time=' || to_char(sysdate,'mm/dd/yyyy hh:mi:ss am') ||  ' user=' || in_user  ||  ';'   as notes,
      null as maxdat_audit_create_dt,
      null as maxdat_audit_update_dt,
      case when in_entered_hours < 3.5 then in_entered_hours
           when in_entered_hours >= 3.5 and in_entered_hours < 5 then in_entered_hours - 0.25
           when in_entered_hours >= 5 and in_entered_hours < 10 then in_entered_hours - 0.5
           when in_entered_hours >= 10 then in_entered_hours  - 0.75
      end as production_hours,
      'Y' as sup_u
      from d_deltek_hours
      where employee_id=in_employee_id
      and ddh_id = (select max(ddh_id) from d_deltek_hours where employee_id=in_employee_id);

   end if;

   commit;

   close c1;

END;

/
