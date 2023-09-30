DECLARE
 I number := 0;
BEGIN

DBMS_OUTPUT.PUT_LINE ( 'Process Started at : ' || to_char(sysdate,'mm/dd/yyyy HH24:Mi:ss AM') );

/* Identify records that need to be  fixed  */

For Def_Cur in ( Select Assignment_id, Tracking_ID
                  From Cadir_Maxdat_Stg MS
                 Inner Join cadir_role_stg RS  ON RS.role_id = MS.role_id
                 Where MS.c_assigned_Date is null  
                   And MS.subject_type = 2
                   And RS.name <> 'Closed Cases Queue'
                 ) 
LOOP

  delete from BPM_UPDATE_EVENT_QUEUE where identifier = to_char(Def_Cur.Assignment_Id);
  delete from BPM_UPDATE_EVENT_QUEUE_ARCHIVE where identifier = to_char(Def_Cur.Assignment_Id);
  delete from f_mw_by_date where mw_bi_id in ( select mw_bi_id from d_mw_current where "Task ID" = Def_Cur.Assignment_Id);
  delete from d_mw_current where "Task ID"= Def_Cur.Assignment_Id;
  delete from Corp_Etl_Manage_Work where Task_ID = Def_Cur.Assignment_Id;
  update cadir_maxdat_stg set mw_processed = 'N' where Assignment_id = Def_Cur.Assignment_Id;
  
  I := I + 1;
  
  IF I > 1000 THEN 
    Commit;
    I := 0;
  END IF;


END LOOP;                 
COMMIT;   
DBMS_OUTPUT.PUT_LINE ( 'Process Ended at : ' || to_char(sysdate,'mm/dd/yyyy HH24:Mi:ss AM') );   
   
END;
/