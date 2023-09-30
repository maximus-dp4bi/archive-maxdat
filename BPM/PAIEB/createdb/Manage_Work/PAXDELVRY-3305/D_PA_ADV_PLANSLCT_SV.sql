
/* PAXDELIVRY-3305 */

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_PA_ADV_PLANSLCT_SV
AS SELECT ASEL.PLAN_ID, ASEL.PLAN_ID_EXT, ASEL.STATUS_CD, ASEL.CREATE_TS, ASEL.SENT_DATE, ASEL.RESPONSE_RECEIVED_DATE
, asel.app_adv_plan_id
, ASEL.APPLICATION_ID app_id
, ASEL.PLACEMENT_COUNTY
, ASEL.RESIDENCE_COUNTY
, ASEL.REASON_CD
, ASEL.CHOICE_HIERARCHY_SELECTION_IND
FROM ATS.APP_ADV_PLAN_SELECTION ASEL
WHERE TRUNC(CREATE_TS) >= TRUNC(ADD_MONTHS(SYSDATE,-24),'YYYY')
;

GRANT SELECT ON MAXDAT_SUPPORT.D_PA_ADV_PLANSLCT_SV TO MAXDAT_SUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_PA_ADV_PLANSLCT_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_PA_ADV_PLANSLCT_SV TO MAXDAT_REPORTS; 