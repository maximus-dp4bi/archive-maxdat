This folder is for the Core scripts needed for deployment to a shared DB environment with multiple schemas
The runall script should have the variable declaration that is specific to the project

Example:
Runall script - runall_Core_scripts.sql
Location - /maxdat/BPM/LAEB/patch

Inside runall_Core_scripts.sql, initialize the variables

column tablespacen new_value tablespacename noprint 
select <specify tablespace name> tablespacen from dual;
column role_nm new_value role_name noprint
select <specify role name> role_nm from dual;
<Call each script here>

Example:

column tablespacen new_value tablespacename noprint 
select 'MAXDAT_LAEB_DATA' tablespacen from dual;
column role_nm new_value role_name noprint
select 'MAXDAT_LAEB_READ_ONLY' role_nm from dual;
@@create_ETL_tables.sql
@@create_ETL_sequences.sql