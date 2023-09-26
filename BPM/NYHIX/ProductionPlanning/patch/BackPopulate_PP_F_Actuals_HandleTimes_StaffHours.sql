DECLARE
V_ERRCODE varchar2(50);
V_ERRMSG varchar2(3000);

BEGIN
  
  INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script','Manual run to back-populate Handle Times and Staff Hours - Begin', SYSDATE); 
  COMMIT;
  FOR RECS IN 
    (
        with ht as
        (
        select event_id, trunc(task_start-4/24) as d_date, handle_time, task_end, task_start from pp_bo_actuals
        )
        select distinct ht.d_date,  
               usr.uow_id,
               AVG((ht.task_end-ht.task_start)*24*60) over (partition by d_date, uow_id) as avg_handle_time, 
               MIN((ht.task_end-ht.task_start)*24*60) over (partition by d_date, uow_id) as min_handle_time,
               STDDEV((ht.task_end-ht.task_start)*24*60) over (partition by d_date, uow_id) as stdev_handle_time,
               MEDIAN((ht.task_end-ht.task_start)*24*60) over (partition by d_date, uow_id) as median_handle_time,
               MAX((ht.task_end-ht.task_start)*24*60) over (partition by d_date, uow_id) as max_handle_time,
               (SUM((ht.task_end-ht.task_start)*24*60) over (partition by d_date, uow_id)/60) as staff_hours,
               SUM((ht.task_end-ht.task_start)*24*60) over (partition by d_date, uow_id) as sum_ht,
               count(1) over (partition by d_date, uow_id) as count_ht
          from ht
          join pp_d_uow_source_ref usr
            on usr.source_ref_id = ht.event_id
           and usr.source_ref_detail_identifier='PIPKINS EVENTS' and usr.end_date > sysdate
) 
    LOOP
              
              
              UPDATE PP_F_ACTUALS 
                 SET actl_handle_time_avg=RECS.avg_handle_time,
                     actl_handle_time_min=RECS.min_handle_time,
                     actl_handle_time_max=RECS.max_handle_time,
                     actl_handle_time_mean=RECS.avg_handle_time,
                     actl_handle_time_median=RECS.median_handle_time,
                     actl_handle_time_sd=RECS.stdev_handle_time,
                     actl_staff_hours=RECS.staff_hours
               WHERE d_date=RECS.d_date and uow_id=RECS.uow_id;
               
              /* INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script',RECS.D_DATE || ' --- ' || RECS.UOW_ID , SYSDATE);*/ 

  END LOOP;
  INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script','Manual run to back-populate Handle Times and Staff Hours - Processed', SYSDATE); 
  COMMIT;


EXCEPTION
WHEN OTHERS 
  THEN 
    ROLLBACK;
    V_ERRCODE := SQLCODE;
    V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
    INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Script','Manual run to back-populate Handle Times and Staff Hours - Processed - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
      COMMIT; 
    RAISE;
END;

/



