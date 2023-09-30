grant select on CC_S_TMP_ACTUALEVENTTIMELINE to maxdat_read_only;
grant select on CC_S_TMP_INTERVAL to maxdat_read_only;
grant select on CC_S_TMP_IVR_STEP to maxdat_read_only;
grant select on CC_S_TMP_AVY_IAPPLICATION to maxdat_read_only;
grant select on CC_S_TMP_CISCO_C_T_INTERVAL to maxdat_read_only;
grant select on CC_S_TMP_CISCO_AGENT_INTERVAL to maxdat_read_only;
grant select on CC_S_TMP_CISCO_AGENT_LOGOUT to maxdat_read_only;
grant select on CC_S_TMP_CISCO_A_SG_INTERVAL to maxdat_read_only;
grant select on CC_S_TMP_AGENT_SKILL_GROUP to maxdat_read_only;

create public synonym CC_S_TMP_AGENT_SKILL_GROUP for CC_S_TMP_AGENT_SKILL_GROUP;