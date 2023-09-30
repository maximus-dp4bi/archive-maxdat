------------------------------------------------------------------------
-- Item: 	Procedure DP_SCORECARD.Insert_Back_Office
-- Comment: 	Needs SVN properties
------------------------------------------------------------------------

CREATE OR REPLACE Procedure DP_SCORECARD.Insert_Back_Office
AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/patch/20170623_PP_WFM_BACK_OFFICE_LOAD_PKG.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 20489 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-07-03 14:31:06 -0500 (Mon, 03 Jul 2017) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';

BEGIN

   -- DP_SCORECARD.PP_WFM_BACK_OFFICE_LOAD_PKG.LOAD_SC_PROD_AND_SMRY();
   NULL;

END;
/

------------------------------------------------------------------------
-- Item: 		Procedure DP_SCORECARD.Insert_Back_Office_Rollup
-- Comment: 	Needs SVN properties
------------------------------------------------------------------------

CREATE OR REPLACE Procedure DP_SCORECARD.Insert_Back_Office_Rollup
AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/patch/20170623_PP_WFM_BACK_OFFICE_LOAD_PKG.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 20489 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-07-03 14:31:06 -0500 (Mon, 03 Jul 2017) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';

BEGIN

    DP_SCORECARD.PP_WFM_BACK_OFFICE_LOAD_PKG.LOAD_SC_PROD_AND_SMRY();

    DP_SCORECARD.PP_WFM_BACK_OFFICE_LOAD_PKG.LOAD_SC_SUMMARY_BO_ROLLUP();

END;
/

------------------------------------------------------------------------
-- Item: 		Procedure DP_SCORECARD.Update_Attendance
-- Comment: 	Replace with Production Version
------------------------------------------------------------------------

CREATE OR REPLACE Procedure DP_SCORECARD.Update_Attendance
   ( in_staff_id in number
   , in_sc_attendance_id in number
   , in_absence_type_id in number
   , in_NATIONAL_ID	in NUMBER)

AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/ScoreCard/patch/20170929_1610_SC_ATTENDANCE_DDL_PRD3.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 21344 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-09-27 11:12:30 -0400 (Wed, 27 Sep 2017) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';

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

------------------------------------------------------------------------
-- Item: 		Procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC_v1x
-- Comment: 	Drop Test procedures used for parrallel testing 
------------------------------------------------------------------------

DROP Procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC_v1x;

------------------------------------------------------------------------
-- Item: 		Procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC_V1XX
-- Comment: 	Drop Test procedures used for parrallel testing 
------------------------------------------------------------------------

DROP Procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC_V1XX; 

------------------------------------------------------------------------
-- Item: 		Procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC_v2
-- Comment: 	Drop Test procedures used for parrallel testing 
------------------------------------------------------------------------

DROP Procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC_v2;

------------------------------------------------------------------------
-- Item: 		TRIGGER DP_SCORECARD.TRG_AIU_SC_ATTENDANCE
-- Action:  	Replace with trigger from PRODCUTION
------------------------------------------------------------------------

--DROP TRIGGER DP_SCORECARD.TRG_AIU_SC_ATTENDANCE;

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_ATTENDANCE
AFTER INSERT OR UPDATE OR DELETE ON DP_SCORECARD.SC_ATTENDANCE
for each row
BEGIN

