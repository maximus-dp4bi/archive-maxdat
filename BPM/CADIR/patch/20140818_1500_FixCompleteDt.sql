DECLARE

PROCEDURE Fix_CompleteDt
IS
   v_Stage  cadir_maxdat_stg%ROWTYPE;
   v_Name   VARCHAR2(50);
   v_RoleName  VARCHAR2(50);   
   v_Check  NUMBER;
   v_Error varchar2(4000) ;

BEGIN

   FOR CycRow IN (select task_id , create_date, cemw_id
                    from corp_etl_manage_work mw, cadir_maxdat_stg ms1 
                   where complete_date is not null 
                     and ms1.assignment_id = mw.task_id 
                     and not exists (select 1 from cadir_maxdat_stg ms 
                                      where ms.tracking_id = mw.source_reference_id 
                                       and ms.id > ms1.id 
                                       and ms.subject_type = 2)
                  )
   LOOP
      BEGIN

             UPDATE corp_etl_manage_work
                SET task_status         = 'UNCLAIMED'
                  , complete_date       = NULL
                  , instance_status     = 'Active'
                  , instance_end_date   = NULL
                  , asf_complete_work   = 'N'
                  , complete_flag       = 'N'
             WHERE cemw_id = CycRow.cemw_id;
             
             -- Insert into temp table to process records 
             INSERT INTO corp_etl_manage_work_tmp
              SELECT T.*,NULL FROM corp_etl_manage_work T WHERE cemw_id = CycRow.cemw_id;             
              
             COMMIT; 

      EXCEPTION
         WHEN Others THEN
            v_Error := SQLERRM ;
            INSERT INTO corp_etl_error_log (process_name,job_name,error_desc,error_codes)
                   VALUES ('Fix_CompleteDt','CADIR MW', v_Error, CycRow.task_id);
      END;

   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Fix_CompleteDt', 'CADIR MW', v_Error);
      COMMIT;
END Fix_CompleteDt;

BEGIN

-- Delete error records from event queue 
delete from bpm_update_event_queue where bueq_id in (5024340,5745774,5772151)
and trunc(event_date) < trunc(sysdate) ;

Commit;

--- Init Proc , clear temp table 
begin

   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'InitProc');   commit;

   MAXDAT_CADR.cadir_etl_manage_work_pkg.InitProcess;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;

end;

-- Fix complete date in corp_etl_manage_work table and populate temp table to process records.

Fix_CompleteDt;

--------------- upd2_10
   
begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'Upd2_10');
   commit;

   MAXDAT_CADR.cadir_etl_manage_work_pkg.Upd2_10;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
end;

---------  lc_Upd3_10A

begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'Upd3_10A');
   commit;

   MAXDAT_CADR.cadir_etl_manage_work_pkg.Upd3_10A;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
end;

----- lc_Upd3_10B

begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'Upd3_10B');
   commit;

   MAXDAT_CADR.cadir_etl_manage_work_pkg.Upd3_10B;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
end;

----- upd3_10C

begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'Upd3_10C');
   commit;

   MAXDAT_CADR.cadir_etl_manage_work_pkg.Upd3_10C;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
end;

----- Upd6_10

begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'Upd6_10');
   commit;

   MAXDAT_CADR.cadir_etl_manage_work_pkg.Upd6_10;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
end;

---- UpdateMW 

begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'UpdateMW');
   commit;

   MAXDAT_CADR.cadir_etl_manage_work_pkg.UpdateMW;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
   
end;

END;
/
