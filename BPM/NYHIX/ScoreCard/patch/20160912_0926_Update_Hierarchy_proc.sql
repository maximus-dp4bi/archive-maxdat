create or replace PROCEDURE LOAD_SCORECARD_HIERARCHY 
AS 
BEGIN
delete scorecard_hierarchy where 1=1;
commit;

insert into scorecard_hierarchy ("ADMIN_ID", "SR_DIRECTOR_NAME", "SR_DIRECTOR_STAFF_ID", "SR_DIRECTOR_NATID", "DIRECTOR_NAME", "DIRECTOR_STAFF_ID", "DIRECTOR_NATID", "SR_MANAGER_NAME", "SR_MANAGER_STAFF_ID", "SR_MANAGER_NATID", "MANAGER_NAME", "MANAGER_STAFF_ID", "MANAGER_NATID", "SUPERVISOR_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NATID", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "STAFF_NATID", "HIRE_DATE", "POSITION", "OFFICE", "TERMINATION_DATE") 
  with sr_directors as
(
select staff_id as sr_director_staff_id, national_id as sr_director_natid, (LAST_NAME||', '|| FIRST_NAME) as sr_director_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Sr. Director'))
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, directors as
(
select staff_id as director_staff_id, national_id as director_natid, (LAST_NAME||', '|| FIRST_NAME) as director_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Director'))
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, sr_managers as
(
select staff_id as sr_manager_staff_id, national_id as sr_manager_natid, (LAST_NAME||', '|| FIRST_NAME) as sr_manager_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Sr. Manager'))
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, managers as
(
select staff_id as manager_staff_id, national_id as manager_natid, (LAST_NAME||', '|| FIRST_NAME) as manager_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where job_classification_code_id in (1057,1018,1044))--'Manager','CC Management','Enrollment & Eligibility Operations Manager'
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, supervisors as
(
select staff_id as supervisor_staff_id, national_id as supervisor_natid, (LAST_NAME||', '|| FIRST_NAME) as supervisor_name  from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where job_classification_code_id in (1058,1031)) --'Supervisor','E&E Supervisor'
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, srdir_to_dir as
(
--sr director to director
select srdirs.sr_director_name, srdirs.sr_director_staff_id, srdirs.sr_director_natid, dirs.director_name, dirs.director_staff_id, dirs.director_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join sr_directors srdirs on sts.supervisor_id=srdirs.sr_director_staff_id
join directors dirs on sts.staff_id=dirs.director_staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, dir_to_srmgr as
(
--director to sr manager
select dirs.director_name, dirs.director_staff_id, dirs.director_natid, srmgrs.sr_manager_name, srmgrs.sr_manager_staff_id, srmgrs.sr_manager_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join directors dirs on sts.supervisor_id=dirs.director_staff_id
join sr_managers srmgrs on sts.staff_id=srmgrs.sr_manager_staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, srmgr_to_mgr as
(
--sr manager to manager
select
srmgrs.sr_manager_name, srmgrs.sr_manager_staff_id, srmgrs.sr_manager_natid, mgrs.manager_name, mgrs.manager_staff_id, mgrs.manager_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join sr_managers srmgrs on sts.supervisor_id=srmgrs.sr_manager_staff_id
join managers mgrs on sts.staff_id=mgrs.manager_staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, mgr_to_sup as
(
--manager to supervisor
select mgrs.manager_name, mgrs.manager_staff_id, mgrs.manager_natid, sups.supervisor_name, sups.supervisor_staff_id, sups.supervisor_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join managers mgrs on sts.supervisor_id=mgrs.manager_staff_id
join supervisors sups on sts.staff_id=sups.supervisor_staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, sup_to_staff as
(
SELECT
S.staff_id as staff_staff_id,
S.NATIONAL_ID as staff_natid,
S.LAST_NAME||', '||S.FIRST_NAME as staff_staff_name,
S.HIRE_DATE,
S.TERMINATION_DATE,
JC.CODE POSITION,
O.NAME OFFICE,
S1.STAFF_ID as supervisor_staff_id,
S1.NATIONAL_ID as supervisor_natid,
S1.LAST_NAME||', '||S1.FIRST_NAME as supervisor_name/*,
S1.HIRE_DATE,
JC1.CODE SUP_POSITION*/
FROM MAXDAT.PP_WFM_STAFF_SV S
LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV J ON S.STAFF_ID = J.STAFF_ID
LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV JC ON J.JOB_CLASSIFICATION_CODE_ID = JC.JOB_CLASSIFICATION_CODE_ID
LEFT JOIN DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE_SV SO ON (S.STAFF_ID = SO.STAFF_ID AND SO.END_DATE IS NULL)
LEFT JOIN DP_SCORECARD.PP_WFM_OFFICE_SV O ON SO.OFFICE_ID = O.OFFICE_ID
LEFT JOIN MAXDAT.PP_WFM_SUPERVISOR_TO_STAFF_SV ST ON S.STAFF_ID = ST.STAFF_ID
LEFT JOIN MAXDAT.PP_WFM_STAFF_SV S1 ON ST.SUPERVISOR_ID = S1.STAFF_ID
--LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV J1 ON S1.STAFF_ID = J1.STAFF_ID
--LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV JC1 ON J1.JOB_CLASSIFICATION_CODE_ID = JC1.JOB_CLASSIFICATION_CODE_ID
WHERE J.END_DATE IS NULL
--AND J1.END_DATE IS NULL
AND ((ST.END_DATE IS NULL
or st.end_date >= sysdate)
  and st.effective_date <= sysdate)
AND JC.JOB_CLASSIFICATION_CODE_ID IN ('1059','1054','1053','1024','1011','1010','1009','1008','1043','1019','1013','1012','1056','1047','1028','1025','1061','1032','1033','1060','1039','1063','1038','1037','1035','1052','1030','1022','1020','1046','1055','1026','1023','1027','1045','1051','1050','1049','1048','1017','1016','1015','1014')
--AND (S.TERMINATION_DATE IS NULL or S.TERMINATION_DATE > TRUNC(SYSDATE))
)
select 999 as admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
       sdtd.sr_director_name,
       sdtd.sr_director_staff_id,
       sdtd.sr_director_natid,
       dts.director_name,
       dts.director_staff_id,
       dts.director_natid,
       dts.sr_manager_name,
       dts.sr_manager_staff_id,
       dts.sr_manager_natid,
       stm.manager_name,
       stm.manager_staff_id,
       stm.manager_natid,
       mts.supervisor_name,
       mts.supervisor_staff_id,
       mts.supervisor_natid,
       sts.staff_staff_id,
       sts.staff_staff_name,
       sts.staff_natid,
       sts.hire_date,
       sts.position,
       sts.office,
       sts.termination_date
  from srdir_to_dir sdtd
  left outer join dir_to_srmgr dts on sdtd.director_staff_id = dts.director_staff_id
  left outer join  srmgr_to_mgr stm
    on dts.sr_manager_staff_id = stm.sr_manager_staff_id
  left outer join  mgr_to_sup mts
    on stm.manager_staff_id = mts.manager_staff_id
  left outer join  sup_to_staff sts
    on mts.supervisor_staff_id = sts.supervisor_staff_id
  order by
  sdtd.sr_director_name,
       dts.director_name,
       dts.sr_manager_name,
       stm.manager_name,
       mts.supervisor_name,
       sts.staff_staff_name
;
commit;
END LOAD_SCORECARD_HIERARCHY;
/
