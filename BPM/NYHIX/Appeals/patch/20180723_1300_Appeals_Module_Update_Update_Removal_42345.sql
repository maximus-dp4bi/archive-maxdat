alter session set current_schema = MAXDAT;
----  NYHIX-42345 -> Prod version of the change
SELECT *
FROM MAXDAT.corp_etl_list_lkup
WHERE list_type = 'APPEAL_STATUS'
AND NAME = 'PA_UPD20_70';

UPDATE MAXDAT.corp_etl_list_lkup
SET    out_var = '''Appeal Closed'''
WHERE list_type = 'APPEAL_STATUS'
AND NAME = 'PA_UPD20_70';
commit;

commit;

SELECT *
FROM MAXDAT.corp_etl_list_lkup
WHERE list_type = 'APPEAL_STATUS'
AND NAME = 'PA_UPD20_70';
