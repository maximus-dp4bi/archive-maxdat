DECLARE
V_ERRCODE varchar2(50);
V_ERRMSG varchar2(3000);

BEGIN
  
  INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script','Manual run to back-populate MW Inventory Avg Age for all UOW - Begin', SYSDATE); 
  COMMIT;
  FOR RECS IN 
    (
        with cal_usr as
        (
        select usr.usr_id, usr.uow_id, uow.age_days_type, uow.inv_avg_age
          from pp_d_uow_source_ref usr
          join pp_cfg_unit_of_work uow on uow.cfg_uow_id=usr.uow_id
         where usr.source_ref_detail_identifier in
               ('TASK ID', 'BATCH TYPE', 'BATCH CLASS')
           and usr.end_date > sysdate                                 
        ),
        cal_ad_all as
        (
        select dad_id, u.age_days_type,u.inv_avg_age,u.uow_id
          from pp_d_actual_details ad
          join cal_usr u on u.usr_id=ad.usr_id   
        ),
        cal_adv_w_age as 
        (
        select adv.dad_id,
               adv.d_date,
               adv.usr_id,
               ada.inv_avg_age,
               ada.uow_id,
               CASE
                     WHEN ada.age_days_type = 'BUS' THEN
                       BUS_DAYS_BETWEEN(min(adv.d_date) over(partition by adv.dad_id), adv.d_date)
                     ELSE
                       adv.d_date - min(adv.d_date) over(partition by adv.dad_id)
                END as age
          from pp_d_actual_details_sv adv
          join cal_ad_all ada on ada.dad_id=adv.dad_id
         where actual_inventory=1
        ),
        cal_adv_inv_avg_age as
        (
        select dad_id, d_date, cal_adv_w_age.usr_id, uow_id, 
        inv_avg_age,
        case when age > inv_avg_age then inv_avg_age
          else age
        end as age
        from cal_adv_w_age

        )
        select distinct d_date,
                        uow_id,
                        AVG(age) over(partition by d_date, uow_id) as avg_age,
                        MIN(age) over(partition by d_date, uow_id) as min_age,
                        MAX(age) over(partition by d_date, uow_id) as max_age,
                        STDDEV(age) over(partition by d_date, uow_id) as stddev_age,
                        MEDIAN(age) over(partition by d_date, uow_id) as median_age
          from cal_adv_inv_avg_age
) 
    LOOP
              UPDATE PP_F_ACTUALS
                 SET actl_inventory_age_avg=RECS.AVG_AGE,
                     actl_inventory_age_min=RECS.Min_Age,
                     actl_inventory_age_max=RECS.MAX_AGE,
                     actl_inventory_age_mean=RECS.AVG_AGE,
                     actl_inventory_age_median=RECS.MEDIAN_AGE,
                     actl_inventory_age_sd=RECS.STDDEV_AGE
               WHERE d_date=RECS.D_DATE and uow_id=RECS.UOW_ID;
               
               INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script',RECS.D_DATE || ' --- ' || RECS.UOW_ID , SYSDATE); 

  END LOOP;
  INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'LOG',SYSDATE,'PP_Actuals_Script','Manual run to back-populate MW Inventory Avg Age for all UOW - Processed', SYSDATE); 
  COMMIT;


EXCEPTION
WHEN OTHERS 
  THEN 
    ROLLBACK;
    V_ERRCODE := SQLCODE;
    V_ERRMSG := SUBSTR(SQLERRM, 1, 3000);                 
    INSERT INTO PP_STG_LOG
      (PP_STG_ID, LOG_TYPE, PROCESS_DATE, PROCESS, DESCRIPTION, CREATE_DATE)
      VALUES (SEQ_PP_STG_ID.NEXTVAL,'ERR',SYSDATE,'PP_Actuals_Script','Manual run to back-populate MW Inventory Avg Age for all UOW - Processed - ' || V_ERRCODE || ' : ' || V_ERRMSG,SYSDATE); 
      COMMIT; 
    RAISE;
END;

/



