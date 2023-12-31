
-- Drop unwanted Packeges

DROP PACKAGE PKG_HCO_V2_CALL;

-- Drop unwanted Materialized View Logs

DROP MATERIALIZED VIEW LOG CC_HCO_F_V2_CALL;

-- Drop unwanted Sequences

DROP SEQUENCE CC_CELL_HISTORY_SEQ;
DROP SEQUENCE HCO_SEQ_CAMPAIGNTRK_ID;
DROP SEQUENCE SEQ_CC_CELL_ID;
DROP SEQUENCE SEQ_CC_HCO_F_CALL_BACK;
DROP SEQUENCE SEQ_CC_HCO_F_V2_CALL_MV;
DROP SEQUENCE SEQ_CC_HCO_S_CALL_BACK;
DROP SEQUENCE SEQ_CC_SRLKUP_ID;

-- Drop unwanted Views

DROP VIEW CC_F_QINTERVAL_MASSHEALTH_SV;
DROP VIEW CC_HCO_F_CALL_BACK_SV;
DROP VIEW CC_NCEB_F_CALLS_BY_DAY_MULTIGRAIN_SV;
DROP VIEW CC_NCEB_F_V2_CALL_SV;
DROP VIEW HCO_C_CAMPAIGN_TRACKING_SV;
DROP VIEW HCO_F_VM_BY_HR_TYPE_BY_DAY_SV;

-- Drop unwanted Tables

DROP TABLE CC_C_CONTACT_QUEUE_BAK;
DROP TABLE CC_D_AGENT_BKP;
DROP TABLE CC_D_CONTACT_QUEUE_BAK;
DROP TABLE CC_HCO_F_CALL_BACK;
DROP TABLE CC_HCO_F_V2_CALL;
DROP TABLE CC_HCO_S_CALL_BACK;
DROP TABLE CC_S_ACD_INTERVAL_PERIOD_BAK;
DROP TABLE CC_S_AGENT_BKP;
DROP TABLE CC_S_CONTACT_QUEUE_BAK;
DROP TABLE CC_S_TMP_PIPKINS_EVENT;
DROP TABLE CC_S_TMP_PIPKINS_OFFICE;
DROP TABLE CC_S_TMP_PIPKINS_STAFF;
DROP TABLE CC_S_TMP_PIPKINS_STAFF_GROUP;
DROP TABLE CC_S_TMP_PIPKINS_STF_GRP_STF;
DROP TABLE CC_S_TMP_PIPKINS_STF_TO_OFFICE;
DROP TABLE CC_S_TMP_PIPKINS_SUP_TO_STAFF;
DROP TABLE CC_S_TMP_PIPKINS_TASK;
DROP TABLE CC_S_TMP_PIPKINS_TIMEZONE;
DROP TABLE HCO_BUSINESS_HOURS_TYPE_LKUP;
DROP TABLE HCO_C_CAMPAIGN_TRACKING;
DROP TABLE MLOG$_CC_HCO_F_V2_CALL;

