ALTER TABLE D_BPM_ENTITY_INSTANCE ADD
(
    ENTITY_REFERENCE_TYPE                               NUMBER(18,0),
    ENTITY_REFERENCE_ID                                 NUMBER(18,0)
);

CREATE UNIQUE INDEX IDX_INST_SOURCE_REF_TYPE_ID ON D_BPM_ENTITY_INSTANCE (ENTITY_REFERENCE_TYPE, ENTITY_REFERENCE_ID)
TABLESPACE MAXDAT_INDX;

ALTER TABLE D_BPM_ENTITY_INSTANCE ADD
(
    CONSTRAINT      D_BPM_ENTITY_INSTANCE_FK4
    FOREIGN KEY     (ENTITY_REFERENCE_TYPE)
    REFERENCES      D_BPM_ENTITY_TYPE(ENTITY_TYPE_ID)
    ENABLE
);

CREATE OR REPLACE FORCE EDITIONABLE VIEW D_BPM_ENTITY_INSTANCE_SV AS
    SELECT
        ENTITY_INSTANCE_ID
        , ei.ENTITY_ID
        , ei.ENTITY_TYPE_ID
        , ei.PROCESS_INSTANCE_ID
        , ei.ENTITY_NAME
        , ei.ENTITY_DESCRIPTION
        , ei.ENTITY_REFERENCE_TYPE
        , ei.ENTITY_REFERENCE_ID
        , ei.START_DATE
        , ei.COMPLETE_DATE
        , e.TIMELINESS_THRESHOLD
        , e.TIMELINESS_DAYS_TYPE
        , ei.TIMELINESS_STATUS
        , pi.PROCESS_START_DATE
        , pi.PROCESS_COMPLETE_DATE
        , COALESCE(ei.complete_date, SYSDATE) - pi.process_start_date                                       AS  CYCLE_TIME
        , BPM_COMMON.bus_days_between(COALESCE(ei.complete_date, SYSDATE), pi.process_start_date)           AS  CYCLE_TIME_BUS_DAYS
        , ei.IS_ACTIVE
        , ei.IS_STARTING_ENTITY
        , ei.IS_TERMINATING_ENTITY  
    FROM    
        D_BPM_ENTITY_INSTANCE                   ei,
        D_BPM_ENTITY                            e,
        D_BPM_PROCESS_INSTANCE                  pi
    WHERE    
        ei.process_instance_id              =   pi.process_instance_id      AND
        ei.entity_id                        =   e.entity_id
    WITH read only;

GRANT SELECT ON D_BPM_ENTITY_INSTANCE_SV TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE ON D_BPM_ENTITY_INSTANCE_SV TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON D_BPM_ENTITY_INSTANCE_SV TO MAXDAT_OLTP_SIUD;