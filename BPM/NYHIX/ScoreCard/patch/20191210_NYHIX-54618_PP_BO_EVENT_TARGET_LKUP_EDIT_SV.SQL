
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "DP_SCORECARD"."PP_BO_EVENT_TARGET_LKUP_EDIT_SV" ("ERROR_MESSAGE", "EVENT_ID", "NAME", "TARGET", "SCORECARD_FLAG", "START_DATE", "END_DATE", "CREATE_BY", "CREATE_DATETIME", "SCORECARD_GROUP", "EE_ADHERENCE", "OPS_GROUP", "WORKSUBACTIVITY_FLAG", "QC_FLAG", "EE_ADHERENCE_V2") AS 
  with duplicates as
( -- duplicates
	select event_id, start_date, 'Duplicate Date' as err_msg 
	from MAXDAT.PP_BO_EVENT_TARGET_LKUP
	where ( event_id, start_date, end_date )
	in ( select event_id, start_date, end_date
		from MAXDAT.PP_BO_EVENT_TARGET_LKUP
		group by event_id, start_date, end_date
		having sum(1) > 1 
		)
),
bad_flags as
( 
	select event_id, start_date, 'Bad Flag' as err_msg 
	from MAXDAT.PP_BO_EVENT_TARGET_LKUP
	where 1= 2 
	or scorecard_flag is null
	or scorecard_flag not in ('Y','N')
	or ee_adherence is null
	or ee_adherence not in ('Y','N')
	or worksubactivity_flag is null
	or worksubactivity_flag not in ('Y','N')
	or QC_flag is null
	or QC_flag not in ('Y','N')
	or ee_adherence_v2 is null
	or ee_adherence_v2 not in ('Y','N')
),
null_fields as
(
	select event_id, start_date, 'Null Fields' as err_msg 
	from MAXDAT.PP_BO_EVENT_TARGET_LKUP
	where 1= 2 
	or start_date is null
	or scorecard_group is null
	or ops_group is null
),
bad_target as
(
	select event_id, start_date, 'Bad Target' as err_msg 
	from MAXDAT.PP_BO_EVENT_TARGET_LKUP
	where target is null or target < 0
),
bad_start_date as
( 
	select event_id, start_date, 'Future Start Date' as err_msg 
	from MAXDAT.PP_BO_EVENT_TARGET_LKUP
	where start_date > trunc(nvl(end_date,sysdate))
),
date_overlap as
( 
--	select event_id, x.start_date, 'Date Ovelap' as err_msg
--	from MAXDAT.PP_BO_EVENT_TARGET_LKUP
--	where event_id in 
--	( -- date overlaping dates 
		select x.event_id, x.start_date, 'Date Ovelap' as err_msg 
		from MAXDAT.PP_BO_EVENT_TARGET_LKUP x 
		join MAXDAT.PP_BO_EVENT_TARGET_LKUP y 
		on x.event_id = y.event_id 
		and x.end_date between y.start_date and nvl(y.end_date,sysdate) 
		and x.rowid <> y.rowid 
--	)
),
date_gaps as
(
	select event_id, start_date, 'Date Gap' as err_msg
	from MAXDAT.PP_BO_EVENT_TARGET_LKUP
	where event_id in 
	( -- date gaps    
		select event_id
		from 
			(
			select event_id, start_date, end_date,
			lag(end_date) 
				over 
				( order by event_id, start_date ) as prior_end_date
		from MAXDAT.PP_BO_EVENT_TARGET_LKUP
		where event_id in 
		(
			select event_id 
			from MAXDAT.PP_BO_EVENT_TARGET_LKUP
			group by event_id
			having sum(1) > 1 )
		)
	where prior_end_date is not null
	and start_date > prior_end_date+1
	)
),
all_error_event_ids as
( 
	select event_id from duplicates
	union 
	select event_id from bad_flags
	union
	select event_id from null_fields 
	union
	select event_id from bad_target
	union 
	select event_id from bad_start_date
	union
	select event_id from date_overlap
	union
	select event_id from date_gaps
),
results as
(
	select rtrim( 
				case when duplicates.err_msg is null then null else duplicates.err_msg||', ' end
				||case when bad_flags.err_msg is null then null else bad_flags.err_msg||', ' end
				||case when null_fields.err_msg is null then null else null_fields.err_msg||', '  end
				||case when bad_target.err_msg is null then null else bad_target.err_msg||', ' end
				||case when bad_start_date.err_msg is null then null else bad_start_date.err_msg||', ' end
				||case when date_overlap.err_msg is null then null else date_overlap.err_msg||', ' end
				||case when date_gaps.err_msg is null then null else date_gaps.err_msg||', ' end
			,', ') as error_message,
			lkup.* 
	from MAXDAT.PP_BO_EVENT_TARGET_LKUP lkup
	left outer join duplicates
		on  duplicates.event_id = lkup.event_id
		and duplicates.start_date = lkup.start_date
	--
	left outer join bad_flags
		on  bad_flags.event_id = lkup.event_id
		and bad_flags.start_date = lkup.start_date
	--
	left outer join null_fields
		on  null_fields.event_id = lkup.event_id
		and null_fields.start_date = lkup.start_date
	--
	left outer join bad_target
		on  bad_target.event_id = lkup.event_id
		and bad_target.start_date = lkup.start_date
	--
	left outer join bad_start_date
		on  bad_start_date.event_id = lkup.event_id
		and bad_start_date.start_date = lkup.start_date
	--
	left outer join date_overlap
		on  date_overlap.event_id = lkup.event_id
		and date_overlap.start_date = lkup.start_date
	--
	left outer join date_gaps
		on 	date_gaps.event_id = lkup.event_id
		and date_gaps.start_date = lkup.start_date
	--
	where lkup.event_id in 
		( 
			select event_id from all_error_event_ids
		)
)
select results."ERROR_MESSAGE",results."EVENT_ID",results."NAME",results."TARGET",results."SCORECARD_FLAG",results."START_DATE",results."END_DATE",results."CREATE_BY",results."CREATE_DATETIME",results."SCORECARD_GROUP",results."EE_ADHERENCE",results."OPS_GROUP",results."WORKSUBACTIVITY_FLAG",results."QC_FLAG",results."EE_ADHERENCE_V2" 
from results 
order by event_id, start_date;

grant select on DP_SCORECARD.PP_BO_EVENT_TARGET_LKUP_EDIT_SV to MAXDAT_READ_ONLY;
grant select on DP_SCORECARD.PP_BO_EVENT_TARGET_LKUP_EDIT_SV to MAXDAT_REPORTS;
grant select on DP_SCORECARD.PP_BO_EVENT_TARGET_LKUP_EDIT_SV to PUBLIC;

