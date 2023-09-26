update CORP_ETL_CONTROL 
set name = 'DOC_LOOKBACK_DAYS'
where name = 'PMFX_DCN_ID';

delete from CORP_ETL_CONTROL where name like 'MFD%';

commit;