-- update HI HIX all agents record
-- staging
update cc_s_agent
set first_name = 'HIX',
  middle_initial = 'HIX',
  last_name = 'Agents',
  job_title = 'Unknown',
  language = 'Unknown',
  site_name = 'Unknown'
where login_id = 0
  and first_name = 'HIHIX Agents';

-- dimensional
update cc_d_agent
set first_name = 'HIX',
  middle_initial = 'HIX',
  last_name = 'Agents',
  job_title = 'Unknown',
  language = 'Unknown',
  site_name = 'Unknown'
where login_id = 0
  and first_name = 'HIHIX Agents';

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.3.1','100','100_UPDATE_HIHIX_ALL_AGENTS_RECORD');

commit;