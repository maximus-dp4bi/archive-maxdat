delete from cc_c_lookup
where lookup_id in (83
,92
,368
,377);

commit;

insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','Austin');

CREATE INDEX cc_s_agent_idx1 ON cc_s_agent (login_id asc);

CREATE INDEX cc_c_lookup_idx1 ON cc_c_lookup (lookup_type asc,lookup_key asc);

commit;