update corp_etl_appeal set cancelled_date = null
where closed_date is not null and cancelled_date is not null
and closed_date <= cancelled_date;

update corp_etl_appeal cea
set cea.expert_reviewer_md_id = nvl((
select u.person_id from
MAXDAT.Fedqic_Appeal_Stg fas
join fedqic_user_stg u
on fas.c_expert_reviewer_md_id = u.user_id
where fas.id = cea.appeal_id),-1)
where cea.expert_reviewer_md_id = -1;


