CREATE OR REPLACE PACKAGE MW_POPULATE_INSTANCE_TABLES AS

-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
    SVN_FILE_URL varchar2(200) := '$URL$';
    SVN_REVISION varchar2(20) := '$Revision$';
    SVN_REVISION_DATE varchar2(60) := '$Date$';
    SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

    g_entity_type_task                                              CONSTANT    PLS_INTEGER                                         :=  5;

    PROCEDURE   populate_instance_tables;
    PROCEDURE   process_deltek_load;

END MW_POPULATE_INSTANCE_TABLES;
/
CREATE OR REPLACE PACKAGE BODY MW_POPULATE_INSTANCE_TABLES AS

    PROCEDURE   truncate_table
                (
                    p_table_name                        IN                      VARCHAR2
                )
    IS
        l_sql                                                                   VARCHAR2(200);
    BEGIN

        l_sql   :=  'TRUNCATE TABLE ' || p_table_name;
        EXECUTE IMMEDIATE   l_sql;

    END         truncate_table;

    PROCEDURE   populate_instance_tables
    IS
         v_start_curr_status_date                                               DATE;
         v_last_mw_run_date                                                     DATE;
         v_section_error                                                        VARCHAR2(100);
         v_err_msg                                                              VARCHAR2(4000);
         v_err_code                                                             VARCHAR2(400);
         l_sql                                                                  VARCHAR2(1000);
         l_process_instance_count                                               NUMBER;
    BEGIN
        -----------------------------------------------------------------------------
        --  Get the number of process instances
        -----------------------------------------------------------------------------
        SELECT  
            COUNT(*)
        INTO
            l_process_instance_count
        FROM
            D_BPM_PROCESS_INSTANCE;

        -----------------------------------------------------------------------------
        --  Get last record from last MW run
        -----------------------------------------------------------------------------
        SELECT
            MAX(curr_status_date) 
        INTO    
            v_start_curr_status_date 
        FROM    
            D_MW_TASK_INSTANCE;

        IF
        (
            l_process_instance_count > 0
        )
        THEN
            SELECT
                COALESCE((MAX(job_end_date) - 2), SYSDATE) 
            INTO 
                v_last_mw_run_date 
            FROM 
                CORP_ETL_JOB_STATISTICS 
            WHERE 
                job_name        =   'MW_RUNALL'     AND
                job_status_cd   =   'COMPLETED';
        ELSE
            v_last_mw_run_date  :=  TO_DATE('01/01/1900', 'mm/dd/yyyy');
        END IF;
        -----------------------------------------------------------------------------
        --  Insert/Update into Process Instance
        ----------------------------------------------------------------------------
        SELECT  
            'Insert/Update into Process Instance' 
        INTO
            v_section_error 
        FROM 
            DUAL;

        truncate_table
        (
            p_table_name    =>  'GTT_MW_TASK_INSTANCE'
        );

        INSERT 
        INTO 
            GTT_MW_TASK_INSTANCE
        SELECT 
            ti.*
        FROM 
            D_MW_TASK_INSTANCE              ti
            JOIN 
            D_BPM_TASK_TYPE_ENTITY          tt
            ON
            (
                ti.task_type_id         =   tt.task_type_id
            )
        WHERE 
            ti.CURR_STATUS_DATE         <=  v_start_curr_status_date    AND
            ti.stg_last_update_date >= v_last_mw_run_date
        LOG ERRORS (v_section_error || '(' || sysdate ||')');

        COMMIT;

        DBMS_STATS.gather_table_stats(USER, 'GTT_MW_TASK_INSTANCE');

        MERGE  
        INTO    
            D_BPM_PROCESS_INSTANCE      pi
        USING
        (
            WITH 
                task_types                  AS 
                ( -- Generate a distinct list of task_type_ids that are part of a process
                    SELECT 
                        DISTINCT 
                        task_type_id, 
                        entity_id 
                    FROM 
                        D_BPM_TASK_TYPE_ENTITY
                ),
                task_type_entity            AS 
                ( -- Generate a distinct list of task_type_ids and entity_id sthat are part of a process
                    SELECT 
                        DISTINCT 
                        task_type_id, 
                        entity_id 
                    FROM 
                        D_BPM_TASK_TYPE_ENTITY
                ),
                tte_start_terminator        AS
                (
                    SELECT  
                        tte.task_type_id, 
                        tte.entity_id, 
                        e.is_starting_entity, 
                        e.is_terminating_entity 
                    FROM 
                        D_BPM_TASK_TYPE_ENTITY          tte, 
                        D_BPM_ENTITY                    e
                    WHERE 
                        tte.entity_id               =   e.entity_id
                ),
                new_updated_processes       AS 
                ( -- Generate a list of the new and updated process instances
                    SELECT 
                        DISTINCT 
                        m1.source_process_instance_id                                                                   AS  PROCESS_INSTANCE_ID,
                        p.process_id,
                        p.process_name,
                        p.process_description,
                        p.parent_process_id,
                        (
                            SELECT  
                                MIN(m11.create_date) 
                            FROM 
                                GTT_MW_TASK_INSTANCE                    m11, 
                                tte_start_terminator                    tte_st 
                            WHERE 
                                m11.source_process_instance_id      =   m1.source_process_instance_id       AND
                                m11.task_type_id                    =   tte_st.task_type_id                 AND 
                                tte_st.is_starting_entity           =   'Y'
                        )                                                                                               AS  PROCESS_START_DATE,
                        (
                            SELECT
                                MAX(m11.COMPLETE_DATE) 
                            FROM 
                                GTT_MW_TASK_INSTANCE                m11, 
                                tte_start_terminator                tte_st 
                            WHERE 
                                m11.source_process_instance_id  =   m1.source_process_instance_id           AND
                                m11.task_type_id                =   tte_st.task_type_id                     AND 
                                tte_st.is_terminating_entity    =   'Y'                                     AND
                                m11.CREATE_DATE =   (
                                                        SELECT 
                                                            MAX(create_date) 
                                                        FROM 
                                                            GTT_MW_TASK_INSTANCE                    m12, 
                                                            tte_start_terminator                    tte_st 
                                                        WHERE 
                                                            m12.source_process_instance_id      =   m11.source_process_instance_id      AND
                                                            m12.task_type_id                    =   tte_st.task_type_id                 AND 
                                                            tte_st.is_terminating_entity        =   'Y'
                                                    )
                        )                                                                                               AS  PROCESS_COMPLETE_DATE,
                        'UNKN'                                                                                          AS  TIMELINESS_STATUS
                    FROM    
                        GTT_MW_TASK_INSTANCE            m1
                        JOIN 
                            task_type_entity                tte
                        ON
                        (
                            m1.task_type_id         =   tte.task_type_id
                        )
                        JOIN 
                            D_BPM_ENTITY               e
                        ON 
                        (
                            tte.entity_id           =   e.entity_id
                        )
                        JOIN    
                            D_BPM_PROCESS               p
                        ON 
                        (
                            p.process_id            =   e.process_id
                        )
                        LEFT JOIN 
                            D_BPM_PROCESS_INSTANCE      pi
                        ON 
                        (
                            m1.source_process_instance_id   =   pi.PROCESS_INSTANCE_ID
                        )
                    WHERE   
                        m1.source_process_instance_id IS NOT NULL           AND
                        pi.PROCESS_INSTANCE_ID  IS NULL
                    UNION ALL
                    SELECT 
                        DISTINCT 
                        pi.process_instance_id,
                        pi.process_id,
                        pi.process_name,
                        pi.process_description,
                        pi.parent_process_id,
                        NVL
                        (
                            pi.process_start_date,
                            (
                                SELECT 
                                    MIN(m10.create_date) 
                                FROM 
                                    D_MW_TASK_INSTANCE              m10, 
                                    tte_start_terminator            tte_st 
                                WHERE 
                                    m10.source_process_instance_id  =   mw.source_process_instance_id               AND
                                    m10.task_type_id                =   tte_st.task_type_id                         AND
                                    tte_st.is_starting_entity       =   'Y'
                            )
                        )                                                                                               AS  PROCESS_START_DATE,
                        NVL
                        (
                            pi.process_complete_date, 
                            (
                                SELECT  
                                    MAX(m11.COMPLETE_DATE) 
                                FROM 
                                    D_MW_TASK_INSTANCE                  m11, 
                                    tte_start_terminator                tte_st 
                                WHERE 
                                    m11.source_process_instance_id  =   mw.source_process_instance_id               AND
                                    m11.task_type_id                =   tte_st.task_type_id                         AND
                                    tte_st.is_terminating_entity    =   'Y'                                         AND
                                    m11.CREATE_DATE =   (
                                                            SELECT 
                                                                MAX(create_date) 
                                                            FROM 
                                                                D_MW_TASK_INSTANCE                      m12, 
                                                                tte_start_terminator                    tte_st 
                                                            WHERE 
                                                                m12.source_process_instance_id      =   m11.source_process_instance_id      AND
                                                                m12.task_type_id                    =   tte_st.task_type_id                 AND
                                                                tte_st.is_terminating_entity        =   'Y'
                                                        )
                            )
                        )                                                                                               AS  PROCESS_COMPLETE_DATE,
                        'UNKN'                                                                                          AS  TIMELINESS_STATUS
                    FROM 
                        D_MW_TASK_INSTANCE                  mw
                        JOIN 
                            D_BPM_PROCESS_INSTANCE          pi
                        ON
                        (
                            mw.source_process_instance_id   =   pi.PROCESS_INSTANCE_ID
                        )
                    WHERE 
                        (
                            pi.PROCESS_COMPLETE_DATE IS NULL                AND
                            EXISTS  (
                                        SELECT 
                                            m11.COMPLETE_DATE 
                                        FROM 
                                            D_MW_TASK_INSTANCE                      m11, 
                                            tte_start_terminator                    tte_st 
                                        WHERE 
                                            m11.source_process_instance_id      =   mw.source_process_instance_id       AND
                                            m11.task_type_id                    =   tte_st.task_type_id                 AND
                                            tte_st.is_terminating_entity        =   'Y'                                 AND
                                            m11.complete_date is not null
                                    )
                        )                                                   OR
                        ( 
                                pi.PROCESS_START_DATE IS NULL       AND 
                                EXISTS  (
                                            SELECT  
                                                m10.create_date 
                                            FROM    
                                                D_MW_TASK_INSTANCE          m10, 
                                                tte_start_terminator        tte_st 
                                            WHERE 
                                                m10.source_process_instance_id  =   mw.source_process_instance_id       AND
                                                m10.task_type_id                =   tte_st.task_type_id                 AND
                                                tte_st.is_starting_entity       =   'Y'                                 AND
                                                m10.create_date is not null
                                        )
                        )

                )
            SELECT 
                nup.process_instance_id,
                nup.process_id,
                nup.process_name,
                nup.process_description,
                nup.parent_process_id,
                nup.process_start_date,
                nup.process_complete_date,
                CASE    
                    WHEN    nup.process_complete_date IS NULL 
                    THEN    'In Process'
                    WHEN    p.PROCESS_TIMELINESS_DAYS_TYPE = 'C'    AND 
                            round((nup.process_complete_date - nup.process_start_date),0) <= p.PROCESS_TIMELINESS_THRESHOLD 
                    THEN    'Timely'
                    WHEN    p.PROCESS_TIMELINESS_DAYS_TYPE = 'C'    AND 
                            round((nup.process_complete_date - nup.process_start_date),0) > p.PROCESS_TIMELINESS_THRESHOLD 
                    THEN    'Untimely'
                    WHEN    p.PROCESS_TIMELINESS_DAYS_TYPE = 'B'    AND 
                            round(Bus_days_between(nup.process_start_date, nup.process_complete_date),0) <= p.PROCESS_TIMELINESS_THRESHOLD 
                    THEN    'Timely'
                ELSE 
                    'Untimely' 
                END                                                                                                     AS  TIMELINESS_STATUS
            FROM 
                new_updated_processes           nup
                JOIN 
                    D_BPM_PROCESS               p
                ON 
                (
                    p.process_id            =   nup.process_id
                )                                   
        )                                                                                                                   nu
        ON 
        (
            pi.process_instance_id  =   nu.process_instance_id
        )
        WHEN MATCHED 
        THEN
            UPDATE SET
                pi.process_start_date       =   nu.process_start_date,
                pi.process_complete_date    =   nu.process_complete_date,
                pi.timeliness_status        =   nu.timeliness_status
        WHEN NOT MATCHED 
        THEN
            INSERT
            (    
                PROCESS_INSTANCE_ID,
                PROCESS_ID,
                PROCESS_NAME,
                PROCESS_DESCRIPTION,
                PARENT_PROCESS_ID,
                PROCESS_START_DATE,
                PROCESS_COMPLETE_DATE,
                TIMELINESS_STATUS
            )
            VALUES
            (    
                nu.process_instance_id,
                nu.process_id,
                nu.process_name,
                nu.process_description,
                nu.parent_process_id,
                nu.process_start_date,
                nu.process_complete_date,
                nu.timeliness_status
            )
        LOG ERRORS (v_section_error || '(' || sysdate ||')')
        ;
        COMMIT;

        DBMS_STATS.gather_table_stats(USER, 'D_BPM_PROCESS_INSTANCE');

        -----------------------------------------------------------------------------
        --  Insert/Update into Entity Instance
        ----------------------------------------------------------------------------
        SELECT 
            'Insert/Update into Entity Instance' 
        INTO 
            v_section_error 
        FROM 
            DUAL;

        MERGE 
        INTO    
            D_BPM_ENTITY_INSTANCE   ei
        USING
        (
            WITH    
                task_types              AS 
                ( -- Generate a distinct list of task_type_ids that are part of a process
                    SELECT
                        DISTINCT 
                        task_type_id 
                    FROM 
                        D_BPM_TASK_TYPE_ENTITY
                ),
                new_entity_instance     AS 
                ( -- Generate a list of new entity instance records

                    SELECT  
                        DISTINCT 
                        NULL                                AS  ENTITY_INSTANCE_ID, 
                        e.entity_id, 
                        e.entity_type_id, 
                        ti.source_process_instance_id       AS  PROCESS_INSTANCE_ID, 
                        e.entity_name, 
                        e.entity_description,
                        g_entity_type_task                  AS  ENTITY_REFERENCE_TYPE,
                        ti.task_id                          AS  ENTITY_REFERENCE_ID ,
                        ti.create_date                      AS  START_DATE, 
                        ti.complete_date, 
                        'UNKN'                              AS  TIMELINESS_STATUS,
                        CASE    WHEN    TI.complete_date IS NULL 
                                THEN    'Y' 
                                ELSE    'N' 
                        END                                 AS  IS_ACTIVE, 
                        e.is_starting_entity, 
                        e.is_terminating_entity
                    FROM    
                        GTT_MW_TASK_INSTANCE                        ti
                        JOIN 
                            D_BPM_PROCESS_INSTANCE                  pi
                        ON 
                        (
                            ti.source_process_instance_id   =   pi.PROCESS_INSTANCE_ID
                        )
                        JOIN 
                            D_BPM_TASK_TYPE_ENTITY                  te
                        ON
                        (
                            ti.task_type_id                 =   te.task_type_id
                        )
                        JOIN 
                            D_BPM_ENTITY                            e 
                        ON
                        (
                            te.entity_id                    =   e.entity_id     AND
                            e.process_id                    =   pi.process_id
                        )
                    WHERE
                        NOT EXISTS  (
                                        SELECT  
                                            1
                                        FROM
                                            D_BPM_ENTITY_INSTANCE               ei
                                        WHERE
                                            ei.entity_reference_type        =   g_entity_type_task               AND
                                            ei.entity_reference_id          =   ti.task_id
                                    )
                ),
                updated_entity_instance AS 
                ( -- Generate a list of updated entity instance records

                    SELECT  
                        ei.entity_instance_id,
                        ei.entity_id, 
                        ei.entity_type_id, 
                        ei.process_instance_id, 
                        ei.entity_name, 
                        ei.entity_description, 
                        ei.entity_reference_type,
                        ei.entity_reference_id,                    
                        ei.start_date, 
                        utl1.complete_date, 
                        'UNKN'                                          AS  TIMELINESS_STATUS,
                        CASE    
                            WHEN    utl1.complete_date IS NULL 
                            THEN    'Y' 
                        ELSE    
                            'N' 
                        END                                             AS  IS_ACTIVE, 
                        ei.IS_STARTING_ENTITY, 
                        ei.IS_TERMINATING_ENTITY
                    FROM    
                        D_BPM_ENTITY_INSTANCE                       ei
                        JOIN 
                            GTT_MW_TASK_INSTANCE                    utl1
                        ON 
                        (
                            ei.entity_reference_type            =   g_entity_type_task      AND
                            ei.entity_reference_id              =   utl1.task_id            AND
                            ei.COMPLETE_DATE    IS NULL                                     AND
                            utl1.COMPLETE_DATE  IS NOT NULL
                        )
                ),
                new_updated_entities    AS 
                (
                    SELECT  
                        entity_instance_id,
                        entity_id,
                        entity_type_id,
                        process_instance_id,
                        entity_name,
                        entity_description,
                        entity_reference_type,
                        entity_reference_id,                              
                        start_date,
                        complete_date,
                        timeliness_status,
                        is_active,
                        is_starting_entity,
                        is_terminating_entity 
                    FROM    
                        new_entity_instance
                    UNION ALL
                    SELECT  
                        entity_instance_id,
                        entity_id,
                        entity_type_id,
                        process_instance_id,
                        entity_name,
                        entity_description,
                        entity_reference_type,
                        entity_reference_id,                              
                        start_date,
                        complete_date,
                        timeliness_status,
                        is_active,
                        is_starting_entity,
                        is_terminating_entity 
                    FROM    
                        updated_entity_instance
                )
                SELECT  
                    neu.entity_instance_id,              
                    neu.entity_id,
                    neu.entity_type_id,
                    neu.process_instance_id,
                    neu.entity_name,
                    neu.entity_description,
                    neu.entity_reference_type,
                    neu.entity_reference_id,                          
                    neu.start_date,
                    neu.complete_date,
                    CASE    
                        WHEN    neu.complete_date IS NULL 
                        THEN    'In Process'
                        WHEN    dbe.TIMELINESS_DAYS_TYPE = 'C'  AND 
                                round((neu.complete_date - neu.start_date),0) <= dbe.TIMELINESS_THRESHOLD 
                        THEN    'Timely'
                        WHEN    dbe.TIMELINESS_DAYS_TYPE = 'C' AND 
                                round((neu.complete_date - neu.start_date),0) > dbe.TIMELINESS_THRESHOLD 
                        THEN    'Untimely'
                        WHEN    dbe.TIMELINESS_DAYS_TYPE = 'B' AND 
                                round(Bus_days_between(neu.start_date, neu.complete_date),0) <= dbe.TIMELINESS_THRESHOLD 
                        THEN    'Timely'
                    ELSE    
                        'Untimely' 
                    END                                     AS  TIMELINESS_STATUS,
                    neu.IS_ACTIVE,
                    neu.IS_STARTING_ENTITY,
                    neu.IS_TERMINATING_ENTITY
                FROM    
                    new_updated_entities neu
                    JOIN 
                        D_BPM_ENTITY                                dbe
                    ON 
                    (
                        dbe.ENTITY_ID = neu.entity_id
                    )
        )                                                           nu
        ON
        (
            NU.entity_instance_id   =   ei.entity_instance_id   
        )
        WHEN MATCHED 
        THEN
            UPDATE SET 
                ei.complete_date        =   nu.complete_date,
                ei.is_active            =   nu.is_active,
                ei.timeliness_status    =   nu.timeliness_status
        WHEN NOT MATCHED 
        THEN
            INSERT
            (
                ENTITY_INSTANCE_ID,
                ENTITY_ID,
                ENTITY_TYPE_ID,
                PROCESS_INSTANCE_ID,
                ENTITY_NAME,
                ENTITY_DESCRIPTION,
                ENTITY_REFERENCE_TYPE,
                ENTITY_REFERENCE_ID,      
                START_DATE,
                COMPLETE_DATE,
                TIMELINESS_STATUS,
                IS_ACTIVE,
                IS_STARTING_ENTITY,
                IS_TERMINATING_ENTITY
            )
            VALUES
            (
                SEQ_D_BPM_ENTITY_INSTANCE.NEXTVAL,
                nu.entity_id,
                nu.entity_type_id,
                nu.process_instance_id,
                nu.entity_name,
                nu.entity_description,
                nu.entity_reference_type,
                nu.entity_reference_id,                      
                nu.start_date,
                nu.complete_date,
                nu.timeliness_status,
                nu.is_active,
                nu.is_starting_entity,
                nu.is_terminating_entity
            )
        LOG ERRORS (v_section_error || '(' || sysdate ||')')
        ;
        COMMIT;

        DBMS_STATS.gather_table_stats(USER, 'D_BPM_ENTITY_INSTANCE');

        -----------------------------------------------------------------------------
        --  Insert into FLOW Instance
        ----------------------------------------------------------------------------
        SELECT  
            'Insert into FLOW Instance' 
        INTO 
            v_section_error 
        FROM 
            DUAL;

        INSERT 
        INTO 
            D_BPM_FLOW_INSTANCE
            (    
                FLOW_INSTANCE_ID,
                FLOW_ID,
                PROCESS_INSTANCE_ID,
                FLOW_NAME,
                FLOW_DESCRIPTION,
                FLOW_SOURCE_ENTITY_INSTANCE_ID,
                FLOW_DEST_ENTITY_INST_ID,
                CREATED_DATE
            )
        SELECT 
            SEQ_D_BPM_FLOW_INSTANCE.NEXTVAL, 
            F.*
        FROM 
        (
            WITH 
                curr_flow_list      AS 
                ( -- Generate a list of all possible flow records by task_type_id
                    SELECT 
                        f.flow_id, 
                        f.process_id, 
                        f.flow_name, 
                        f.flow_description, 
                        f.flow_source_entity_id,
                        f.flow_destination_entity_id
                    FROM 
                        D_BPM_FLOW                      f
                ),
                new_flow_instance   AS 
                ( -- Generate a list of new flow instance records
                    SELECT 
                        DISTINCT 
                        cfl.flow_id, 
                        eis.process_instance_id                 AS  PROCESS_INSTANCE_ID, 
                        cfl.flow_name, 
                        cfl.flow_description, 
                        eis.entity_instance_id                  AS  FLOW_SOURCE_ENTITY_INSTANCE_ID,
                        eis.complete_date, 
                        eid.entity_instance_id                  AS  FLOW_DEST_ENTITY_INST_ID,
                        eid.start_date                          AS  CREATED_DATE
                    FROM 
                        curr_flow_list                              cfl
                        JOIN 
                            D_BPM_ENTITY_INSTANCE                   eis
                        ON
                        (
                            eis.entity_id                       =   cfl.flow_source_entity_id
                        )
                        JOIN    
                            D_BPM_ENTITY_INSTANCE                   eid
                        ON
                        (
                            eid.entity_id                       =   cfl.flow_destination_entity_id
                        )
                        JOIN
                            D_BPM_PROCESS_INSTANCE                  pi
                        ON
                        (
                            pi.process_instance_id              =   eis.process_instance_id
                        )                        
                    WHERE
                        eis.process_instance_id                 =   eid.process_instance_id     AND
                        eis.entity_instance_id                  !=  eid.entity_instance_id      AND
                        NOT EXISTS  ( -- Make sure there is not another destination task that is closer in time (based on creation date) to the source task.
                                        SELECT  
                                            1
                                        FROM  
                                            D_BPM_ENTITY_INSTANCE               eio          
                                        WHERE  
                                            eio.entity_id                   =   eid.entity_id               AND
                                            eio.start_date                  <   eid.start_date              AND
                                            eio.start_date                  >   eis.start_date              AND
                                            eio.entity_instance_id          !=  eid.entity_instance_id      AND
                                            eio.process_instance_id         =   eis.process_instance_id
                                    )
                )              
                SELECT 
                    DISTINCT 
                    nf.flow_id, 
                    nf.process_instance_id, 
                    nf.flow_name, 
                    nf.flow_description, 
                    nf.flow_source_entity_instance_id, 
                    nf.flow_dest_entity_inst_id, 
                    nf.created_date
                FROM 
                    new_flow_instance                   nf
                LEFT JOIN 
                    D_BPM_FLOW_INSTANCE                 fi
                ON 
                (
                    nf.flow_id                              =   fi.flow_id                          AND 
                    nf.process_instance_id                  =   fi.process_instance_id              AND 
                    nf.flow_source_entity_instance_id       =   fi.flow_source_entity_instance_id   AND 
                    nf.flow_dest_entity_inst_id             =   fi.flow_dest_entity_inst_id
                )
                WHERE 
                    fi.flow_id IS NULL
        ) F
        LOG ERRORS (v_section_error || '(' || sysdate ||')')
        ;
        COMMIT;

        -----------------------------------------------------------------------------
        --  Insert into Process Segment Instance
        -----------------------------------------------------------------------------
        SELECT 
            'Insert into Process Segment Instance' 
        INTO 
            v_section_error 
        FROM 
            DUAL;

        MERGE 
        INTO    
            D_BPM_PROCESS_SEGMENT_INSTANCE                      psi
        USING
        (
            WITH    
                curr_segment_list           AS 
                ( -- Generate a list of all possible segment records
                    SELECT 
                        DISTINCT 
                        ps.process_segment_id, 
                        ps.process_id, 
                        ps.process_segment_name, 
                        ps.process_segment_description, 
                        ps.process_timeliness_threshold, 
                        ps.process_timeliness_days_type,
                        ps.segment_start_entity_id,
                        ps.segment_finish_entity_id
                    FROM 
                        D_BPM_PROCESS_SEGMENT                   ps
                ),
                new_segment_instance        AS 
                ( -- Generate a list of new segment instance records
                    SELECT 
                        DISTINCT 
                        csl.process_segment_id,
                        eis.process_instance_id,
                        csl.process_segment_name,
                        csl.process_segment_description,
                        eis.entity_instance_id                      AS  SEGMENT_START_ENTITY_INST_ID,
                        eid.entity_instance_id                      AS  SEGMENT_END_ENTITY_INST_ID,
                        eis.start_date                              AS  PROCESS_SEGMENT_START_DATE,
                        eid.complete_date                           AS  PROCESS_SEGMENT_COMPLETE_DATE,
                        'UNKN' timeliness_status
                    FROM 
                        curr_segment_list                           csl
                        JOIN 
                            D_BPM_ENTITY_INSTANCE                   eis
                        ON
                        (
                            eis.entity_id                       =   csl.segment_start_entity_id
                        )
                        JOIN    
                            D_BPM_ENTITY_INSTANCE                   eid
                        ON
                        (
                            eid.entity_id                       =   csl.segment_finish_entity_id
                        )
                        JOIN
                            D_BPM_PROCESS_INSTANCE                  pi
                        ON
                        (
                            pi.process_instance_id              =   eis.process_instance_id
                        )                        
                        LEFT JOIN 
                            D_BPM_PROCESS_SEGMENT_INSTANCE          si
                        ON 
                        (
                            csl.process_segment_id              =   si.process_segment_id           AND 
                            eis.process_instance_id             =   si.process_instance_id          AND 
                            eis.entity_instance_id              =   si.segment_start_entity_inst_id AND 
                            eis.start_date                      =   si.process_segment_start_date   AND 
                            eid.entity_instance_id              =   si.segment_end_entity_inst_id
                        )
                    WHERE 
                        eis.process_instance_id                 =   eid.process_instance_id     AND
                        (
                            eis.entity_instance_id          !=  eid.entity_instance_id      OR
                            csl.segment_start_entity_id     =   csl.segment_finish_entity_id
                        )                                                                       AND
                        NOT EXISTS  ( -- Make sure there is not another destination task that is closer in time (based on creation date) to the source task.
                                        SELECT  
                                            1
                                        FROM  
                                            D_BPM_ENTITY_INSTANCE               eio          
                                        WHERE  
                                            eio.entity_id                   =   eid.entity_id               AND
                                            eio.start_date                  <   eid.start_date              AND
                                            eio.start_date                  >   eis.start_date              AND
                                            eio.entity_instance_id          !=  eid.entity_instance_id      AND
                                            eio.process_instance_id         =   eis.process_instance_id
                                    )                                                                       AND
                        si.PROCESS_INSTANCE_ID IS NULL
                ),
                updated_segment_instance        AS 
                ( -- Generate a list of updated segment instance records
                    SELECT 
                        si.PROCESS_SEGMENT_INSTANCE_ID,
                        si.PROCESS_SEGMENT_ID,
                        si.PROCESS_INSTANCE_ID,
                        si.PROCESS_SEGMENT_NAME,
                        si.PROCESS_SEGMENT_DESCRIPTION,
                        si.SEGMENT_START_ENTITY_INST_ID,
                        si.SEGMENT_END_ENTITY_INST_ID,
                        si.PROCESS_SEGMENT_START_DATE,
                        eid.complete_date                                       AS  PROCESS_SEGMENT_COMPLETE_DATE,
                        'UNKN'                                                  AS  TIMELINESS_STATUS
                    FROM 
                        D_BPM_PROCESS_SEGMENT_INSTANCE                              si
                        JOIN 
                            D_BPM_ENTITY_INSTANCE                                   eid
                        ON 
                        (
                            si.SEGMENT_END_ENTITY_INST_ID       =   eid.entity_instance_id
                        )
                    WHERE 
                        COALESCE(eid.complete_date,to_date('1/1/1900','dd/mm/yyyy')) != COALESCE(si.process_segment_complete_date,to_date('1/1/1900','dd/mm/yyyy'))
                ),
                new_updated_segments       AS 
                (
                    SELECT 
                        0       AS  process_segment_instance_id, 
                        si.* 
                    FROM 
                        new_segment_instance            si
                    UNION
                    SELECT 
                        * 
                    FROM 
                        updated_segment_instance
                )
                SELECT 
                    nus.process_segment_instance_id,
                    nus.process_segment_id,
                    nus.process_instance_id,
                    nus.process_segment_name,
                    nus.process_segment_description,
                    nus.segment_start_entity_inst_id,
                    nus.segment_end_entity_inst_id,
                    nus.process_segment_start_date,
                    nus.process_segment_complete_date,
                    CASE 
                        WHEN    nus.process_segment_complete_date IS NULL 
                        THEN    'In Process'
                        WHEN    p.PROCESS_TIMELINESS_DAYS_TYPE = 'C'    AND 
                                round((nus.process_segment_complete_date - nus.process_segment_start_date),0) <= p.PROCESS_TIMELINESS_THRESHOLD 
                        THEN    'Timely'
                        WHEN    p.PROCESS_TIMELINESS_DAYS_TYPE = 'C'    AND 
                                round((nus.process_segment_complete_date - nus.process_segment_start_date),0) > p.PROCESS_TIMELINESS_THRESHOLD 
                        THEN    'Untimely'
                        WHEN    p.PROCESS_TIMELINESS_DAYS_TYPE = 'B'    AND
                                round(Bus_days_between(nus.process_segment_start_date, nus.process_segment_complete_date),0) <= p.PROCESS_TIMELINESS_THRESHOLD 
                        THEN    'Timely'
                    ELSE        
                        'Untimely' 
                    END timeliness_status
                FROM 
                    new_updated_segments        nus
                    JOIN 
                        D_BPM_PROCESS_SEGMENT   p
                    ON 
                    (
                        p.process_segment_id    =   nus.process_segment_id
                    )
        ) nu
        ON 
        (
            psi.process_segment_instance_id     =   NU.process_segment_instance_id
        )
        WHEN MATCHED 
        THEN
            UPDATE SET 
                psi.process_segment_complete_date   =   NU.process_segment_complete_date,
                psi.timeliness_status               =   NU.timeliness_status
        WHEN NOT MATCHED 
        THEN
            INSERT
            (    
                PROCESS_SEGMENT_INSTANCE_ID,
                PROCESS_SEGMENT_ID,
                PROCESS_INSTANCE_ID,
                PROCESS_SEGMENT_NAME,
                PROCESS_SEGMENT_DESCRIPTION,
                SEGMENT_START_ENTITY_INST_ID,
                SEGMENT_END_ENTITY_INST_ID,
                PROCESS_SEGMENT_START_DATE,
                PROCESS_SEGMENT_COMPLETE_DATE,
                TIMELINESS_STATUS
            )
            VALUES
            (    
                SEQ_D_BPM_SEGMENT_INSTANCE.NEXTVAL,
                NU.PROCESS_SEGMENT_ID,
                NU.PROCESS_INSTANCE_ID,
                NU.PROCESS_SEGMENT_NAME,
                NU.PROCESS_SEGMENT_DESCRIPTION,
                NU.SEGMENT_START_ENTITY_INST_ID,
                NU.SEGMENT_END_ENTITY_INST_ID,
                NU.PROCESS_SEGMENT_START_DATE,
                NU.PROCESS_SEGMENT_COMPLETE_DATE,
                NU.TIMELINESS_STATUS
            )
        LOG ERRORS (v_section_error || '(' || sysdate ||')')
        ;
        COMMIT;

        -----------------------------------------------------------------------------
        --  Insert/Upadte Fact Process By Date
        -----------------------------------------------------------------------------
        SELECT 'Insert/Update Fact Process By Date' INTO v_section_error FROM DUAL;

        MERGE 
        INTO 
            F_BPM_PROCESS_BY_DATE           pbd
        USING
        (
            SELECT 
                DISTINCT
                pi.process_id,
                ddate.d_date                                                                    AS  D_DATE,
                pi.PROCESS_NAME,
                SUM
                (
                    CASE
                        WHEN    pi.process_complete_date IS NOT NULL            AND 
                                TRUNC(pi.process_complete_date) = ddate.d_date 
                        THEN    1 
                    ELSE
                        0 
                    END
                ) OVER (PARTITION BY pi.process_id, ddate.d_date)                               AS  COMPLETE_PROCESS_COUNT,
                SUM
                (
                    CASE 
                        WHEN    pi.process_complete_date IS NULL 
                        THEN    1 
                    ELSE 
                        0 
                    END
                )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date))             AS  ACTIVE_PROCESS_COUNT,
                ROUND
                (
                    AVG
                    (
                        CASE 
                            WHEN    pi.PROCESS_COMPLETE_DATE IS NULL 
                            THEN    SYSDATE - pi.process_start_date 
                        END
                    )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2)      AS  AVG_PROCESS_AGE,
                ROUND
                (
                    MIN
                    (
                        CASE 
                            WHEN    pi.process_complete_date IS NULL 
                            THEN    SYSDATE - pi.process_start_date 
                        END
                    )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2)      AS  MIN_PROCESS_AGE,
                ROUND
                (
                    MAX
                    (
                        CASE 
                            WHEN    pi.process_complete_date IS NULL 
                            THEN    SYSDATE - pi.process_start_date 
                        END
                    )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2)      AS  MAX_PROCESS_AGE,
                ROUND
                (
                    AVG
                    (
                        CASE 
                            WHEN    pi.process_complete_date IS NOT NULL 
                            THEN    pi.process_complete_date - pi.process_start_date 
                        END
                    )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2)      AS  AVG_PROCESS_COMPLETE_TIME,
                ROUND
                (
                    MIN
                    (
                        CASE 
                            WHEN    pi.process_complete_date IS NOT NULL 
                            THEN    pi.process_complete_date - pi.process_start_date 
                        END
                    )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2)      AS  MIN_PROCESS_COMPLETE_TIME,
                ROUND
                (
                    MAX
                    (
                        CASE 
                            WHEN    pi.PROCESS_COMPLETE_DATE IS NOT NULL 
                            THEN    pi.PROCESS_COMPLETE_DATE - pi.process_start_date 
                        END
                    )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date)),2)      AS  MAX_PROCESS_COMPLETE_TIME,
                SUM
                (
                    CASE 
                        WHEN    upper(pi.timeliness_status) = 'TIMELY' 
                        THEN    1 
                        ELSE    0 
                    END
                )   over (PARTITION BY pi.process_id, TRUNC(pi.process_start_date))             AS  TIMELY_PROCESS_COUNT,
                SUM
                (
                    CASE 
                        WHEN    upper(pi.timeliness_status) = 'UNTIMELY' 
                        THEN    1 
                        ELSE    0 
                    END
                )   OVER (PARTITION BY pi.process_id, TRUNC(pi.process_start_date))             AS  UNTIMELY_PROCESS_COUNT
            FROM 
                D_BPM_PROCESS_INSTANCE          pi
                JOIN 
                    BPM_D_DATES                 ddate
                ON 
                (
                    ddate.D_DATE = TRUNC(pi.process_start_date)
                )
        )                                                                                           pi
        ON 
        (
            pbd.process_id  =   pi.PROCESS_ID   AND 
            pbd.d_date      =   pi.d_date
        )
        WHEN MATCHED THEN
            UPDATE SET 
                pbd.complete_process_count      =   pi.complete_process_count,
                pbd.active_process_count        =   pi.active_process_count,
                pbd.avg_process_age             =   pi.avg_process_age,
                pbd.min_process_age             =   pi.min_process_age,
                pbd.max_process_age             =   pi.max_process_age,
                pbd.avg_process_complete_time   =   pi.avg_process_complete_time,
                pbd.min_process_complete_time   =   pi.min_process_complete_time,
                pbd.max_process_complete_time   =   pi.max_process_complete_time,
                pbd.timely_process_count        =   pi.timely_process_count,
                pbd.untimely_process_count      =   pi.untimely_process_count
        WHEN NOT MATCHED THEN
            INSERT
                (
                    PROCESS_ID,
                    D_DATE,
                    PROCESS_NAME,
                    COMPLETE_PROCESS_COUNT,
                    ACTIVE_PROCESS_COUNT,
                    AVG_PROCESS_AGE,
                    MIN_PROCESS_AGE,
                    MAX_PROCESS_AGE,
                    AVG_PROCESS_COMPLETE_TIME,
                    MIN_PROCESS_COMPLETE_TIME,
                    MAX_PROCESS_COMPLETE_TIME,
                    TIMELY_PROCESS_COUNT,
                    UNTIMELY_PROCESS_COUNT
                )
                VALUES
                (
                    pi.process_id,
                    pi.d_date,
                    pi.process_name,
                    pi.complete_process_count,
                    pi.active_process_count,
                    pi.avg_process_age,
                    pi.min_process_age,
                    pi.max_process_age,
                    pi.avg_process_complete_time,
                    pi.min_process_complete_time,
                    pi.max_process_complete_time,
                    pi.timely_process_count,
                    pi.untimely_process_count
                )
        LOG ERRORS (v_section_error || '(' || sysdate ||')')
        ;
        COMMIT;

    EXCEPTION
        WHEN    OTHERS 
        THEN    v_err_code := SUBSTR(SQLCODE, 1, 400);
                v_err_msg := SUBSTR(SQLERRM, 1, 3800);

                INSERT 
                INTO 
                    CORP_ETL_ERROR_LOG
                VALUES
                    (
                        SEQ_CEEL_ID.nextval,--CEEL_ID
                        SYSDATE,--ERR_DATE
                        'CRITICAL',--ERR_LEVEL
                        'MW_POPULATE_INSTANCE_TABLES',--PROCESS_NAME
                        'POPULATE_INSTANCE_TABLES',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_section_error ||' '||v_err_msg,--ERROR_DESC
                        NULL,--ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        SYSDATE,--CREATE_TS
                        SYSDATE,--UPDATE_TS
                        null,--DRIVER_TABLE_NAME
                        null--DRIVER_KEY_NUMBER
                    );
                COMMIT;
                RAISE_APPLICATION_ERROR
                (
                    -20001,
                    'An error was encountered in ' || v_section_error || ' - '||SQLCODE||' -ERROR- '||SQLERRM
                );

    END         populate_instance_tables;

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




