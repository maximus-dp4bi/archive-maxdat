alter session set current_schema = cisco_enterprise_cc;

CREATE OR REPLACE VIEW CC_S_AGENT_FIRST_CALL_DT_SV
AS
select cc_s_agent_first_call_dt.agent_call_dt_id, 
cc_s_agent_first_call_dt.agent_id, 
cc_s_agent_first_call_dt.login_id, 
cc_s_agent_first_call_dt.first_name, 
cc_s_agent_first_call_dt.last_name, 
cc_d_project.project_id, 
cc_s_agent_first_call_dt.project_name, 
cc_s_agent_first_call_dt.job_title, 
cc_s_agent_first_call_dt.department, 
cc_s_agent_first_call_dt.agent_call_dt, 
cc_s_agent_first_call_dt.extract_dt, 
cc_s_agent_first_call_dt.last_update_dt, 
cc_s_agent_first_call_dt.last_update_by
from cc_s_agent_first_call_dt
INNER JOIN CC_D_PROJECT ON cc_s_agent_first_call_dt.PROJECT_NAME = CC_D_PROJECT.PROJECT_NAME;