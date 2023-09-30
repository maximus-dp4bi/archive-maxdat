--------------------------------------------------------
--  DDL for View CC_S_TMP_IVR_STEP_SV
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "CC_S_TMP_IVR_STEP_SV" ("ID", "CONNID", "STEPTIME", "STEPNAME", "STEPVALUE", "NODENAME", "BEGIN_NODE", "END_NODE", "OURNODENAME") AS 
  select iStep.id
, iStep.connid
, iStep.steptime
,iStep.stepname
,iStep.stepvalue 
,iStep.nodename 
, CASE WHEN STEPVALUE LIKE 'mdiivrapp%' THEN NULL ELSE LAG(nodename, 1, NULL) OVER (ORDER BY connid, steptime) END AS begin_node
,  nodename as end_node
,(case when iStep.stepname = 'RPT_IVRData' then iStep.stepvalue else iStep.nodename end) as ournodename
from cc_s_tmp_ivr_step iStep
WHERE ((iStep.stepname = 'RPT_IVR_GetMenu') or (iStep.stepname = 'RPT_IVR_GetData' and iStep.stepvalue like 'mdiivrapp%') 
or (iStep.stepname = 'RPT_IVRData' and iStep.stepvalue like '%vcall'));

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.1.3','005','005_CREATE_REPLACE_CC_S_TMP_IVR_STEP_SV');

COMMIT;