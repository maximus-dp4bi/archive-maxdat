---------------------------------------------
-- COMPARE THE COUNTS 
-- IF THEY DO NOT MATCH STOP!!!!
---------------------------------------------  


select count(*) from MAXDAT.PP_WFM_ACTUALS;
	
select count(*) from MAXDAT.PP_WFM_ACTUALS_NEW;
	
-------------------------------------------------
-- DO NOT PROCEDE IF THERE ARE ANY ERRORS OR DIFFERENCES
-------------------------------------------------

-------------------------------------------------
-- RENAME THE CURRENT TABLE TO 'BAK'
-------------------------------------------------

RENAME PP_WFM_ACTUALS TO PP_WFM_ACTUALS_BAK;

GRANT SELECT ON MAXDAT.PP_WFM_ACTUALS_BAK TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON MAXDAT.PP_WFM_ACTUALS_BAK TO MAXDAT_READ_ONLY;

-------------------------------------------------
-- DROP THE INDEXES AND PRIMARY KEY CONSTRAINT
-------------------------------------------------

ALTER TABLE MAXDAT.PP_WFM_ACTUALS_BAK
 DROP PRIMARY KEY CASCADE;

--DROP INDEX MAXDAT.PP_WFM_ACTUAL_EVENTID_NDX;

--DROP INDEX MAXDAT.PP_WFM_ACTUALS_STAFF_ID_NDX;

--DROP INDEX MAXDAT.PP_WFM_ACTUAL_TASK_END_NDX;

--DROP INDEX MAXDAT.PP_WFM_ACTUAL_TASK_START_NDX;

--DROP INDEX PP_WFM_ACTUALS_TASK_END_NDX;

--DROP INDEX PP_WFM_ACTUALS_EVENTTASK_NDX;
	
-------------------------------------------------
-- RENAME THE 'NEW' TABLE TO THE OLD NAME
-------------------------------------------------

RENAME PP_WFM_ACTUALS_NEW TO PP_WFM_ACTUALS;

-------------------------------------------------
-- ADD THE CONSTRAINTS, GRANTS AND INDEXES TO THE NEW TABLE
-------------------------------------------------

GRANT SELECT ON MAXDAT.PP_WFM_ACTUALS TO DP_SCORECARD WITH GRANT OPTION;

GRANT REFERENCES, UPDATE ON MAXDAT.PP_WFM_ACTUALS TO DP_SCORECARD;

GRANT SELECT ON MAXDAT.PP_WFM_ACTUALS TO MAXDAT_READ_ONLY;


--------------------------------------------------

CREATE UNIQUE INDEX MAXDAT.PP_WFM_ACTUALS_PK ON MAXDAT.PP_WFM_ACTUALS
(RT_ACTUALS_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


ALTER TABLE MAXDAT.PP_WFM_ACTUALS ADD (
  CONSTRAINT PP_WFM_ACTUALS_PK
  PRIMARY KEY
  (RT_ACTUALS_ID)
  USING INDEX MAXDAT.PP_WFM_ACTUALS_PK
  ENABLE VALIDATE);

-----------------------------------------------------
  
CREATE INDEX MAXDAT.PP_WFM_ACTUALS_STAFF_ID_NDX 
ON MAXDAT.PP_WFM_ACTUALS
(STAFF_ID) LOCAL
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

CREATE INDEX MAXDAT.PP_WFM_ACTUAL_TASK_START_NDX 
ON MAXDAT.PP_WFM_ACTUALS
(TASK_START)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

CREATE INDEX MAXDAT.PP_WFM_ACTUALS_TASK_END_NDX 
ON MAXDAT.PP_WFM_ACTUALS
(TASK_END)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

CREATE INDEX MAXDAT.PP_WFM_ACTUALS_EVENTTASK_NDX 
ON MAXDAT.PP_WFM_ACTUALS
(EVENT_ID, TASK_END)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

CREATE INDEX MAXDAT.PP_WFM_ACTUAL_EVENTID_NDX 
ON MAXDAT.PP_WFM_ACTUALS
(EVENT_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


CREATE INDEX MAXDAT.PP_WFM_ACTUAL_TASK_START_T_NDX 
ON MAXDAT.PP_WFM_ACTUALS
(TRUNC(TASK_START))
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

CREATE INDEX MAXDAT.PP_WFM_ACTUAL_TASK_END_T_NDX 
ON MAXDAT.PP_WFM_ACTUALS
(TRUNC(TASK_END))
LOGGING
TABLESPACE MAXDAT_DATA
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

-------------------------------------------------
-- Update the Trigger
-------------------------------------------------
		   
		   
-------------------------------------------------
-- ADD THE COMMENTS
-------------------------------------------------

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.RT_ACTUALS_ID IS 'Internal identifier for a RT_ACTUALS record.';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.STAFF_ID IS 'Internal identifier for a STAFF record.';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.EVENT_ID IS 'Internal identifier for a EVENT record.';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.SOURCE_ID IS 'Identifier of the source of the unprocessed data (1 = Notify Manual RTA screen).';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.TASK_START IS 'Is the date and time at which the task commences.';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.TASK_CATEGORY_ID IS 'Internal identifier for the TASK CATEGORY record.';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.TASK_END IS 'Is the date and time at which the task ends.';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.WORK_ACTIVITY IS 'A note of work description or detail added to the data.';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.ANNOTATION IS 'A note of explanation or comment added to the data.';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.CREATE_DATE IS 'Records the date when the record was created.';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.CREATE_STAFF_ID IS 'Internal identifier for a STAFF record.';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.MODIFY_DATE IS 'Records the date when the record was last edited.';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.MODIFY_STAFF_ID IS 'Internal identifier for a STAFF record.';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.QUEUE_ID IS 'Internal identifier for a QUEUE record.';

COMMENT ON COLUMN MAXDAT.PP_WFM_ACTUALS.EXCLUSION_FLAG IS 'Has this record been excluded.';

-------------------------------------------------------------------------------------------
----------------------------------------------------------
-- RECOMPLIE ANY INVALID OBJECTS
-- THE FOLLOWING WILL PRODUCE THE SQL FOR THE RECOMPILE
----------------------------------------------------------

select 'ALTER '||OBJECT_TYPE||' '||OBJECT_NAME||' COMPILE;' from all_objects 
where status <> 'VALID'
AND OWNER = 'MAXDAT';


