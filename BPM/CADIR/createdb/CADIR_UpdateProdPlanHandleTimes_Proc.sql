CREATE OR REPLACE Procedure UpdateProdPlanHandleTimes()
   
IS

V_ERRCODE varchar2(50);
V_ERRMSG varchar2(3000);

BEGIN
  
  INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_HandleTimes','Scheduled run to back-populate Handle Times and Staff Hours - Begin', SYSDATE); 
  COMMIT;
  FOR RECS IN 
    (
        with ht as
        (
          select x."Task ID" as task_id, x."Current Task Type" as task_type,
                 trunc(x."Create Date") as d_date,
                 x.Handle_Time
            from d_mw_current_sv x
           where x.Handle_Time between .5 and 100
             and trunc(x."Create Date") >= (sysdate - 365)
        )
        select distinct ht.d_date,  
               usr.uow_id,
               AVG(Handle_Time) over (partition by d_date, uow_id) as avg_handle_time, 
               MIN(Handle_Time) over (partition by d_date, uow_id) as min_handle_time,
               STDDEV(Handle_Time) over (partition by d_date, uow_id) as stdev_handle_time,
               MEDIAN(Handle_Time) over (partition by d_date, uow_id) as median_handle_time,
               MAX(Handle_Time) over (partition by d_date, uow_id) as max_handle_time,
               (SUM(Handle_Time) over (partition by d_date, uow_id)/60) as staff_hours,
               SUM(Handle_Time) over (partition by d_date, uow_id) as sum_ht,
               count(1) over (partition by d_date, uow_id) as count_ht
          from ht
          join pp_d_uow_source_ref usr
            on usr.source_ref_value = ht.task_type
           and usr.source_ref_detail_identifier='TASK ID' and usr.end_date >= sysdate
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

  END LOOP;
  INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script','Scheduled run to back-populate Handle Times and Staff Hours - Processed', SYSDATE); 
  COMMIT;


EXCEPTION
WHEN OTHERS 
  THEN 
    ROLLBACK;
    V_ERRCODE := SQLCODE;
    V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
    INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Script','Scheduled run to back-populate Handle Times and Staff Hours - Processed - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
      COMMIT; 
    RAISE;
END;




