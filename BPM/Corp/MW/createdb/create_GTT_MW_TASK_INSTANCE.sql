CREATE GLOBAL TEMPORARY TABLE GTT_MW_TASK_INSTANCE
(	
    MW_BI_ID                                                NUMBER NOT NULL ENABLE, 
	AGE_IN_BUSINESS_DAYS                                    NUMBER DEFAULT 0 NOT NULL ENABLE, 
	AGE_IN_CALENDAR_DAYS                                    NUMBER DEFAULT 0 NOT NULL ENABLE, 
	CANCELLED_BY_STAFF_ID                                   NUMBER, 
	CANCEL_METHOD                                           VARCHAR2(50), 
	CANCEL_REASON                                           VARCHAR2(256), 
	CANCEL_WORK_DATE                                        DATE, 
	CASE_ID                                                 NUMBER(18,0), 
	CLIENT_ID                                               NUMBER(18,0), 
	COMPLETE_DATE                                           DATE, 
	CREATE_DATE                                             DATE NOT NULL ENABLE, 
	CURR_CREATED_BY_STAFF_ID                                NUMBER, 
	ESCALATED_FLAG                                          VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE, 
	CURR_ESCALATED_TO_STAFF_ID                              NUMBER, 
	CURR_FORWARDED_BY_STAFF_ID                              NUMBER, 
	FORWARDED_FLAG                                          VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE, 
	CURR_BUSINESS_UNIT_ID                                   NUMBER, 
	INSTANCE_START_DATE                                     DATE, 
	INSTANCE_END_DATE                                       DATE, 
	JEOPARDY_FLAG                                           VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE, 
	CURR_LAST_UPD_BY_STAFF_ID                               NUMBER, 
	CURR_LAST_UPDATE_DATE                                   DATE NOT NULL ENABLE, 
	LAST_EVENT_DATE                                         DATE, 
	CURR_OWNER_STAFF_ID                                     NUMBER, 
	PARENT_TASK_ID                                          NUMBER, 
	SOURCE_REFERENCE_ID                                     NUMBER(*,0), 
	SOURCE_REFERENCE_TYPE                                   VARCHAR2(30), 
	CURR_STATUS_DATE                                        DATE NOT NULL ENABLE, 
	STATUS_AGE_IN_BUS_DAYS                                  NUMBER DEFAULT 0 NOT NULL ENABLE, 
	STATUS_AGE_IN_CAL_DAYS                                  NUMBER DEFAULT 0 NOT NULL ENABLE, 
	STG_EXTRACT_DATE                                        DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	STG_LAST_UPDATE_DATE                                    DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	STAGE_DONE_DATE                                         DATE, 
	TASK_ID                                                 NUMBER NOT NULL ENABLE, 
	TASK_PRIORITY                                           VARCHAR2(50), 
	CURR_TASK_STATUS                                        VARCHAR2(50) NOT NULL ENABLE, 
	TASK_TYPE_ID                                            NUMBER NOT NULL ENABLE, 
	CURR_TEAM_ID                                            NUMBER, 
	TIMELINESS_STATUS                                       VARCHAR2(20) DEFAULT 'Not Complete' NOT NULL ENABLE, 
	UNIT_OF_WORK                                            VARCHAR2(30), 
	CURR_WORK_RECEIPT_DATE                                  DATE, 
	SOURCE_PROCESS_ID                                       NUMBER(18,0), 
	SOURCE_PROCESS_INSTANCE_ID                              NUMBER(18,0), 
	CURR_CLAIM_DATE                                         DATE, 
    CONSTRAINT GTT_MW_TASK_INSTANCE_PK PRIMARY KEY (MW_BI_ID) 
)
ON COMMIT PRESERVE ROWS;

CREATE INDEX GTT_MW_TASK_INSTANCE_I01 ON GTT_MW_TASK_INSTANCE (CANCELLED_BY_STAFF_ID);

CREATE INDEX GTT_MW_TASK_INSTANCE_I02 ON GTT_MW_TASK_INSTANCE (COMPLETE_DATE);

CREATE INDEX GTT_MW_TASK_INSTANCE_I03 ON GTT_MW_TASK_INSTANCE (CURR_CREATED_BY_STAFF_ID);

CREATE INDEX GTT_MW_TASK_INSTANCE_I04 ON GTT_MW_TASK_INSTANCE (CREATE_DATE);

CREATE INDEX GTT_MW_TASK_INSTANCE_I05 ON GTT_MW_TASK_INSTANCE (CURR_BUSINESS_UNIT_ID); 

CREATE INDEX GTT_MW_TASK_INSTANCE_I06 ON GTT_MW_TASK_INSTANCE (TASK_TYPE_ID);

CREATE INDEX GTT_MW_TASK_INSTANCE_I07 ON GTT_MW_TASK_INSTANCE (CURR_TEAM_ID);

CREATE INDEX GTT_MW_TASK_INSTANCE_I08 ON GTT_MW_TASK_INSTANCE (CURR_ESCALATED_TO_STAFF_ID);

CREATE INDEX GTT_MW_TASK_INSTANCE_I09 ON GTT_MW_TASK_INSTANCE (CURR_FORWARDED_BY_STAFF_ID);

CREATE INDEX GTT_MW_TASK_INSTANCE_I10 ON GTT_MW_TASK_INSTANCE (CURR_LAST_UPD_BY_STAFF_ID);

CREATE INDEX GTT_MW_TASK_INSTANCE_I11 ON GTT_MW_TASK_INSTANCE (CURR_OWNER_STAFF_ID);

CREATE INDEX GTT_MW_TASK_INSTANCE_I12 ON GTT_MW_TASK_INSTANCE (SOURCE_REFERENCE_ID);
  
CREATE INDEX GTT_MW_TASK_INSTANCE_I13 ON GTT_MW_TASK_INSTANCE (SOURCE_PROCESS_INSTANCE_ID, CREATE_DATE);

CREATE INDEX GTT_MW_TASK_INSTANCE_I14 ON GTT_MW_TASK_INSTANCE (SOURCE_PROCESS_INSTANCE_ID, COMPLETE_DATE);

CREATE INDEX GTT_MW_TASK_INSTANCE_I15 ON GTT_MW_TASK_INSTANCE (SOURCE_PROCESS_INSTANCE_ID);

CREATE UNIQUE INDEX GTT_MW_TASK_INSTANCE_UI01 ON GTT_MW_TASK_INSTANCE (TASK_ID);
