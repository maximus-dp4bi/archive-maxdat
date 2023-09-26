DROP VIEW DP_SCORECARD.SCORECARD_HIERARCHY_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_HIERARCHY_SV
(ADMIN_ID, SR_DIRECTOR_NAME, SR_DIRECTOR_STAFF_ID, SR_DIRECTOR_NATID, SR_DIRECTOR_TERMINATION_DATE, 
 DIRECTOR_NAME, DIRECTOR_STAFF_ID, DIRECTOR_NATID, DIRECTOR_TERMINATION_DATE, SR_MANAGER_NAME, 
 SR_MANAGER_STAFF_ID, SR_MANAGER_NATID, SR_MANAGER_TERMINATION_DATE, MANAGER_NAME, MANAGER_STAFF_ID, 
 MANAGER_NATID, MANAGER_TERMINATION_DATE, SUPERVISOR_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NATID, 
 SUPERVISOR_TERMINATION_DATE, STAFF_STAFF_ID, STAFF_STAFF_NAME, STAFF_NATID, HIRE_DATE, 
 POSITION, OFFICE, TERMINATION_DATE, DEPARTMENT, BUILDING)
AS 
select 999 as admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
       h.sr_director_name,
       h.sr_director_staff_id,
       h.sr_director_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.sr_director_staff_id = s.Staff_id) sr_director_termination_date,
       h.director_name,
       h.director_staff_id,
       h.director_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.director_staff_id = s.Staff_id) director_termination_date,
       h.sr_manager_name,
       h.sr_manager_staff_id,
       h.sr_manager_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.sr_manager_staff_id = s.Staff_id) sr_manager_termination_date,
       h.manager_name,
       h.manager_staff_id,
       h.manager_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.manager_staff_id = s.Staff_id) manager_termination_date,
       h.supervisor_name,
       h.supervisor_staff_id,
       h.supervisor_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.supervisor_staff_id = s.Staff_id) supervisor_termination_date,
       h.staff_staff_id,
       h.staff_staff_name,
       h.staff_natid,
       h.hire_date,
       h.position,
       h.office,
       h.termination_date,
       (select distinct d.name from dp_scorecard.pp_wfm_staff_to_department std
        join dp_scorecard.pp_wfm_department d on std.department_id=d.department_id
        where
        (trunc(std.effective_date) <= trunc(sysdate)
        and coalesce(std.end_date,to_date('07/07/7777','mm/dd/yyyy')) > trunc(sysdate)
        AND h.TERMINATION_DATE IS null)
        and std.staff_id=h.staff_staff_id
        UNION
        select distinct d.name from dp_scorecard.pp_wfm_staff_to_department std
        join dp_scorecard.pp_wfm_department d on std.department_id=d.department_id
        where
            (h.termination_date IS NOT NULL
           AND trunc(std.effective_date) <= trunc(h.termination_date)
           AND std.end_date >= trunc(h.termination_date)
           AND std.DELETE_FLAG = 'N')
        and std.staff_id=h.staff_staff_id
        ) as department ,
       (select DISTINCT building from dp_scorecard.scorecard_office_building_lkup obl where obl.office=h.office) as building
  from dp_scorecard.scorecard_hierarchy h
/*  union
  select null as admin_id,
       null as sr_director_name,
       null as sr_director_staff_id,
       null as sr_director_natid,
       null as  sr_director_termination_date,
       null as director_name,
       null as director_staff_id,
       null as director_natid,
       null as director_termination_date,
       null as sr_manager_name,
       null as sr_manager_staff_id,
       null as sr_manager_natid,
       null as sr_manager_termination_date,
      null as manager_name,
       null as manager_staff_id,
       null as manager_natid,
       null as manager_termination_date,
       null as supervisor_name,
       null as supervisor_staff_id,
       null as supervisor_natid,
       null as supervisor_termination_date,
         null as staff_staff_id,
       null as staff_staff_name,
       null as staff_natid,
       null as hire_date,
       null as position,
       null as office,
       null as termination_date,
       null as department,
       null as building
  from dual*/
;


GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO MAXDAT_READ_ONLY;
