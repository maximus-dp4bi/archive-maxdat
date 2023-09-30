EXECUTE DBMS_ERRLOG.CREATE_ERROR_LOG('d_bpm_process_instance');
EXECUTE DBMS_ERRLOG.CREATE_ERROR_LOG('d_bpm_entity_instance');
EXECUTE DBMS_ERRLOG.CREATE_ERROR_LOG('d_bpm_flow_instance');
EXECUTE DBMS_ERRLOG.CREATE_ERROR_LOG('d_bpm_process_segment_instance');
EXECUTE DBMS_ERRLOG.CREATE_ERROR_LOG('F_BPM_PROCESS_BY_DATE');
CREATE OR REPLACE package MW_POPULATE_INSTANCE_TABLES as

-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
    SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/Corp/MW/createdb/MW_POPULATE_INSTANCE_TABLES_PKG.sql $';
    SVN_REVISION varchar2(20) := '$Revision: 25970 $';
    SVN_REVISION_DATE varchar2(60) := '$Date: 2019-01-15 18:43:40 -0500 (Tue, 15 Jan 2019) $';
    SVN_REVISION_AUTHOR varchar2(20) := '$Author: eb45730 $';

   procedure populate_instance_tables;
   PROCEDURE PROCESS_DELTEK_LOAD;

   end MW_POPULATE_INSTANCE_TABLES;
/

CREATE OR REPLACE package body MW_POPULATE_INSTANCE_TABLES as
  procedure populate_instance_tables as
     v_start_curr_status_date DATE;
     v_last_mw_run_date DATE;
     v_section_error VARCHAR2(100);
     v_err_msg VARCHAR2(4000);
     v_err_code VARCHAR2(400);
     l_sql VARCHAR2(1000);


BEGIN

-----------------------------------------------------------------------------
--  Get last record from last MW run
----------------------------------------------------------------------------
SELECT MAX(curr_status_date) INTO v_start_curr_status_date FROM D_MW_TASK_INSTANCE;
SELECT coalesce((MAX(job_end_date) - 2), SYSDATE) INTO v_last_mw_run_date FROM CORP_ETL_JOB_STATISTICS WHERE JOB_NAME ='MW_RUNALL' AND JOB_STATUS_CD = 'COMPLETED';
-----------------------------------------------------------------------------
--  Insert/Update into Process Instance
----------------------------------------------------------------------------
SELECT 'Insert/Update into Process Instance' INTO v_section_error FROM DUAL;

l_sql := 'TRUNCATE TABLE GTT_MW_TASK_INSTANCE';
EXECUTE IMMEDIATE l_sql;

INSERT INTO GTT_MW_TASK_INSTANCE
SELECT ti.*
FROM D_MW_TASK_INSTANCE ti
JOIN D_BPM_TASK_TYPE_ENTITY tt
on ti.task_type_id = tt.task_type_id
WHERE ti.CURR_STATUS_DATE <= v_start_curr_status_date
AND ti.stg_last_update_date >= v_last_mw_run_date;

DBMS_STATS.gather_table_stats(USER, 'GTT_MW_TASK_INSTANCE');

MERGE  INTO d_bpm_process_instance pi
USING
(
WITH task_types AS ( -- Generate a distinct list of task_type_ids that are part of a process
SELECT DISTINCT task_type_id, ENTITY_ID FROM D_BPM_TASK_TYPE_ENTITY
)

, task_type_entity AS ( -- Generate a distinct list of task_type_ids and entity_id sthat are part of a process
SELECT DISTINCT task_type_id, ENTITY_ID FROM D_BPM_TASK_TYPE_ENTITY
)

, new_updated_processes AS ( -- Generate a list of the new and updated process instances
SELECT distinct m1.source_process_instance_id process_instance_id
, p.process_id
, p.PROCESS_NAME
, p.PROCESS_DESCRIPTION
, p.PARENT_PROCESS_ID
, (SELECT min(m11.create_date) FROM GTT_MW_TASK_INSTANCE m11 WHERE m11.source_process_instance_id = m1.source_process_instance_id) process_start_date
, (SELECT max(m11.COMPLETE_DATE) FROM GTT_MW_TASK_INSTANCE m11 WHERE m11.source_process_instance_id = m1.source_process_instance_id
      AND m11.CREATE_DATE = (SELECT max(create_date) FROM GTT_MW_TASK_INSTANCE m12 WHERE m12.source_process_instance_id = m11.source_process_instance_id)) process_complete_date
, 'UNKN' timeliness_status
FROM GTT_MW_TASK_INSTANCE m1
JOIN task_type_entity tte
ON m1.task_type_id = tte.task_type_id
JOIN d_bpm_entity e
ON tte.entity_id = e.entity_id
JOIN d_bpm_process p
ON p.process_id = e.process_id
LEFT JOIN d_bpm_process_instance pi
ON m1.source_process_instance_id = pi.PROCESS_INSTANCE_ID
WHERE m1.source_process_instance_id IS NOT NULL
AND pi.PROCESS_INSTANCE_ID IS NULL

UNION

SELECT DISTINCT pi.process_instance_id
, pi.process_id
, pi.PROCESS_NAME
, pi.PROCESS_DESCRIPTION
, pi.PARENT_PROCESS_ID
, pi.process_start_date
, (SELECT max(m11.COMPLETE_DATE) FROM D_MW_TASK_INSTANCE m11 WHERE m11.source_process_instance_id = mw.source_process_instance_id
      AND m11.CREATE_DATE = (SELECT max(create_date) FROM D_MW_TASK_INSTANCE m12 WHERE m12.source_process_instance_id = m11.source_process_instance_id)) process_complete_date
, 'UNKN' timeliness_status
FROM D_MW_TASK_INSTANCE mw
JOIN d_bpm_process_instance pi
ON mw.source_process_instance_id = pi.PROCESS_INSTANCE_ID
WHERE pi.PROCESS_COMPLETE_DATE IS NULL
AND (SELECT max(m11.COMPLETE_DATE) FROM D_MW_TASK_INSTANCE m11 WHERE m11.source_process_instance_id = mw.source_process_instance_id
      AND m11.CREATE_DATE = (SELECT max(create_date) FROM D_MW_TASK_INSTANCE m12 WHERE m12.source_process_instance_id = m11.source_process_instance_id)) IS NOT NULL
)


SELECT nup.process_instance_id
     , nup.process_id
     , nup.PROCESS_NAME
     , nup.PROCESS_DESCRIPTION
     , nup.PARENT_PROCESS_ID
     , nup.process_start_date
     , nup.process_complete_date
     , CASE WHEN nup.process_complete_date IS NULL THEN 'In Process'
            WHEN p.PROCESS_TIMELINESS_DAYS_TYPE = 'C' AND round((nup.process_complete_date - nup.process_start_date),0) <= p.PROCESS_TIMELINESS_THRESHOLD THEN 'Timely'
            WHEN p.PROCESS_TIMELINESS_DAYS_TYPE = 'C' AND round((nup.process_complete_date - nup.process_start_date),0) > p.PROCESS_TIMELINESS_THRESHOLD THEN 'Untimely'
            WHEN p.PROCESS_TIMELINESS_DAYS_TYPE = 'B' AND round(Bus_days_between(nup.process_start_date, nup.process_complete_date),0) <= p.PROCESS_TIMELINESS_THRESHOLD THEN 'Timely'
            ELSE 'Untimely' END timeliness_status
FROM new_updated_processes nup
JOIN d_bpm_process p
ON p.process_id = nup.process_id) nu

