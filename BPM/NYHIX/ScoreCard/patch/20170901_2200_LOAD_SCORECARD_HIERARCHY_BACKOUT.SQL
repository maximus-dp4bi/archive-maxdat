CREATE OR REPLACE PROCEDURE DP_SCORECARD.LOAD_SCORECARD_HIERARCHY
AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';
BEGIN
delete scorecard_hierarchy where 1=1;
commit;

insert into scorecard_hierarchy ("ADMIN_ID", "SR_DIRECTOR_NAME", "SR_DIRECTOR_STAFF_ID", "SR_DIRECTOR_NATID", "DIRECTOR_NAME", "DIRECTOR_STAFF_ID", "DIRECTOR_NATID", "SR_MANAGER_NAME", "SR_MANAGER_STAFF_ID", "SR_MANAGER_NATID", "MANAGER_NAME", "MANAGER_STAFF_ID", "MANAGER_NATID", "SUPERVISOR_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NATID", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "STAFF_NATID", "HIRE_DATE", "POSITION", "OFFICE", "TERMINATION_DATE")
SELECT
admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
sr_director_name,
sr_director_staff_id,
sr_director_natid,
director_name,
director_staff_id,
director_natid,
sr_manager_name,
sr_manager_staff_id,
sr_manager_natid,
manager_name,
manager_staff_id,
manager_natid,
supervisor_name,
supervisor_staff_id,
supervisor_natid,
staff_staff_id,
staff_staff_name,
staff_natid,
hire_date,
position,
office,
termination_date
FROM (
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
WHERE  J.END_DATE IS NULL
--AND J1.END_DATE IS NULL
AND ((ST.END_DATE IS NULL
or st.end_date >= sysdate)
  and st.effective_date <= sysdate)
AND
JC.JOB_CLASSIFICATION_CODE_ID IN ('1068','1059','1054','1053','1024','1011','1010','1009','1008','1043','1019','1013','1012','1056','1047','1028','1025','1061','1032','1033','1060','1039','1063','1038','1037','1035','1052','1030','1022','1020','1046','1055','1026','1023','1027','1045','1051','1050','1049','1048','1017','1016','1015','1014')
--AND (S.TERMINATION_DATE IS NULL or S.TERMINATION_DATE > TRUNC(SYSDATE))
)
,
 t_sr_directors as
