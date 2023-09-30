ALTER SESSION SET CURRENT_SCHEMA=MAXDAT;

CREATE OR REPLACE VIEW D_NYHIX_MFD_MW_REJECTIONS_SV
AS (
SELECT DISTINCT
    A11.ECN                                                                                                 ECN,
    A11.DCN                                                                                                 DCN,
    A12.TASK_ID                                                                                             TASK_ID,
    A14.EXT_STAFF_NUMBER	                                                                            CURRENT_OWNER_STAFF_ID,
    CASE WHEN A14.STAFF_ID = 0 THEN 'UNKNOWN' ELSE ( A14.LAST_NAME || ', ' || A14.FIRST_NAME )    END       CURRENT_OWNER_STAFF_NAME,
    A13.OPERATIONS_GROUP                                                                                    OPERATIONS_GROUP,
    A12.CURR_CREATED_BY_STAFF_ID                                                                            ORIGINATOR_STAFF_ID,
    CASE WHEN A14.STAFF_ID = 0 THEN 'UNKNOWN' ELSE ( A15.LAST_NAME || ', ' || A15.FIRST_NAME )    END       ORIGINATOR_STAFF_NAME,
    A12.TASK_TYPE_ID                                                                                        TASK_TYPE_ID,
    A13.TASK_NAME                                                                                           TASK_NAME,
    A12.CURR_TASK_STATUS                                                                                    CURRENT_TASK_STATUS,
    TRUNC(A12.CREATE_DATE)                                                                                  CREATE_DATE,
    TRUNC(A12.COMPLETE_DATE)                                                                                COMPLETE_DATE,
    A16.ACTION_STATUS                                                                                       Action_Status,
    case when a110.STAFF_ID = 0 then 'None' ELSE (a110.LAST_NAME || ', ' || a110.FIRST_NAME) end            SUPERVISOR_NAME,
    a110.EXT_STAFF_NUMBER                                                                                   SUPERVISOR_ID,
    'NA'                                                                                                    NOTICE, 
    'NA'                                                                                                    LETTER_TYPE
FROM
     D_NYHIX_MFD_CURRENT_SV_V2 A11
JOIN NYHIX_ETL_MFD_CSC_V2_SV  A16 ON A16.KOFAX_DCN = A11.KOFAX_DCN
JOIN D_MW_V2_CURRENT_SV       A12 ON ( A16.CSC_DETAIL_ID = A12.SOURCE_REFERENCE_ID ) AND A12.SOURCE_REFERENCE_TYPE = 'CSC_ZIP_FILE_DCN_DETAIL'
JOIN D_TASK_TYPES_SV          A13 ON ( A12.TASK_TYPE_ID = A13.TASK_TYPE_ID )
JOIN D_STAFF_SV               A14 ON ( A12.CURR_OWNER_STAFF_ID = A14.STAFF_ID )
JOIN D_STAFF_SV               A15 ON ( A12.CURR_CREATED_BY_STAFF_ID = A15.STAFF_ID )
JOIN D_TEAMS_SV               A17 ON ( A12.CURR_TEAM_ID = A17.TEAM_ID )
JOIN D_STAFF_SV               A110 ON ( A17.TEAM_SUPERVISOR_STAFF_ID = A110.STAFF_ID )
WHERE    A13.TASK_TYPE_ID = 20181001
);

CREATE OR REPLACE VIEW F_NYHIX_NOTIFICATIONS_BY_TYPE_SV
AS WITH A AS
(
        SELECT a11.doc_type, a11.form_type,  TRUNC(a11.env_status_dt), a11.env_status_dt, a11.env_status_cd, a11.kofax_dcn, a11.dcn,a11.channel  channel
        , CASE WHEN  a11.doc_type  IN ('Verification Document', 'Verification', 'VERIFICATION_DOCUMENT','VerificationDocument') THEN 1 ELSE 0 END AS is_doc_type_verification
        , CASE WHEN  a11.kofax_dcn  LIKE 'V%'  THEN 1 ELSE 0 END AS is_v_prefix
        , CASE WHEN  a11.doc_type IN ('Application') THEN 1 ELSE 0 END AS is_application
        , CASE WHEN (a11.form_type  LIKE 'Identity Proof%' OR a11.form_type IN ('Nav/CAC ID Proofing Form')) THEN 1 ELSE 0 END AS is_id_proof
         FROM     maxdat.d_nyhix_mfd_current_v2            a11
         WHERE ( 1=1
               AND TRUNC(a11.env_status_dt) BETWEEN TRUNC(add_months(sysdate, -12),'MM') AND TRUNC(sysdate)
               AND a11.env_status_cd IN ('COMPLETEDRELEASED')
               ))
SELECT DISTINCT
        CASE    WHEN is_application = 1 THEN 'Applications'
                WHEN (is_doc_type_verification = 1 OR is_v_prefix = 1) AND is_id_proof = 0 THEN 'Consumer Documents (Mail/Fax/Mobile)'
                WHEN is_id_proof = 1 THEN 'Identity Proof Forms' ELSE NULL END AS document_type,
        TRUNC(A.env_status_dt)  complete_date,
        A.kofax_dcn,
        A.channel,
        COUNT(A.dcn) AS completed_count
FROM A
WHERE doc_type NOT  IN ('Incident', 'APPEAL','Hidden', 'MANUAL_NOTICE',  'Returned Mail')
AND form_type NOT IN ('Manual Notice','Medicare Savings Program','Other')
GROUP BY
        CASE    WHEN is_application = 1 THEN 'Applications'
                WHEN (is_doc_type_verification = 1 OR is_v_prefix = 1) AND is_id_proof = 0 THEN 'Consumer Documents (Mail/Fax/Mobile)'
                WHEN is_id_proof = 1 THEN 'Identity Proof Forms' ELSE NULL END,
        TRUNC(A.env_status_dt),
        A.kofax_dcn, A.channel
UNION ALL
SELECT     a11.document_type document_type,
           TRUNC(a11.complete_date_time)  complete_date,
           a11.kofax_dcn,
           a11.channel   ,
           SUM(a11.completed_count)  completed_count
FROM        maxdat.d_nyhix_web_notifications_sv       a11
WHERE       a11.complete_date BETWEEN  TRUNC(add_months(sysdate, -12),'MM')  AND TRUNC(sysdate)
GROUP BY     a11.document_type, a11.complete_date_time, a11.kofax_dcn,a11.channel
;