ON (PI.process_instance_id = NU.process_instance_id)
WHEN MATCHED THEN
UPDATE SET
    PI.process_start_date = NU.process_start_date
   ,PI.process_complete_date = NU.process_complete_date
   ,PI.timeliness_status =  NU.timeliness_status
WHEN NOT MATCHED THEN
INSERT
(    PROCESS_INSTANCE_ID
    , PROCESS_ID
    , PROCESS_NAME
    , PROCESS_DESCRIPTION
    , PARENT_PROCESS_ID
    , PROCESS_START_DATE
    , PROCESS_COMPLETE_DATE
    , TIMELINESS_STATUS
)
VALUES
(    NU.PROCESS_INSTANCE_ID
    , NU.PROCESS_ID
    , NU.PROCESS_NAME
    , NU.PROCESS_DESCRIPTION
    , NU.PARENT_PROCESS_ID
    , NU.PROCESS_START_DATE
    , NU.PROCESS_COMPLETE_DATE
    , NU.TIMELINESS_STATUS
)
LOG ERRORS (v_section_error || '(' || sysdate ||')')
;
COMMIT;

-----------------------------------------------------------------------------
--  Insert/Update into Entity Instance
----------------------------------------------------------------------------
SELECT 'Insert/Update into Entity Instance' INTO v_section_error FROM DUAL;


