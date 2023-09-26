
UPDATE corp_etl_list_lkup
SET out_var = '''TN 411'',''TN 408'',''TN 408ftp'''
WHERE name = 'CIR_TERM_LETTERS';

commit;