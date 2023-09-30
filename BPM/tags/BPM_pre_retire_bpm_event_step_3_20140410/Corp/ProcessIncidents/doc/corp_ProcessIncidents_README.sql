-- Files can be found at:
-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ProcessIncidents/createdb
-- or (project) svn://rcmxapp1d.maximus.com/maxdat/BPM/(project)/ProcessIncidents/createdb

Run order:
        
 1. create_ETL_ProcessIncidents_tables.sql
 2. create_ETL_ProcessIncidents_sequences.sql
 3. SemanticModel_DPY_ProcessIncidents.sql
 4. DPY_PROCESS_INCIDENTS_pkg.sql
 5. populate_lkup_tables.sql
 6. (project) populate_BPM_EVENT_MASTER.sql
 7. create_ETL_ProcessIncidents_triggers.sql