MERGE INTO D_BPM_ENTITY_INSTANCE ei
USING
(
WITH task_types AS ( -- Generate a distinct list of task_type_ids that are part of a process
SELECT DISTINCT task_type_id FROM D_BPM_TASK_TYPE_ENTITY
)

, curr_flow_list AS ( -- Generate a list of all possible flow records by task_type_id
SELECT f.flow_id, f.process_id, f.flow_name, f.flow_description, te1.ENTITY_ID source_entity_id, te1.task_type_id source_task_type_id, te2.ENTITY_ID destination_entity_id, te2.task_type_id destination_task_type_id
FROM D_BPM_FLOW f
JOIN D_BPM_TASK_TYPE_ENTITY te1
ON f.flow_source_entity_id = te1.entity_id
JOIN D_BPM_TASK_TYPE_ENTITY te2
ON f.FLOW_DESTINATION_ENTITY_ID = te2.entity_id
)

, new_flow_instance AS ( -- Generate a list of new flow instance records
SELECT cfl.flow_id, utl1.source_process_instance_id process_instance_id, cfl.flow_name, cfl.flow_description, cfl.source_entity_id, utl1.task_id source_task_id, utl1.complete_date, cfl.destination_entity_id, utl2.task_id dest_task_id, utl2.create_date created_date
FROM curr_flow_list cfl
JOIN GTT_MW_TASK_INSTANCE utl1
ON cfl.source_task_type_id = utl1.task_type_id
JOIN GTT_MW_TASK_INSTANCE utl2
ON cfl.destination_task_type_id = utl2.task_type_id
WHERE NOT EXISTS    ( -- Make sure there is not another destination task that is closer in time (based on creation date) to the source task.
                        select  1
                          from  GTT_MW_TASK_INSTANCE                utl3
                         where  utl3.task_type_id               =   cfl.destination_task_type_id
                           and  utl3.create_date                <   utl2.create_date
                           and  utl3.create_date                >   utl1.create_date
                           and  utl3.task_id                    !=  utl2.task_id
                           and  utl3.source_process_instance_id =   utl1.source_process_instance_id
                    )
AND utl1.source_process_instance_id = utl2.source_process_instance_id
AND utl1.task_id != utl2.task_id
)
, curr_segment_list AS ( -- Generate a list of all possible segment records
SELECT DISTINCT ps.PROCESS_SEGMENT_ID, ps.PROCESS_ID, ps.PROCESS_SEGMENT_NAME, ps.PROCESS_SEGMENT_DESCRIPTION, ps.PROCESS_TIMELINESS_THRESHOLD, ps.PROCESS_TIMELINESS_DAYS_TYPE, te1.ENTITY_ID segment_start_entity_id, te1.task_type_id source_task_type_id, te2.ENTITY_ID segment_finish_entity_id, te2.task_type_id dest_task_type_id
FROM D_BPM_PROCESS_SEGMENT ps
JOIN D_BPM_TASK_TYPE_ENTITY te1
ON ps.SEGMENT_START_ENTITY_ID = te1.entity_id
JOIN D_BPM_TASK_TYPE_ENTITY te2
ON ps.segment_finish_ENTITY_ID = te2.entity_id
)
, new_segment_instance AS ( -- Generate a list of new segment instance records
SELECT DISTINCT cfl.PROCESS_SEGMENT_ID
, utl1.source_process_instance_id process_instance_id
, cfl.PROCESS_SEGMENT_NAME
, cfl.PROCESS_SEGMENT_DESCRIPTION
, cfl.segment_start_entity_id
, cfl.segment_finish_entity_id
, utl1.task_id segment_start_entity_inst_id
, utl2.task_id segment_finish_entity_inst_id
, utl1.create_date process_segment_start_date
, utl2.complete_date process_segment_complete_date
, 'UNKN' timeliness_status
FROM curr_segment_list cfl
JOIN GTT_MW_TASK_INSTANCE utl1
ON cfl.source_task_type_id = utl1.task_type_id
JOIN GTT_MW_TASK_INSTANCE utl2
ON cfl.dest_task_type_id = utl2.task_type_id
LEFT JOIN d_bpm_process_segment_instance si
ON cfl.PROCESS_SEGMENT_ID = si.PROCESS_SEGMENT_ID AND utl1.source_process_instance_id = si.PROCESS_INSTANCE_ID AND utl1.task_id = si.SEGMENT_START_ENTITY_INST_ID AND utl1.create_date = si.PROCESS_SEGMENT_START_DATE AND utl2.task_id = si.SEGMENT_END_ENTITY_INST_ID
WHERE NOT EXISTS    ( -- Make sure there is not another destination task that is closer in time (based on creation date) to the source task.
                        select  1
                          from  GTT_MW_TASK_INSTANCE                   utl3
                         where  utl3.task_type_id               =   cfl.dest_task_type_id
                           and  utl3.create_date                <   utl2.create_date
                           and  utl3.create_date                >   utl1.create_date
                           and  utl3.task_id                    !=  utl2.task_id
                           and  utl3.source_process_instance_id =   utl1.source_process_instance_id
                    )
AND utl1.source_process_instance_id = utl2.source_process_instance_id
AND ( -- The tasks cannot be the same, unless the start and finish entity IDs are the same.
            (
                    utl1.task_id = utl2.task_id
                AND cfl.segment_start_entity_id = cfl.segment_finish_entity_id
            )
        OR  (
                    utl1.task_id != utl2.task_id
                AND cfl.segment_start_entity_id != cfl.segment_finish_entity_id
            )
    )
AND si.PROCESS_INSTANCE_ID IS NULL
)
, new_entity_instance AS ( -- Generate a list of new entity instance records
sELECT DISTINCT a.task_id ENTITY_INSTANCE_ID, e.entity_id, e.entity_type_id, ti.source_process_instance_id PROCESS_INSTANCE_ID, e.entity_name, e.entity_description, ti.create_date start_date, ti.complete_date, 'UNKN' timeliness_status,
CASE WHEN TI.complete_date IS NULL THEN 'Y' ELSE 'N' END is_active, e.is_starting_entity, e.is_terminating_entity
FROM (SELECT source_entity_id entity_id, source_task_id task_id FROM new_flow_instance
      UNION
      SELECT destination_entity_id entity_id, dest_task_id task_id  FROM new_flow_instance
      UNION
      SELECT segment_start_entity_id entity_id, segment_start_entity_inst_id task_id FROM new_segment_instance
      UNION
      SELECT segment_finish_entity_id entity_id, segment_finish_entity_inst_id task_id FROM new_segment_instance) a
JOIN GTT_MW_TASK_INSTANCE ti
ON ti.task_id = a.task_id
JOIN d_bpm_entity e
ON e.ENTITY_ID = a.entity_id
)

, updated_entity_instance AS ( -- Generate a list of updated entity instance records
SELECT ei.ENTITY_INSTANCE_ID, ei.ENTITY_ID, ei.ENTITY_TYPE_ID, ei.PROCESS_INSTANCE_ID, ei.ENTITY_NAME, ei.ENTITY_DESCRIPTION, ei.START_DATE, utl1.COMPLETE_DATE, 'UNKN' TIMELINESS_STATUS,
CASE WHEN utl1.complete_date IS NULL THEN 'Y' ELSE 'N' END IS_ACTIVE, ei.IS_STARTING_ENTITY, ei.IS_TERMINATING_ENTITY
FROM D_BPM_ENTITY_INSTANCE ei
JOIN GTT_MW_TASK_INSTANCE utl1
ON ei.ENTITY_INSTANCE_ID = utl1.task_id
AND ei.COMPLETE_DATE IS NULL
AND utl1.COMPLETE_DATE IS NOT null
)
, new_updated_entities AS (
SELECT ENTITY_INSTANCE_ID
    , ENTITY_ID
    , ENTITY_TYPE_ID
    , PROCESS_INSTANCE_ID
    , ENTITY_NAME
    , ENTITY_DESCRIPTION
    , START_DATE
    , COMPLETE_DATE
    , TIMELINESS_STATUS
    , IS_ACTIVE
    , IS_STARTING_ENTITY
    , IS_TERMINATING_ENTITY FROM new_entity_instance
UNION
SELECT ENTITY_INSTANCE_ID
    , ENTITY_ID
    , ENTITY_TYPE_ID
    , PROCESS_INSTANCE_ID
    , ENTITY_NAME
    , ENTITY_DESCRIPTION
    , START_DATE
    , COMPLETE_DATE
    , TIMELINESS_STATUS
    , IS_ACTIVE
    , IS_STARTING_ENTITY
    , IS_TERMINATING_ENTITY FROM updated_entity_instance

)
SELECT neu.ENTITY_INSTANCE_ID
    , neu.ENTITY_ID
    , neu.ENTITY_TYPE_ID
    , neu.PROCESS_INSTANCE_ID
    , neu.ENTITY_NAME
    , neu.ENTITY_DESCRIPTION
    , neu.START_DATE
    , neu.COMPLETE_DATE
    , CASE WHEN neu.complete_date IS NULL THEN 'In Process'
           WHEN dbe.TIMELINESS_DAYS_TYPE = 'C' AND round((neu.complete_date - neu.start_date),0) <= dbe.TIMELINESS_THRESHOLD THEN 'Timely'
           WHEN dbe.TIMELINESS_DAYS_TYPE = 'C' AND round((neu.complete_date - neu.start_date),0) > dbe.TIMELINESS_THRESHOLD THEN 'Untimely'
           WHEN dbe.TIMELINESS_DAYS_TYPE = 'B' AND round(Bus_days_between(neu.start_date, neu.complete_date),0) <= dbe.TIMELINESS_THRESHOLD THEN 'Timely'
           ELSE 'Untimely' END timeliness_status
    , neu.IS_ACTIVE
    , neu.IS_STARTING_ENTITY
    , neu.IS_TERMINATING_ENTITY
FROM new_updated_entities neu
JOIN d_bpm_entity dbe
ON dbe.ENTITY_ID = neu.entity_id
JOIN d_bpm_process_instance pi
ON pi.process_instance_id = neu.process_instance_id
) nu

