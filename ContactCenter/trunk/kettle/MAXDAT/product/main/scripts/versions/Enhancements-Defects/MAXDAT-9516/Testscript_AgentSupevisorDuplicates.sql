
--check for duplicate versions
select * from cc_d_acd_agent_supervisor 
 where agent_login_id in (select agent_login_id from ( 
 select agent_login_id, supervisor_login_id, version, record_end_dt, count(*) from cc_d_acd_agent_supervisor 
 group by agent_login_id,supervisor_login_id,record_end_dt,version 
 having count(*) > 1)t) 
 order by agent_login_id,version ;
 
--check for record eff dt gaps between versions
SELECT * 
        FROM 
          (SELECT
            D_AGENT_SUPERVISOR_ID
            , D_AGENT_ID
            , AGENT_LOGIN_ID
            , D_SUPERVISOR_ID
            ,SUPERVISOR_LOGIN_ID
            , VERSION
            , RECORD_EFF_DT
            , RECORD_END_DT
            , LEAD (RECORD_EFF_DT , 1, NULL) OVER (PARTITION BY AGENT_LOGIN_ID ORDER BY AGENT_LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT) as NEXT_EFF_DT
            FROM CC_D_ACD_AGENT_SUPERVISOR a
            ORDER BY AGENT_LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT
            )sub 
            WHERE RECORD_END_DT < NEXT_EFF_DT
            ORDER BY AGENT_LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT;