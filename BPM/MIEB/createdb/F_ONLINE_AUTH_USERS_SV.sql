CREATE OR REPLACE VIEW F_ONLINE_AUTH_USERS_SV
AS
select
D.D_DATE RECORD_DATE
,TRUNC(D.D_DATE,'MM') RECORD_MONTH
,CASE_ID
,upper(SUBSTR(REGEXP_SUBSTR(COMMENTS,'[:^][^]]+'),3)) AS PORTAL_USR
, case when event_type_cd = 'LOGGED_INTO_MOBILEAPP' then 'MO' 
       when event_type_cd = 'LOGGED_IN_PORTAL' then 'O'
         else 'O'
           end LOGIN_SOURCE_CD 
,count(distinct e.event_id) login_cnt
, 1 user_cnt
FROM EB.EVENT E
RIGHT OUTER JOIN MAXDAT_SUPPORT.BPM_D_DATES D ON (E.EFFECTIVE_DATE=D.D_DATE)
WHERE EVENT_TYPE_CD in ('LOGGED_INTO_MOBILEAPP', 'LOGGED_IN_PORTAL')
and e.effective_date >= trunc(add_months(sysdate, -12),'MM')
--and e.case_id in (2492745, 4356270)
GROUP BY
D.D_DATE
,TRUNC(D.D_DATE,'MM')
,CASE_ID
, event_type_cd
,upper(SUBSTR(REGEXP_SUBSTR(COMMENTS,'[:^][^]]+'),3))
;


GRANT SELECT ON MAXDAT_SUPPORT.F_ONLINE_AUTH_USERS_SV TO MAXDAT_REPORTS;
