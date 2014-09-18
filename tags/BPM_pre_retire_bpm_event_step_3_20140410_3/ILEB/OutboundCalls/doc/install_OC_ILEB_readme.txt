
Instructions to install ILEB Database Scripts for Outbound Calls

********************************************************************************

----------------------------------------
CORP and ILEB PROCESS SCRIPTS SECTION
----------------------------------------

    -------------------------------------------------
    OutboundCalls

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/createdb/
	-- or svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/OutboundCalls/createdb/
	-- or (ILEB) svn://rcmxapp1d.maximus.com/maxdat/BPM/ILEB/OutboundCalls/)

        Run order:
	
         1. CORP_ETL_STAGE_pkg.sql
         2. create_ETL_OutboundCalls_tables.sql
         3. create_ETL_OutboundCalls_triggers.sql
         4. create_ETL_OutboundCalls_sequences.sql
         5. create_ETL_OutboundCalls_grant_synonyms.sql
         6. SemanticModel_Outbound_Calls.sql
         7. insert_OC_CORP_ETL_CONTROL.sql
         8. create_CORP_ETL_LIST_LKUP.sql
         9. populate_lkup_tables.sql
        10. (ILEB/createdb)  populate_BPM_EVENT_MASTER.sql
        11. populate_BPM_ATTRIBUTE_LKUP.sql
        12. populate_BPM_ATTRIBUTE.sql
        13. populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
        14. OUTBOUND_CALLS_pkg.sql
        15. (ILEB/patch) BPM_EVENT_PROJECT_pkg_body.sql
        16. (ILEB/patch) BPM_SEMANTIC_PROJECT_pkg_body.sql
        17. ETL_PROCESS_OUTBOUND_CALLS_pkg.sql
