CREATE OR REPLACE Procedure Insert_Bonus_Scores
   ( in_employee_id in number
   , in_score in number
   , in_date in date
   , in_score_type in varchar2
   , in_user in number )

AS
   v_dbs_id number;

   cursor c1 is
   select dbs_id
  from d_bonus_scores_sv
 where employee_id = in_employee_id
   and score_type = in_score_type
   and (trunc(start_date) - (to_number(to_char(start_date,'DD')) - 1)) = (trunc(in_date) - (to_number(to_char(in_date,'DD')) - 1));

BEGIN

   open c1;
   fetch c1 into v_dbs_id;


   if  v_dbs_id > 0 then
     /*do nothing*/
      null;

   else

     insert into maxdat_cadr.d_bonus_scores
       (dbs_id, employee_id, score_type, score, start_date, end_date, notes, create_ts, update_ts)
     values
       (seq_dbs_id.nextval, 
       in_employee_id, 
       in_score_type, 
       in_score, 
       (trunc(in_date) - (to_number(to_char(in_date,'DD')) - 1)), 
       add_months(trunc(in_date) - (to_number(to_char((in_date),'DD')) - 1), 1) -1, 
       ' time=' || to_char(sysdate,'mm/dd/yyyy hh:mi:ss am') ||  ' score=' || in_score  ||  ' user=' || in_user  ||  ';', 
       sysdate, sysdate);
     
   end if;

   commit;

   close c1;

END;

/
