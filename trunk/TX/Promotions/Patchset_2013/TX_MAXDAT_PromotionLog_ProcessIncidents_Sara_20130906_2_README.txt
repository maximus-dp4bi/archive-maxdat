***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB Kettle Scripts and DB Scripts
----------------
2013/09/06 Saraswathi Konidena    - Created

******************************************************************************************************

------------------------------
1. Database scripts SECTION
------------------------------

Deploy all files from  DB_ProcessIncidents_20130906_SARA_2.zip 

OR


Download the following file from svn://rcmxapp1d.maximus.com/maxdat/BPM/Core/patch
and see run instructions below

20130906_1740_alter_size_out_var_column.sql


Download the following file from svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ProcessIncidents/patch
and see run instructions below

20130906_1744_reinsert_into_corp_etl_list_lkup.sql

Run the following in the promotional instance in the following order:

20130906_1740_alter_size_out_var_column.sql
20130906_1744_reinsert_into_corp_etl_list_lkup.sql