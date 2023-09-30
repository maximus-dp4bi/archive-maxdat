update corp_etl_complaints_incidents set gwf_resolved_ees_css = 'Y'
where gwf_resolved_ees_css = 'Resolved';

update corp_etl_complaints_incidents set gwf_resolved_ees_css = 'N'
where gwf_resolved_ees_css = 'Tosupervisor';

update corp_etl_complaints_incidents set gwf_resolved_ees_css = 'N'
where gwf_resolved_ees_css = 'ToSupervisor';

commit;
