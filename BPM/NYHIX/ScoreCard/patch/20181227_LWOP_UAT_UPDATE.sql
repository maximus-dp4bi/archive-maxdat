--------------------------------------------------------------------
-- views
--------------------------------------------------------------------

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_LWOP_SV
AS 
WITH
SCH AS
( SELECT STAFF_ID AS STAFF_STAFF_ID, 
    TRUNC(nvl(SENIORITY_EFFECTIVE_DATE,HIRE_DATE)) AS HIRE_DATE
  FROM DP_SCORECARD.SC_HIERARCHY_STAFF
  where trunc(SENIORITY_EFFECTIVE_DATE) <> to_date('12/31/9999','MM/DD/YYYY')
),  
LWOP_DATA AS
(
    SELECT lwop_instance_id,
        SUPERVISOR_NATID,  
        STAFF_STAFF_ID, 
        HIRE_DATE, 
        LWOP_OCCURRENCE_DATE, 
        START_DATE,
		CASE WHEN LWOP_OCCURRENCE_DATE BETWEEN TRUNC(HIRE_DATE) 
			AND (ADD_MONTHS(TRUNC(HIRE_DATE),+12)-(1/(24*60*60)) ) THEN 56	
			WHEN LWOP_OCCURRENCE_DATE BETWEEN TRUNC(HIRE_DATE) 
			AND (ADD_MONTHS(TRUNC(HIRE_DATE),+24)-(1/(24*60*60)) ) THEN 40
			ELSE 0 
		END                                     AS LWOP_LIMIT,
		SUM(LWOP_HOURS)                         AS LWOP_HOURS,
		MESSAGE
    FROM    
    (   SELECT  L.LWOP_INSTANCE_ID,
                L.LWOP_UPDATE_USER         				AS SUPERVISOR_NATID,  
                SCH.STAFF_STAFF_ID, 
                SCH.HIRE_DATE,
        -------------
		CASE WHEN  TRUNC(LWOP_OCCURRENCE_DATE) < TRUNC(HIRE_DATE)
                THEN TRUNC(LWOP_OCCURRENCE_DATE)
            WHEN LWOP_OCCURRENCE_DATE BETWEEN TRUNC(HIRE_DATE) 
                AND (ADD_MONTHS(TRUNC(HIRE_DATE),+12)-(1/(24*60*60)) ) 
                    THEN     HIRE_DATE	
			WHEN LWOP_OCCURRENCE_DATE BETWEEN ADD_MONTHS(TRUNC(HIRE_DATE),+12) 
                AND (ADD_MONTHS(TRUNC(HIRE_DATE),+24)-(1/(24*60*60)) ) 
                    THEN ADD_MONTHS(TRUNC(HIRE_DATE),+12)
			ELSE ADD_MONTHS(TRUNC(HIRE_DATE),+24)  
		END                                             AS START_DATE,
        -------------- 
                nvl(L.LWOP_OCCURRENCE_DATE,SCH.hire_date) as LWOP_OCCURRENCE_DATE,  
                L.LWOP_HOURS,
				'LWOP Hours USED'                               AS MESSAGE
        FROM SCH 
    --    LEFT OUTER JOIN SC_AUDIT_LWOP L
        JOIN DP_SCORECARD.SC_AUDIT_LWOP L
        ON L.STAFF_STAFF_ID = SCH.STAFF_STAFF_ID
        UNION all  -- INITIAL HIRE 
        SELECT -1,
                NULL AS SUPERVISOR_NATID, 
                STAFF_STAFF_ID, 
                HIRE_DATE,
                trunc(hire_date) as start_date,
                HIRE_DATE AS LWOP_OCCURRENCE_DATE, 
                0 AS LWOP_HOURS,
				'Permanent Hire Date - 1st Year Balance'   AS MESSAGE
        FROM SCH H
        UNION all -- One Year Annaversary
        SELECT -1,
                NULL AS SUPERVISOR_NATID, 
                STAFF_STAFF_ID, 
                HIRE_DATE,
                ADD_MONTHS(TRUNC(HIRE_DATE),+12) AS start_date,
                ADD_MONTHS(TRUNC(HIRE_DATE),+12) AS LWOP_OCCURRENCE_DATE, 
                0 AS LWOP_HOURS,
				'Permanent Hire Date - 2nd Year Balance'                               AS MESSAGE
        FROM SCH
        WHERE TRUNC(SYSDATE) >= ADD_MONTHS(TRUNC(HIRE_DATE),+12)
        OR STAFF_STAFF_ID IN ( SELECT STAFF_STAFF_ID
        FROM DP_SCORECARD.SC_AUDIT_LWOP
        WHERE TRUNC(LWOP_OCCURRENCE_DATE) >= ADD_MONTHS(TRUNC(HIRE_DATE),+12)
        )
        UNION all -- Second year Annaversary
        SELECT -1,
                NULL AS SUPERVISOR_NATID, 
                STAFF_STAFF_ID, 
                HIRE_DATE,
                ADD_MONTHS(TRUNC(HIRE_DATE),+24) AS start_date,
                ADD_MONTHS(TRUNC(HIRE_DATE),+24) AS LWOP_OCCURRENCE_DATE, 
                0 AS LWOP_HOURS,
				'Permanent Hire Date - 3rd and Subsequent Year Balance'                               AS MESSAGE
        FROM SCH
        WHERE TRUNC(SYSDATE) >= ADD_MONTHS(TRUNC(HIRE_DATE),+24)
        OR STAFF_STAFF_ID IN ( SELECT STAFF_STAFF_ID
        FROM DP_SCORECARD.SC_AUDIT_LWOP
        WHERE TRUNC(LWOP_OCCURRENCE_DATE) >= ADD_MONTHS(TRUNC(HIRE_DATE),+24)
        )
    )
    GROUP BY lwop_instance_id, SUPERVISOR_NATID, STAFF_STAFF_ID, HIRE_DATE, 
        start_date,
        LWOP_OCCURRENCE_DATE,
		case when LWOP_OCCURRENCE_DATE between trunc(hire_date) 
			and (ADD_MONTHS(TRUNC(HIRE_DATE),+12)-(1/(24*60*60)) ) then 56	
			when LWOP_OCCURRENCE_DATE between trunc(hire_date) 
			and (ADD_MONTHS(TRUNC(HIRE_DATE),+24)-(1/(24*60*60)) ) then 40
			else 0 end,
		message
),
LWOP_BALANCE AS
(
SELECT lwop_instance_id, supervisor_natid, STAFF_STAFF_ID, TRUNC(HIRE_DATE) AS HIRE_DATE, TRUNC(LWOP_OCCURRENCE_DATE) AS LWOP_OCCURRENCE_DATE, LWOP_HOURS, 
    TRUNC(START_DATE) AS START_DATE, 
    LWOP_LIMIT, MESSAGE,
    -- calculate the balance
	sum( 
        LWOP_HOURS )
        OVER ( PARTITION BY STAFF_STAFF_ID, START_DATE 
            ORDER BY STAFF_STAFF_ID, start_date, LWOP_OCCURRENCE_DATE ) total_used
    FROM LWOP_DATA
    WHERE LWOP_OCCURRENCE_DATE IS NOT NULL
    GROUP BY lwop_instance_id, supervisor_natid,
        STAFF_STAFF_ID, TRUNC(HIRE_DATE), trunc(start_date), TRUNC(LWOP_OCCURRENCE_DATE), LWOP_HOURS, 
    TRUNC(START_DATE), 
    LWOP_LIMIT,
    STAFF_STAFF_ID, HIRE_DATE, LWOP_OCCURRENCE_DATE, LWOP_HOURS, 
    START_DATE, 
    MESSAGE
)
SELECT  
LB.LWOP_INSTANCE_ID, SUPERVISOR_NATID AS UPDATED_BY_NATID,
    LB.STAFF_STAFF_ID, LB.HIRE_DATE, LB.LWOP_OCCURRENCE_DATE, LB.LWOP_HOURS, LB.START_DATE, LB.LWOP_LIMIT, (LB.LWOP_LIMIT - LB.total_used) LWOP_BALANCE,
