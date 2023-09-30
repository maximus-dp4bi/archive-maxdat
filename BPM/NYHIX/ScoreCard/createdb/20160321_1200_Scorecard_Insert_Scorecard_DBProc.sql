---PROC
CREATE OR REPLACE Procedure Insert_Scorecard
   ( in_staff_id in number
   , in_absence_type_id in number
   , in_date in date
   , in_comment in varchar2
   , in_user in number )

AS

   v_incentive_flag varchar2(1);

   cursor c1 is
   select incentive_flag from PP_BO_ABSENCE_DESCRIPTION_LKUP where adl_id=in_absence_type_id;

BEGIN

   open c1;
   fetch c1 into v_incentive_flag;

   if c1%notfound then
      v_incentive_flag := NULL;
   end if;

   if  in_staff_id is null or in_absence_type_id is null or in_date is null then
     /*do nothing*/  
      null;
   elsif (v_incentive_flag='Y' and in_comment is null) then
     /*do nothing - incentives require a comment*/  
      null;
   else
      --insert into pp_bo_scorecard. added where clause to prevent user from adding dates before staff's hire date or future dates
      insert into pp_bo_scorecard
        (sc_id, staff_id, sc_entry_date, adl_id, absence_type, point_value, comments, create_by, create_datetime, incentive_flag)
        (select SEQ_PBADL_ID.nextval, 
                in_staff_id, 
                trunc(in_date), 
                in_absence_type_id,
                (select absence_type from PP_BO_ABSENCE_DESCRIPTION_LKUP where adl_id=in_absence_type_id),
                (select point_value from PP_BO_ABSENCE_DESCRIPTION_LKUP where adl_id=in_absence_type_id),
                in_comment, 
                'user: ' || to_char(in_user), 
                sysdate,
                v_incentive_flag 
          from dual
          where (trunc(in_date) >= (select dates from  PP_BO_SCORECARD_SV where staff_id=in_staff_id and sc_id=0)
          and trunc(in_date) <= trunc(sysdate)));
            
       commit;
       
       --call procedure to recalculate running totals for this staff id
       scorecard_calculate_balance(in_staff_id);     

   end if;

   close c1;

END;

/