ON (NU.entity_instance_id = ei.entity_instance_id)
WHEN MATCHED THEN
UPDATE SET ei.complete_date = NU.complete_date
          ,ei.is_active = NU.is_active
          ,ei.timeliness_status =NU.timeliness_status
WHEN NOT MATCHED THEN
INSERT (ENTITY_INSTANCE_ID
    , ENTITY_ID
    , ENTITY_TYPE_ID
    , PROCESS_INSTANCE_ID
    , ENTITY_NAME
    , ENTITY_DESCRIPTION
    , START_DATE
    , COMPLETE_DATE
    , TIMELINESS_STATUS
    , IS_ACTIVE
    , IS_STARTING_ENTITY
    , IS_TERMINATING_ENTITY
)
VALUES
(NU.ENTITY_INSTANCE_ID
    , NU.ENTITY_ID
    , NU.ENTITY_TYPE_ID
    , NU.PROCESS_INSTANCE_ID
    , NU.ENTITY_NAME
    , NU.ENTITY_DESCRIPTION
    , NU.START_DATE
    , NU.COMPLETE_DATE
    , NU.TIMELINESS_STATUS
    , NU.IS_ACTIVE
    , NU.IS_STARTING_ENTITY
    , NU.IS_TERMINATING_ENTITY
)
LOG ERRORS (v_section_error || '(' || sysdate ||')')
;
COMMIT;

-----------------------------------------------------------------------------
--  Insert into FLOW Instance
----------------------------------------------------------------------------
SELECT 'Insert into FLOW Instance' INTO v_section_error FROM DUAL;


INSERT INTO D_BPM_FLOW_INSTANCE
(    FLOW_INSTANCE_ID
    , FLOW_ID
    , PROCESS_INSTANCE_ID
    , FLOW_NAME
    , FLOW_DESCRIPTION
    , FLOW_SOURCE_ENTITY_INSTANCE_ID
    , FLOW_DEST_ENTITY_INST_ID
    , CREATED_DATE
)

SELECT SEQ_D_BPM_FLOW_INSTANCE.NEXTVAL, F.*
FROM (
WITH task_types AS ( -- Generate a distinct list of task_type_ids that are part of a process
SELECT DISTINCT task_type_id FROM D_BPM_TASK_TYPE_ENTITY
)

, curr_flow_list AS ( -- Generate a list of all possible flow records by task_type_id
SELECT f.flow_id, f.process_id, f.flow_name, f.flow_description, te1.ENTITY_ID source_entity_id, te1.task_type_id source_task_type_id, te2.ENTITY_ID destination_entity_id, te2.task_type_id destination_task_type_id
FROM D_BPM_FLOW f
JOIN D_BPM_TASK_TYPE_ENTITY te1
ON f.flow_source_entity_id = te1.entity_id
JOIN D_BPM_TASK_TYPE_ENTITY te2
ON f.FLOW_DESTINATION_ENTITY_ID = te2.entity_id
)

, new_flow_instance AS ( -- Generate a list of new flow instance records
SELECT DISTINCT cfl.flow_id, utl1.source_process_instance_id process_instance_id, cfl.flow_name, cfl.flow_description, utl1.task_id source_task_id, utl1.complete_date, utl2.task_id dest_task_id, utl2.create_date created_date
FROM curr_flow_list cfl
JOIN GTT_MW_TASK_INSTANCE utl1
ON cfl.source_task_type_id = utl1.task_type_id
JOIN GTT_MW_TASK_INSTANCE utl2
ON cfl.destination_task_type_id = utl2.task_type_id
WHERE NOT EXISTS    ( -- Make sure there is not another destination task that is closer in time (based on creation date) to the source task.
                        select  1
                          from  GTT_MW_TASK_INSTANCE                utl3
                         where  utl3.task_type_id               =   cfl.destination_task_type_id
                           and  utl3.create_date                <   utl2.create_date
                           and  utl3.create_date                >   utl1.create_date
                           and  utl3.task_id                    !=  utl2.task_id
                           and  utl3.source_process_instance_id =   utl1.source_process_instance_id
                    )
AND utl1.source_process_instance_id = utl2.source_process_instance_id
AND utl1.task_id != utl2.task_id
)

SELECT DISTINCT nf.FLOW_ID, nf.PROCESS_INSTANCE_ID, nf.FLOW_NAME, nf.FLOW_DESCRIPTION, nf.SOURCE_TASK_ID, nf.dest_task_id, nf.CREATED_DATE
FROM new_flow_instance nf
LEFT JOIN D_BPM_FLOW_INSTANCE fi
ON nf.flow_id = fi.FLOW_ID AND nf.process_instance_id = fi.PROCESS_INSTANCE_ID AND nf.source_task_id = fi.FLOW_SOURCE_ENTITY_INSTANCE_ID AND nf.dest_task_id = fi.FLOW_DEST_ENTITY_INST_ID
WHERE fi.FLOW_ID IS NULL
) F
LOG ERRORS (v_section_error || '(' || sysdate ||')')
;
COMMIT;

