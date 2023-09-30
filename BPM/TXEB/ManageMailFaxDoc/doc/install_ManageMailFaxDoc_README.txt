ManageMailFaxDoc

-- Files can be found at:
-- (Corp) svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageMailFaxDoc/createdb
-- or (TXEB) svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ManageMailFaxDoc/createdb

Run order:
 1. (TXEB) create_ETL_Mailfaxdoc_tables.sql
 2. (TXEB) create_ETL_Mailfaxdoc_sequences.sql
 3. (Corp) SemanticModel_Manage_Mail_Fax_Doc.sql
 4. (Corp) MANAGE_MAIL_FAX_DOC_pkg.sql
 5. (TXEB) populate_CORP_ETL_CONTROL.sql
 6. (TXEB) populate_CORP_ETL_LIST_LKUP.sql
 7. (TXEB) populate_CORP_INSTANCE_CLEANUP_TABLE.sql
 8. (Corp) populate_lkup_tables.sql
 9. (TXEB) populate_BPM_EVENT_MASTER.sql
10. (Corp) populate_BPM_ATTRIBUTE_LKUP.sql
11. (Corp) populate_BPM_ATTRIBUTE.sql
12. (Corp) populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
13. (TXEB) create_ETL_Mailfaxdoc_triggers.sql
14. (TXEB) create_ETL_Mailfaxdoc_grants_public_syn.sql
