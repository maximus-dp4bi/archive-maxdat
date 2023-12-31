ALTER TABLE CC_F_IVR_PERFORMANCE_INSTANCE ADD
(
    IVR_CALL_DATE_LOCAL                         DATE, 
    IVR_CALL_START_TIME_LOCAL                   DATE, 
    IVR_CALL_END_TIME_LOCAL                     DATE, 
    D_INTERVAL_ID_LOCAL                         NUMBER(38,0)
);

COMMENT ON COLUMN CC_F_IVR_PERFORMANCE_INSTANCE.IVR_CALL_DATE_LOCAL IS 'VXMLSESSION.CALLSTARTDATE; The local callstartdate';
COMMENT ON COLUMN CC_F_IVR_PERFORMANCE_INSTANCE.IVR_CALL_START_TIME_LOCAL IS 'VXMLSESSION.CALLSTARTDATE; The local call startdatetime';
COMMENT ON COLUMN CC_F_IVR_PERFORMANCE_INSTANCE.IVR_CALL_END_TIME_LOCAL IS 'VXMLSESSION.CALLSTARTDATE; The local call enddatetime';
COMMENT ON COLUMN CC_F_IVR_PERFORMANCE_INSTANCE.D_INTERVAL_ID_LOCAL IS 'VXMLSESSION.CALLSTARTDATE; The CC_D_INTERVAL.D_INTERVAL_ID that contains the local call startdatetime';

alter table cc_f_ivr_performance_instance add
(
    local_timezone              varchar2(20)
);

ALTER TABLE CC_F_IVR_PERFORMANCE_INSTANCE ADD (
    D_DATE_ID_LOCAL                             NUMBER(38,0)
);

comment on column cc_f_ivr_performance_instance.local_timezone  is 'Local timezone';

CREATE INDEX CC_F_IVR_PERFORMANCE_INSTANCE_IDX6 ON  CC_F_IVR_PERFORMANCE_INSTANCE(D_DATE_ID_LOCAL)     TABLESPACE MAXDAT_DATA      LOGGING ;
CREATE INDEX CC_F_IVR_PERFORMANCE_INSTANCE_IDX7 ON  CC_F_IVR_PERFORMANCE_INSTANCE(D_INTERVAL_ID_LOCAL)     TABLESPACE MAXDAT_DATA      LOGGING ;

CREATE OR REPLACE VIEW CC_F_IVR_PERFORMANCE_INSTANCE_SV AS
SELECT * FROM ( 
SELECT /*+ PARALLEL(10) */
IVRPI.F_IVR_PERFORMANCE_INSTANCE_ID
,IVRPI.D_DATE_ID
,IVRPI.D_INTERVAL_ID
,IVRPI.D_PROJECT_ID
,IVRPI.D_PROGRAM_ID
,IVRPI.IVR_SOURCE
,IVRPI.IVR_APPLICATION_NAME
,IVRPI.IVR_CALL_DATE
,IVRPI.IVR_CALL_START_TIME
,IVRPI.IVR_CALL_END_TIME
,IVRPI.INBOUND_DNIS
,IVRPI.ANI
,IVRPI.IVR_LANG_ID
,IVRPI.DURATION_IN_IVR
,IVRPI.CALL_GUID
,IVRPI.ROUTER_CALL_KEY_DAY
,IVRPI.ROUTER_CALL_KEY
,IVRPI.IVR_EXIT_EVENT
,IVRPI.IVR_EXIT_CAUSE
,IVRPI.COMPLETION_CODE
,IVRPI.IVR_EXIT_POINT
,IVRPI.MAIN_MENU_SELECTION
,IVRPI.SELF_SERVICE_DESCRIPTION
,IVRPI.DESTINATION_TRANSFER
,IVRPI.SRC_AGENT_ROUTING_GROUP_NAME
,IVRPI.SRC_AGENT_ROUTING_GROUP_ID
,IVRPI.SRC_QUEUE_NAME
,IVRPI.SRC_QUEUE_NUMBER   
,IVRPI.SOURCE_TABLE_NAME
,IVRPI.SOURCE_TABLE_ID
,IVRPI.CREATE_DT
,IVRPI.CREATED_BY,UPDATE_DT,UPDATED_BY
,IVRPI.IVR_CALL_DATE_LOCAL
,IVRPI.IVR_CALL_START_TIME_LOCAL
,IVRPI.IVR_CALL_END_TIME_LOCAL
,IVRPI.D_INTERVAL_ID_LOCAL
,IVRPI.local_timezone 
,IVRPI.D_DATE_ID_LOCAL
,IVRPIE.inbound_dnis_type           
--,IVRPIE.unit_of_work 
,IVRPIE.AGENT_ROUTING_GROUP_ID
,IVRPIE.D_UNIT_OF_WORK_ID               
,IVRPIE.D_CONTACT_QUEUE_ID               
,IVRPIE.ivr_exit_result             
,IVRPIE.IVR_EXIT_RESULT_DETAIL      
,IVRPIE.CALL_CONTAINED_IN_IVR       
,IVRPIE.CALL_ROUTED_TO_AGENT        
,IVRPIE.CALL_RECEIVED_AFTER_HOURS
,IVRPIE.S_IVR_PERFORMANCE_INSTANCE_EXT_ID 
, ARG.AGENT_ROUTING_GROUP_NUMBER
, ARG.AGENT_ROUTING_GROUP_NAME
, ARG.AGENT_ROUTING_GROUP_TYPE
FROM CC_F_IVR_PERFORMANCE_INSTANCE IVRPI
LEFT JOIN (SELECT 
      S_IVR_PERFORMANCE_INSTANCE_EXT_ID
      ,F_IVR_PERFORMANCE_INSTANCE_ID
      ,inbound_dnis_type         
      ,unit_of_work              
      ,AGENT_ROUTING_GROUP_ID
      ,D_UNIT_OF_WORK_ID               
      ,D_CONTACT_QUEUE_ID               
      ,ivr_exit_result           
      ,IVR_EXIT_RESULT_DETAIL    
      ,CALL_CONTAINED_IN_IVR     
      ,CALL_ROUTED_TO_AGENT      
      ,CALL_RECEIVED_AFTER_HOURS
      FROM (
           SELECT IEXT.*
           , ROW_NUMBER() OVER (PARTITION BY IEXT.F_IVR_PERFORMANCE_INSTANCE_ID ORDER BY IEXT.S_IVR_PERFORMANCE_INSTANCE_EXT_ID DESC) ROWN 
           FROM CC_S_IVR_PERFORMANCE_INSTANCE_EXT IEXT
      )
      WHERE ROWN = 1
      ) IVRPIE ON IVRPI.F_IVR_PERFORMANCE_INSTANCE_ID = IVRPIE.F_IVR_PERFORMANCE_INSTANCE_ID
LEFT JOIN CC_C_AGENT_RTG_GRP ARG ON ARG.C_AGENT_ROUTING_GROUP_ID = IVRPIE.AGENT_ROUTING_GROUP_ID AND ARG.RECORD_EFF_DT <= TRUNC(SYSDATE) AND ARG.RECORD_END_DT >= TRUNC(SYSDATE)
) ;

GRANT SELECT ON CC_F_IVR_PERFORMANCE_INSTANCE_SV TO CISCO_READ_ONLY;
GRANT SELECT ON CC_F_IVR_PERFORMANCE_INSTANCE_SV TO MAXDAT_READ_ONLY;
