BEGIN

--- Init Proc
begin

   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'InitProc');   commit;

   MAXDAT_CADR.cadir_etl_manage_work_pkg.InitProcess;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;

end;
   
--------------- lc_Ins_1
   
begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'INS_1');
   commit;

   MAXDAT_CADR.cadir_etl_manage_work_pkg.Ins_1;

   MAXDAT_CADR.Maxdat_Statistics.TABLE_STATS('CORP_ETL_MANAGE_WORK');

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
end;   
   
--------------- lc_upd2_10
   
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