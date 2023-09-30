-- D_BPM_ENTITY

UPDATE	D_BPM_ENTITY
   SET  entity_name             =   'PROCESS_EDER_CRM',
        entity_description      =   'Activity ends when all EDERs processed',
        is_starting_entity      =   'N',
        is_terminating_entity   =   'N'
 WHERE  entity_id           =   5008;

UPDATE	D_BPM_ENTITY
   SET  entity_name         =   'PROCESS_EXEMPTION_CRM',
        entity_description  =   'Activity ends when all exemptions processed',
        is_starting_entity      =   'N',
        is_terminating_entity   =   'N'        
 WHERE  entity_id           =   5009;
                        
COMMIT;
