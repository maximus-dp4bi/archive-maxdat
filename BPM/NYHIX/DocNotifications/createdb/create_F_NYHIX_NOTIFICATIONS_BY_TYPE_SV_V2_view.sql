ALTER SESSION SET CURRENT_SCHEMA = MAXDAT; 
CREATE OR REPLACE VIEW F_NYHIX_NOTIFICATIONS_BY_TYPE_SV AS 
WITH A AS 
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
SELECT     document_type document_type,
            TRUNC(a11.complete_date)  complete_date,
             a11.kofax_dcn,
             a11.channel   ,
            SUM(a11.completed_count)  completed_count
FROM        maxdat.d_nyhix_web_notifications_sv       a11
WHERE       a11.complete_date BETWEEN  TRUNC(add_months(sysdate, -12),'MM')  AND TRUNC(sysdate) 
GROUP BY     document_type, TRUNC(a11.complete_date), a11.kofax_dcn,a11.channel;

GRANT   SELECT ON   MAXDAT.F_NYHIX_NOTIFICATIONS_BY_TYPE_SV TO   MAXDAT_READ_ONLY;

Commit;