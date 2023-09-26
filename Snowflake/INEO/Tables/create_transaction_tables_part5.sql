create or replace sequence seq_agent_performance_history_id;

DROP TABLE IF EXISTS INEO_AGENT_PERFORMANCE_HISTORY;
create TABLE INEO_AGENT_PERFORMANCE_HISTORY (
    AGENT_PERFORMANCE_HISTORY_ID NUMBER NOT NULL DEFAULT seq_agent_performance_history_id.nextval,
	DATE DATE,
	USERID VARCHAR,
	QUEUE VARCHAR,
	CALLTYPE VARCHAR,
	INTERACTIONS NUMBER,
	AVGTALK VARCHAR,
	TOTALTALK VARCHAR,
	AVGHOLD VARCHAR,
	TOTALHOLD VARCHAR,
	AVGACW VARCHAR,
	TOTALACW VARCHAR,
	AVGSPDANS VARCHAR,
	LOCALDISCONNECTED NUMBER,
	AGENTAVAILABLE VARCHAR,
	FILENAME VARCHAR,
	FILENAME_PREFIX VARCHAR
);

alter table INEO_AGENT_PERFORMANCE_HISTORY add primary key (AGENT_PERFORMANCE_HISTORY_ID);

CREATE OR REPLACE SEQUENCE seq_ineo_queue_daily_summary_history_id;

CREATE OR REPLACE TABLE INEO_QUEUE_DAILY_SUMMARY_HISTORY (ineo_queue_daily_summary_history_id NUMBER NOT NULL DEFAULT seq_ineo_queue_daily_summary_history_id.nextval,
date DATE,
abd NUMBER,
aht VARCHAR,
asa VARCHAR,
rcc VARCHAR,
filename VARCHAR,
calls_offered NUMBER,
calls_answered NUMBER,
abd15_secs NUMBER,
ab_rate VARCHAR,
sla_8060 VARCHAR,
average_talk_time VARCHAR,
average_hold_time VARCHAR,
average_follow_up_time VARCHAR,
 sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
 sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());
 
ALTER TABLE INEO_QUEUE_DAILY_SUMMARY_HISTORY ADD PRIMARY KEY(ineo_queue_daily_summary_history_id);

CREATE OR REPLACE SEQUENCE seq_ineo_rcc_iedss_task_inventory_history_id;

CREATE OR REPLACE TABLE INEO_RCC_IEDSS_TASK_INVENTORY_HISTORY (ineo_rcc_iedss_task_inventory_history_id NUMBER NOT NULL DEFAULT seq_ineo_rcc_iedss_task_inventory_history_id.nextval,
date DATE,
region VARCHAR,
county VARCHAR,
office VARCHAR,
totals NUMBER,
filename VARCHAR,
work_category VARCHAR,
queue_name VARCHAR,
task_name VARCHAR,
future_total NUMBER,
current_total NUMBER,
overdue_total NUMBER,
 sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
 sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());
 
ALTER TABLE INEO_RCC_IEDSS_TASK_INVENTORY_HISTORY ADD PRIMARY KEY(ineo_rcc_iedss_task_inventory_history_id);

CREATE OR REPLACE SEQUENCE seq_ineo_queue_summary_history_id;

CREATE OR REPLACE TABLE INEO_QUEUE_SUMMARY_HISTORY (ineo_queue_summary_history_id NUMBER NOT NULL DEFAULT seq_ineo_queue_summary_history_id.nextval,
date DATE,
abd NUMBER,
aht VARCHAR,
asa VARCHAR,
rcc VARCHAR,
filename VARCHAR,
calls_offered NUMBER,
calls_answered NUMBER,
abd15_secs NUMBER,
ab_rate VARCHAR,
sla_8060 VARCHAR,
average_talk_time VARCHAR,
average_hold_time VARCHAR,
average_follow_up_time VARCHAR,
summary_type VARCHAR,
 sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
 sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());
 
ALTER TABLE INEO_QUEUE_SUMMARY_HISTORY ADD PRIMARY KEY(ineo_queue_summary_history_id);