-----------------------------------------------------------------------------
--  Insert into Process Segment Instance
-----------------------------------------------------------------------------
SELECT 'Insert into Process Segment Instance' INTO v_section_error FROM DUAL;


MERGE INTO D_BPM_PROCESS_SEGMENT_INSTANCE psi
USING
(
WITH task_types AS ( -- Generate a distinct list of task_type_ids that are part of a process
SELECT DISTINCT task_type_id FROM D_BPM_TASK_TYPE_ENTITY
)

, curr_segment_list AS ( -- Generate a list of all possible segment records
SELECT DISTINCT ps.PROCESS_SEGMENT_ID, ps.PROCESS_ID, ps.PROCESS_SEGMENT_NAME, ps.PROCESS_SEGMENT_DESCRIPTION, ps.PROCESS_TIMELINESS_THRESHOLD, ps.PROCESS_TIMELINESS_DAYS_TYPE, te1.ENTITY_ID segment_start_entity_id, te1.task_type_id source_task_type_id, te2.ENTITY_ID segment_finish_entity_id, te2.task_type_id dest_task_type_id
FROM D_BPM_PROCESS_SEGMENT ps
JOIN D_BPM_TASK_TYPE_ENTITY te1
ON ps.SEGMENT_START_ENTITY_ID = te1.entity_id
JOIN D_BPM_TASK_TYPE_ENTITY te2
ON ps.segment_finish_ENTITY_ID = te2.entity_id
)

, new_segment_instance AS ( -- Generate a list of new segment instance records
SELECT DISTINCT cfl.PROCESS_SEGMENT_ID
, utl1.source_process_instance_id process_instance_id
, cfl.PROCESS_SEGMENT_NAME
, cfl.PROCESS_SEGMENT_DESCRIPTION
, utl1.task_id segment_start_entity_inst_id
, utl2.task_id segment_end_entity_inst_id
, utl1.create_date process_segment_start_date
, utl2.complete_date process_segment_complete_date
, 'UNKN' timeliness_status
FROM curr_segment_list cfl
JOIN GTT_MW_TASK_INSTANCE utl1
ON cfl.source_task_type_id = utl1.task_type_id
JOIN GTT_MW_TASK_INSTANCE utl2
ON cfl.dest_task_type_id = utl2.task_type_id
LEFT JOIN d_bpm_process_segment_instance si
ON cfl.PROCESS_SEGMENT_ID = si.PROCESS_SEGMENT_ID AND utl1.source_process_instance_id = si.PROCESS_INSTANCE_ID AND utl1.task_id = si.SEGMENT_START_ENTITY_INST_ID AND utl1.create_date = si.PROCESS_SEGMENT_START_DATE AND utl2.task_id = si.SEGMENT_END_ENTITY_INST_ID
WHERE NOT EXISTS    ( -- Make sure there is not another destination task that is closer in time (based on creation date) to the source task.
                        select  1
                          from  GTT_MW_TASK_INSTANCE                utl3
                         where  utl3.task_type_id               =   cfl.dest_task_type_id
                           and  utl3.create_date                <   utl2.create_date
                           and  utl3.create_date                >   utl1.create_date
                           and  utl3.task_id                    !=  utl2.task_id
                           and  utl3.source_process_instance_id =   utl1.source_process_instance_id
                    )
AND utl1.source_process_instance_id = utl2.source_process_instance_id
AND ( -- The tasks cannot be the same, unless the start and finish entity IDs are the same.
            (
                    utl1.task_id = utl2.task_id
                AND cfl.segment_start_entity_id = cfl.segment_finish_entity_id
            )
        OR  (
                    utl1.task_id != utl2.task_id
                AND cfl.segment_start_entity_id != cfl.segment_finish_entity_id
            )
    )
AND si.PROCESS_INSTANCE_ID IS NULL
)

, updated_segment_instance AS ( -- Generate a list of updated segment instance records
SELECT si.PROCESS_SEGMENT_INSTANCE_ID
    , si.PROCESS_SEGMENT_ID
    , si.PROCESS_INSTANCE_ID
    , si.PROCESS_SEGMENT_NAME
    , si.PROCESS_SEGMENT_DESCRIPTION
    , si.SEGMENT_START_ENTITY_INST_ID
    , si.SEGMENT_END_ENTITY_INST_ID
    , si.PROCESS_SEGMENT_START_DATE
    , utl1.complete_date PROCESS_SEGMENT_COMPLETE_DATE
    , 'UNKN' TIMELINESS_STATUS
FROM D_BPM_PROCESS_SEGMENT_INSTANCE si
JOIN GTT_MW_TASK_INSTANCE utl1
ON si.SEGMENT_END_ENTITY_INST_ID = utl1.task_id
WHere coalesce(utl1.complete_date,to_date('1/1/1900','dd/mm/yyyy')) != coalesce(si.PROCESS_SEGMENT_COMPLETE_DATE,to_date('1/1/1900','dd/mm/yyyy'))
)

, new_updated_segments AS (
SELECT 1 process_segment_instance_id, si.* FROM new_segment_instance si
UNION
SELECT * FROM updated_segment_instance
)

SELECT NUS.PROCESS_SEGMENT_INSTANCE_ID
    , NUS.PROCESS_SEGMENT_ID
    , NUS.PROCESS_INSTANCE_ID
    , NUS.PROCESS_SEGMENT_NAME
    , NUS.PROCESS_SEGMENT_DESCRIPTION
    , NUS.SEGMENT_START_ENTITY_INST_ID
    , NUS.SEGMENT_END_ENTITY_INST_ID
    , NUS.PROCESS_SEGMENT_START_DATE
    , NUS.PROCESS_SEGMENT_COMPLETE_DATE
    , CASE WHEN nus.process_segment_complete_date IS NULL THEN 'In Process'
           WHEN p.PROCESS_TIMELINESS_DAYS_TYPE = 'C' AND round((nus.process_segment_complete_date - nus.process_segment_start_date),0) <= p.PROCESS_TIMELINESS_THRESHOLD THEN 'Timely'
           WHEN p.PROCESS_TIMELINESS_DAYS_TYPE = 'C' AND round((nus.process_segment_complete_date - nus.process_segment_start_date),0) > p.PROCESS_TIMELINESS_THRESHOLD THEN 'Untimely'
           WHEN p.PROCESS_TIMELINESS_DAYS_TYPE = 'B' AND round(Bus_days_between(nus.process_segment_start_date, nus.process_segment_complete_date),0) <= p.PROCESS_TIMELINESS_THRESHOLD THEN 'Timely'
           ELSE 'Untimely' END timeliness_status
FROM new_updated_segments nus
JOIN d_bpm_process_segment p
ON p.process_segment_id = nus.process_segment_id
) nu

