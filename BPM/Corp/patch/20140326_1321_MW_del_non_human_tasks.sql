/* Remove non-Human and Virtual human tasks
1.	Disable triggers
2.	Write human and virtual recs to temp table
3.	Truncate stage table,
4.	Ins  temp table records back into stage
5.	Enable triggers
*/

--ALTER TRIGGER step_instance_stg_TRG DISABLE;
ALTER TRIGGER TRG_BIU_STEP_INSTANCE_STG DISABLE;

CREATE TABLE temp_human_tasks AS
SELECT sis.*
  FROM step_instance_stg sis, step_definition_stg sds
 WHERE sds.step_type_cd IN ('VIRTUAL_HUMAN_TASK','HUMAN_TASK') 
   AND sds.step_definition_id = sis.step_definition_id;
   
TRUNCATE TABLE step_instance_stg;

BEGIN
  dbms_stats.gather_table_stats('MAXDAT','STEP_INSTANCE_STG');
END;
/

INSERT INTO step_instance_stg
SELECT * FROM temp_human_tasks;

COMMIT;

DROP TABLE temp_human_tasks
/

--ALTER TRIGGER step_instance_stg_TRG ENABLE;
ALTER TRIGGER TRG_BIU_STEP_INSTANCE_STG ENABLE;


