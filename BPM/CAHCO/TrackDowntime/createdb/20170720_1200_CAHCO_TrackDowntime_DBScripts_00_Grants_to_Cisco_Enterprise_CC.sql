--GRANT Select on CISCO_ENTERPRISE_CC Views
grant select on CISCO_ENTERPRISE_CC.CC_D_DATES_SV to DP_CAHCO WITH GRANT OPTION;
grant select on CISCO_ENTERPRISE_CC.CC_D_PROJECT_SV to DP_CAHCO WITH GRANT OPTION;
grant select on CISCO_ENTERPRISE_CC.CC_D_PROGRAM_SV to DP_CAHCO WITH GRANT OPTION;

grant select on CISCO_ENTERPRISE_CC.CC_D_DATES_SV to MAXDAT_READ_ONLY;
grant select on CISCO_ENTERPRISE_CC.CC_D_PROJECT_SV to MAXDAT_READ_ONLY;
grant select on CISCO_ENTERPRISE_CC.CC_D_PROGRAM_SV to MAXDAT_READ_ONLY;
 
grant select on CISCO_ENTERPRISE_CC.CC_D_DATES_SV to MAXDAT;
grant select on CISCO_ENTERPRISE_CC.CC_D_PROJECT_SV to MAXDAT;
grant select on CISCO_ENTERPRISE_CC.CC_D_PROGRAM_SV to MAXDAT;


commit;

/