ON (psi.process_segment_instance_id = NU.process_segment_instance_id)
WHEN MATCHED THEN
UPDATE SET psi.process_segment_complete_date = NU.process_segment_complete_date
          ,psi.timeliness_status = NU.timeliness_status
WHEN NOT MATCHED THEN
INSERT
(    PROCESS_SEGMENT_INSTANCE_ID
    , PROCESS_SEGMENT_ID
    , PROCESS_INSTANCE_ID
    , PROCESS_SEGMENT_NAME
    , PROCESS_SEGMENT_DESCRIPTION
    , SEGMENT_START_ENTITY_INST_ID
    , SEGMENT_END_ENTITY_INST_ID
    , PROCESS_SEGMENT_START_DATE
    , PROCESS_SEGMENT_COMPLETE_DATE
    , TIMELINESS_STATUS
)
VALUES
(    SEQ_D_BPM_SEGMENT_INSTANCE.NEXTVAL
    , NU.PROCESS_SEGMENT_ID
    , NU.PROCESS_INSTANCE_ID
    , NU.PROCESS_SEGMENT_NAME
    , NU.PROCESS_SEGMENT_DESCRIPTION
    , NU.SEGMENT_START_ENTITY_INST_ID
    , NU.SEGMENT_END_ENTITY_INST_ID
    , NU.PROCESS_SEGMENT_START_DATE
    , NU.PROCESS_SEGMENT_COMPLETE_DATE
    , NU.TIMELINESS_STATUS
)
LOG ERRORS (v_section_error || '(' || sysdate ||')')
;
COMMIT;

-----------------------------------------------------------------------------
--  Insert/Upadte Fact Process By Date
-----------------------------------------------------------------------------
SELECT 'Insert/Update Fact Process By Date' INTO v_section_error FROM DUAL;

MERGE INTO F_BPM_PROCESS_BY_DATE pbd
USING
(
SELECT distinct
    pi.PROCESS_ID
    , ddate.D_DATE D_DATE
    , pi.PROCESS_NAME
    , sum(case when pi.process_complete_date IS NOT NULL AND TRUNC(pi.process_complete_date) = ddate.D_DATE then 1 else 0 end) over (PARTITION BY pi.process_id, ddate.d_date) complete_process_count
    , sum(case when pi.process_complete_date IS NULL then 1 else 0 end) over (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)) ACTIVE_PROCESS_COUNT
    , round(avg(CASE WHEN pi.PROCESS_COMPLETE_DATE IS NULL THEN SYSDATE - pi.process_start_date END)  OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2) AVG_PROCESS_AGE
    , round(min(CASE WHEN pi.PROCESS_COMPLETE_DATE IS NULL THEN SYSDATE - pi.process_start_date END)  OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2) MIN_PROCESS_AGE
    , round(max(CASE WHEN pi.PROCESS_COMPLETE_DATE IS NULL THEN SYSDATE - pi.process_start_date END)  OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2) MAX_PROCESS_AGE
    , round(avg(CASE WHEN pi.PROCESS_COMPLETE_DATE IS not null THEN pi.PROCESS_COMPLETE_DATE - pi.process_start_date END)  OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2) AVG_PROCESS_COMPLETE_TIME
    , round(min(CASE WHEN pi.PROCESS_COMPLETE_DATE IS not null THEN pi.PROCESS_COMPLETE_DATE - pi.process_start_date END)  OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2) MIN_PROCESS_COMPLETE_TIME
    , round(max(CASE WHEN pi.PROCESS_COMPLETE_DATE IS not null THEN pi.PROCESS_COMPLETE_DATE - pi.process_start_date END)  OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2) MAX_PROCESS_COMPLETE_TIME
    , sum(case when upper(pi.timeliness_status) = 'TIMELY' then 1 else 0 end) over (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)) TIMELY_PROCESS_COUNT
    , sum(case when upper(pi.timeliness_status) = 'UNTIMELY' then 1 else 0 end) over (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)) UNTIMELY_PROCESS_COUNT
FROM D_BPM_PROCESS_INSTANCE pi
JOIN bpm_d_dates ddate
ON ddate.D_DATE = TRUNC(pi.process_start_date)
) pi
ON (pbd.process_id = pi.PROCESS_ID AND pbd.d_date = pi.d_date)
WHEN MATCHED THEN
UPDATE SET pbd.COMPLETE_PROCESS_COUNT = PI.COMPLETE_PROCESS_COUNT
    , pbd.ACTIVE_PROCESS_COUNT = PI.ACTIVE_PROCESS_COUNT
    , pbd.AVG_PROCESS_AGE = PI.AVG_PROCESS_AGE
    , pbd.MIN_PROCESS_AGE = PI.MIN_PROCESS_AGE
    , pbd.MAX_PROCESS_AGE = PI.MAX_PROCESS_AGE
    , pbd.AVG_PROCESS_COMPLETE_TIME = PI.AVG_PROCESS_COMPLETE_TIME
    , pbd.MIN_PROCESS_COMPLETE_TIME = PI.MIN_PROCESS_COMPLETE_TIME
    , pbd.MAX_PROCESS_COMPLETE_TIME = PI.MAX_PROCESS_COMPLETE_TIME
    , pbd.TIMELY_PROCESS_COUNT = PI.TIMELY_PROCESS_COUNT
    , pbd.UNTIMELY_PROCESS_COUNT = PI.UNTIMELY_PROCESS_COUNT

