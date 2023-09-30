--TXEB-5579 Include all letters for now and check performance
update corp_etl_list_lkup
set out_var = 'X'
where name = 'LETTER_TYPES_TO_EXCLUDE';

UPDATE corp_etl_list_lkup
SET value = '''Voided'',''Combined Similar Requests'',''Overcome by Events'',''Canceled'''
WHERE name = 'LETTER_STATUS_OTHR';

commit;