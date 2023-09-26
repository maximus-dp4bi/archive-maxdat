create or replace Procedure INSERT_SC_AUDIT_LWOP
   ( in_staff_id in number
   , in_hours in number
   , in_date in date
   , in_NATIONAL_ID in NUMBER )


AS
   v_username varchar2(100);
BEGIN

  if  in_staff_id is null or in_hours is null or in_date is null or in_NATIONAL_ID is null then
     /*do nothing*/
    null;
   else  
      
      --get username
      select name into v_username from 
      (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
        UNION  
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
      ); 
      
      insert into dp_scorecard.SC_AUDIT_LWOP  
        (STAFF_STAFF_ID,                            
          LWOP_OCCURRENCE_DATE,
          LWOP_HOURS,
          LWOP_CREATE_USER,
          LWOP_CREATE_DATE,
          LWOP_UPDATE_USER,
          LWOP_UPDATE_DATE
)
      values
        (in_staff_id,
         TRUNC(in_date),
         in_hours,
         v_username,
         SYSDATE,
         v_username,
         sysdate);

       commit;

   end if;

END;

/