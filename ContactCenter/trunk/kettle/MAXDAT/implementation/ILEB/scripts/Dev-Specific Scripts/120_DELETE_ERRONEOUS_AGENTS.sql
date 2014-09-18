-- remove erroneous records that were incorrectly tied to an unknown program/project because of ETL bug in load_CC_S_AGENT
delete
from cc_s_acd_agent_activity aaa
where aaa.agent_id in (select agent_id
                      from cc_s_agent
                      where project_config_id = 0);

delete
from cc_s_agent_work_day awd
where awd.agent_id in (select agent_id
                      from cc_s_agent
                      where project_config_id = 0);

delete
from cc_s_wfm_agent_activity waa
where waa.agent_id in (select agent_id
                      from cc_s_agent
                      where project_config_id = 0);

delete
from cc_s_agent_absence aa
where aa.agent_id in (select agent_id
                      from cc_s_agent
                      where project_config_id = 0);
commit;

DELETE FROM CC_S_AGENT_SUPERVISOR aa 
WHERE aa.supervisor_agent_id in (select agent_id
                      from cc_s_agent
                      where project_config_id = 0);

DELETE FROM cc_s_agent
WHERE project_config_id = 0;

insert into cc_l_patch_log (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
values ('0.3.1',120,'120_DELETE_ERRONEOUS_AGENTS');
commit;
