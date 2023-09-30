/*
Created on 17-Oct-2012 by Raj A.

Description:
Email question to John: So, what about when we have a QC task id-1 created after an MI task-1 and then have a QC task id-2 
created after an MI task-2; After qc_task_id_2 was created our Process MI deployment happened, the ETL associated  qc_task_id-2 
to MI task-1 and qc_task_id-2 mi_task-id-2 too . This is because qc_task_id-2 was the latest one seen by the code. 
Both instances now have the same qc_task_id-2 . Do you think it is okay ?

Answer:
John and I had a phone conversation and he thinks qc_task_id_1 should be associated to mi_task_id_1 and qc-task_id_2 
to mi_task_id-2 as highlighted in the Excel file.

GRANTS and PUBLIC SYNONYM added on 26-OCT-2012.
*/

create table Pro_MI_multiple_qc_rsch_strw as
select bpm_1.* 
from nyec_etl_process_mi bpm_1,
     nyec_etl_process_mi bpm_2
where 1=1 
and bpm_1.app_id = bpm_2.app_id
and bpm_1.mi_task_type <> 'State Review Task - MI Reprocess Result'
and bpm_2.mi_task_type <> 'State Review Task - MI Reprocess Result'
and bpm_1.mi_task_id < bpm_2.mi_task_id
and (
     exists ( select 1 
                 from step_instance_stg si_stg
                where bpm_1.app_id = si_stg.ref_id
                  and si_stg.step_instance_id > bpm_1.mi_task_id
                  and si_stg.step_instance_id < bpm_2.mi_task_id
                  and si_stg.step_definition_id in (SELECT ref_id FROM corp_etl_list_lkup
                                                    WHERE NAME = 'TASK_MONITOR_TYPE'
                                                      AND out_var = 'QC' 
                                                      AND SYSDATE BETWEEN start_date AND end_date)
                  and si_stg.step_instance_id <> bpm_1.qc_task_id
             )
        OR
       exists ( select 1 
                 from step_instance_stg si_stg
                where bpm_1.app_id = si_stg.ref_id
                  and si_stg.step_instance_id > bpm_1.mi_task_id
                  and si_stg.step_instance_id < bpm_2.mi_task_id
                  and si_stg.step_definition_id in (SELECT ref_id FROM corp_etl_list_lkup
                                              WHERE NAME = 'TASK_MONITOR_TYPE'
                                              AND out_var = 'Research' 
                                              AND SYSDATE BETWEEN start_date AND end_date)
                  and si_stg.step_instance_id <> bpm_1.research_task_id
               )
          OR
        exists ( select 1 
                 from step_instance_stg si_stg
                where bpm_1.app_id = si_stg.ref_id
                  and si_stg.step_instance_id > bpm_1.mi_task_id
                  and si_stg.step_instance_id < bpm_2.mi_task_id
                  and si_stg.step_definition_id in (SELECT ref_id FROM corp_etl_list_lkup
                                                      WHERE NAME = 'TASK_MONITOR_TYPE'
                                                      AND out_var = 'State Review' 
                                                      AND SYSDATE BETWEEN start_date AND end_date)
                  and si_stg.step_instance_id <> bpm_1.state_review_task_id
             )
        )                 
--and bpm_1.app_id = 249159  
--and bpm_1.stage_done_date is null           
;


create public synonym PRO_MI_MULTIPLE_QC_RSCH_STRW for MAXDAT.PRO_MI_MULTIPLE_QC_RSCH_STRW;

GRANT SELECT ON MAXDAT.PRO_MI_MULTIPLE_QC_RSCH_STRW TO MAXDAT_READ_ONLY;