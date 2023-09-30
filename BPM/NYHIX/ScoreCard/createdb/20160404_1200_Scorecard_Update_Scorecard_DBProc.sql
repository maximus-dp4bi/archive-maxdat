CREATE OR REPLACE Procedure Update_Scorecard
   ( in_staff_id in number
   , in_sc_id in number
   , in_absence_type_id in number
   , in_comment in varchar2)

AS

v_adl_id number;

   cursor c1 is
   select adl_id from PP_BO_ABSENCE_DESCRIPTION_LKUP where absence_type='Delete';

BEGIN

   open c1;
   fetch c1 into v_adl_id;

   if c1%notfound then
      v_adl_id := NULL;
   end if;

   if  in_sc_id = 0 then
     /*do nothing*/
      null;
   else
      if in_absence_type_id is null then
          update pp_bo_scorecard
          set comments = case when in_comment is null then comments else in_comment end
          where staff_id = in_staff_id and sc_id = in_sc_id;        
      elsif (in_absence_type_id is not null and in_comment is not null) or (in_absence_type_id = v_adl_id) then 
          update pp_bo_scorecard
          set adl_id = in_absence_type_id,
              absence_type = (select absence_type from PP_BO_ABSENCE_DESCRIPTION_LKUP where adl_id=in_absence_type_id),
              point_value = (select point_value from PP_BO_ABSENCE_DESCRIPTION_LKUP where adl_id=in_absence_type_id),
              comments = case when in_comment is null then comments else in_comment end,
              incentive_flag = (select incentive_flag from PP_BO_ABSENCE_DESCRIPTION_LKUP where adl_id=in_absence_type_id)
          where staff_id = in_staff_id and sc_id = in_sc_id;
      else
          /*do nothing if a comment is not submitted with an update or user wants to perform a Delete*/
          null;  
      end if;

   end if;

   delete from pp_bo_scorecard where staff_id=in_staff_id and absence_type='Delete' ;

   commit;
   
   close c1;
   
   --call procedure to recalculate running totals for this staff id
   scorecard_calculate_balance(in_staff_id);  

END;

/
