create or replace PROCEDURE              LOAD_SCORECARD_HIERARCHY
AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
    SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180220_1610_LOAD_SCORECARD_HIERARCHY.SQL $';
    SVN_REVISION varchar2(20) := '$Revision: 22472 $';
    SVN_REVISION_DATE varchar2(60) := '$Date: 2018-02-20 15:49:26 -0500 (Tue, 20 Feb 2018) $';
    SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';

BEGIN
    -- includes changes for Serving_Team
    -- includes changes for Buildin and Department
    -- Some ( But not bullet proof ) protection from Duplicates
    -- Eliminated NULL Staff_Staff_IDs


    execute immediate 'truncate table DP_SCORECARD.SCORECARD_HIERARCHY';

    --Delete from SC_SUMMARY_CC;
    --commit;

    commit;

insert into DP_SCORECARD.SCORECARD_HIERARCHY
(   ADMIN_ID, SR_DIRECTOR_NAME, SR_DIRECTOR_STAFF_ID, SR_DIRECTOR_NATID,
    DIRECTOR_NAME, DIRECTOR_STAFF_ID, DIRECTOR_NATID,
    SR_MANAGER_NAME, SR_MANAGER_STAFF_ID, SR_MANAGER_NATID,
    MANAGER_NAME, MANAGER_STAFF_ID, MANAGER_NATID,
    SUPERVISOR_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NATID, STAFF_STAFF_ID,
    STAFF_STAFF_NAME, STAFF_NATID, HIRE_DATE,
    POSITION, OFFICE, TERMINATION_DATE,
    EVENT_NAME,BUILDING,DEPARTMENT,QC_TENURE,QC_GROUP
)
SELECT admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
         sr_director_name,
         sr_director_staff_id,
         get_numeric(sr_director_natid) as sr_director_natid,
         director_name,
         director_staff_id,
         get_numeric(director_natid)    as director_natid,
         sr_manager_name,
         sr_manager_staff_id,
         get_numeric(sr_manager_natid)  as sr_manager_natid,
         manager_name,
         manager_staff_id,
         get_numeric(manager_natid)     as manager_natid,
         supervisor_name,
         supervisor_staff_id,
         get_numeric(supervisor_natid)  as supervisor_natid,
         staff_staff_id,
         staff_staff_name,
         get_numeric(staff_natid)       as staff_natid,
         hire_date,
         position,
         office,
         termination_date,
         event_name,
         BUILDING,
         DEPARTMENT,
         QC_TENURE,
         QC_GROUP
    FROM
