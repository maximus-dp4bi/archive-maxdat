create or replace view CC_D_MANAGER_SV as
 select distinct d.*
 from cc_s_agent_supervisor mgr
 inner join cc_s_agent_supervisor sup on mgr.agent_id = sup.supervisor_agent_id
 inner join cc_s_agent a on mgr.supervisor_agent_id = a.agent_id
 inner join cc_d_agent d on a.login_id = d.login_id;
/
 -- supervisor dimension data set (revised to use dim vs. stage in return)
 create or replace view CC_D_SUPERVISOR_SV as
 select distinct d.*
 from cc_s_agent_supervisor sup
 inner join cc_s_agent a on sup.supervisor_agent_id = a.agent_id 
 inner join cc_d_agent d on a.login_id = d.login_id ;
/
grant select on CC_D_MANAGER_SV to MAXDAT_READ_ONLY;
grant select on CC_D_SUPERVISOR_SV to MAXDAT_READ_ONLY;
						  
INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.9.0','002','002_REPLACE_CC_D_MANAGERS_SUPERVISORS_SV');

COMMIT;

