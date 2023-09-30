CREATE OR REPLACE Procedure Insert_Bonus_Standards
   ( in_task_type in varchar2
   , in_role_name in varchar2
   , in_bonus_standard in number
   , in_bonus_point1 in number
   , in_bonus_point2 in number
   , in_bonus_point3 in number
   , in_start_date in date )

AS
   v_bid number;
   v_begin_mo_date date;

   cursor c1 is
   select bid
   from d_bonus_standards
   where task_type=in_task_type
   and trunc(start_date) = (trunc(in_start_date) - (to_number(to_char(in_start_date,'DD')) - 1))
   and trunc(end_date)=to_date('07/07/7777','mm/dd/yyyy');

   cursor c2 is
   select trunc(sysdate) - (to_number(to_char(sysdate,'DD')) - 1) as begin_mo from dual;

BEGIN

   open c1;
   fetch c1 into v_bid;

   open c2;
   fetch c2 into v_begin_mo_date;

   --if in_start_date >= v_begin_mo_date then   ---6/6/16 Aram requested to remove constraint --update/insert only when start date is greater than or equal to the first day of the current month, otherwise do nothing

       if  v_bid > 0 then

          update d_bonus_standards
          set end_date=(trunc(in_start_date) - (to_number(to_char(in_start_date,'DD')) - 1)),
          active='N'
          where bid=v_bid;

          insert into d_bonus_standards
            (bid, task_type, bonus_standard, bonus_point_1, bonus_point_2, bonus_point_3, active, start_date, end_date, role_name)
          values
            ((select max(bid)+1 from D_BONUS_STANDARDS)
            , in_task_type
            , in_bonus_standard
            , in_bonus_point1
            , in_bonus_point2
            , in_bonus_point3
            , 'Y', (trunc(in_start_date) - (to_number(to_char(in_start_date,'DD')) - 1))
            , to_date('07/07/7777','mm/dd/yyyy')
            , NVL(in_role_name,NULL));

       else

          update d_bonus_standards
          set end_date=(trunc(in_start_date) - (to_number(to_char(in_start_date,'DD')) - 1))-1
          where task_type=in_task_type
          and trunc(start_date) <> (trunc(in_start_date) - (to_number(to_char(in_start_date,'DD')) - 1))
          and trunc(end_date)=to_date('07/07/7777','mm/dd/yyyy');

          insert into d_bonus_standards
            (bid, task_type, bonus_standard, bonus_point_1, bonus_point_2, bonus_point_3, active, start_date, end_date, role_name)
          values
            ((select max(bid)+1 from D_BONUS_STANDARDS)
            , in_task_type
            , in_bonus_standard
            , in_bonus_point1
            , in_bonus_point2
            , in_bonus_point3
            , 'Y', (trunc(in_start_date) - (to_number(to_char(in_start_date,'DD')) - 1))
            , to_date('07/07/7777','mm/dd/yyyy')
            , NVL(in_role_name,NULL));

       end if;

       commit;
   --end if;
   close c1;
   close c2;

END;

/