IF UPDATING THEN

	BEGIN

    --  :old.BALANCE          		--<< don't check these
    --  :old.INCENTIVE_BALANCE   	--<< don't check these
    --  :old.TOTAL_BALANCE        	--<< don't check these

	IF    :old.SC_ATTENDANCE_ID      <> :new.SC_ATTENDANCE_ID
    or  :old.STAFF_ID              <> :new.STAFF_ID
    or  :old.ENTRY_DATE            <> :new.ENTRY_DATE
    or  :old.SC_ALL_ID             <> :new.SC_ALL_ID
    or  :old.ABSENCE_TYPE          <> :new.ABSENCE_TYPE
    or  :old.POINT_VALUE           <> :new.POINT_VALUE
    or  :old.CREATE_BY             <> :new.CREATE_BY
    or  :old.CREATE_DATETIME       <> :new.CREATE_DATETIME
    or  :old.INCENTIVE_FLAG        <> :new.INCENTIVE_FLAG
    or  :old.LAST_UPDATED_BY       <> :new.LAST_UPDATED_BY
    or  :old.LAST_UPDATED_DATETIME <> :new.LAST_UPDATED_DATETIME
	THEN
		INSERT INTO SC_ATTENDANCE_AUDIT
		(Record_type
		,Record_action
		,SC_ATTENDANCE_ID
		,STAFF_ID
		,ENTRY_DATE
		,SC_ALL_ID
		,ABSENCE_TYPE
		,POINT_VALUE
		,CREATE_BY
		,CREATE_DATETIME
		,BALANCE
		,INCENTIVE_BALANCE
		,TOTAL_BALANCE
		,INCENTIVE_FLAG
		,LAST_UPDATED_BY
		,LAST_UPDATED_DATETIME
		,TRANSACTION_DATE)
		VALUES
			('Update'
			,'Delete'
			,:old.SC_ATTENDANCE_ID
			,:old.STAFF_ID
			,:old.ENTRY_DATE
			,:old.SC_ALL_ID
			,:old.ABSENCE_TYPE
			,:old.POINT_VALUE
			,:old.CREATE_BY
			,:old.CREATE_DATETIME
			,:old.BALANCE
			,:old.INCENTIVE_BALANCE
			,:old.TOTAL_BALANCE
			,:old.INCENTIVE_FLAG
			,:old.LAST_UPDATED_BY
			,:old.LAST_UPDATED_DATETIME
			,SYSDATE);

    INSERT INTO SC_ATTENDANCE_AUDIT
      (Record_type
      ,Record_action
      ,SC_ATTENDANCE_ID
      ,STAFF_ID
      ,ENTRY_DATE
      ,SC_ALL_ID
      ,ABSENCE_TYPE
      ,POINT_VALUE
      ,CREATE_BY
      ,CREATE_DATETIME
      ,BALANCE
      ,INCENTIVE_BALANCE
      ,TOTAL_BALANCE
      ,INCENTIVE_FLAG
      ,LAST_UPDATED_BY
      ,LAST_UPDATED_DATETIME
      ,TRANSACTION_DATE)
     VALUES
      ('Update'
      ,'Insert'
      ,:new.SC_ATTENDANCE_ID
      ,:new.STAFF_ID
      ,:new.ENTRY_DATE
      ,:new.SC_ALL_ID
      ,:new.ABSENCE_TYPE
      ,:new.POINT_VALUE
      ,:new.CREATE_BY
      ,:new.CREATE_DATETIME
      ,:new.BALANCE
      ,:new.INCENTIVE_BALANCE
      ,:new.TOTAL_BALANCE
      ,:new.INCENTIVE_FLAG
      ,:new.LAST_UPDATED_BY
      ,:new.LAST_UPDATED_DATETIME,
      SYSDATE);

	END IF;

	END;

END IF;

IF INSERTING THEN
    INSERT INTO SC_ATTENDANCE_AUDIT
      (Record_type
      ,Record_action
      ,SC_ATTENDANCE_ID
      ,STAFF_ID
      ,ENTRY_DATE
      ,SC_ALL_ID
      ,ABSENCE_TYPE
      ,POINT_VALUE
      ,CREATE_BY
      ,CREATE_DATETIME
      ,BALANCE
      ,INCENTIVE_BALANCE
      ,TOTAL_BALANCE
      ,INCENTIVE_FLAG
      ,LAST_UPDATED_BY
      ,LAST_UPDATED_DATETIME
      ,TRANSACTION_DATE)
     VALUES
      ('Insert'
      ,'Insert'
      ,:new.SC_ATTENDANCE_ID
      ,:new.STAFF_ID
      ,:new.ENTRY_DATE
      ,:new.SC_ALL_ID
      ,:new.ABSENCE_TYPE
      ,:new.POINT_VALUE
      ,:new.CREATE_BY
      ,:new.CREATE_DATETIME
      ,:new.BALANCE
      ,:new.INCENTIVE_BALANCE
      ,:new.TOTAL_BALANCE
      ,:new.INCENTIVE_FLAG
      ,:new.LAST_UPDATED_BY
      ,:new.LAST_UPDATED_DATETIME
      ,SYSDATE);

