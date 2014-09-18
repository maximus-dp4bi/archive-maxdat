Run order 
svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MailFaxBatch/createdb/
1. create_ETL_MailFaxBatch_tables.sql
2. create_ETL_MailFaxBatch_covered_indexes.sql
3. create_ETL_MailFaxBatch_sequences.sql
4. populate_CORP_ETL_CONTROL_table.sql
5. populate_lkup_tables.sql
6. populate_CORP_ETL_LIST_LKUP.sql

svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/MailFaxBatch/createdb/
7. populate_BPM_EVENT_MASTER.sql

svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MailFaxBatch/createdb/
8. populate_BPM_ATTRIBUTE_LKUP.sql
9. populate_BPM_ATTRIBUTE.sql
10. populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
11. SemanticModel_Mail_Fax_Batch.sql
12. create_MailFaxBatch_triggers.sql
13. MAIL_FAX_BATCH_pkg.sql

svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/MailFaxBatch/patch/
14. BPM_EVENT_PROJECT_pkg_body.sql
15. BPM_SEMANTIC_PROJECT_pkg_body.sql