(
select staff_id as sr_director_staff_id, national_id as sr_director_natid, (LAST_NAME||', '|| FIRST_NAME) as sr_director_name, modify_date AS sr_director_modify_date from maxdat.pp_wfm_staff_sv s where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv cs
 where  job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         WHERE code IN('Sr. Director')))
)
, t_directors as
(
select staff_id as director_staff_id, national_id as director_natid, (LAST_NAME||', '|| FIRST_NAME) as director_name, modify_date AS director_modify_date from maxdat.pp_wfm_staff_sv s where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Director')))
)
, t_sr_managers as
(
select staff_id as sr_manager_staff_id, national_id as sr_manager_natid, (LAST_NAME||', '|| FIRST_NAME) as sr_manager_name, modify_date AS sr_manager_modify_date from maxdat.pp_wfm_staff_sv s where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Sr. Manager')))
)
, t_managers as
(
select staff_id as manager_staff_id, national_id as manager_natid, (LAST_NAME||', '|| FIRST_NAME) as manager_name, modify_date AS manager_modify_date from maxdat.pp_wfm_staff_sv s where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where job_classification_code_id in (1057,1018,1044)))
)
, t_supervisors as
(
select staff_id as supervisor_staff_id, national_id as supervisor_natid, (LAST_NAME||', '|| FIRST_NAME) as supervisor_name, modify_date AS supervisor_modify_date  from maxdat.pp_wfm_staff_sv s where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where job_classification_code_id in (1058,1031)))
)
, t_srdir_to_dir as
(
--sr director to director
select srdirs.sr_director_name, srdirs.sr_director_staff_id, srdirs.sr_director_natid, dirs.director_name, dirs.director_staff_id, dirs.director_natid, sr_director_modify_date, director_modify_date
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join t_sr_directors srdirs on sts.supervisor_id=srdirs.sr_director_staff_id
join t_directors dirs on sts.staff_id=dirs.director_staff_id
JOIN MAXDAT.PP_WFM_STAFF_SV s ON sts.STAFF_ID = s.staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, t_dir_to_srmgr as
(
--director to sr manager
select dirs.director_name, dirs.director_staff_id, dirs.director_natid, srmgrs.sr_manager_name, srmgrs.sr_manager_staff_id, srmgrs.sr_manager_natid, director_modify_date, sr_manager_modify_date
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join t_directors dirs on sts.supervisor_id=dirs.director_staff_id
join t_sr_managers srmgrs on sts.staff_id=srmgrs.sr_manager_staff_id
JOIN MAXDAT.PP_WFM_STAFF_SV s ON sts.STAFF_ID = s.staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, t_srmgr_to_mgr as
(
--sr manager to manager
select
srmgrs.sr_manager_name, srmgrs.sr_manager_staff_id, srmgrs.sr_manager_natid, mgrs.manager_name, mgrs.manager_staff_id, mgrs.manager_natid, sr_manager_modify_date, manager_modify_date
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join t_sr_managers srmgrs on sts.supervisor_id=srmgrs.sr_manager_staff_id
join t_managers mgrs on sts.staff_id=mgrs.manager_staff_id
JOIN MAXDAT.PP_WFM_STAFF_SV s ON sts.STAFF_ID = s.staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, t_mgr_to_sup as
(
--manager to supervisor
select mgrs.manager_name, mgrs.manager_staff_id, mgrs.manager_natid, sups.supervisor_name, sups.supervisor_staff_id, sups.supervisor_natid, manager_modify_date, supervisor_modify_date
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join t_managers mgrs on sts.supervisor_id=mgrs.manager_staff_id
join t_supervisors sups on sts.staff_id=sups.supervisor_staff_id
JOIN MAXDAT.PP_WFM_STAFF_SV s ON sts.STAFF_ID = s.staff_id
where ((sts.end_date is null
    or sts.end_date >= sysdate)
    and sts.effective_date <= sysdate)
)
, t_sup_to_staff as
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
S1.LAST_NAME||', '||S1.FIRST_NAME as supervisor_name,
s1.MODIFY_DATE AS supervisor_modify_date
FROM MAXDAT.PP_WFM_STAFF_SV S
LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV J ON (S.STAFF_ID = J.STAFF_ID AND TRUNC(S.TERMINATION_DATE) = TRUNC(J.END_DATE))
LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV JC ON J.JOB_CLASSIFICATION_CODE_ID = JC.JOB_CLASSIFICATION_CODE_ID
LEFT JOIN DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE_SV SO ON (S.STAFF_ID = SO.STAFF_ID AND TRUNC(S.TERMINATION_DATE) = TRUNC(SO.END_DATE))
LEFT JOIN DP_SCORECARD.PP_WFM_OFFICE_SV O ON SO.OFFICE_ID = O.OFFICE_ID
LEFT JOIN MAXDAT.PP_WFM_SUPERVISOR_TO_STAFF_SV ST ON (S.STAFF_ID = ST.STAFF_ID AND TRUNC(S.TERMINATION_DATE) = TRUNC(ST.END_DATE))
LEFT JOIN MAXDAT.PP_WFM_STAFF_SV S1 ON ST.SUPERVISOR_ID = S1.STAFF_ID
WHERE
JC.JOB_CLASSIFICATION_CODE_ID IN ('1068','1059','1054','1053','1024','1011','1010','1009','1008','1043','1019','1013','1012','1056','1047','1028','1025','1061','1032','1033','1060','1039','1063','1038','1037','1035','1052','1030','1022','1020','1046','1055','1026','1023','1027','1045','1051','1050','1049','1048','1017','1016','1015','1014')
AND S.TERMINATION_DATE IS NOT NULL
AND SO.delete_flag ='N'
AND SO.effective_DATE =(SELECT max(so2.effective_date) FROM DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE_SV SO2 WHERE sO.staff_ID = sO2.staff_ID AND SO2.EFFECTIVE_DATE IS NOT null)
AND S.hire_date = (SELECT max(s2.hire_date) FROM MAXDAT.PP_WFM_STAFF_SV S2 WHERE S.national_id = s2.national_id AND S2.hire_date IS NOT null)
AND J.end_date = (SELECT max(j2.end_date) FROM DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV J2 WHERE J.STAFF_ID = j2.STAFF_ID AND J2.END_DATE IS NOT NULL)
AND nvl(jc.modify_date,to_date('01/01/2000','dd/mm/yyyy')) = (SELECT max(nvl(jc2.modify_date,to_date('01/01/2000','dd/mm/yyyy'))) FROM DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV JC2 WHERE JC.JOB_CLASSIFICATION_CODE_ID = jc2.JOB_CLASSIFICATION_CODE_ID)
ORDER BY S.NATIONAL_ID
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
UNION
-- Select Termed Staff
SELECT distinct 999 as admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
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
  from t_sup_to_staff sts
    JOIN t_mgr_to_sup mts ON mts.supervisor_staff_id = sts.supervisor_staff_id
    JOIN t_srmgr_to_mgr stm ON stm.manager_staff_id = mts.manager_staff_id
    JOIN t_dir_to_srmgr dts ON dts.sr_manager_staff_id = stm.sr_manager_staff_id
    JOIN t_srdir_to_dir sdtd ON sdtd.director_staff_id = dts.director_staff_id
    WHERE sts.termination_date IS NOT NULL
    -- create a linked hierarchy list implementing the following logic
    -- Get the last suprv for a termed staff
    -- For that suprv get the last manager
    -- For that manager get the last sr_manager
    -- For that sr_manager get the last director
    -- For that director get the last sr_director
    AND sts.supervisor_modify_date = (SELECT min(supervisor_modify_date) FROM t_sup_to_staff sts2 WHERE sts2.staff_staff_id = sts.staff_staff_id)
    AND mts.manager_modify_date = (SELECT min(manager_modify_date) FROM t_mgr_to_sup mts2 WHERE mts2.supervisor_staff_id = sts.supervisor_staff_id)
    AND stm.sr_manager_modify_date = (SELECT min(sr_manager_modify_date) FROM t_srmgr_to_mgr stm2 WHERE stm2.manager_staff_id = mts.manager_staff_id)
    AND dts.director_modify_date = (SELECT min(director_modify_date) FROM t_dir_to_srmgr dts2 WHERE dts2.sr_manager_staff_id = stm.sr_manager_staff_id)
    AND sdtd.sr_director_modify_date = (SELECT min(sr_director_modify_date) FROM t_srdir_to_dir sdtd2 WHERE sdtd2.director_staff_id = dts.director_staff_id)
)
  order by
  sr_director_name,
      director_name,
       sr_manager_name,
       manager_name,
       supervisor_name,
       staff_staff_name
;
commit;
END LOAD_SCORECARD_HIERARCHY;
/
