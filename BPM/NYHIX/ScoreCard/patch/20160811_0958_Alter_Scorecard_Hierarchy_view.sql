create or replace force view DP_SCORECARD.SCORECARD_HIEARCHY_SV as
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
       h.termination_date
  from dp_scorecard.scorecard_hierarchy h
  ;
  
  GRANT select on DP_SCORECARD.SCORECARD_HIEARCHY_SV to MAXDAT_READ_ONLY;
  GRANT select on DP_SCORECARD.SCORECARD_HIEARCHY_SV to MAXDAT;
