drop view D_CALL_ACTION_REFERRAL_SV;
CREATE OR REPLACE VIEW D_CALL_ACTION_REFERRAL_SV AS
SELECT CASE WHEN upper(VALUE) LIKE 'REFER%STATE%' THEN 'To State-Operated Call Centers'
            when upper(VALUE) like 'REFER%PHP%' then 'To PHP'
            when upper(VALUE) like 'REFER%HEALTH%' then 'To PHP'
            when upper(VALUE) like 'REFER%OMBUD%' then 'To Ombudsman'
            when upper(VALUE) like 'REFER%DSS%' THEN 'To County DSS and PHHS Offices'
			when upper(VALUE) like 'REFER%EBCITRIBAL%' THEN 'To EBCI Tribal' -- Add to recognize Tribal
            else 'To State-Operated Call Centers'
            end Referral_to
            , TRIM(substr(report_label,instr(report_label,'- ')+1)) referral_reason
            , VALUE FULL_REFERRAL_DESC 
FROM EB.ENUM_MANUAL_CALL_ACTION WHERE CATEGORIES like 'REFERRAL'
AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,SYSDATE+1);

GRANT SELECT ON MAXDAT_SUPPORT.D_CALL_ACTION_REFERRAL_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_CALL_ACTION_REFERRAL_SV TO MAXDAT_REPORTS;
