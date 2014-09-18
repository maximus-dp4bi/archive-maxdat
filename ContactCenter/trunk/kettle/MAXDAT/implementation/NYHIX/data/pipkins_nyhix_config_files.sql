--CC_C_ACTIVITY_TYPE.tsv --limit to used activities, join to task
/*
select distinct task_id from task t
 where t.task_edit_id = 0 
  and t.scenario_group_id = 5
  and trunc(task_start)>=trunc(sysdate)-360
  minus one year
  
task category
TASK_CATEGORY_ID	NAME	DESCRIPTION	CATEGORY	PAID	SEQUENCE
1	Regular	Regular Time	1	1	5
2	Overtime	Overtime	2	1	3
3	Comp. Time	Compensation Time for time worked In Lieu	3	1	1
4	In Lieu	Time worked to be taken as Comp. Time in the future	4	0	2
5	Paid Entitlement	Compensated Non-Work type Activities	5	1	4
6	Unpaid Entitlement	Uncompensated Non-Work type Activities	6	0	7
7	Unknown Task Category	Used by RTA program when event is unknown	7	0	6

task
STAFF_ID	SCHEDULE_INSTANCE_ID	TASK_START	SCENARIO_GROUP_ID	TASK_END	TASK_CATEGORY_ID	DURATION	EVENT_ID	SUPERVISOR	TASK_EDIT_ID	EDIT_STATE	TASK_MODIFICATION_REQUEST_REF	ALT_TASK_EDIT_ID	TASK_ID
1845		02-OCT-13	5	02-OCT-13	1	6	1019		0				5157
1845		02-OCT-13	5	02-OCT-13	7	0	16		0				5158

event
EVENT_ID	NAME	EVENT_TYPE_GROUP_ID	EVENT_TYPE_ID	TOLERANCE_FOR_TIMECLOCK	DELETE_DATE	TOLERANCE_FOR_ADHERING	DESCRIPTION	OWNER_USER	MODIFY_USER	OWNER_DATE	MODIFY_DATE	WORK_CLASSIFICATION_ID
1	Beginning of Attendance	2	5	01-JAN-00		01-JAN-00	Beginning of Attendance	-2	1004	26-AUG-05	19-SEP-13	50
2	End of Attendance	3	5	01-JAN-00		01-JAN-00	End of Attendance	-2	1004	26-AUG-05	19-SEP-13	50


ACTIVITY_TYPE_NAME	ACTIVITY_TYPE_DESCRIPTION	ACTIVITY_TYPE_CATEGORY	IS_PAID_FLAG	IS_AVAILABLE_FLAG	IS_READY_FLAG	IS_ABSENCE_FLAG	RECORD_EFF_DT	RECORD_END_DT
ABSENT	Sick or absent	Unscheduled PTO	1	0	0	1	1/1/1900	12/31/2999
*/
select distinct e.name activity_type_name, e.description activity_type_description, et.name activity_type_category, --etg.name activity_category2
0 is_paid_flag, 0 is_available_flag, 0 is_ready_flag, 0 is_absence_flag, '1/1/1900' record_eff_dt, '12/31/2999' record_end_dt
from event e,
event_type et,
event_type_group etg,
task t
where e.event_type_id=et.event_type_id
and et.event_type_id=etg.event_type_id
and t.event_id=e.event_id
and t.task_start>=sysdate-360


--CC_C_FILTER.csv --look at staff, staff_group, staff_group_staff, look at who's active
/*
FILTER_TYPE	VALUE
WFM_STAFF_GROUP_INC	1001
WFM_STAFF_GROUP_INC	1000
*/

select distinct 'WFM_STAFF_GROUP_INC' filter_type,sg.staff_group_id
from staff s, staff_group sg, staff_group_to_staff sgs
where sgs.staff_id=s.staff_id
and sgs.staff_group_id=sg.staff_group_id
and exists(select 1 from task t where t.staff_id=s.staff_id and t.task_start>sysdate-360)


--CC_C_LOOKUP.csv
/*
LOOKUP_TYPE	LOOKUP_KEY	LOOKUP_VALUE
WFM_GROUP_PROGRAM	1001	EB
WFM_GROUP_PROJECT	1001	IL EB
WFM_GROUP_PROGRAM	1000	EEV
WFM_GROUP_PROJECT	1000	IL EEV
*/

--CC_C_PROJECT_CONFIG.tsv --we make it up. ask valerio what are the projects that we'll be extracting from the albany infra 
--NYHBE FPBP NYEC etc will need a line 
/*
PROJECT_CONFIG_ID	PROJECT_NAME	PROGRAM_NAME	REGION_NAME	STATE_NAME	PROVINCE_NAME	DISTRICT_NAME	COUNTRY_NAME	RECORD_EFF_DT	RECORD_END_DT
0	Unknown	Unknown	Unknown	Unknown	Unknown	Unknown	Unknown	1900/01/01	2999/12/31
1	IL EB	EB	Central	Illinois	Unknown	Unknown	USA	1900/01/01	2999/12/31
2	IL EEV	EEV	Central	Illinois	Unknown	Unknown	USA	1900/01/01	2999/12/31
*/

