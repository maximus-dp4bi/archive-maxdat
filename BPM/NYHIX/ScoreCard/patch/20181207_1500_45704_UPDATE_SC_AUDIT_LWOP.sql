create or replace Procedure              Update_SC_AUDIT_LWOP
   ( in_staff_id in number
   , in_lwop_instance_id in number
   , in_delete_flag in number
   , in_NATIONAL_ID in NUMBER
   , in_hours in number )


AS
  v_username varchar2(100);

BEGIN

   if in_delete_flag = 1 then
     delete from dp_scorecard.SC_AUDIT_LWOP  where staff_staff_id=in_staff_id and LWOP_INSTANCE_ID = in_lwop_instance_id;
     commit;

   ELSE

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

    update dp_scorecard.SC_AUDIT_LWOP
          set
          
                  LWOP_HOURS		= 	IN_HOURS,
		  LWOP_UPDATE_DATE    	=	sysdate,
		  LWOP_UPDATE_USER    	=	v_username
		  
		  where LWOP_INSTANCE_ID = IN_LWOP_INSTANCE_ID;

       commit;

   end if;

END;

/