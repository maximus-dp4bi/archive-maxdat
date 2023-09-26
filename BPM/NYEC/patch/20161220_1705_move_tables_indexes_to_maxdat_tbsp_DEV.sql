/*
Created on 12/20/2016 by Raj A.
Description: MAXDAT-1314
*/
--Tables are in the correct tablespace, MAXDAT_DATA. Hence, no changes needed to alter tables.

alter index I_SNAP$_D_YEARS rebuild tablespace MAXDAT_INDX online;
alter index I_SNAP$_D_MONTHS rebuild tablespace MAXDAT_INDX online;
alter index XPKGROUP_STEP_DEFINITION rebuild tablespace MAXDAT_INDX online;
alter index PK_NOTE rebuild tablespace MAXDAT_INDX online;
alter index SYS_C0067480 rebuild tablespace MAXDAT_INDX online;
alter index CC_EVNT_REF_ARC_INDX rebuild tablespace MAXDAT_INDX online;
alter index CC_EVNT_REF_AF_INDX rebuild tablespace MAXDAT_INDX online;
alter index SYS_C0067476 rebuild tablespace MAXDAT_INDX online;
alter index SIS_HIST_OWNER_IDX rebuild tablespace MAXDAT_INDX online;
alter index SIS_HIST_CREATE_TS_IDX rebuild tablespace MAXDAT_INDX online;
alter index SIS_HIST_CREATE_BY_IDX rebuild tablespace MAXDAT_INDX online;
alter index CC_EVNT_REF_INDX rebuild tablespace MAXDAT_INDX online;
alter index SYS_C0026998 rebuild tablespace MAXDAT_INDX online;