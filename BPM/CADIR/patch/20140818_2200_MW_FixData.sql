Declare
v_mw_bi_id number;
v_task_id number;

Begin

delete from corp_etl_manage_work_tmp ; commit;

For I in ( select Assignment_id task_id 
            from cadir_maxdat_stg 
            where assignment_id in ( select task_id 
                                       from corp_etl_manage_work 
                                      where complete_date is null and stage_done_Date is not null)
         )   
Loop
 v_task_id := I.task_id;
 begin
   select mw_bi_id into v_mw_bi_id from d_mw_current where "Task ID" = v_task_id;
 exception
 when others then
   v_mw_bi_id := null;
 end;  
 
 IF v_mw_bi_id is not null Then
    delete from f_mw_by_date where mw_bi_id = v_mw_bi_id;
    delete from d_mw_current where "Task ID" = I.task_id;
 END IF;
    
 delete from bpm_update_event_queue_archive where IDENTIFIER = to_char(v_Task_id);
 
 delete from corp_etl_manage_work where task_id = v_task_id;

   INSERT INTO corp_etl_manage_work (
           create_date
         , created_by_name
         , group_name
         , last_update_by_name
         , last_update_date
         , source_reference_id
         , source_reference_type
         , status_date
         , task_id
         , task_status
         , task_type
         , team_name
         , stg_extract_date
         , stg_last_update_date
         , case_number
         , channel
         , instance_status
         , instance_start_date
         , received_date
         , assigned_date
         , cancel_work_flag
         , complete_flag
         , task_priority
         , forwarded_by_name
         , forwarded_flag
         )
      SELECT
           MS.assignment_date
         , cadir_etl_manage_work_pkg.Get_Person_Name(MS.c_created_by) 
         , RS.name
         , cadir_etl_manage_work_pkg.Get_Person_Name(MS.c_created_by) 
         , MS.assignment_date
         , MS.tracking_id
         , 'TRACKING_ID'
         , MS.assignment_date
         , MS.assignment_id
         , 'UNCLAIMED'
         , RS.NAME
         , 'UNASSIGNED'
         , SYSDATE
         , SYSDATE
         , MS.c_case_number
         , 'Appeal Type'
         , 'Active'
         , MS.assignment_date
         , MS.c_received_date
         , NVL(MS.c_assigned_date, MS.assignment_date)
         , 'N'
         , 'N'
         , TS.c_name
         , NULL
         , 'N'
      FROM  cadir_maxdat_stg          MS
      INNER JOIN cadir_role_stg       RS  ON RS.role_id = MS.role_id
      LEFT OUTER JOIN cadir_claim_type_stg TS  ON TS.id = MS.c_claim_type0
      LEFT OUTER JOIN (select value, out_var as sla_days_type from corp_etl_list_lkup  where name = 'ManageWork_SLA_Days_Type') SLA_TYPE
                       on  SLA_TYPE.value =  RS.name
      LEFT OUTER JOIN (select value, out_var as sla_days from corp_etl_list_lkup  where name = 'ManageWork_SLA_Days') SLA_DAYS
                       on  SLA_DAYS.value =  RS.name
      LEFT OUTER JOIN (select value, out_var as sla_jeopardy_days from corp_etl_list_lkup  where name = 'ManageWork_SLA_Jeopardy_Days') SLA_JEOPARDY
                       on  SLA_JEOPARDY.value =  RS.name
      LEFT OUTER JOIN (select value, out_var as sla_target_days from corp_etl_list_lkup  where name = 'ManageWork_SLA_Target_Days') SLA_TARGET
                       on  SLA_TARGET.value =  RS.name

      WHERE MS.data_object_key = 'T_IMR'
        AND MS.subject_type = 2
        AND RS.name <> 'Closed Cases Queue'
        AND MS.Assignment_ID = v_TASK_ID
        AND NOT EXISTS (SELECT 1 FROM corp_etl_manage_work MW WHERE MW.task_id = MS.assignment_id)
      ORDER BY MS.id;

   INSERT INTO corp_etl_manage_work_tmp
      SELECT T.*,NULL FROM corp_etl_manage_work T 
       WHERE task_id = v_TASK_ID   
       AND NOT EXISTS (SELECT 1 FROM corp_etl_manage_work_tmp T1 WHERE T1.task_id = T.Task_ID);

End Loop;

  cadir_etl_manage_work_pkg.Upd2_10;
  cadir_etl_manage_work_pkg.Upd3_10A;
  cadir_etl_manage_work_pkg.Upd3_10B;
  cadir_etl_manage_work_pkg.Upd3_10C;
  cadir_etl_manage_work_pkg.Upd6_10;
  cadir_etl_manage_work_pkg.UpdateMW;

END;
/