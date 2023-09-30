  -- dups test
   
   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.audio_quality group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.billable_usage group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.configuration_objects group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.conversations group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.conversations_detail group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.conversation_attributes group by 1,2,3)
select count(*) from dups where dup_count > 1;--0
   
   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.dialer_detail group by 1,2,3)
select count(*) from dups where dup_count > 1;--  43

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.dialer_preview_detail group by 1,2,3)
select count(*) from dups where dup_count > 1;--3

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.divisions group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.evaluations group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.evaluation_forms group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.flow_outcomes group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.groups_membership group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.locations group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.mysql_audits group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.participants group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.primary_presence group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.queues_membership group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.queue_configuration group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.routing_status group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.segments group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.sessions group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.session_summary group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.user_details group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.user_locations group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.user_roles group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.user_skills group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.wfm_activity_codes group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.wfm_historical_actuals group by 1,2,3)
select count(*) from dups where dup_count > 1;--12008

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.wfm_historical_exceptions group by 1,2,3)
select count(*) from dups where dup_count > 1;--0

   with dups as (
select projectid, programid, raw, count(*) as dup_count from raw.wfm_schedule group by 1,2,3)
select count(*) from dups where dup_count > 1;--0