-- All files can be found at:
-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ManageEnrollmentActivity/createdb

Run order:
	
 1. create_ETL_ManageEnroll_tables.sql
 2. create_ETL_ManageEnroll_sequences.sql
 3. create_ETL_ManageEnroll_indexes.sql
 4. populate_CORP_ETL_CONTROL
 5. populate_CORP_ETL_LIST_LKUP
 6. populate_RULE_LKUP_MNG_ENRL_FOLLOWUP
 7. populate_RULE_LKUP_MNG_ENRL_SLA
 8. populate_RULE_LKUP_MNG_ENRL_PACKET
 9. SemanticModel_ManageEnrollment.sql
 10. create_ETL_ManageEnroll_triggers.sql
 11. populate_lkup_tables.sql
 12. populate_BPM_EVENT_MASTER.sql
 13. populate_BPM_ATTRIBUTE_LKUP.sql
 14. populate_BPM_ATTRIBUTE.sql
 15. populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
 16. MANAGE_ENROLL_pkg.sql
 17.create_ETL_ManageEnroll_grants_public_syn.sql