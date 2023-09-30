/*
v1 Raj A. 16-Aug-2012 Creation.
v2 Raj A. 21-Aug-2012 Added three more columns to the step_instance_stg.
			1.SR_PROCESSED
			2.TP_PROCESSED
			3.IR_PROCESSED
*/

/*
Adding a column to STEP_INSTANCE_STG from Process MI Perspective.
When 'Process MI' is done using the Step Instance recordm it will set the column, MI_PROCESSED to 'Y'.
*/
alter table step_instance_stg add MI_PROCESSED varchar2(1) default 'N' ;

/*
Adding columns to STEP_INSTANCE_STG for each process.
When 'Process MI' is done using the Step Instance records it will set the column, MI_PROCESSED to 'Y'.
Likewise for all processes.
*/
alter table step_instance_stg 
add (
SR_PROCESSED varchar2(1) default 'N',
TP_PROCESSED varchar2(1) default 'N',
IR_PROCESSED varchar2(1) default 'N'
);