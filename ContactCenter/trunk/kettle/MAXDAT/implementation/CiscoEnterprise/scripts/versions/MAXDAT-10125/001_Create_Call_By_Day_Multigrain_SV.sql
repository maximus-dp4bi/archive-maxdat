alter session set current_schema = cisco_enterprise_cc;

create or replace view CC_NCEB_F_V2_CALL_SV AS
Select * from 
(
  SELECT
 F.F_V2_CALL_ID
,F.D_DATE_ID
,F.DATETIME
,F.CALLTYPE_REPORTING_DATETIME
,F.D_CONTACT_QUEUE_ID
,F.QUEUE_NUMBER
,F.D_AGENT_ID
,F.AGENT_LOGIN_ID
,F.ROUTER_CALL_KEY_DAY
,F.ROUTER_CALL_KEY
,F.PERIPHERAL_CALL_KEY
,F.PERIPHERAL_CALL_TYPE
,F.PERIPHERAL_ID
,F.SKILL_GROUP_ID
,F.PRECISION_QUEUE_ID
,F.SOURCE_D_AGENT_ID
,F.SOURCE_AGENT_LOGIN_ID
,F.CALL_REFERENCE_ID
,F.CALLGUID
,F.CALL_SEGMENT_ID
,F.SOURCE_CALL_ID
,F.ACTIVITY_ID
,F.DIGITS_DIALED
,F.ANI_PHONE_NUMBER
,F.CALL_DISPOSITION
,DL.CALL_DISPOSITION_DESC
,F.CALL_DISPOSITION_FLAG
,DFL.CALL_DISPOSITION_FLG_DESC
,F.DNIS
,(SELECT COALESCE((select lookup_value from cc_c_lookup where lookup_type = 'LANGUAGE_CODE' and lookup_key = F.QUEUE_NUMBER), 'UNKNOWN') from dual) LANGUAGE
,F.QUEUE_TIME_SECONDS
,F.RING_TIME_SECONDS
,F.HOLD_TIME_SECONDS
,F.WORK_TIME_SECONDS
,F.TALK_TIME_SECONDS
,F.IVR_TIME_SECONDS
,F.NETWORK_TIME_SECONDS
,F.LOCAL_Q_TIME_SECONDS
,F.DELAY_TIME_SECONDS
,F.TIME_TO_ABAND_SECONDS
,F.CALL_DURATION
,F.TRANSFER_TO
,F.XFERRED_OUT_FLAG
,CASE WHEN
	D.QUEUE_TYPE in  (SELECT distinct rtrim(ltrim(regexp_substr(OUT_VAR, '[^,]+', 1, level),''''),'''')
  FROM (SELECT OUT_VAR  FROM CC_A_LIST_LKUP WHERE NAME = 'VM_call_types')
CONNECT BY instr(OUT_VAR, ',', 1, level - 1) > 0)
	THEN 'Y' 	ELSE 'N' END VOICEMAIL_FLAG
,CASE WHEN TIME_TO_ABAND_SECONDS > 0 THEN 1 ELSE 0 END CALL_ABANDONED_FLAG
,CASE WHEN
	D.QUEUE_TYPE in  (SELECT distinct rtrim(ltrim(regexp_substr(OUT_VAR, '[^,]+', 1, level),''''),'''')
  FROM (SELECT OUT_VAR  FROM CC_A_LIST_LKUP WHERE NAME = 'Handled_Inbound_call_types')
CONNECT BY instr(OUT_VAR, ',', 1, level - 1) > 0)
	THEN 1 	ELSE 0 END CALL_OFFERED_FLAG
,CASE WHEN TALK_TIME_SECONDS >0 THEN 1 ELSE 0 END CALL_ANSWERED_FLAG
,CASE WHEN CALL_DISPOSITION in (8,9,11) THEN 1 ELSE 0 END CALL_BUSY_FLAG
,CASE WHEN CALL_DISPOSITION in (10,12) THEN 1 ELSE 0 END CALL_DROPPED_FLAG
,CASE
   WHEN F.D_CONTACT_QUEUE_ID IS NOT NULL THEN D.QUEUE_TYPE
   WHEN F.PERIPHERAL_CALL_TYPE = 9 THEN 'Agent'
   WHEN F.CALL_HANDLE_METHOD = 'Predictive Dialer' THEN CALL_HANDLE_METHOD
ELSE NULL
END CALL_HANDLE_METHOD
,'Manual' as CALL_DIAL_METHOD
,F.CALL_SEGMENT_END_DT
,F.CREATE_DATE
,F.LAST_UPDATE_DATE
,F.LAST_UPDATED_BY
,NULL AS CUSTOMER_ACCOUNT_NUMBER
, CASE
   WHEN F.D_CONTACT_QUEUE_ID IS NOT NULL THEN D.D_PROJECT_ID
   WHEN (F.PERIPHERAL_CALL_TYPE = 9 AND F.D_AGENT_ID IS NOT NULL) THEN  (select PROJECT_ID
FROM CC_D_PROJECT P
, CC_S_AGENT S
, CC_C_PROJECT_CONFIG C
WHERE S.LOGIN_ID = F.AGENT_LOGIN_ID
AND S.PROJECT_CONFIG_ID = C.PROJECT_CONFIG_ID
AND C.PROJECT_NAME = P.PROJECT_NAME)
   ELSE NULL
   END D_PROJECT_ID
, CASE
   WHEN F.D_CONTACT_QUEUE_ID IS NOT NULL THEN D.D_PROGRAM_ID
   WHEN (F.PERIPHERAL_CALL_TYPE = 9 AND F.D_AGENT_ID IS NOT NULL) THEN  (select PROGRAM_ID
FROM CC_D_PROGRAM P
, CC_S_AGENT S
, CC_C_PROJECT_CONFIG C
WHERE S.LOGIN_ID = F.AGENT_LOGIN_ID
AND S.PROJECT_CONFIG_ID = C.PROJECT_CONFIG_ID
AND C.PROGRAM_NAME = P.PROGRAM_NAME)
   ELSE NULL
   END D_PROGRAM_ID
,CASE
   WHEN F.D_CONTACT_QUEUE_ID IS NOT NULL THEN D.D_UNIT_OF_WORK_ID
  ELSE NULL
  END D_UNIT_OF_WORK_ID
FROM CC_F_V2_CALL F
LEFT OUTER JOIN CC_D_CONTACT_QUEUE D ON F.D_CONTACT_QUEUE_ID = D.D_CONTACT_QUEUE_ID
LEFT OUTER JOIN CC_C_CALL_DISPOSITION_LKUP DL ON F.CALL_DISPOSITION = DL.CALL_DISPOSITION_CODE
LEFT OUTER JOIN CC_C_CALL_DISPOSITION_FLG_LKUP DFL ON F.CALL_DISPOSITION_FLAG = DFL.CALL_DISPOSITION_FLG_CODE)
inner join cc_d_project p on d_project_id = p.project_id and p.project_name = 'NCEB';

GRANT SELECT ON CC_NCEB_F_V2_CALL_SV  TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW CC_NCEB_F_CALLS_BY_DAY_MULTIGRAIN_SV AS
select trunc(t2.DateTime) as d_date, t2.call_result, t2.queue_number, t1.d_date_id, t1.d_project_id, t1.d_program_id, t1.d_contact_queue_id, t1.d_unit_of_work_id
     , case when t2.call_result = 'ABANDON' then 0 else max(t1.time_to_answer) end as max_ans_time
     , case when t2.call_result = 'HANDLE' then 0 else max(t1.time_to_aband) end as max_ab_time
     from (
        select tcd.Router_Call_Key_Day, tcd.Router_Call_Key, tcd.queue_number, tcd.d_date_id, tcd.d_project_id, tcd.d_program_id, tcd.d_contact_queue_id, tcd.d_unit_of_work_id,
       sum(tcd.talk_time_seconds) as talk_time, sum(tcd.Local_Q_Time_seconds) + sum(Ring_Time_Seconds) + 1 as time_to_answer, sum(tcd.Time_To_Aband_seconds) as time_to_aband
from   cc_nceb_f_v2_call_sv tcd
join   cc_d_contact_queue ct on (tcd.queue_number = ct.queue_number and ct.queue_type = 'Inbound')
join   cc_d_project p on (tcd.d_project_id = p.project_id and p.project_name = 'NCEB')
group by tcd.Router_Call_Key_Day, tcd.Router_Call_Key, tcd.queue_number, tcd.d_date_id, tcd.d_project_id, tcd.d_program_id, tcd.d_contact_queue_id, tcd.d_unit_of_work_id
) t1,
(
select distinct tcd2.Router_Call_Key_Day, tcd2.Router_Call_Key, tcd2.queue_number, tcd2.Call_Disposition, tcd2.Call_Disposition_Flag, tcd2.DateTime
      ,case when tcd2.Call_Disposition_Flag = 2 then 'ABANDON'
            when tcd2.Call_Disposition_Flag = 1 then 'HANDLE'
            else 'OTHER' end as call_result
from   cc_nceb_f_v2_call_sv tcd2
join   cc_d_contact_queue ct on (tcd2.queue_number = ct.queue_number and ct.queue_type = 'Inbound')
join   cc_d_project p on (tcd2.d_project_id = p.project_id and p.project_name = 'NCEB')
and    tcd2.Call_Reference_ID is not null
) t2
where t1.Router_Call_Key_Day = t2.Router_Call_Key_Day 
and t1.Router_Call_Key = t2.Router_Call_Key 
and t1.queue_number = t2.queue_number
group by trunc(t2.DateTime), t2.call_result, t2.queue_number, t1.d_date_id, t1.d_project_id, t1.d_program_id, t1.d_contact_queue_id, t1.d_unit_of_work_id
;

GRANT SELECT ON CC_NCEB_F_CALLS_BY_DAY_MULTIGRAIN_SV TO MAXDAT_READ_ONLY;