update D_MW_TASK_INSTANCE
    set
     TASK_UNCLAIMED_TIME = mw.GET_TASK_UNCLAIMED_TIME(CREATE_DATE,COALESCE(CURR_CLAIM_DATE,INSTANCE_END_DATE))     
    where
      CURR_CLAIM_DATE is null
      and CANCEL_WORK_DATE is null
      and instance_end_date is not null;
      
commit;      