--CC_C_UNIT_OF_WORK.csv we'll define try to group queues that are used and look for relationships for grouping. ask valerio if there are defined uow for NY
--make up for now, possible later update of fact table
/*
UNIT_OF_WORK_NAME	RECORD_EFF_DT	RECORD_END_DT
N/A	1/1/1900	12/31/2999
EEV English	1/1/1900	12/31/2999
*/

--CC_D_ACTIVITY_TYPE.tsv --basically cc_c_activity_type copy. "file per table" why its a dupe
/*
ACTIVITY_TYPE_NAME	ACTIVITY_TYPE_CATEGORY	ACTIVITY_TYPE_DESCRIPTION	IS_PAID_FLAG	IS_READY_FLAG	IS_ABSENCE_FLAG	RECORD_EFF_DT	RECORD_END_DT	VERSION
ABSENT	Unscheduled PTO	Sick or absent	1	0	1	1900/01/01	2999/12/31	1
BOA	Other Not Ready	Beginning of Attendance	1	0	0	1900/01/01	2999/12/31	1
*?

--CC_D_CONTACT_QUEUE.csv --cc_c_contact_queue
/*
D_CONTACT_QUEUE_ID	QUEUE_NUMBER	QUEUE_NAME	SOURCE_QUEUE	QUEUE_TYPE	SERVICE_PERCENT	SERVICE_SECONDS	QUEUE_GROUP	INTERVAL_MINUTES	SPEED_ANSWER_PERIOD_1_BOUND	SPEED_ANSWER_PERIOD_2_BOUND	SPEED_ANSWER_PERIOD_3_BOUND	SPEED_ANSWER_PERIOD_4_BOUND	SPEED_ANSWER_PERIOD_5_BOUND	SPEED_ANSWER_PERIOD_6_BOUND	SPEED_ANSWER_PERIOD_7_BOUND	SPEED_ANSWER_PERIOD_8_BOUND	SPEED_ANSWER_PERIOD_9_BOUND	SPEED_ANSWER_PERIOD_10_BOUND	CALLS_ABNDONED_PERIOD_1_BOUND	CALLS_ABNDONED_PERIOD_2_BOUND	CALLS_ABNDONED_PERIOD_3_BOUND	CALLS_ABNDONED_PERIOD_4_BOUND	CALLS_ABNDONED_PERIOD_5_BOUND	CALLS_ABNDONED_PERIOD_6_BOUND	CALLS_ABNDONED_PERIOD_7_BOUND	CALLS_ABNDONED_PERIOD_8_BOUND	CALLS_ABNDONED_PERIOD_9_BOUND	CALLS_ABNDONED_PERIOD_10_BOUND	VERSION	RECORD_EFF_DT	RECORD_END_DT
0	0	Unknown	0	Unknown	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1/1/1900	12/31/2199
*/

--CC_D_GEOGRAPHY_MASTER.csv
/*
geography_master_id	geography_name	country_id	 state_id	 province_id	 district_id	 region_id
0	Unknown	0	0	0	0	0
1	New York	1	1	0	0	1

*/

--CC_D_PROD_PLANNING_TARGET.csv --seed with zeroes, one per project
/*
D_PROD_PLANNING_TARGET_ID	D_PROJECT_ID	D_TARGET_ID	TARGET_VALUE	RECORD_EFF_DT	RECORD_END_DT	VERSION
0	0	0	0	1/1/1900	12/31/2199	1
*/

--CC_D_PROGRAM.csv --those come from valerio
--ask matthew and jonathan about programs/projects and if/how they want it broken down, what value for reporting. etc
/*
program_id	program_name
0	Unknown
1	CHIP
2	EB
3	THS
4	EEV
*/

--CC_D_PROJECT.csv --those come from valerio
--NYHBE, NYEC, FPBP
/*
project_id	 project_name	 segment_id
0	Unknown	0
1	IL EB	1
2	IL EEV	2
*/

--CC_D_PROJECT_TARGETS.csv --zeroes, one per project
/*
project_id	 average_handle_time_target	cost_per_call_target	labor_cost_per_call_target	occupancy_target	utilization_target	record_eff_dt	record_end_dt	version
0	0	0	0	0	0	1/1/1900	12/31/2199	0
1	0	0	0	0	0	1/1/1900	12/31/2199	1
2	0	0	0	0	0	1/1/1900	12/31/2199	1
*/

--CC_D_REGION.csv --add eastern
/*
region_id	region_name
0	Unknown
1	Eastern
*/

--CC_D_STATE.csv --add NY
/*
state_id	state_name
0	Unknown
1	New York
*/

--CC_D_UNIT_OF_WORK.csv  --those come from valerio copy of cc_c_unit_of_work
/*
uow_id	unit_of_work_name	production_plan_id	hourly_flag	handle_time_unit
0	Unknown	0	N	Seconds
	CSR English	0	N	Seconds
	CSR Spanish	0	N	Seconds
*/