END IF;

IF DELETING THEN
        INSERT INTO SC_ATTENDANCE_AUDIT
        (Record_type
        ,Record_action
        ,SC_ATTENDANCE_ID
        ,STAFF_ID
        ,ENTRY_DATE
        ,SC_ALL_ID
        ,ABSENCE_TYPE
        ,POINT_VALUE
        ,CREATE_BY
        ,CREATE_DATETIME
        ,BALANCE
        ,INCENTIVE_BALANCE
        ,TOTAL_BALANCE
        ,INCENTIVE_FLAG
        ,LAST_UPDATED_BY
        ,LAST_UPDATED_DATETIME
        ,TRANSACTION_DATE)
        VALUES
            ('Delete'
            ,'Delete'
            ,:old.SC_ATTENDANCE_ID
            ,:old.STAFF_ID
            ,:old.ENTRY_DATE
            ,:old.SC_ALL_ID
            ,:old.ABSENCE_TYPE
            ,:old.POINT_VALUE
            ,:old.CREATE_BY
            ,:old.CREATE_DATETIME
            ,:old.BALANCE
            ,:old.INCENTIVE_BALANCE
            ,:old.TOTAL_BALANCE
            ,:old.INCENTIVE_FLAG
            ,:old.LAST_UPDATED_BY
            ,:old.LAST_UPDATED_DATETIME,
            SYSDATE);
    END IF;

END;
/

------------------------------------------------------------------------
-- Item: 		DP_SCORECARD.TRG_BIU_WEBCHAT_ACTUALS
-- Comment: 	Trigger is IN PRODUCTION BUT not in UAT 
-- Action:  	Copy trigger from Production to UAT 
-- Status: 	
------------------------------------------------------------------------

-- DROP TRIGGER DP_SCORECARD.TRG_BIU_WEBCHAT_ACTUALS;

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_BIU_WEBCHAT_ACTUALS
BEFORE INSERT OR UPDATE ON DP_SCORECARD.WEBCHAT_ACTUALS
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    :new.create_datetime := sysdate;
  else
    :new.last_update_date := sysdate;
 END IF;

end;
/


------------------------------------------------------------------------
-- Item: 		DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV
-- Comment: 	Moving the ";" to the end of the last line OF VIEW
-- Action:  	Copy view from PRODUCTION
------------------------------------------------------------------------

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV
(SEARCH_STAFF_ID, MANAGER_STAFF_ID, MANAGER_NAME, MANAGER_NATID, SUPERVISOR_STAFF_ID, 
 SUPERVISOR_NAME, STAFF_STAFF_ID, STAFF_STAFF_NAME, STAFF_NATID, CA_ID, 
 CA_ENTRY_DATE, CAL_ID, CORRECTION_ACTION_TYPE, UNSATISFACTORY_BEHAVIOR, COMMENTS, 
 CREATE_BY, CREATE_DATETIME, LAST_UPDATED_BY, LAST_UPDATED_DATETIME)
