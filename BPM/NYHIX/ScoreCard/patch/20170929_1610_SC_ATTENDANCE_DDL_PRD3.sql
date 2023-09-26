
CREATE OR REPLACE Procedure DP_SCORECARD.Insert_Attendance
   ( in_staff_id in number
   , in_absence_type_id in number
   , in_datetime in date
   , in_NATIONAL_ID	in NUMBER )

AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


   v_incentive_flag varchar2(1);
   v_username varchar2(100);

   cursor c1 is
   select incentive_flag from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id;

BEGIN
           
   open c1;
   fetch c1 into v_incentive_flag;

   if c1%notfound then
      v_incentive_flag := NULL;
   end if;

   if  in_staff_id is null or in_absence_type_id is null or in_datetime is null or in_NATIONAL_ID is null then
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

      --insert into pp_bo_scorecard. added where clause to prevent user from adding dates before staff's hire date or future dates
      insert into dp_scorecard.sc_attendance
        (sc_attendance_id, staff_id, entry_date, sc_all_id, absence_type, point_value, create_by, create_datetime, incentive_flag, last_updated_by, LAST_UPDATED_DATETIME)
        (select SEQ_SCAS_ID.nextval,
                in_staff_id,
                trunc(in_datetime),
                in_absence_type_id,
                (select absence_type from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
                (select point_value from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
                v_username,
                sysdate,
                v_incentive_flag,
                v_username,
                sysdate
          from dual
          where (trunc(in_datetime) >= (select min(dates) 
                                        from DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV 
                                        where staff_staff_id=in_staff_id 
                                        and sc_attendance_id=0
                                        )
          and trunc(in_datetime) <= trunc(sysdate)));

       commit;

       --call procedure to recalculate running totals for this staff id
       --DP_SCORECARD.Calc_Attendance_Score(in_staff_id)
       --call procedure to populate monthly score table
       --DP_SCORECARD.Update_Sc_Attendance_Mthly(in_staff_id)
       
       DP_SCORECARD.Calc_Attendance_Score_PKG.CALC_ATTENDANCE_SCORE(in_staff_id);

   end if;

   close c1;

END;
/

GRANT EXECUTE ON DP_SCORECARD.Insert_Attendance TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.Insert_Attendance TO MAXDAT_READ_ONLY;
GRANT EXECUTE ON DP_SCORECARD.Insert_Attendance TO MAXDAT_REPORTS;



-------------------------------------------------

CREATE OR REPLACE Procedure DP_SCORECARD.Update_Attendance
   ( in_staff_id in number
   , in_sc_attendance_id in number
   , in_absence_type_id in number
   , in_NATIONAL_ID	in NUMBER)

AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

   v_all_id number;
   v_username varchar2(100);
   cursor c1 is
   select sc_all_id from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where absence_type='Delete';

BEGIN

   open c1;
   fetch c1 into v_all_id;

   if c1%notfound then
      v_all_id := NULL;
   end if;

   if  in_sc_attendance_id = 0 then
     /*do nothing*/
      null;
   else
      if (in_absence_type_id is not null) or (in_absence_type_id = v_all_id) then
          
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
          
          
          update dp_scorecard.sc_attendance
          set sc_all_id = in_absence_type_id,
              absence_type = (select absence_type from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
              point_value = (select point_value from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
              incentive_flag = (select incentive_flag from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
              last_updated_by = v_username,
              LAST_UPDATED_DATETIME = sysdate
          where staff_id = in_staff_id and sc_attendance_id = in_sc_attendance_id;
      else
          /*do nothing if a comment is not submitted with an update or user wants to perform a Delete*/
          null;
      end if;

   end if;

   delete from dp_scorecard.sc_attendance where staff_id=in_staff_id and absence_type='Delete' ;

   commit;

   close c1;

   --call procedure to recalculate running totals for this staff id
   --DP_SCORECARD.Calc_Attendance_Score(in_staff_id);
   --call procedure to populate monthly score table
   --DP_SCORECARD.Update_Sc_Attendance_Mthly(in_staff_id)
   
   DP_SCORECARD.Calc_Attendance_Score_PKG.CALC_ATTENDANCE_SCORE(in_staff_id);

END;
/

GRANT EXECUTE ON DP_SCORECARD.Update_Attendance TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.Update_Attendance TO MAXDAT_READ_ONLY;
GRANT EXECUTE ON DP_SCORECARD.Update_Attendance TO MAXDAT_REPORTS;



-------------------------------------------------

CREATE OR REPLACE procedure DP_SCORECARD.UPDATE_SC_ATTENDANCE_MTHLY
(in_staff_id IN NUMBER default NULL )
AS

	LV_IN_STAFF_ID                 VARCHAR2(10) := '%';
	LV_CALC_STAFF_ID               NUMBER := 0;
	LV_RUN_DATE                     DATE := SYSDATE;
	
	-- THIS PROCEDURE IS CALLED FROM THE INSERT_ATTENDANCE PROCEDURE OR
	-- THE UPDATE_ATTENDANCE PROCEDURE OR THE ELT TO LOAD THE HIERARCHY.
	-- INSERT_ATTENDANCE AND UPDATE_ATTENDANCE PROCEDURES WILL PROVIDE A SPECIFIC STAFF_ID
	
	-- EACH TIME THE SCORCARD RUNS THIS PROCEDURE IS CALLED WITH A NULL STAFF_ID
	-- FOR THE FIRST EXECUTION WITHIN A MONTH IT WILL RUN ALL THE STAFF_IDs
	-- SUBSEQUENT EXECUTIONS WOULD BE FOR A SINGLE STAFF_ID;
	
	-- THIS CURSOR IDENTIFIES ANY STAFF_ID WHICH DO NOT HAVE ENTRIES IN THE CURRENT MONTH
	
	CURSOR STAFF_ATTENDANCE_CSR(LV_IN_STAFF_ID IN VARCHAR) IS
		SELECT staff_staff_id, MAX(TO_DATE(DATES_MONTH_NUM,'YYYYMM')) AS RUN_DATE 
		FROM (
            WITH 
            ---------------------------------------------
            -- The first part of the cursor is used to --
            -- DETERMINE A DATE RANGE FOR THE STAFF_ID --	
            ---------------------------------------------	
        HIRE AS 
            ( SELECT STAFF_STAFF_ID, MAX(HIRE_DATE)                 AS MAX_HIRE_DATE
                FROM DP_SCORECARD.SCORECARD_HIERARCHY
                WHERE STAFF_STAFF_ID like LV_IN_STAFF_ID
                GROUP BY STAFF_STAFF_ID
            ),
        TERM AS
            ( SELECT STAFF_STAFF_ID,  MAX(NVL(TERMINATION_DATE,SYSDATE))  AS MAX_TERM_DATE
                FROM DP_SCORECARD.SCORECARD_HIERARCHY
                WHERE STAFF_STAFF_ID like LV_IN_STAFF_ID
                GROUP BY STAFF_STAFF_ID
            ),
        ATND AS	-- GET THE FIRST SC_ATTENDANCE_RECORD	
            ( SELECT STAFF_ID, MIN(ENTRY_DATE)                AS MIN_ENTRY_DATE
				FROM DP_SCORECARD.SC_ATTENDANCE
                WHERE STAFF_ID like LV_IN_STAFF_ID
                GROUP BY STAFF_ID	
            ),
        INIT AS	-- GET THE FIRST INITIALIZATION RECORD	
            ( SELECT STAFF_ID, MIN(START_DATE)                AS MIN_START_DATE
                FROM DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE
                WHERE STAFF_ID like LV_IN_STAFF_ID
                GROUP BY STAFF_ID
            ),
        STAFF_START_STOP AS
            ( SELECT HIRE.STAFF_STAFF_ID,
                    TO_CHAR(GREATEST(MAX_HIRE_DATE, 
                    NVL(MIN_ENTRY_DATE,MAX_HIRE_DATE), 
                    NVL(MIN_START_DATE,MAX_HIRE_DATE)),'YYYYMM')    AS START_MONTH_NUM, 
                    TO_CHAR(MAX_TERM_DATE,'YYYYMM')                             AS TERM_MONTH_NUM
                FROM HIRE		
                LEFT OUTER JOIN TERM ON TERM.STAFF_STAFF_ID = HIRE.STAFF_STAFF_ID
                LEFT OUTER JOIN ATND ON ATND.STAFF_ID = HIRE.STAFF_STAFF_ID
                LEFT OUTER JOIN INIT ON INIT.STAFF_ID = HIRE.STAFF_STAFF_ID 		
            ),
        ALL_MONTHS AS
            ( SELECT STAFF_START_STOP.STAFF_STAFF_ID, D.DATES_MONTH_NUM 
                FROM  STAFF_START_STOP
                JOIN
                ( SELECT 
                    TO_CHAR(ADD_MONTHS (TRUNC (TO_DATE('01/01/2012','MM/DD/YYYY'), 'MM'), 1*LEVEL -1), 'YYYYMM') AS DATES_MONTH_NUM
                    FROM DUAL 
                    CONNECT BY LEVEL <= MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE('01/01/2012','MM/DD/YYYY')) + 1
                ) D
                ON 1=1
                WHERE D.DATES_MONTH_NUM BETWEEN START_MONTH_NUM AND TERM_MONTH_NUM  
            ),
        STAFF_MONTHS AS
            ( SELECT STAFF_STAFF_ID AS STAFF_STAFF_ID, 
                    ALL_MONTHS.DATES_MONTH_NUM,
                    TO_DATE(ALL_MONTHS.DATES_MONTH_NUM,'YYYYMM') AS DATES
                FROM ALL_MONTHS
		--WHERE ALL_MONTHS.DATES_MONTH_NUM
		--BETWEEN STAFF_START_STOP.ATTND_DATES_MONTH_NUM AND STAFF_START_STOP.TERM_MONTH_NUM
            )
    SELECT STAFF_STAFF_ID, DATES_MONTH_NUM 
    FROM ALL_MONTHS	
    WHERE STAFF_STAFF_ID like LV_IN_STAFF_ID
    MINUS
    SELECT STAFF_STAFF_ID, DATES_MONTH_NUM 
    FROM DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY
    WHERE STAFF_STAFF_ID like LV_IN_STAFF_ID
	)
	GROUP BY STAFF_STAFF_ID;


BEGIN

	IF IN_STAFF_ID IS NULL
	THEN LV_IN_STAFF_ID := '%';
	ELSE LV_IN_STAFF_ID := IN_STAFF_ID;
	END IF;
	
	IF (staff_attendance_csr%ISOPEN) 
	THEN
		CLOSE staff_attendance_csr;
	END IF;	

	OPEN staff_attendance_csr(LV_IN_STAFF_ID); 
	
	LOOP

	FETCH staff_attendance_csr INTO LV_CALC_STAFF_ID, LV_RUN_DATE;
	EXIT WHEN staff_attendance_csr%NOTFOUND;

		--call procedure to recalculate running totals for this staff id
		
		DBMS_OUTPUT.PUT_LINE('CALLING CALC FOR: '||LV_CALC_STAFF_ID);
		
        DP_SCORECARD.Calc_Attendance_Score_PKG.CALC_ATTENDANCE_SCORE(LV_CALC_STAFF_ID,LV_RUN_DATE );
	   
	END LOOP;
	
	DBMS_OUTPUT.PUT_LINE('DELETING ROWS FOR: '||LV_IN_STAFF_ID);
	
    COMMIT;
    
end update_sc_attendance_mthly;
/

GRANT EXECUTE ON DP_SCORECARD.UPDATE_SC_ATTENDANCE_MTHLY TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.UPDATE_SC_ATTENDANCE_MTHLY TO MAXDAT_READ_ONLY;
GRANT EXECUTE ON DP_SCORECARD.UPDATE_SC_ATTENDANCE_MTHLY TO MAXDAT_REPORTS;

-------------------------------------------------

