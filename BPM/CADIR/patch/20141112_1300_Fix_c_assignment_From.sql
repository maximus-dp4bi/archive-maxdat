Declare
 v_str varchar2(250);
Begin

 v_str := 'Process Started'||to_char(sysdate,'mm/dd/yyyy hh:mi:ss');
 dbms_output.put_line(v_str); 

   -- Identify records where Assignment_From is duplicate     
 
   For I In ( select c_assignment_from , Tracking_id 
                from cadir_maxdat_stg 
              where 1=1 -- tracking_id = 57544453 
               and tracking_id not in (select tracking_id 
                                         from cadir_maxdat_stg 
                                        group by tracking_id, c_assignment_to
                                       having count(1) > 1  )
              group by tracking_id, c_assignment_from
              having count(1) > 1 )
    Loop
    
             For Fix_Rec in ( Select  Tracking_id, Assignment_Id, c_assignment_from, c_assignment_to,Prev_Assignment_ID, c_created_on, id
                                from 
                              (select Tracking_id, Assignment_Id, c_assignment_from, c_assignment_to
                                     , LAG(C_assignment_to, 1, 0) OVER (PARTITION BY tracking_id ORDER BY id NULLS LAST) Prev_Assignment_ID
                                     , c_created_on, id
                                from cadir_maxdat_stg
                               where c_assignment_from = I.C_ASSIGNMENT_FROM  ) a 
                              where a.prev_assignment_id <> 0
                               order by a.c_created_on, a.id
                              ) 
                              
             Loop
              
                 update cadir_maxdat_stg 
                    set  c_assignment_from = Fix_rec.Prev_Assignment_ID
                       , mw_processed = 'N'
                  where id = Fix_Rec.id ;
               
             v_str := 'TrackingID:'||Fix_Rec.Tracking_id||','||'Assignment_From:'||Fix_Rec.c_assignment_from||','||'Changed to:'||Fix_Rec.Prev_Assignment_ID;
             dbms_output.put_line(v_str);

              End loop;                 
    
     End loop;    
     
     Commit;
     
 v_str := 'Process Completed'||to_char(sysdate,'mm/dd/yyyy hh:mi:ss');
 dbms_output.put_line(v_str); 

  End;
  

  
  
  
