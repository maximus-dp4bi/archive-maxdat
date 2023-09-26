-- D_TASK_TYPES

UPDATE  D_TASK_TYPES
   SET  SLA_DAYS                =   2
 WHERE  task_type_id            IN  (8,9,10,14,16);
 
-- D_BPM_ENTITY

UPDATE  D_BPM_ENTITY    e
   SET  (timeliness_threshold, timeliness_days_type)    =   (
                                                                SELECT  sla_days,
                                                                        sla_days_type
                                                                  FROM  D_TASK_TYPES                    tt,
                                                                        D_BPM_TASK_TYPE_ENTITY          tte
                                                                 WHERE  tt.task_type_id             =   tte.task_type_id
                                                                   AND  tte.entity_id               =   e.entity_id
                                                            )
 WHERE  e.entity_id IN  (
                            SELECT  tte.entity_id
                              FROM  D_BPM_TASK_TYPE_ENTITY  tte
                        );
                        
COMMIT;