CASE WHEN NVL(LB.LWOP_LIMIT - LB.total_used,0) < 0 THEN 'Balance Cannot be Negative' 
    ELSE message
END AS MESSAGE  
FROM LWOP_BALANCE LB
ORDER BY STAFF_STAFF_ID, HIRE_DATE, LWOP_OCCURRENCE_DATE;
/

show errors

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_LWOP_SV TO MAXDAT_REPORTS;

GRANT SELECT on DP_SCORECARD.SC_AUDIT_LWOP_SV TO MAXDAT_MSTR_TRX_RPT;

--------------------------------------------------------------------
-- procedures
--------------------------------------------------------------------

CREATE OR REPLACE Procedure DP_SCORECARD.INSERT_SC_AUDIT_LWOP
   ( in_staff_id in number
   , in_hours in number
   , in_date in date
   , in_NATIONAL_ID in NUMBER )


AS
   v_username varchar2(100);
BEGIN

  if  in_staff_id is null 
    or in_hours is null or in_hours < 0
    or in_date is null 
    or in_NATIONAL_ID is null 
  then
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

show errors

GRANT EXECUTE ON DP_SCORECARD.INSERT_SC_AUDIT_LWOP TO MAXDAT;

GRANT EXECUTE ON DP_SCORECARD.INSERT_SC_AUDIT_LWOP TO MAXDAT_READ_ONLY;

GRANT EXECUTE ON DP_SCORECARD.INSERT_SC_AUDIT_LWOP TO MAXDAT_REPORTS;

GRANT EXECUTE on DP_SCORECARD.INSERT_SC_AUDIT_LWOP TO MAXDAT_MSTR_TRX_RPT;

GRANT EXECUTE ON DP_SCORECARD.INSERT_SC_AUDIT_LWOP TO dp_scorecard_READ_ONLY;


-------------------------------------------------------------------------
-------------------------------------------------------------------------

CREATE OR REPLACE Procedure DP_SCORECARD.Update_SC_AUDIT_LWOP
   ( in_staff_id in number
   , in_lwop_instance_id in number
   , in_delete_flag in number
   , in_NATIONAL_ID in NUMBER
   , in_hours in number )


AS
  v_username varchar2(100);

BEGIN

   if in_delete_flag =1 then
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
		  
		  where LWOP_INSTANCE_ID = IN_LWOP_INSTANCE_ID
		  and IN_HOURS >= 0;

       commit;

   end if;

END;
/

show errors

GRANT EXECUTE ON DP_SCORECARD.Update_SC_AUDIT_LWOP TO MAXDAT;

GRANT EXECUTE ON DP_SCORECARD.Update_SC_AUDIT_LWOP TO MAXDAT_READ_ONLY;

GRANT EXECUTE ON DP_SCORECARD.Update_SC_AUDIT_LWOP TO MAXDAT_REPORTS;

GRANT EXECUTE on DP_SCORECARD.Update_SC_AUDIT_LWOP TO MAXDAT_MSTR_TRX_RPT;

GRANT EXECUTE ON DP_SCORECARD.Update_SC_AUDIT_LWOP TO dp_scorecard_READ_ONLY;
