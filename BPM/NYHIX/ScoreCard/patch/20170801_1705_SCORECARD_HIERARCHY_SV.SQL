CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_HIERARCHY_SV
(ADMIN_ID, SR_DIRECTOR_NAME, SR_DIRECTOR_STAFF_ID, SR_DIRECTOR_NATID, SR_DIRECTOR_TERMINATION_DATE, 
 DIRECTOR_NAME, DIRECTOR_STAFF_ID, DIRECTOR_NATID, DIRECTOR_TERMINATION_DATE, SR_MANAGER_NAME, 
 SR_MANAGER_STAFF_ID, SR_MANAGER_NATID, SR_MANAGER_TERMINATION_DATE, MANAGER_NAME, MANAGER_STAFF_ID, 
 MANAGER_NATID, MANAGER_TERMINATION_DATE, SUPERVISOR_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NATID, 
 SUPERVISOR_TERMINATION_DATE, STAFF_STAFF_ID, STAFF_STAFF_NAME, STAFF_NATID, HIRE_DATE, 
 POSITION, OFFICE, TERMINATION_DATE, DEPARTMENT, BUILDING, 
 EVENT_NAME)
AS 
SELECT -- 6/30/2017 NYHIX-32295 Single row query returns multiple Rows  SVN = 20170630_NYHIX32295_SCORECARD_HIERARCHY_SV.SQL
		-- Added std.DELETE_FLAG = 'N'
		999 AS admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
           h.sr_director_name,
           h.sr_director_staff_id,
           h.sr_director_natid,
           (SELECT termination_date
              FROM MAXDAT.PP_WFM_STAFF_SV S
             WHERE h.sr_director_staff_id = s.Staff_id)
               sr_director_termination_date,
           h.director_name,
           h.director_staff_id,
           h.director_natid,
           (SELECT termination_date
              FROM MAXDAT.PP_WFM_STAFF_SV S
             WHERE h.director_staff_id = s.Staff_id)
               director_termination_date,
           h.sr_manager_name,
           h.sr_manager_staff_id,
           h.sr_manager_natid,
           (SELECT termination_date
              FROM MAXDAT.PP_WFM_STAFF_SV S
             WHERE h.sr_manager_staff_id = s.Staff_id)
               sr_manager_termination_date,
           h.manager_name,
           h.manager_staff_id,
           h.manager_natid,
           (SELECT termination_date
              FROM MAXDAT.PP_WFM_STAFF_SV S
             WHERE h.manager_staff_id = s.Staff_id)
               manager_termination_date,
           h.supervisor_name,
           h.supervisor_staff_id,
           h.supervisor_natid,
           (SELECT termination_date
              FROM MAXDAT.PP_WFM_STAFF_SV S
             WHERE h.supervisor_staff_id = s.Staff_id)
               supervisor_termination_date,
           h.staff_staff_id,
           h.staff_staff_name,
           h.staff_natid,
           h.hire_date,
           h.position,
           h.office,
           h.termination_date,
           H.DEPARTMENT,
           H.BUILDING,
           H.EVENT_NAME
      FROM dp_scorecard.scorecard_hierarchy h;


GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO MAXDAT_READ_ONLY;
