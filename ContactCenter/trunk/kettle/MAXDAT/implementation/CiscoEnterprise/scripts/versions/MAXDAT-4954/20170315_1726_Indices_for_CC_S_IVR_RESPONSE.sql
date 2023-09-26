/*
Created on 03/15/2016 by Raj A.
Originally created on 10/19/2016 by Raj A. for MSSS-224, Deploy CSI IVR File load process to ilebmxdp for MI MSS IVR File.
*/
create index ivr_resp_call_starttime on CC_S_IVR_RESPONSE (call_START_time) TABLESPACE  MAXDAT_INDX online;
create index ivr_resp_comp_code on CC_S_IVR_RESPONSE (COMPLETION_CODE) TABLESPACE  MAXDAT_INDX online;
create index ivr_resp_dest_dnis on CC_S_IVR_RESPONSE (DESTINATION_DNIS) TABLESPACE  MAXDAT_INDX online;
create index ivr_resp_proj_name on CC_S_IVR_RESPONSE (PROJECT_NAME) TABLESPACE  MAXDAT_INDX online;
create index ivr_resp_prog_name on CC_S_IVR_RESPONSE (PROGRAM_NAME) TABLESPACE  MAXDAT_INDX online;
create index ivr_resp_geo_name on CC_S_IVR_RESPONSE (GEOGRAPHY_NAME) TABLESPACE  MAXDAT_INDX online;