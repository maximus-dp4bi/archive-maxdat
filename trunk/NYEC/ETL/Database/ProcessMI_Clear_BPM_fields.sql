/*
Created on 19-Oct-2012 by Raj A.
updated on 25-Oct-2012 by Raj A. nulling the stage_done_date and instance_complete_dt.
updated on 26-Oct-2012 by Raj A. Defaulting ASF_SEND_MI_LETTER and GWF_MANUAL_LETTER to 'N'.


Description:
Clearing all the attributes that get updated after the MI Task is completed.
For these instances, logic will be run again from UPD5_20_Bug_Fix and later.

Bugs:
1. New_MI_Creation_date getting reset.
2. All_MI_satisfies not checked correctly in the Transformation tab.
3. Deployment artifact in the data.(Multiple QC Task IDs, Research Task IDs issue).
*/
update process_mi_stg
   set instance_status = 'ACTIVE',
       ASPB_PERFORM_QC = null,
       ASED_PERFORM_QC = null,
       ASPB_PERFORM_RESEARCH  = null,
       ASED_PERFORM_RESEARCH  = null,
       ASSD_SEND_MI_LETTER  = null,
       ASPB_SEND_MI_LETTER = null,
       ASED_SEND_MI_LETTER = null,
       GWF_MANUAL_LETTER  = 'N',
       GWF_SEND_RESEARCH = null,
       GWF_QC_REQUIRED = null,
       GWF_QC_OUTCOME = null,
       GWF_MI_OUTCOME = null,
       ASF_PERFORM_QC = 'N',
       ASF_PERFORM_RESEARCH = 'N', 
       ASF_SEND_MI_LETTER = 'N',
       QC_TASK_ID           = null,
      QC_TASK_CLAIMED_DATE   = null,
      QC_TASK_CLAIMED_BY      = null,
      QC_TASK_COMPLETED_DATE   = null,
      QC_TASK_COMPLETED_BY   = null,
      RESEARCH_TASK_ID        = null,
      RSRCH_TASK_CLAIMED_DATE  = null,
      RSRCH_TASK_CLAIMED_BY     = null,
      RSRCH_TASK_COMPLETED_DATE  = null,
      RSRCH_TASK_COMPLETED_BY  = null,
      STATE_REVIEW_TASK_ID   = null,
      STRW_TASK_CLAIMED_DATE    = null,
      STRW_TASK_CLAIMED_BY       = null,
      STRW_TASK_COMPLETED_DATE   = null,
      STRW_TASK_COMPLETED_BY    = null,
      stage_done_date = null,
      instance_complete_dt = null 	
where mi_task_id in (select distinct mi_task_id from Pro_MI_multiple_qc_rsch_strw);
commit;