(WITH
-----------------------------------------------------
sr_directors AS
-----------------------------------------------------
(SELECT staff_id                        AS sr_director_staff_id,
                          national_id                     AS sr_director_natid,
                          (LAST_NAME || ', ' || FIRST_NAME) AS sr_director_name
                     FROM maxdat.pp_wfm_staff_sv
                    WHERE staff_id IN
                              (SELECT staff_id
                                 FROM dp_scorecard.pp_wfm_job_classification_sv
                                WHERE     job_classification_code_id IN
                                              (SELECT job_classification_code_id
                                                 FROM dp_scorecard.pp_wfm_job_class_code_sv
                                                WHERE code IN ('Sr. Director'))
                                      AND TRUNC (SYSDATE) BETWEEN start_date
                                                              AND NVL (
                                                                      end_date,
                                                                      TO_DATE (
                                                                          '07/07/2077',
                                                                          'mm/dd/yyyy')))--       and termination_date is null
                                                                                         ),
-----------------------------------------------------
    directors AS
-----------------------------------------------------
(SELECT staff_id                        AS director_staff_id,
                          national_id                     AS director_natid,
                          (LAST_NAME || ', ' || FIRST_NAME) AS director_name
                     FROM maxdat.pp_wfm_staff_sv
                    WHERE staff_id IN
                              (SELECT staff_id
                                 FROM dp_scorecard.pp_wfm_job_classification_sv
                                WHERE     job_classification_code_id IN
                                              (SELECT job_classification_code_id
                                                 FROM dp_scorecard.pp_wfm_job_class_code_sv
                                                WHERE code IN ('Director'))
                                      AND TRUNC (SYSDATE) BETWEEN start_date
                                                              AND NVL (
                                                                      end_date,
                                                                      TO_DATE (
                                                                          '07/07/2077',
                                                                          'mm/dd/yyyy')))--       and termination_date is null
 ),
-----------------------------------------------------
    sr_managers AS
-----------------------------------------------------
(SELECT staff_id                        AS sr_manager_staff_id,
                          national_id                     AS sr_manager_natid,
                          (LAST_NAME || ', ' || FIRST_NAME) AS sr_manager_name
                     FROM maxdat.pp_wfm_staff_sv
                    WHERE staff_id IN
                              (SELECT staff_id
                                 FROM dp_scorecard.pp_wfm_job_classification_sv
                                WHERE     job_classification_code_id IN
                                              (SELECT job_classification_code_id
                                                 FROM dp_scorecard.pp_wfm_job_class_code_sv
                                                WHERE code IN ('Sr. Manager'))
                                      AND TRUNC (SYSDATE) BETWEEN start_date
                                                              AND NVL (
                                                                      end_date,
                                                                      TO_DATE (
                                                                          '07/07/2077',
                                                                          'mm/dd/yyyy')))--       and termination_date is null
 ),
-----------------------------------------------------
    managers AS
-----------------------------------------------------
(SELECT staff_id                        AS manager_staff_id,
                          national_id                     AS manager_natid,
                          (LAST_NAME || ', ' || FIRST_NAME) AS manager_name
                     FROM maxdat.pp_wfm_staff_sv
                    WHERE staff_id IN
                              (SELECT staff_id
                                 FROM dp_scorecard.pp_wfm_job_classification_sv
                                WHERE     job_classification_code_id IN
                                              (SELECT job_classification_code_id
                                                 FROM dp_scorecard.pp_wfm_job_class_code_sv
                                                WHERE job_classification_code_id IN
                                                          (1057, 1018, 1044)) --'Manager','CC Management','Enrollment andELIGIBILITY  Operations Manager'
                                      AND TRUNC (SYSDATE) BETWEEN start_date
                                                              AND NVL (
                                                                      end_date,
                                                                      TO_DATE (
                                                                          '07/07/2077',
                                                                          'mm/dd/yyyy')))--       and termination_date is null
),
-----------------------------------------------------
    supervisors AS
-----------------------------------------------------
(SELECT staff_id                        AS supervisor_staff_id,
                          national_id                     AS supervisor_natid,
                          (LAST_NAME || ', ' || FIRST_NAME) AS supervisor_name
                     FROM maxdat.pp_wfm_staff_sv
                    WHERE staff_id IN
                              (SELECT staff_id
                                 FROM dp_scorecard.pp_wfm_job_classification_sv
                                WHERE     job_classification_code_id IN
                                              (SELECT job_classification_code_id
                                                 FROM dp_scorecard.pp_wfm_job_class_code_sv
                                                WHERE job_classification_code_id IN
                                                          (1058, 1031)) --'Supervisor','EandE Supervisor'
                                      AND TRUNC (SYSDATE) BETWEEN start_date
                                                              AND NVL (
                                                                      end_date,
                                                                      TO_DATE (
                                                                          '07/07/2077',
                                                                          'mm/dd/yyyy')))--       and termination_date is null
 ),
-----------------------------------------------------
    srdir_to_dir AS
-----------------------------------------------------
( SELECT srdirs.sr_director_name,
                          srdirs.sr_director_staff_id,
                          srdirs.sr_director_natid,
                          dirs.director_name,
                          dirs.director_staff_id,
                          dirs.director_natid
                     FROM maxdat.pp_wfm_supervisor_to_staff_sv sts
                          JOIN sr_directors srdirs
                              ON sts.supervisor_id =
                                     srdirs.sr_director_staff_id
                          JOIN directors dirs
                              ON sts.staff_id = dirs.director_staff_id
                    WHERE (    (sts.end_date IS NULL OR sts.end_date >= SYSDATE)
                           AND sts.effective_date <= SYSDATE)
 ),
-----------------------------------------------------
    dir_to_srmgr AS
-----------------------------------------------------
(
    SELECT dirs.director_name,
                          dirs.director_staff_id,
                          dirs.director_natid,
                          srmgrs.sr_manager_name,
                          srmgrs.sr_manager_staff_id,
                          srmgrs.sr_manager_natid
                     FROM maxdat.pp_wfm_supervisor_to_staff_sv sts
                          JOIN directors dirs
                              ON sts.supervisor_id = dirs.director_staff_id
                          JOIN sr_managers srmgrs
                              ON sts.staff_id = srmgrs.sr_manager_staff_id
                    WHERE (    (sts.end_date IS NULL OR sts.end_date >= SYSDATE)
                           AND sts.effective_date <= SYSDATE)
),
-----------------------------------------------------
    srmgr_to_mgr AS
-----------------------------------------------------
(
    SELECT srmgrs.sr_manager_name,
                          srmgrs.sr_manager_staff_id,
                          srmgrs.sr_manager_natid,
                          mgrs.manager_name,
                          mgrs.manager_staff_id,
                          mgrs.manager_natid
                     FROM maxdat.pp_wfm_supervisor_to_staff_sv sts
                          JOIN sr_managers srmgrs
                              ON sts.supervisor_id = srmgrs.sr_manager_staff_id
                          JOIN managers mgrs
                              ON sts.staff_id = mgrs.manager_staff_id
                    WHERE (    (sts.end_date IS NULL OR sts.end_date >= SYSDATE)
                           AND sts.effective_date <= SYSDATE)
),
-----------------------------------------------------
    mgr_to_sup AS
-----------------------------------------------------
(
    SELECT mgrs.manager_name,
                          mgrs.manager_staff_id,
                          mgrs.manager_natid,
                          sups.supervisor_name,
                          sups.supervisor_staff_id,
                          sups.supervisor_natid
                     FROM maxdat.pp_wfm_supervisor_to_staff_sv sts
                          JOIN managers mgrs
                              ON sts.supervisor_id = mgrs.manager_staff_id
                          JOIN supervisors sups
                              ON sts.staff_id = sups.supervisor_staff_id
                    WHERE (    (sts.end_date IS NULL OR sts.end_date >= SYSDATE)
                           AND sts.effective_date <= SYSDATE)
 ),
-----------------------------------------------------
    sup_to_staff AS --<< ALL STAFF BOTH ACTIVE AND TERMINATED
-----------------------------------------------------
(   SELECT S.staff_id   AS staff_staff_id,
                          S.NATIONAL_ID AS staff_natid,
                          S.LAST_NAME || ', ' || S.FIRST_NAME
                              AS staff_staff_name,
                          S.HIRE_DATE,
                          S.TERMINATION_DATE,
                          JC.CODE      POSITION,
                          O.NAME       OFFICE,
                          S1.STAFF_ID  AS supervisor_staff_id,
                          S1.NATIONAL_ID AS supervisor_natid,
                          S1.LAST_NAME || ', ' || S1.FIRST_NAME AS supervisor_name
                          /*,S1.HIRE_DATE,JC1.CODE SUP_POSITION*/
                     FROM MAXDAT.PP_WFM_STAFF_SV S
                          LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV J
                              ON S.STAFF_ID = J.STAFF_ID
                          LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV JC
                              ON J.JOB_CLASSIFICATION_CODE_ID =
                                     JC.JOB_CLASSIFICATION_CODE_ID
                          LEFT JOIN ( select * from DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE_SV
                                        where nvl(delete_flag,'N') = 'N'
                                    ) SO
                              ON (    S.STAFF_ID = SO.STAFF_ID
                                  AND SO.END_DATE IS NULL)
                          LEFT JOIN DP_SCORECARD.PP_WFM_OFFICE_SV O
                              ON SO.OFFICE_ID = O.OFFICE_ID
                          LEFT JOIN MAXDAT.PP_WFM_SUPERVISOR_TO_STAFF_SV ST
                              ON S.STAFF_ID = ST.STAFF_ID
                          LEFT JOIN MAXDAT.PP_WFM_STAFF_SV S1
                              ON ST.SUPERVISOR_ID = S1.STAFF_ID
                    --LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV J1 ON S1.STAFF_ID = J1.STAFF_ID
                    --LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV JC1 ON J1.JOB_CLASSIFICATION_CODE_ID = JC1.JOB_CLASSIFICATION_CODE_ID
                    WHERE     J.END_DATE IS NULL
                          --AND J1.END_DATE IS NULL
                          AND (    (   ST.END_DATE IS NULL
                                    OR st.end_date >= SYSDATE)
                               AND st.effective_date <= SYSDATE)
                      AND     JC.JOB_CLASSIFICATION_CODE_ID
                      IN ('1068', '1059', '1054',  '1053',  '1024',  '1011',  '1010',  '1009',
                        '1008',  '1043',  '1019',  '1013',  '1012',  '1056',  '1047',  '1028',
                        '1025',  '1061',  '1032',  '1033',  '1060',  '1039',  '1063',  '1038',
                        '1037',  '1035',  '1052',  '1030',  '1022',  '1020',  '1046',  '1055',
                        '1026',  '1023',  '1027',  '1045',  '1051',  '1050',  '1049',  '1048',
                        '1017',  '1016',  '1015',  '1014', '1082')
                    --AND (S.TERMINATION_DATE IS NULL or S.TERMINATION_DATE > TRUNC(SYSDATE))
),
-----------------------------------------------------
    t_sr_directors AS
-----------------------------------------------------
(   SELECT staff_id                        AS sr_director_staff_id,
                          national_id                     AS sr_director_natid,
                          (LAST_NAME || ', ' || FIRST_NAME) AS sr_director_name,
                          modify_date
                              AS sr_director_modify_date
                     FROM maxdat.pp_wfm_staff_sv s
                    WHERE staff_id IN
                              (SELECT staff_id
                                 FROM dp_scorecard.pp_wfm_job_classification_sv
                                      cs
                                WHERE job_classification_code_id IN
                                          (SELECT job_classification_code_id
                                             FROM dp_scorecard.pp_wfm_job_class_code_sv
                                            WHERE code IN ('Sr. Director')))
),
-----------------------------------------------------
    t_directors AS
-----------------------------------------------------
(
    SELECT staff_id                        AS director_staff_id,
                          national_id                     AS director_natid,
                          (LAST_NAME || ', ' || FIRST_NAME) AS director_name,
                          modify_date
                              AS director_modify_date
                     FROM maxdat.pp_wfm_staff_sv s
                    WHERE staff_id IN
                              (SELECT staff_id
                                 FROM dp_scorecard.pp_wfm_job_classification_sv
                                WHERE job_classification_code_id IN
                                          (SELECT job_classification_code_id
                                             FROM dp_scorecard.pp_wfm_job_class_code_sv
                                            WHERE code IN ('Director')))),
-----------------------------------------------------
    t_sr_managers AS
-----------------------------------------------------
(   SELECT staff_id                        AS sr_manager_staff_id,
                          national_id                     AS sr_manager_natid,
                          (LAST_NAME || ', ' || FIRST_NAME) AS sr_manager_name,
                          modify_date
                              AS sr_manager_modify_date
                     FROM maxdat.pp_wfm_staff_sv s
                    WHERE staff_id IN
                              (SELECT staff_id
                                 FROM dp_scorecard.pp_wfm_job_classification_sv
                                WHERE job_classification_code_id IN
                                          (SELECT job_classification_code_id
                                             FROM dp_scorecard.pp_wfm_job_class_code_sv
                                            WHERE code IN ('Sr. Manager')))),
-----------------------------------------------------
    t_managers AS
-----------------------------------------------------
(   SELECT staff_id                        AS manager_staff_id,
                          national_id                     AS manager_natid,
                          (LAST_NAME || ', ' || FIRST_NAME) AS manager_name,
                          modify_date
                              AS manager_modify_date
                     FROM maxdat.pp_wfm_staff_sv s
                    WHERE staff_id IN
                              (SELECT staff_id
                                 FROM dp_scorecard.pp_wfm_job_classification_sv
                                WHERE job_classification_code_id IN
                                          (SELECT job_classification_code_id
                                             FROM dp_scorecard.pp_wfm_job_class_code_sv
                                            WHERE job_classification_code_id IN
                                                      (1057, 1018, 1044)))
),
-----------------------------------------------------
    t_supervisors AS
-----------------------------------------------------
(   SELECT staff_id                        AS supervisor_staff_id,
                          national_id                     AS supervisor_natid,
                          (LAST_NAME || ', ' || FIRST_NAME) AS supervisor_name,
                          modify_date
                              AS supervisor_modify_date
                     FROM maxdat.pp_wfm_staff_sv s
                    WHERE staff_id IN
                              (SELECT staff_id
                                 FROM dp_scorecard.pp_wfm_job_classification_sv
                                WHERE job_classification_code_id IN
                                          (SELECT job_classification_code_id
                                             FROM dp_scorecard.pp_wfm_job_class_code_sv
                                            WHERE job_classification_code_id IN
                                                      (1058, 1031)))
),
-----------------------------------------------------
    t_srdir_to_dir AS
-----------------------------------------------------
(
                   SELECT srdirs.sr_director_name,
                          srdirs.sr_director_staff_id,
                          srdirs.sr_director_natid,
                          dirs.director_name,
                          dirs.director_staff_id,
                          dirs.director_natid,
                          sr_director_modify_date,
                          director_modify_date
                     FROM maxdat.pp_wfm_supervisor_to_staff_sv sts
                          JOIN t_sr_directors srdirs
                              ON sts.supervisor_id =
                                     srdirs.sr_director_staff_id
                          JOIN t_directors dirs
                              ON sts.staff_id = dirs.director_staff_id
                          JOIN MAXDAT.PP_WFM_STAFF_SV s
                              ON sts.STAFF_ID = s.staff_id
                    WHERE (    (sts.end_date IS NULL OR sts.end_date >= SYSDATE)
                           AND sts.effective_date <= SYSDATE)
 ),
-----------------------------------------------------
    t_dir_to_srmgr AS
-----------------------------------------------------
(--director to sr manager
                   SELECT dirs.director_name,
                          dirs.director_staff_id,
                          dirs.director_natid,
                          srmgrs.sr_manager_name,
                          srmgrs.sr_manager_staff_id,
                          srmgrs.sr_manager_natid,
                          director_modify_date,
                          sr_manager_modify_date
                     FROM maxdat.pp_wfm_supervisor_to_staff_sv sts
                          JOIN t_directors dirs
                              ON sts.supervisor_id = dirs.director_staff_id
                          JOIN t_sr_managers srmgrs
                              ON sts.staff_id = srmgrs.sr_manager_staff_id
                          JOIN MAXDAT.PP_WFM_STAFF_SV s
                              ON sts.STAFF_ID = s.staff_id
                    WHERE (    (sts.end_date IS NULL OR sts.end_date >= SYSDATE)
                           AND sts.effective_date <= SYSDATE)
 ),
-----------------------------------------------------
   t_srmgr_to_mgr AS
-----------------------------------------------------
(--sr manager to manager
                   SELECT srmgrs.sr_manager_name,
                          srmgrs.sr_manager_staff_id,
                          srmgrs.sr_manager_natid,
                          mgrs.manager_name,
                          mgrs.manager_staff_id,
                          mgrs.manager_natid,
                          sr_manager_modify_date,
                          manager_modify_date
                     FROM maxdat.pp_wfm_supervisor_to_staff_sv sts
                          JOIN t_sr_managers srmgrs
                              ON sts.supervisor_id = srmgrs.sr_manager_staff_id
                          JOIN t_managers mgrs
                              ON sts.staff_id = mgrs.manager_staff_id
                          JOIN MAXDAT.PP_WFM_STAFF_SV s
                              ON sts.STAFF_ID = s.staff_id
                    WHERE (    (sts.end_date IS NULL OR sts.end_date >= SYSDATE)
                           AND sts.effective_date <= SYSDATE)
 ),
-----------------------------------------------------
    t_mgr_to_sup AS
-----------------------------------------------------
(--manager to supervisor
                   SELECT mgrs.manager_name,
                          mgrs.manager_staff_id,
                          mgrs.manager_natid,
                          sups.supervisor_name,
                          sups.supervisor_staff_id,
                          sups.supervisor_natid,
                          manager_modify_date,
                          supervisor_modify_date
                     FROM maxdat.pp_wfm_supervisor_to_staff_sv sts
                          JOIN t_managers mgrs
                              ON sts.supervisor_id = mgrs.manager_staff_id
                          JOIN t_supervisors sups
                              ON sts.staff_id = sups.supervisor_staff_id
                          JOIN MAXDAT.PP_WFM_STAFF_SV s
                              ON sts.STAFF_ID = s.staff_id
                    WHERE (    (sts.end_date IS NULL OR sts.end_date >= SYSDATE)
                           AND sts.effective_date <= SYSDATE)
 ),
-----------------------------------------------------
   t_sup_to_staff AS    --<< ALL STAFF BOTH ACTIVE AND TERMINATED
-----------------------------------------------------
(  SELECT S.staff_id AS staff_staff_id,
                            S.NATIONAL_ID AS staff_natid,
                            S.LAST_NAME || ', ' || S.FIRST_NAME
                                AS staff_staff_name,
                            S.HIRE_DATE,
                            S.TERMINATION_DATE,
                            JC.CODE    POSITION,
                            O.NAME     OFFICE,
                            S1.STAFF_ID AS supervisor_staff_id,
                            S1.NATIONAL_ID AS supervisor_natid,
                            S1.LAST_NAME || ', ' || S1.FIRST_NAME
                                AS supervisor_name,
                            s1.MODIFY_DATE AS supervisor_modify_date
                       FROM MAXDAT.PP_WFM_STAFF_SV S
                            LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV J
                                ON (    S.STAFF_ID = J.STAFF_ID
                                    AND TRUNC (S.TERMINATION_DATE) =
                                            TRUNC (J.END_DATE))
                            LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV JC
                                ON J.JOB_CLASSIFICATION_CODE_ID =
                                       JC.JOB_CLASSIFICATION_CODE_ID
                            LEFT JOIN ( select * from DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE_SV
                                        where nvl(delete_flag,'N') = 'N'
                                      ) SO
                                ON (    S.STAFF_ID = SO.STAFF_ID
                                    AND TRUNC (S.TERMINATION_DATE) =
                                            TRUNC (SO.END_DATE))
                            LEFT JOIN DP_SCORECARD.PP_WFM_OFFICE_SV O
                                ON SO.OFFICE_ID = O.OFFICE_ID
                            LEFT JOIN MAXDAT.PP_WFM_SUPERVISOR_TO_STAFF_SV ST
                                ON (    S.STAFF_ID = ST.STAFF_ID
                                    AND TRUNC (S.TERMINATION_DATE) =
                                            TRUNC (ST.END_DATE))
                            LEFT JOIN MAXDAT.PP_WFM_STAFF_SV S1
                                ON ST.SUPERVISOR_ID = S1.STAFF_ID
                      WHERE     JC.JOB_CLASSIFICATION_CODE_ID
                      IN ('1068', '1059', '1054',  '1053',  '1024',  '1011',  '1010',  '1009',
                        '1008',  '1043',  '1019',  '1013',  '1012',  '1056',  '1047',  '1028',
                        '1025',  '1061',  '1032',  '1033',  '1060',  '1039',  '1063',  '1038',
                        '1037',  '1035',  '1052',  '1030',  '1022',  '1020',  '1046',  '1055',
                        '1026',  '1023',  '1027',  '1045',  '1051',  '1050',  '1049',  '1048',
                        '1017',  '1016',  '1015',  '1014', '1082')
              --              AND S.TERMINATION_DATE IS NULL
                            AND nvl(SO.delete_flag,'N') = 'N'
                            AND SO.effective_DATE =
                                    (SELECT MAX (so2.effective_date)
                                       FROM DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE_SV SO2
                                      WHERE     sO.staff_ID = sO2.staff_ID
                                            AND SO2.EFFECTIVE_DATE IS NOT NULL
                                            AND nvl(delete_flag,'N') = 'N')
                            AND S.hire_date =
                                    (SELECT MAX (s2.hire_date)
                                       FROM MAXDAT.PP_WFM_STAFF_SV S2
                                      WHERE     S.national_id = s2.national_id
                                            AND S2.hire_date IS NOT NULL)
                            AND J.end_date =
                                    (SELECT MAX (j2.end_date)
                                       FROM DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV
                                            J2
                                      WHERE     J.STAFF_ID = j2.STAFF_ID
                                            AND J2.END_DATE IS NOT NULL)
                            AND NVL (jc.modify_date,
                                     TO_DATE ('01/01/2000', 'dd/mm/yyyy')) =
                                    (SELECT MAX (
                                                NVL (
                                                    jc2.modify_date,
                                                    TO_DATE ('01/01/2000',
                                                             'dd/mm/yyyy')))
                                       FROM DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV
                                            JC2
                                      WHERE JC.JOB_CLASSIFICATION_CODE_ID =
                                                jc2.JOB_CLASSIFICATION_CODE_ID)
                   ORDER BY S.NATIONAL_ID
 ),
--------------------------------------------------------------------------
    ALL_HIERARCHY AS
--------------------------------------------------------------------------
(
                   SELECT 999 AS admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
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
            FROM srdir_to_dir sdtd
                 LEFT OUTER JOIN dir_to_srmgr dts
                     ON sdtd.director_staff_id = dts.director_staff_id
                 LEFT OUTER JOIN srmgr_to_mgr stm
                     ON dts.sr_manager_staff_id = stm.sr_manager_staff_id
                 LEFT OUTER JOIN mgr_to_sup mts
                     ON stm.manager_staff_id = mts.manager_staff_id
                 LEFT OUTER JOIN sup_to_staff sts
                     ON mts.supervisor_staff_id = sts.supervisor_staff_id
---------------------------------------------------------------
          UNION  --<< Select Termed Staff
---------------------------------------------------------------
          SELECT DISTINCT 999 AS admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
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
            FROM t_sup_to_staff sts
                 JOIN t_mgr_to_sup mts
                     ON mts.supervisor_staff_id = sts.supervisor_staff_id
                 JOIN t_srmgr_to_mgr stm
                     ON stm.manager_staff_id = mts.manager_staff_id
                 JOIN t_dir_to_srmgr dts
                     ON dts.sr_manager_staff_id = stm.sr_manager_staff_id
                 JOIN t_srdir_to_dir sdtd
                     ON sdtd.director_staff_id = dts.director_staff_id
           WHERE     sts.termination_date IS NOT NULL
                 -- create a linked hierarchy list implementing the following logic
                 -- Get the last suprv for a termed staff
                 -- For that suprv get the last manager
                 -- For that manager get the last sr_manager
                 -- For that sr_manager get the last director
                 -- For that director get the last sr_director
                 AND sts.supervisor_modify_date =
                         (SELECT MIN (supervisor_modify_date)
                            FROM t_sup_to_staff sts2
                           WHERE sts2.staff_staff_id = sts.staff_staff_id)
                 AND mts.manager_modify_date =
                         (SELECT MIN (manager_modify_date)
                            FROM t_mgr_to_sup mts2
                           WHERE mts2.supervisor_staff_id =
                                     sts.supervisor_staff_id)
                 AND stm.sr_manager_modify_date =
                         (SELECT MIN (sr_manager_modify_date)
                            FROM t_srmgr_to_mgr stm2
                           WHERE stm2.manager_staff_id = mts.manager_staff_id)
                 AND dts.director_modify_date =
                         (SELECT MIN (director_modify_date)
                            FROM t_dir_to_srmgr dts2
                           WHERE dts2.sr_manager_staff_id =
                                     stm.sr_manager_staff_id)
                 AND sdtd.sr_director_modify_date =
                         (SELECT MIN (sr_director_modify_date)
                            FROM t_srdir_to_dir sdtd2
                           WHERE sdtd2.director_staff_id =
                                     dts.director_staff_id)
),
--------------------------------------------------------------------------
    QC_DATE AS
--------------------------------------------------------------------------
( SELECT months_between(TRUNC(SYSDATE,'MM'), trunc(min(e.evaluation_date_time), 'MM')) QC_Months, e.AGENT_ID
  from dp_scorecard.ENGAGE_ACTUALS e
  JOIN ALL_HIERARCHY h
    on e.agent_id = h.staff_natid
  WHERE e.DELETED_FLAG != 'Y'
    OR e.DELETED_FLAG IS NULL
  GROUP BY e.agent_id
)
-------------------------------------------------------------
------------------------------------------------------------
SELECT
    999 AS admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
    AH.sr_director_name,
    AH.sr_director_staff_id,
    AH.sr_director_natid,
    AH.director_name,
    AH.director_staff_id,
    AH.director_natid,
    AH.sr_manager_name,
    AH.sr_manager_staff_id,
    AH.sr_manager_natid,
    AH.manager_name,
    AH.manager_staff_id,
    AH.manager_natid,
    AH.supervisor_name,
    AH.supervisor_staff_id,
    AH.supervisor_natid,
    AH.staff_staff_id,
    AH.staff_staff_name,
    AH.staff_natid,
    AH.hire_date,
    AH.position,
    AH.office,
    AH.termination_date,
    nvl(ELIGIBILITY.EVENT_NAME,'Undefined') as EVENT_NAME,
    nvl(OBL.BUILDING,'Undefined')           as BUILDING,
    nvl(STAFF_DEP.DEPARTMENT,'Undefined')   as DEPARTMENT,
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
    CASE WHEN ah.POSITION = 'HSDE' THEN 'HSDE'
        WHEN ah.POSITION = 'Eligibility Specialist B' THEN 'V Docs'
        WHEN ah.POSITION = 'CSS1' THEN 'SBM'
        WHEN ah.POSITION = 'CSS3' THEN 'IND'
        WHEN ah.POSITION = 'CSS4' THEN 'WebChat'
        WHEN ah.POSITION = 'SWCC-CSR' THEN 'SWCC'
        WHEN ah.POSITION = 'SWCC-CSR 2' THEN 'SWCC'
        WHEN ah.POSITION = 'Eligibility Specialist C-Appeals' THEN 'Appeals'
        WHEN ah.POSITION = 'SHOP 1' THEN 'SBM'
        WHEN ah.POSITION = 'SHOP 2' THEN 'SBM'
        WHEN ah.POSITION = 'Eligibility Specialist A' THEN 'HSDE-QC/LDS'
        WHEN ah.POSITION = 'Quality Control' THEN 'QC'
        WHEN ah.POSITION = 'Mailroom' THEN 'Mailroom'
        WHEN ah.POSITION = 'Research Specialist' THEN 'Research'
        WHEN ah.POSITION = 'NYEC - Mailroom' THEN 'NYEC 1'
        WHEN ah.POSITION = 'NAV-QR2' THEN 'IND'
        ELSE null
    End QC_GROUP
FROM ALL_HIERARCHY AH
LEFT OUTER JOIN
    QC_DATE Q
    ON Q.AGENT_ID = AH.STAFF_NATID
LEFT OUTER JOIN
    DP_SCORECARD.PP_WFM_STAFF_ELIGIBIL_WRK_SV ELIGIBILITY
    ON ELIGIBILITY.STAFF_ID = AH.STAFF_STAFF_ID
    LEFT OUTER JOIN
        ( -- OFFICE BUILDING LOCATION
            SELECT DISTINCT OFFICE, BUILDING
            FROM DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP
            WHERE OFFICE IN
                (   SELECT OFFICE --<< ENSURE YOU DON'T GET MULTIPLE ROWS
                    FROM DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP
                    GROUP BY OFFICE
                    HAVING SUM(1) = 1
                )
        ) OBL
    ON OBL.OFFICE = AH.OFFICE
    LEFT OUTER JOIN
        (   -- STAFF_DEPARTMENT
            SELECT STD.STAFF_ID,
                TRUNC(STD.EFFECTIVE_DATE)  AS EFFECTIVE_DATE,
                TRUNC(STD.END_DATE)        AS END_DATE,
                D.NAME                     AS DEPARTMENT
            FROM DP_SCORECARD.PP_WFM_STAFF_TO_DEPARTMENT  STD
            JOIN DP_SCORECARD.PP_WFM_DEPARTMENT D
            ON STD.DEPARTMENT_ID = D.DEPARTMENT_ID
            WHERE STD.DELETE_FLAG = 'N'
            GROUP BY STD.STAFF_ID, TRUNC(STD.EFFECTIVE_DATE), TRUNC(STD.END_DATE), D.NAME
            HAVING SUM(1) = 1
        ) STAFF_DEP
    ON STAFF_DEP.STAFF_ID = AH.STAFF_STAFF_ID
    AND STAFF_DEP.EFFECTIVE_DATE <= TRUNC(NVL(AH.TERMINATION_DATE,SYSDATE))
    AND TRUNC(NVL(STAFF_DEP.END_DATE,SYSDATE)) >= TRUNC(NVL(AH.TERMINATION_DATE,SYSDATE))
WHERE AH.STAFF_STAFF_ID IS NOT NULL
--
ORDER BY sr_director_name,
         director_name,
         sr_manager_name,
         manager_name,
         supervisor_name,
         staff_staff_name
)
WHERE STAFF_STAFF_ID IS NOT NULL
AND get_numeric(SR_DIRECTOR_NATID)   IS NOT NULL
AND get_numeric(DIRECTOR_NATID)      IS NOT NULL
AND get_numeric(SR_MANAGER_NATID)    IS NOT NULL
AND get_numeric(MANAGER_NATID)       IS NOT NULL
AND get_numeric(SUPERVISOR_NATID)    IS NOT NULL
AND get_numeric(STAFF_NATID)         IS NOT NULL
;

commit;

END LOAD_SCORECARD_HIERARCHY;
/
show errors