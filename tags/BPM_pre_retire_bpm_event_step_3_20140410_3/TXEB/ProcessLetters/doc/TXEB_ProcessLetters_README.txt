-- All files can be found at:
-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ProcessLetters/createdb

Run order:
	
 1. create_ETL_ProcessLetters_tables.sql
 2. create_ETL_ProcessLetters_sequences.sql  
 3. SemanticModel_Process_Letters.sql
 4. PROCESS_LETTERS_pkg.sql
 5. populate_lkup_tables.sql
 6. populate_BPM_EVENT_MASTER.sql
 7. populate_BPM_ATTRIBUTE_LKUP.sql
 8. populate_BPM_ATTRIBUTE.sql
 9. populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
10. populate_CORP_ETL_CONTROL.sql
11. populate_CORP_ETL_LIST_LKUP.sql
12. create_ETL_ProcessLetters_triggers.sql
