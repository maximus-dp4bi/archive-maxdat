CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_HIERARCHY_SV
AS
WITH QC_DATE AS 
(
SELECT months_between(TRUNC(SYSDATE,'MM'), trunc(min(evaluation_date_time), 'MM')) QC_Months, e.AGENT_ID 
from dp_scorecard.ENGAGE_ACTUALS e 
JOIN dp_scorecard.scorecard_hierarchy h
on e.agent_id = h.staff_natid
WHERE e.DELETED_FLAG != 'Y'
OR e.DELETED_FLAG IS NULL
GROUP BY e.agent_id
)
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
           H.EVENT_NAME,
           CASE WHEN q.QC_MONTHS IS NULL THEN NULL 
                WHEN q.QC_MONTHS = 0 then '0' 
                WHEN q.QC_MONTHS = 1 then '1'
                WHEN q.QC_MONTHS IN (2,3) THEN '2-3'
                WHEN q.QC_MONTHS IN (4,5,6) THEN '4-6'
                WHEN q.QC_MONTHS IN (7,8,9) THEN '7-9'
                WHEN q.QC_MONTHS IN (10,11,12) THEN '10-12'
                WHEN q.QC_MONTHS > 12 THEN 'OVER 12'
                ELSE NULL 
           END QC_TENURE,
           CASE WHEN h.POSITION = 'HSDE' THEN 'HSDE'
                WHEN h.POSITION = 'Eligibility Specialist B' THEN 'V Docs'
                WHEN h.POSITION = 'CSS1' THEN 'SBM'
                WHEN h.POSITION = 'CSS3' THEN 'IND'
                WHEN h.POSITION = 'CSS4' THEN 'WebChat'
                WHEN h.POSITION = 'SWCC-CSR' THEN 'SWCC'
                WHEN h.POSITION = 'SWCC-CSR 2' THEN 'SWCC'
                WHEN h.POSITION = 'Eligibility Specialist C-Appeals' THEN 'Appeals'
                WHEN h.POSITION = 'SHOP 1' THEN 'SBM'
                WHEN h.POSITION = 'SHOP 2' THEN 'SBM'
                WHEN h.POSITION = 'Eligibility Specialist A' THEN 'HSDE-QC/LDS'
                WHEN h.POSITION = 'Quality Control' THEN 'QC'
                WHEN h.POSITION = 'Mailroom' THEN 'Mailroom'
                WHEN h.POSITION = 'Research Specialist' THEN 'Research'
                WHEN h.POSITION = 'NYEC - Mailroom' THEN 'NYEC 1'
                WHEN h.POSITION = 'NAV-QR2' THEN 'IND'
                ELSE null
           End QC_GROUP
      FROM dp_scorecard.scorecard_hierarchy h
      LEFT JOIN QC_DATE q
      ON q.agent_id = h.staff_natid;

GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO MAXDAT_REPORTS;

