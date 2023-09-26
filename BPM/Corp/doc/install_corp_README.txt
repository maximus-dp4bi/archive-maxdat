***** MODIFICATION HISTORY ****************************************************************************
2013/07/26 Devin  - Created
Initialize ETL  should have all db objects that are not part of CORE and not specific to one Work book, 
These items should also be  Corporate meaning  the are the same across all EB and ATS products

----------------


******************************************************************************************************
Prerequisite:
   1. svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/doc/install_core_README.txt


Run order (svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/createdb):
1.create_ETL_initialize_tables.sql

2.create_ETL_initialize_views.sql

3.create_ETL_initialize_triggers.sql

4. BPM_LAST_ETL_RUN_SV.sql