WHEN NOT MATCHED THEN
INSERT
(
    PROCESS_ID
    , D_DATE
    , PROCESS_NAME
    , COMPLETE_PROCESS_COUNT
    , ACTIVE_PROCESS_COUNT
    , AVG_PROCESS_AGE
    , MIN_PROCESS_AGE
    , MAX_PROCESS_AGE
    , AVG_PROCESS_COMPLETE_TIME
    , MIN_PROCESS_COMPLETE_TIME
    , MAX_PROCESS_COMPLETE_TIME
    , TIMELY_PROCESS_COUNT
    , UNTIMELY_PROCESS_COUNT
)
VALUES
(
    PI.PROCESS_ID
    , PI.D_DATE
    , PI.PROCESS_NAME
    , PI.COMPLETE_PROCESS_COUNT
    , PI.ACTIVE_PROCESS_COUNT
    , PI.AVG_PROCESS_AGE
    , PI.MIN_PROCESS_AGE
    , PI.MAX_PROCESS_AGE
    , PI.AVG_PROCESS_COMPLETE_TIME
    , PI.MIN_PROCESS_COMPLETE_TIME
    , PI.MAX_PROCESS_COMPLETE_TIME
    , PI.TIMELY_PROCESS_COUNT
    , PI.UNTIMELY_PROCESS_COUNT
)
LOG ERRORS (v_section_error || '(' || sysdate ||')')
;

COMMIT;

EXCEPTION
WHEN OTHERS THEN

	      v_err_code := SUBSTR(SQLCODE, 1, 400);
              v_err_msg := SUBSTR(SQLERRM, 1, 3800);

INSERT INTO corp_etl_error_log
              VALUES(SEQ_CEEL_ID.nextval,--CEEL_ID
                     sysdate,--ERR_DATE
                     'CRITICAL',--ERR_LEVEL
                     'MW_POPULATE_INSTANCE_TABLES',--PROCESS_NAME
                     'POPULATE_INSTANCE_TABLES',--JOB_NAME
                     '1',--NR_OF_ERROR
                     v_section_error ||' '||v_err_msg,--ERROR_DESC
                     null,--ERROR_FIELD
                     v_err_code,--ERROR_CODES
                     sysdate,--CREATE_TS
                     sysdate,--UPDATE_TS
                     null,--DRIVER_TABLE_NAME
                     null);--DRIVER_KEY_NUMBER
COMMIT;

raise_application_error(-20001,'An error was encountered in ' || v_section_error || ' - '||SQLCODE||' -ERROR- '||SQLERRM);

END populate_instance_tables;

PROCEDURE PROCESS_DELTEK_LOAD
AS
  v_hours_date date;
  v_errmsg varchar2(100);
  v_errcd varchar2(10);
  v_id_exists number;
  v_sup_updated varchar2(1);
  v_date_format varchar2(20);
  v_start_curr_status_date DATE;
  v_last_mw_run_date DATE;
     

BEGIN

-----------------------------------------------------------------------------
--  Get last record from last MW run
----------------------------------------------------------------------------
SELECT MAX(curr_status_date) INTO v_start_curr_status_date FROM D_MW_TASK_INSTANCE;
SELECT coalesce((MAX(job_end_date) - 2), SYSDATE) INTO v_last_mw_run_date FROM CORP_ETL_JOB_STATISTICS WHERE JOB_NAME ='MW_RUNALL' AND JOB_STATUS_CD = 'COMPLETED';
-----------------------------------------------------------------------------
--  
----------------------------------------------------------------------------

  -- Get default date format
  select value into v_date_format from corp_etl_control where name = 'DELTEK_DATE_FORMAT';

  -- Update all stage records, if employee id is less than 4 characters then prefix '0'

  Update d_deltek_hours_tmp t
     set employee_id = '0'||employee_id
   where processed = 'N'
     and length(employee_id) = 4;

  -- Update records from previously loaded files for that date

  Update d_deltek_hours
     set entered_hours = 0, productive_hours = 0
        ,Notes = nvl(notes,'')||'Record updated by load process, hours changed from '||entered_hours||' to 0.'
   where sup_updated = 'N'
     and ddh_id in (Select distinct d.ddh_id
                      from d_deltek_hours_tmp t , d_deltek_hours d
                     where d.employee_id = t.employee_id
                       and d.hours_date =  to_date(t.hours_date, v_date_format)
                       and t.processed = 'N'
                       and trunc(d.maxdat_audit_create_dt) <> trunc(t.create_dt));

   Commit;


  -- Process staged records

  For stg in ( select *
                 from d_deltek_hours_tmp t
                where processed = 'N'
                order by tmp_ddh_id )
  Loop

     -- Begin check Header record
     If RTRIM(stg.employee_id,'0123456789') is not null Then -- Alphanumeric

         update d_deltek_hours_tmp
            set comments = nvl(comments,'')||'Header records'
              , processed = 'E'
          where tmp_ddh_id = stg.tmp_ddh_id;

     Else -- Load Data

         v_hours_date := null;
         v_id_exists := 0;
         v_sup_updated := 'N';

         Begin
           -- Agreed date format
           select to_date(stg.hours_date, v_date_format)
             into v_hours_date
             from dual;

         Exception when others then
              --
              Begin
               -- Just to handle one particular error situation due to date format mismatch.
               select to_date(stg.hours_date, 'Mon dd, yyyy')
                 into v_hours_date
                 from dual;

            Exception when others then

                  v_errmsg := substr(sqlerrm, 1, 100);
                  v_errcd := sqlcode;

                  update d_deltek_hours_tmp
                     set comments = v_errcd || '-' ||v_errmsg
                       , processed = 'E'
                   where tmp_ddh_id = stg.tmp_ddh_id;
              End;
              --
         End;

         -- Check if Pay type exists
         If stg.pay_type is null then

             update d_deltek_hours_tmp
                set comments = nvl(comments,'')||'Pay Type is missing in the record'
                  , processed = 'E'
              where tmp_ddh_id = stg.tmp_ddh_id;

         Elsif v_hours_date is not null then

           Begin

             -- Check if record already exists

             Select ddh_id , sup_updated into v_id_exists, v_sup_updated
               from d_deltek_hours d
              where d.employee_id = stg.employee_id
                and d.hours_date = v_hours_date
                and nvl(d.project_id,'*') = nvl(stg.project_id,'*')
                and d.pay_type = stg.pay_type;
                
              -- If not updated by supervisor then update record in d_deltek_hours  
              If v_sup_updated = 'N' Then  

                 Update d_deltek_hours
                    set employee_id            = stg.employee_id,
                        labor_grp_type         = stg.labor_grp_type,
                        last_name              = stg.last_name,
                        first_name             = stg.first_name,
                        title                  = stg.title,
                        empl_org_id            = stg.empl_org_id,
                        empl_org_name          = stg.empl_org_name,
                        approval_name          = stg.approval_name,
                        project_id             = stg.project_id,
                        project_name           = stg.project_name,
                        org_id                 = stg.org_id,
                        org_name               = stg.org_name,
                        pay_type               = stg.pay_type,
                        plc_id                 = stg.plc_id,
                        hours_date             = v_hours_date,
                        entered_hours          = stg.entered_hours,
                        productive_hours       = stg.productive_hours,
                        notes                  = nvl(notes,'')||'Record updated by load process - '||stg.tmp_ddh_id
                  where ddh_id = v_id_exists;
                  
              Else
                  
                 update d_deltek_hours_tmp
                    set comments = nvl(comments,'')||'Record had been updated by supervisor'
                      , processed = 'E'
                  where tmp_ddh_id = stg.tmp_ddh_id;                
                
              End if;    

           Exception when no_data_found then

             -- If new record then insert

              Insert into d_deltek_hours ( employee_id,  labor_grp_type,  last_name, first_name, title, empl_org_id, empl_org_name,
                                         approval_name, project_id,  project_name, org_id, org_name, pay_type, plc_id, hours_date,
                                         entered_hours, productive_hours, comments, notes)
              values  ( stg.employee_id, stg.labor_grp_type,  stg.last_name, stg.first_name, stg.title, stg.empl_org_id, stg.empl_org_name,
                        stg.approval_name,stg.project_id,  stg.project_name, stg.org_id, stg.org_name, stg.pay_type, stg.plc_id,v_hours_date,
                        stg.entered_hours,stg.productive_hours, stg.comments, stg.notes);

           End;

           Update d_deltek_hours_tmp set processed = 'Y'
            where tmp_ddh_id = stg.tmp_ddh_id
              and processed <> 'E';

         End if; -- Check Pay Type

     End if; -- Check Header Record

     Commit;

  End Loop;
