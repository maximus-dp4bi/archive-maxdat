DECLARE
V_ERRCODE varchar2(50);
V_ERRMSG varchar2(3000);

BEGIN
  FOR RECS IN 
    (
       with usr as
         (select uow_id, usr_id from pp_d_uow_source_ref_sv)
        ,f as
        (
         select actuals_id, d_date, uow_id from pp_f_actuals
        )
        , results as
        (
        select ad.D_DATE, u.UOW_ID, count(1) as INVENTORY
          from pp_d_actual_details_sv ad
         inner join usr u
            on u.usr_id = ad.USR_ID
         where ad.actual_inventory = 1
         group by ad.d_date, u.uow_id
         order by ad.d_date, u.uow_id
        )
        select RESULTS.D_DATE, RESULTS.UOW_ID, RESULTS.INVENTORY, f.ACTUALS_ID from results 
        inner join f on results.d_date=f.d_date and results.uow_id=f.uow_id
    ) 
    LOOP
              UPDATE PP_F_ACTUALS
                 SET ACTL_INVENTORY=RECS.INVENTORY
               WHERE ACTUALS_ID=RECS.ACTUALS_ID;
               
               INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script',RECS.ACTUALS_ID || ' --- ' || RECS.INVENTORY , SYSDATE); 

  END LOOP;
  INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script','Manual run to back-populate MW Inventory counts for all UOW - Processed', SYSDATE); 
  COMMIT;


EXCEPTION
WHEN OTHERS 
  THEN 
    ROLLBACK;
    V_ERRCODE := SQLCODE;
    V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
    INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Script','Manual run to back-populate MW Inventory counts for all UOW - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
      COMMIT; 
    RAISE;
END;

/
