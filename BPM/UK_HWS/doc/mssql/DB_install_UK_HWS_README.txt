Instructions to install UK_HWS Database Scripts

********************************************************************************

Prerequisites: 
1. Microsoft SQL Server 2012 installed.
2. Database install with Maxdat schema and these users created:
	MAXDAT
	MAXDAT_REPORTS
3. Install these items as user "MAXDAT".


-----------------------
1. CORE SCRIPTS SECTION
-----------------------

	-- Run these MS SQL Server scripts below in the new database:  
	-- All files can be found in Subversion (SVN) code repository at:
	-- 	svn://rcmxapp1d.maximus.com/maxdat/


	-- Ordered list of files to deploy to install MAXDAT ETL core database schema.

	BPM/Core/createdb/mssql/create_ETL_tables.sql
	BPM/Core/createdb/mssql/create_ETL_sequences.sql
	BPM/Core/createdb/mssql/ETL_COMMON_pkg.sql

	-- Ordered list of files to deploy to install MAXDAT BPM core database schema.
	        
        BPM/Core/createdb/mssql/create_core_BPM_Event_tables.sql
	BPM/Core/createdb/mssql/create_sequences.sql
	BPM/Core/createdb/mssql/BPM_D_DATES.sql
	BPM/Core/createdb/mssql/BPM_COMMON_pkg.sql
	BPM/Core/createdb/mssql/populate_HOLIDAYS.sql


----------------------------
2. CORPORATE SCRIPTS SECTION
----------------------------

	BPM/Corp/createdb/create_ETL_initialize_tables.sql
	BPM/Corp/createdb/create_ETL_initialize_views.sql


--------------------------------------
3. CORP MANAGE WORK V2 SCRIPTS SECTION
--------------------------------------

	BPM/Corp/ManageWork/createdb/mssql/SemanticModel_MW_V2.sql
        BPM/Corp/ManageWork/createdb/mssql/MW_V2_pkg.sql


-----------------------------------------
4. CORP PROCESS INCIDENTS SCRIPTS SECTION
-----------------------------------------

	BPM/Corp/ProcessIncidents/createdb/mssql/SemanticModel_ProcessIncidents.sql
        BPM/Corp/ProcessIncidents/createdb/mssql/PROCESS_INCIDENTS_pkg.sql


-----------------------------------
5. CORP Assessments SCRIPTS SECTION
-----------------------------------

	BPM/UK_HWS/Assessments/createdb/mssql/SemanticModel_Assessments.sql
	BPM/UK_HWS/Assessments/createdb/mssql/ASSESSMENTS_pkg.sql
        BPM/UK_HWS/Assessments/createdb/mssql/create_ASSESSMENTS_triggers.sql

---------------------------
6. ROLES and GRANTS SECTION
---------------------------

        BPM/Core/createdb/mssql/create_roles.sql
        BPM/Core/createdb/mssql/grant_roles_to_users.sql