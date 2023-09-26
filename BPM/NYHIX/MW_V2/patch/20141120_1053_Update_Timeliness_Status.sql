/*
Created on 11/20/2014 by Raj A.
Description: per NYHIX-11699, we made task configuration changes. Task_Type_ID=2016254 did not have SLA days info previously, now it did. So, we are applying
this change to the COMPLETED instances using the update below. This issue logged by Rob in NYHIX-11287.

task_type_id = 2016214 had SLA days info. but now it is set to null. So, we need to recalculate Timeliness_Status.
*/
update D_MW_V2_CURRENT
    set     
      TIMELINESS_STATUS = maxdat.mw_v2.get_timeliness_status(
                             INSTANCE_END_DATE,
                             TASK_TYPE_ID,
                             CURR_WORK_RECEIPT_DATE
                             )
    where task_id in (
        Select mwc.task_id
        from d_mw_v2_current_sv mwc
          join d_task_types_sv tt
            on mwc.task_type_id = tt.task_type_id where mwc.COMPLETE_DATE is not null
            and tt.SLA_DAYS_TYPE = 'B'
            and mwc.AGE_IN_BUSINESS_DAYS <= tt.SLA_DAYS
            and mwc.TIMELINESS_STATUS != 'Timely'
            );
commit;

update D_MW_V2_CURRENT
    set     
      TIMELINESS_STATUS = maxdat.mw_v2.get_timeliness_status(
                             INSTANCE_END_DATE,
                             TASK_TYPE_ID,
                             CURR_WORK_RECEIPT_DATE
                             )
    where task_id in (
        Select mwc.task_id
        from d_mw_v2_current_sv mwc
          join d_task_types_sv tt
            on mwc.task_type_id = tt.task_type_id where mwc.COMPLETE_DATE is not null
           and tt.SLA_DAYS_TYPE is null
           and mwc.TIMELINESS_STATUS != 'Not Required'
            );
commit;

update D_MW_V2_CURRENT
    set     
      TIMELINESS_STATUS = maxdat.mw_v2.get_timeliness_status(
                             INSTANCE_END_DATE,
                             TASK_TYPE_ID,
                             CURR_WORK_RECEIPT_DATE
                             )
    where task_id in (
        Select mwc.task_id
        from d_mw_v2_current_sv mwc
          join d_task_types_sv tt
            on mwc.task_type_id = tt.task_type_id where mwc.COMPLETE_DATE is not null
           and tt.SLA_DAYS_TYPE is not null
           and mwc.TIMELINESS_STATUS = 'Not Required'
            );
commit;