CREATE TABLE MAXDAT.GRP_STEP_DEFN_DFLT_STG
(
GROUP_STEP_DEFN_DEFAULT_ID NUMBER(18, 0) NOT NULL
, EFFECTIVE_START_TS DATE
, EFFECTIVE_END_TS DATE
, STEP_DEFINITION_ID NUMBER(18, 0)
, GROUP_STEP_DEFINITION_ID NUMBER(18, 0)
, CONSTRAINT XPKGROUP_STEP_DEFN_DEFAULT PRIMARY KEY
(
GROUP_STEP_DEFN_DEFAULT_ID
)
ENABLE
) ;