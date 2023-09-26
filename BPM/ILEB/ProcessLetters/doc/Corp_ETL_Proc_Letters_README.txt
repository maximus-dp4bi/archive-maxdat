***** MODIFICATION HISTORY ****************************************************************************
12/04/2014 Raj A.  - Created. Back filling the deployment instructions as NYHIX(Corp process) is differign form ILEB PL.
----------------


******************************************************************************************************

Run order 

1.svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/createdb/get_inlist_str3.sql

2. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ProcessLetters/createdb/populate_lkup_tables.sql

3. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ProcessLetters/createdb/populate_BPM_EVENT_MASTER

4. svn://rcmxapp1d.maximus.com/maxdat/BPM/ILEB/ProcessLetters/createdb/create_ETL_ProcessLetters_tables.sql

5. svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ProcessLetters/createdb/create_ETL_ProcessLetters_sequences.sql

6. svn://rcmxapp1d.maximus.com/maxdat/BPM/ILEB/ProcessLetters/createdb/create_ETL_ProcessLetters_triggers.sql

7. svn://rcmxapp1d.maximus.com/maxdat/BPM/ILEB/ProcessLetters/createdb/SemanticModel_Process_Letters.sql

8. svn://rcmxapp1d.maximus.com/maxdat/BPM/ILEB/ProcessLetters/createdb/TRG_AI_CORP_ETL_PROC_LETTERS_Q.sql

9. svn://rcmxapp1d.maximus.com/maxdat/BPM/ILEB/ProcessLetters/createdb/TRG_AU_CORP_ETL_PROC_LETTERS_Q.sql

10. svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/ProcessLetters/createdb/populate_CORP_ETL_CONTROL.sql

11. svn://rcmxapp1d.maximus.com/maxdat/BPM/ILEB/ProcessLetters/createdb/PROCESS_LETTERS_pkg.sql

12. svn://rcmxapp1d.maximus.com/maxdat/BPM/ILEB/ProcessLetters/createdb/ETL_PROCESS_LETTERS_PKG.sql

13. svn://rcmxapp1d.maximus.com/maxdat/BPM/ILEB/createdb/BPM_SEMANTIC_PROJECT_pkg_body.sql