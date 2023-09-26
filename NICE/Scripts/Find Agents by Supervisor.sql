

-- Look up by putting Supervisor's name under CURRENT_TEAM
select * from [nice_wfm_integration].dbo.AGENT_SV where CURRENT_TEAM like '%Odair%';

-- Look up agent by putting agent's name under FIRST_NAME or LAST_NAME
select * from [nice_wfm_integration].dbo.AGENT_SV where LAST_NAME like '%Ellis%' and FIRST_NAME like '%Bryan%';

-- Look up agents by TEAM SET NAME
select * from [nice_wfm_integration].dbo.AGENT_SV where CURRENT_TEAM_SET_NAME like '%MA-BOS%'
ORDER BY CURRENT_TEAM, LAST_NAME;