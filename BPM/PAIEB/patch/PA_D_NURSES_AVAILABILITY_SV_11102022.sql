CREATE OR REPLACE VIEW PA_D_NURSES_AVAILABILITY_SV AS
select  s.first_name as EB_FIRST_NAME
       ,s.last_name as EB_LAST_NAME
       ,CASE WHEN LENGTH(TRIM(s.LAST_NAME)) < 1 THEN TRIM(s.FIRST_NAME)
             WHEN LENGTH(TRIM(s.FIRST_NAME)) < 1 THEN TRIM(s.LAST_NAME)
             ELSE TRIM(s.LAST_NAME) || ', ' || TRIM(s.FIRST_NAME)
             END AS EB_FULL_NAME
       ,s.staff_id as EB_STAFF_ID
       ,gr.group_name as EB_TEAM_name
       ,gr.group_id as GROUP_ID
       ,gr.supervisor_staff_id as EB_SUPERVISOR_STAFF_ID
       ,s2.first_name as EB_supervisor_first_name
       ,s2.last_name as EB_suppervisor_last_name
       ,CASE WHEN LENGTH(TRIM(s2.LAST_NAME)) < 1 THEN TRIM(s2.FIRST_NAME)
             WHEN LENGTH(TRIM(s2.FIRST_NAME)) < 1 THEN TRIM(s2.LAST_NAME)
             ELSE TRIM(s2.LAST_NAME) || ', ' || TRIM(s2.FIRST_NAME)
             END AS EB_SUPervisor_FULL_NAME
       ,n.nurse_id
       ,n.gender_cd
       ,n.active_ind
       ,n.activation_date EB_STAFF_START_DATE
       ,case when n.active_ind = 0 then trunc(n.update_ts) else null end EB_STAFF_END_DATE
from   ats.staff s
JOIN ats.groups gr ON (gr.group_id = s.default_group_id AND gr.type_cd = 'TEAM' AND (gr.group_name like ('Field EB Unit%') or gr.group_name = 'OUTREACH TEAM 1'))
left outer join   ats.nurse n on (s.staff_id = n.staff_id) --  and nvl(n.active_ind,0) = 1)
left outer join   ats.staff s2 on (gr.supervisor_staff_id = s2.staff_id)
UNION
select 'Unknown' as EB_FIRST_NAME
      ,'Unknown' as EB_LAST_NAME
      ,'Unknown' AS EB_FULL_NAME
      ,0         as EB_STAFF_ID
      ,'Unknown' as EB_TEAM_name
      ,0         as GROUP_ID
      ,0         as EB_SUPERVISOR_STAFF_ID
      ,null      as EB_supervisor_first_name
      ,null      as EB_suppervisor_last_name
      ,null      AS EB_SUPervisor_FULL_NAME
      ,0         as nurse_id
      ,'U'       as gender_cd
      ,null      as active_ind
      ,to_date('01/01/1985', 'mm/dd/yyyy') EB_STAFF_START_DATE
      ,to_date('01/01/1985', 'mm/dd/yyyy') EB_STAFF_END_DATE
from dual;


GRANT SELECT ON MAXDAT_SUPPORT.PA_D_NURSES_AVAILABILITY_SV TO MAXDATSUPPORT_PFP_READ_ONLY;

GRANT SELECT ON MAXDAT_SUPPORT.PA_D_NURSES_AVAILABILITY_SV TO MAXDATSUPPORT_READ_ONLY;

GRANT SELECT ON MAXDAT_SUPPORT.PA_D_NURSES_AVAILABILITY_SV TO MAXDAT_REPORTS;

GRANT SELECT ON MAXDAT_SUPPORT.PA_D_NURSES_AVAILABILITY_SV TO MAXDAT_SUPPORT_READ_ONLY;