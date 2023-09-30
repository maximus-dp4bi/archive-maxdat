update MAXDAT.CORP_ETL_LIST_LKUP
SET    out_var = '''Appeal Closed'',''Returned - Action Required'',''Refer to ARU QC'',''Returned - Refer to DOH Application Support'',''Returned - Refer to DOH APTC/QHP/Plan Management'',''Returned - Refer to DOH MA/FHP'',''Returned - Refer to DOH TPHI'''
,      Value = 'Various incident status for UPD20_70 - UPD20_120'
WHERE name = 'PA_UPD20_70';

commit;