AS 
select    ca.staff_id as search_staff_id,
          sh.manager_staff_id,
          sh.manager_name,
		  SH.MANAGER_NATID,
          sh.supervisor_staff_id,
          sh.supervisor_name,
          sh.staff_staff_id,
          sh.staff_staff_name,
          sh.staff_natid,
          ca.ca_id,
          ca.ca_entry_date,
          ca.cal_id,
          cal.correction_action_type,
          ca.unsatisfactory_behavior,
          ca.comments,
          ca.create_by,
          ca.create_datetime,
          ca.last_updated_by,
          ca.LAST_UPDATED_DATETIME
      from dp_scorecard.sc_corrective_action ca
      join dp_scorecard.sc_corrective_action_lkup cal on ca.cal_id=cal.cal_id
      left outer join (
                select
                staff_staff_id as SEARCH_staff_id,
                manager_staff_id,
                manager_name,
				MANAGER_NATID,
                supervisor_staff_id,
                supervisor_natid,
                supervisor_name,
                staff_staff_id,
                staff_staff_name,
                staff_natid
            from dp_scorecard.scorecard_hierarchy
            union
                select
                supervisor_staff_id as SEARCH_staff_id,
                manager_staff_id,
                manager_name,
				MANAGER_NATID,
                supervisor_staff_id,
                supervisor_natid,
                supervisor_name,
                null as staff_staff_id,
                null as staff_staff_name,
                null as staff_natid
            from dp_scorecard.scorecard_hierarchy
            ) sh
            on ca.staff_id=sh.SEARCH_staff_id;


GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO MAXDAT_REPORTS;

------------------------------------------------------------------------
-- Item: 		PROCEDURE DP_SCORECARD.LOAD_SCORECARD_HIERARCHY
-- Comment: 	This procedure is no longer used - Replaced by package	
-- Action:		Copy Production code to SVN
------------------------------------------------------------------------

DROP PROCEDURE DP_SCORECARD.LOAD_SCORECARD_HIERARCHY;

------------------------------------------------------------------------
-- Item: 		Procedure DP_SCORECARD.CALC_ATTENDANCE_SCORE
-- Comment: 	This procedure is no longer used - Replaced by package	
-- Action:		Drop Procedure from UAT
------------------------------------------------------------------------

DROP Procedure DP_SCORECARD.CALC_ATTENDANCE_SCORE;

------------------------------------------------------------------------
-- Item: 		Procedure DP_SCORECARD.CALC_ATTENDANCE_SCORE
-- Action:		Copy from PRODUCTION
------------------------------------------------------------------------

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_QUALITY_TL_SV
(STAFF_STAFF_ID, STAFF_STAFF_NAME, STAFF_NATID, EVALUATEE_EID, EVALUATEE, 
 SCORECARD_SCORE_TYPE, SCORE_TOTAL, EVAL_DATE, EVALUATION_REFERENCE)
AS 
with QUALITY AS
(
SELECT DISTINCT
A.EVALUATOR_ID, COALESCE(A.CALL_DATE,A.EVALUATION_DATE_TIME) AS EVALUATION_DATE_TIME, F.SCORECARD_SCORE_TYPE, F.SCORECARD_GROUP, A.EVALUATION_REFERENCE, A.SCORE_TOTAL,
A.AGENT_ID AS Evaluatee_EID, (LAST_NAME||', '|| FIRST_NAME) as Evaluatee
FROM DP_SCORECARD.ENGAGE_ACTUALS A
JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F ON A.EVALUATION_FORM = F.EVALUATION_FORM
JOIN MAXDAT.PP_WFM_STAFF S ON A.AGENT_ID=S.NATIONAL_ID
)
SELECT distinct S.staff_staff_id,
       S.staff_staff_name,
       S.staff_natid,
       E.Evaluatee_EID,
       E.Evaluatee,
       E.SCORECARD_SCORE_TYPE,
       E.SCORE_TOTAL,
       E.EVALUATION_DATE_TIME as EVAL_DATE,
       E.EVALUATION_REFERENCE
  FROM dp_scorecard.scorecard_hierarchy_sv S
  JOIN QUALITY E ON S.staff_natid = E.EVALUATOR_ID;


GRANT INSERT, SELECT, UPDATE ON DP_SCORECARD.SCORECARD_QUALITY_TL_SV TO DP_SCORECARD_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SCORECARD_QUALITY_TL_SV TO DP_SCORECARD_OLTP_SIUD;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_TL_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_TL_SV TO MAXDAT_READ_ONLY;

