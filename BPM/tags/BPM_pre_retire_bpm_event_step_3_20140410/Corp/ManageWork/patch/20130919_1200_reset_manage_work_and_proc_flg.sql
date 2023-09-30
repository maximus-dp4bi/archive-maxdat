TRUNCATE TABLE corp_etl_manage_work;

UPDATE step_instance_stg sis SET mw_processed = 'N'
  WHERE EXISTS (SELECT 1
                FROM  step_definition_stg sds
                WHERE sds.step_definition_id = sis.step_definition_id
                  AND sds.step_type_cd in ('HUMAN_TASK','VIRTUAL_HUMAN_TASK')
              );
COMMIT;
