insert into corp_etl_control
		(name,
		value_type,
		value,
		description,
		created_ts,
		updated_ts)
values ('PM_LAST_DCN',
		'N',
		'0',
		'Used to fetch Documents from OLTP for Process Mail Fax Doc process',
		trunc(sysdate),
		trunc(sysdate)
);
commit;
