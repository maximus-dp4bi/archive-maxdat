Declare
 v_str varchar2(250);
Begin

 v_str := 'Process Started'||to_char(sysdate,'mm/dd/yyyy hh:mi:ss');
 dbms_output.put_line(v_str); 

   -- Identify records where Assignment_From is duplicate     
 
   For I In ( select Source_reference_id Tracking_id, task_id
                from corp_etl_manage_work a
               where Source_Reference_Type='TRACKING_ID'
                 and Complete_Date is null
                 --and Source_Reference_ID = 94144458
                 and exists (select 1 from corp_etl_manage_Work a2
                              where a.Source_Reference_ID = a2.Source_Reference_ID
                                and a.Task_ID < a2.Task_ID
                                and Source_Reference_Type='TRACKING_ID')
                   )
    Loop
      
             -- Most of the cases are fixed with this logic
    
             For Fix_Rec in ( Select  Tracking_id, Assignment_Id, c_assignment_from, c_assignment_to, Next_ID, c_created_on, id
                                      ,old_Assignment_from
                                from 
                                      (select Tracking_id, Assignment_Id, c_assignment_from, c_assignment_to
                                            , LAG(ID, 1, 0) OVER  (PARTITION BY tracking_id ORDER BY id NULLS LAST) Prev_ID
                                            , LEAD(ID, 1, 0) OVER (PARTITION BY tracking_id ORDER BY id NULLS LAST) Next_ID
                                            , LEAD(C_assignment_from, 1, 0) OVER (PARTITION BY tracking_id ORDER BY id NULLS LAST) old_Assignment_from                                            
                                            , c_created_on, id
                                        from cadir_maxdat_stg
                                       where tracking_id  = I.Tracking_Id  ) a 
                               --where a.assignment_id = I.Task_Id
                               where a.assignment_id <> old_assignment_from
                                 and old_assignment_from <> 0
                               order by a.c_created_on, a.id  
                              ) 
                              
             Loop
              
                 update cadir_maxdat_stg 
                    set c_assignment_from = Fix_Rec.Assignment_Id
                       , mw_processed = 'N'
                  where id = Fix_Rec.Next_Id 
                  ;
               
             v_str := 'TrackingID:'||Fix_Rec.Tracking_id||','||'Assignment_From:'||Fix_Rec.old_assignment_from||','||'Changed to:'||Fix_Rec.Assignment_Id ||','||' For ID :'||Fix_Rec.Next_Id;
             dbms_output.put_line(v_str);

              End loop;                 

     End loop;    
     
     Commit;
     
 v_str := 'Process Completed'||to_char(sysdate,'mm/dd/yyyy hh:mi:ss');
 dbms_output.put_line(v_str); 

  End;
  

  
  
  
