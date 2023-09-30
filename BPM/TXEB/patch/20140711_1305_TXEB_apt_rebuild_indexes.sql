-- MAXDAT-1083 for TXEB APT only.

create index CC_C_LOOKUP_IDX1 on CC_C_LOOKUP (LOOKUP_TYPE, LOOKUP_KEY) tablespace MAXDAT_INDX;
create index MAXDAT.CC_S_AGENT_IDX1 on MAXDAT.CC_S_AGENT (LOGIN_ID) tablespace MAXDAT_INDX;
create index MAXDAT.DCN_DMFDOC_CURR on MAXDAT.D_MFDOC_CURRENT (DCN) tablespace MAXDAT_INDX;