delete from cc_s_wfm_agent_activity
where trunc(last_update_dt)=trunc(sysdate-1);

commit;