/*
Created on 19-Oct-2012 by Raj A.

Description:
This sql truncates the BPM and pre-BPM table for a fresh reload of the Process MI data.
This is done to fix the bugs in the code.
Bugs:
1. New_MI_Creation_date getting reset.
2. All_MI_satisfies not checked correctly in the Transformation tab.
3. Deployment artifact in the data.(Multiple QC Task IDs, Research Task IDs issue).
*/

truncate table process_mi_stg;
truncate table nyec_etl_process_mi;