-------------------------------------------------------------------------
-- Update the F_STAFF_BY_DATE table
-------------------------------------------------------------------------

MERGE  INTO f_staff_by_date sbd
USING 
( 
with tasks as
(
select DISTINCT trunc(ti1.complete_date) as complete_date
, ti1.curr_owner_staff_id
, count((SELECT ti2.task_id FROM D_MW_TASK_INSTANCE ti2 WHERE ti2.MW_BI_ID = ti1.MW_BI_ID AND ti2.COMPLETE_DATE IS NOT NULL AND ti2.curr_owner_staff_id > 0)) total_tasks
from d_mw_task_instance ti1 
where ti1.CURR_STATUS_DATE  <= v_start_curr_status_date
AND ti1.stg_last_update_date >= v_last_mw_run_date
AND ti1.curr_owner_staff_id > 0
GROUP BY ti1.curr_owner_staff_id, trunc(ti1.complete_date)
),
esn as
(
select DISTINCT dss.staff_id, dss.ext_staff_number, tasks.complete_date, tasks.total_tasks 
from d_staff_sv dss
JOIN tasks tasks
ON dss.STAFF_ID = tasks.curr_owner_staff_id
)
SELECT distinct
    esn.staff_id,
    trunc(dh.hours_date) hours_date,
    sum(dh.entered_hours) tot_hrs,
    esn.total_tasks,
    sum(dh.productive_hours) tot_prd_hrs
 from d_deltek_hours dh
 JOIN esn esn
 ON esn.ext_staff_number = dh.EMPLOYEE_ID AND TRUNC(dh.HOURS_DATE) = TRUNC(esn.complete_date)
--where trunc(dh.hours_date)=to_date('12/19/2017','mm/dd/yyyy')
GROUP BY esn.staff_id,trunc(dh.hours_date), esn.total_tasks) tot_hrs
ON (sbd.staff_id = tot_hrs.staff_id AND trunc(sbd.hours_date) = trunc(tot_hrs.hours_date))
WHEN MATCHED THEN
UPDATE SET 
    sbd.total_hours = tot_hrs.tot_hrs
   ,sbd.completed_tasks_count = tot_hrs.total_tasks
   ,sbd.productive_hours =  tot_hrs.tot_prd_hrs
WHEN NOT MATCHED THEN
INSERT 
(
    staff_id,
    hours_date,
    total_hours,
    completed_tasks_count,
    productive_hours
) 
VALUES 
(    tot_hrs.staff_id
    , tot_hrs.hours_date
    , tot_hrs.tot_hrs
    , tot_hrs.total_tasks
    , tot_hrs.tot_prd_hrs
)
;

COMMIT;

END PROCESS_DELTEK_LOAD;
END MW_POPULATE_INSTANCE_TABLES;
/
GRANT EXECUTE ON MW_POPULATE_INSTANCE_TABLES TO MAXDAT_PFP_E;
GRANT DEBUG ON MW_POPULATE_INSTANCE_TABLES TO MAXDAT_PFP_READ_ONLY;
GRANT EXECUTE ON MW_POPULATE_INSTANCE_TABLES TO MAXDAT_READ_ONLY;




