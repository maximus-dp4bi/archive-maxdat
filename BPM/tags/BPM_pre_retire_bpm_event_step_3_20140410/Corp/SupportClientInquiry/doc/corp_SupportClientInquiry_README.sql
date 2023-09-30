***** MODIFICATION HISTORY ****************************************************************************
2013/08/05 B.Thai  - Created
Support Client Inquiry ETL   should have all db objects that are specific to the Support Client Inquiry
Workbook. These items should also be  Corporate meaning  the are the same across all EB product. Initially
not for any ATS product.
----------------


******************************************************************************************************

-- All files can be found at:
-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/SupportClientInquiry/createdb
-- or (project) svn://rcmxapp1d.maximus.com/maxdat/BPM/(project)/SupportClientInquiry/createdb
-- or DB_INITIAL_LOAD_SUPPORTCLIENTINQUIRY_1.zip

Run order:

 1. create_ETL_SupportClientInquiry_tables.sql
 2. create_ETL_SupportClientInquiry_sequences.sql
 3. SemanticModel_Support_Client_Inquiry.sql
 4. CLIENT_INQUIRY_pkg.sql
 5. (project) populate_BPM_EVENT_MASTER.sql
 6. populate_lkup_tables.sql
 7. populate_CORP_ETL_CONTROL.sql
 8. populate_CORP_SCI_ETL_CACTIONS_LKUP.sql
 9. populate_CORP_SCI_ETL_CTYPES_LKUP.sql
10. create_ETL_SupportClientInquiry_triggers.sql
11. create_ETL_SupportClientInquiry_grants_public_syn.sql

