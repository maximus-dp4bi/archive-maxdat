--process 1
DECLARE  
  CURSOR temp_cur IS
  select o.outreach_id,o.create_dt ased_outreach_step1, o.create_dt assd_outreach_step2,o.create_dt ased_outreach_step2,'MAXDAT' aspb_outreach_step2,
  'System,LetterRequestsJob' aspb_outreach_step1,
  o.create_dt assd_outreach_step3,
 CASE WHEN outreach_status = 'Outreach Successful' THEN 'N' ELSE 'Y' END gwf_unsuccessful,
 coalesce((select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type ='Basic Script Delivered'),ased_perform_outreach) ased_outreach_step3,
 coalesce((select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type ='Basic Script Delivered'),aspb_perform_outreach) aspb_outreach_step3
 from (
select outreach_id,delay_days1,create_dt,delay_days1_unit,OUTREACH_STEP2_TYPE,outreach_status,ased_perform_outreach,aspb_perform_outreach
 from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and outreach_step2_type is not null
and assd_outreach_step2 is null
and ased_outreach_step1 is null
and generic_field2  = 'OUTREACH_REQUEST_1'
and outreach_status in ('Outreach Successful','Outreach Unsuccessful')
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
) o;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set ased_outreach_step1 =  temp_tab(indx).ased_outreach_step1  
               ,aspb_outreach_step1 = temp_tab(indx).aspb_outreach_step1  
               ,assd_outreach_step2 = temp_tab(indx).assd_outreach_step2
               ,ased_outreach_step2 = temp_tab(indx).ased_outreach_step2
               ,aspb_outreach_step2 = temp_tab(indx).aspb_outreach_step2  
               ,assd_outreach_step3 = temp_tab(indx).ased_outreach_step2
               ,ased_outreach_step3 = temp_tab(indx).ased_outreach_step3
               ,aspb_outreach_step3 = temp_tab(indx).aspb_outreach_step3
               ,gwf_step2_required = 'Y'
               ,gwf_step3_required = 'Y'
               ,gwf_unsuccessful = temp_tab(indx).gwf_unsuccessful
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
  select o.outreach_id, assd_outreach_step3 ased_outreach_step2,'MAXDAT' aspb_outreach_step2, assd_outreach_step3 ased_outreach_step3,
  CASE WHEN outreach_status = 'Outreach Successful' THEN 'N' ELSE 'Y' END gwf_unsuccessful 
  ,aspb_outreach_step3
 from (
select outreach_id,delay_days1,create_dt,delay_days1_unit,OUTREACH_STEP2_TYPE,outreach_status,ased_perform_outreach,aspb_perform_outreach,
  coalesce((select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type ='Basic Script Delivered'),ased_perform_outreach) assd_outreach_step3,
 coalesce((select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type ='Basic Script Delivered'),aspb_perform_outreach) aspb_outreach_step3
 from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and assd_outreach_step2 is not null
and ased_outreach_step2 is null
and ased_perform_outreach is not null
and generic_field2  = 'OUTREACH_REQUEST_1'
and outreach_status in ('Outreach Successful','Outreach Unsuccessful')
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
) o;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set ased_outreach_step2 = temp_tab(indx).ased_outreach_step2
               ,aspb_outreach_step2 = temp_tab(indx).aspb_outreach_step2  
               ,assd_outreach_step3 = temp_tab(indx).ased_outreach_step2
               ,ased_outreach_step3 = temp_tab(indx).ased_outreach_step3
               ,aspb_outreach_step3 = temp_tab(indx).aspb_outreach_step3
               ,gwf_step2_required = 'Y'
               ,gwf_step3_required = 'Y'
               ,gwf_unsuccessful = temp_tab(indx).gwf_unsuccessful
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
  select o.outreach_id, ased_perform_outreach ased_outreach_step3,
  CASE WHEN outreach_status = 'Outreach Successful' THEN 'N' ELSE 'Y' END gwf_unsuccessful 
  ,aspb_perform_outreach aspb_outreach_step3
 from (
select outreach_id,outreach_status,ased_perform_outreach,aspb_perform_outreach
  from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and assd_outreach_step3 is not null
and ased_outreach_step3 is null
and ased_perform_outreach is not null
and generic_field2  = 'OUTREACH_REQUEST_1'
and outreach_status in ('Outreach Successful','Outreach Unsuccessful')
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
) o;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set ased_outreach_step3 = temp_tab(indx).ased_outreach_step3
               ,aspb_outreach_step3 = temp_tab(indx).aspb_outreach_step3
               ,gwf_step3_required = 'Y'
               ,gwf_unsuccessful = temp_tab(indx).gwf_unsuccessful
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/


--process 7
DECLARE  
  CURSOR temp_cur IS
  select o.outreach_id,o.create_dt,o.ased_outreach_step1, o.ased_outreach_step1 assd_outreach_step2,aspb_outreach_step1,'MAXDAT' aspb_outreach_step2,
CASE WHEN OUTREACH_STEP2_TYPE = 'Delay1' THEN
   CASE WHEN DELAY_DAYS1_UNIT LIKE '%CAL%'
      THEN 
            (CASE WHEN TRUNC(SYSDATE) - TRUNC(ased_outreach_step1) >= DELAY_DAYS1 
            THEN LEAST(TRUNC(ased_outreach_step1) + DELAY_DAYS1, TRUNC(SYSDATE))
            ELSE NULL
            END)
      WHEN DELAY_DAYS1_UNIT LIKE '%BUS%'
         THEN   CASE WHEN BUS_DAYS_BETWEEN(TRUNC(ased_outreach_step1),TRUNC(SYSDATE)) >= DELAY_DAYS1 
           THEN LEAST(GET_BUS_DATE(TRUNC(ased_outreach_step1),DELAY_DAYS1),TRUNC(SYSDATE))
           ELSE NULL
            END
           END 
 ELSE NULL END AS ased_outreach_step2,
 CASE WHEN outreach_status = 'Outreach Successful' THEN 'N' ELSE 'Y' END gwf_unsuccessful,
 (select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type in('Outreach Request - Letter Request has been created.','Manual Action')) ased_outreach_step3,
 (select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type in('Outreach Request - Letter Request has been created.','Manual Action')) aspb_outreach_step3
 from (
select outreach_id,delay_days1,create_dt,delay_days1_unit,OUTREACH_STEP2_TYPE,outreach_status,ased_perform_outreach,
 (select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type = 'Consumer selected for Outbound Dialer') ased_outreach_step1,
 (select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type = 'Consumer selected for Outbound Dialer') aspb_outreach_step1
from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and outreach_step2_type is not null
and assd_outreach_step2 is null
and ased_outreach_step1 is null
and generic_field2  = 'OUTREACH_REQUEST_7'
and outreach_status in ('Outreach Successful','Outreach Unsuccessful')
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
) o;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set ased_outreach_step1 =  temp_tab(indx).ased_outreach_step1  
               ,aspb_outreach_step1 = temp_tab(indx).aspb_outreach_step1  
               ,assd_outreach_step2 = temp_tab(indx).assd_outreach_step2
               ,ased_outreach_step2 = temp_tab(indx).ased_outreach_step2
               ,aspb_outreach_step2 = temp_tab(indx).aspb_outreach_step2  
               ,assd_outreach_step3 = temp_tab(indx).ased_outreach_step2
               ,ased_outreach_step3 = temp_tab(indx).ased_outreach_step3
               ,aspb_outreach_step3 = temp_tab(indx).aspb_outreach_step3
               ,gwf_step2_required = 'Y'
               ,gwf_step3_required = 'Y'
               ,gwf_unsuccessful = temp_tab(indx).gwf_unsuccessful
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS  
  select outreach_id,delay_days1,create_dt,delay_days1_unit,OUTREACH_STEP2_TYPE,outreach_status,ased_perform_outreach,aspb_perform_outreach 
 from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and assd_outreach_step2 is not null
and ased_outreach_step2 is null
and ased_perform_outreach is not null
and generic_field2  = 'OUTREACH_REQUEST_7'
and outreach_status = 'Outreach Successful'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set  ased_outreach_step2 = temp_tab(indx).ased_perform_outreach
               ,aspb_outreach_step2 = temp_tab(indx).aspb_perform_outreach
               ,gwf_step2_required = 'Y'
               ,asf_outreach_step2 = 'Y'
               ,assd_outreach_step3 = temp_tab(indx).ased_perform_outreach
               ,ased_outreach_step3 = temp_tab(indx).ased_perform_outreach
               ,aspb_outreach_step3 = temp_tab(indx).aspb_perform_outreach
               ,gwf_step3_required = 'Y'
               ,asf_outreach_step3 = 'Y'
               ,gwf_unsuccessful = 'N'
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS  
  select outreach_id,delay_days1,create_dt,delay_days1_unit,OUTREACH_STEP2_TYPE,outreach_status,ased_perform_outreach,aspb_perform_outreach 
 from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and assd_outreach_step3 is not null
and ased_outreach_step3 is null
and ased_perform_outreach is not null
and generic_field2  = 'OUTREACH_REQUEST_7'
and outreach_status = 'Outreach Successful'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set  ased_outreach_step3 = temp_tab(indx).ased_perform_outreach
               ,aspb_outreach_step3 = temp_tab(indx).aspb_perform_outreach
               ,gwf_step3_required = 'Y'
               ,asf_outreach_step3 = 'Y'
               ,gwf_unsuccessful = 'N'
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/


--process 3 and 5

DECLARE  
  CURSOR temp_cur IS
  select outreach_id,ased_perform_outreach ased_outreach_step1, aspb_perform_outreach aspb_outreach_step1, 'N' gwf_unsuccessful
  from corp_etl_clnt_outreach
where instance_status = 'Complete'
and assd_outreach_step1 is not null
and ased_outreach_step1 is null
and ased_perform_outreach is not null
and generic_field2 in('OUTREACH_REQUEST_5','OUTREACH_REQUEST_3')
and outreach_status = 'Outreach Successful'--in ('Outreach Successful','Outreach Unsuccessful')
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set ased_outreach_step1 =  temp_tab(indx).ased_outreach_step1  
               ,aspb_outreach_step1 = temp_tab(indx).aspb_outreach_step1                 
               ,gwf_unsuccessful = temp_tab(indx).gwf_unsuccessful
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
  select outreach_id,ased_perform_outreach
  from corp_etl_clnt_outreach
  where instance_status = 'Complete' 
  and generic_field2 = 'OUTREACH_REQUEST_5'
  and outreach_status = 'Letter Requested'
  and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set outreach_status = 'Outreach Successful'
               ,outreach_status_dt = temp_tab(indx).ased_perform_outreach 
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

-- process 2
DECLARE  
  CURSOR temp_cur IS
  select o.outreach_id,o.create_dt ased_outreach_step1, o.create_dt assd_outreach_step2,o.create_dt ased_outreach_step2,'MAXDAT' aspb_outreach_step2,
  'System,LetterRequestsJob' aspb_outreach_step1,
  o.create_dt assd_outreach_step3,
  ased_outreach_step3,
  aspb_outreach_step3,
  ased_outreach_step3 assd_outreach_step4,
  ased_perform_outreach ased_outreach_step4,
  aspb_outreach_step3 aspb_outreach_step4,
  'N'  gwf_unsuccessful
 from (
select outreach_id,delay_days1,create_dt,delay_days1_unit,OUTREACH_STEP2_TYPE,outreach_status,ased_perform_outreach,aspb_perform_outreach
  , coalesce((select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type ='HCO Script Delivered'),ased_perform_outreach) ased_outreach_step3,
 coalesce((select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type ='HCO Script Delivered'),aspb_perform_outreach) aspb_outreach_step3
 from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and assd_outreach_step1 is not null
and ased_outreach_step1 is null
and ased_perform_outreach is not null
and generic_field2  = 'OUTREACH_REQUEST_2'
and outreach_status = 'Outreach Successful'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
) o;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set ased_outreach_step1 =  temp_tab(indx).ased_outreach_step1  
               ,aspb_outreach_step1 = temp_tab(indx).aspb_outreach_step1  
               ,assd_outreach_step2 = temp_tab(indx).assd_outreach_step2
               ,ased_outreach_step2 = temp_tab(indx).ased_outreach_step2
               ,aspb_outreach_step2 = temp_tab(indx).aspb_outreach_step2  
               ,assd_outreach_step3 = temp_tab(indx).assd_outreach_step3
               ,ased_outreach_step3 = temp_tab(indx).ased_outreach_step3
               ,aspb_outreach_step3 = temp_tab(indx).aspb_outreach_step3
               ,assd_outreach_step4 = temp_tab(indx).assd_outreach_step4
               ,ased_outreach_step4 = temp_tab(indx).ased_outreach_step4
               ,aspb_outreach_step4 = temp_tab(indx).aspb_outreach_step4
               ,gwf_step2_required = 'Y'
               ,gwf_step3_required = 'Y'
               ,gwf_step4_required = 'Y'
               ,gwf_unsuccessful = temp_tab(indx).gwf_unsuccessful
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
  select o.outreach_id,ased_outreach_step2,'MAXDAT' aspb_outreach_step2,  
  ased_outreach_step2 assd_outreach_step3,
  ased_outreach_step2 ased_outreach_step3,
  aspb_outreach_step3,
  ased_outreach_step2 assd_outreach_step4,
  ased_perform_outreach ased_outreach_step4,
  aspb_outreach_step3 aspb_outreach_step4,
  'N'  gwf_unsuccessful
 from (
select outreach_id,delay_days1,create_dt,delay_days1_unit,OUTREACH_STEP2_TYPE,outreach_status,ased_perform_outreach,aspb_perform_outreach
  , coalesce((select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type ='HCO Script Delivered'),ased_perform_outreach) ased_outreach_step2,
 coalesce((select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type ='HCO Script Delivered'),aspb_perform_outreach) aspb_outreach_step3
 from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and assd_outreach_step2 is not null
and ased_outreach_step2 is null
and ased_perform_outreach is not null
and generic_field2  = 'OUTREACH_REQUEST_2'
and outreach_status = 'Outreach Successful'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
) o;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set  ased_outreach_step2 = temp_tab(indx).ased_outreach_step2
               ,aspb_outreach_step2 = temp_tab(indx).aspb_outreach_step2  
               ,assd_outreach_step3 = temp_tab(indx).assd_outreach_step3
               ,ased_outreach_step3 = temp_tab(indx).ased_outreach_step3
               ,aspb_outreach_step3 = temp_tab(indx).aspb_outreach_step3
               ,assd_outreach_step4 = temp_tab(indx).assd_outreach_step4
               ,ased_outreach_step4 = temp_tab(indx).ased_outreach_step4
               ,aspb_outreach_step4 = temp_tab(indx).aspb_outreach_step4
               ,gwf_step2_required = 'Y'
               ,gwf_step3_required = 'Y'
               ,gwf_step4_required = 'Y'
               ,gwf_unsuccessful = temp_tab(indx).gwf_unsuccessful
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/
DECLARE  
  CURSOR temp_cur IS
  select o.outreach_id,  
  ased_outreach_step3,
  aspb_outreach_step3,
  ased_outreach_step3 assd_outreach_step4,
  ased_perform_outreach ased_outreach_step4,
  aspb_outreach_step3 aspb_outreach_step4,
  'N'  gwf_unsuccessful
 from (
select outreach_id,delay_days1,create_dt,delay_days1_unit,OUTREACH_STEP2_TYPE,outreach_status,ased_perform_outreach,aspb_perform_outreach
  , coalesce((select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type ='HCO Script Delivered'),ased_perform_outreach) ased_outreach_step3,
 coalesce((select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type ='HCO Script Delivered'),aspb_perform_outreach) aspb_outreach_step3
 from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and assd_outreach_step3 is not null
and ased_outreach_step3 is null
and ased_perform_outreach is not null
and generic_field2  = 'OUTREACH_REQUEST_2'
and outreach_status = 'Outreach Successful'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
) o;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set  ased_outreach_step3 = temp_tab(indx).ased_outreach_step3
               ,aspb_outreach_step3 = temp_tab(indx).aspb_outreach_step3
               ,assd_outreach_step4 = temp_tab(indx).assd_outreach_step4
               ,ased_outreach_step4 = temp_tab(indx).ased_outreach_step4
               ,aspb_outreach_step4 = temp_tab(indx).aspb_outreach_step4               
               ,gwf_step3_required = 'Y'
               ,gwf_step4_required = 'Y'
               ,gwf_unsuccessful = temp_tab(indx).gwf_unsuccessful
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/
DECLARE  
  CURSOR temp_cur IS
  select o.outreach_id,   
  ased_perform_outreach ased_outreach_step4,
  aspb_perform_outreach aspb_outreach_step4,
  'N'  gwf_unsuccessful
 from (
select outreach_id,delay_days1,create_dt,delay_days1_unit,OUTREACH_STEP2_TYPE,outreach_status,ased_perform_outreach,aspb_perform_outreach 
 from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and assd_outreach_step4 is not null
and ased_outreach_step4 is null
and ased_perform_outreach is not null
and generic_field2  = 'OUTREACH_REQUEST_2'
and outreach_status = 'Outreach Successful'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
) o;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set  ased_outreach_step4 = temp_tab(indx).ased_outreach_step4
               ,aspb_outreach_step4 = temp_tab(indx).aspb_outreach_step4                              
               ,gwf_step4_required = 'Y'
               ,gwf_unsuccessful = temp_tab(indx).gwf_unsuccessful
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

update corp_etl_clnt_outreach
set asf_outreach_step1 = 'Y'
where instance_status = 'Complete'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
and ased_outreach_step1 is not null
and asf_outreach_step1 = 'N';

update corp_etl_clnt_outreach
set asf_outreach_step2 = 'Y'
where instance_status = 'Complete'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
and ased_outreach_step2 is not null
and asf_outreach_step2 = 'N';

update corp_etl_clnt_outreach
set asf_outreach_step3 = 'Y'
where instance_status = 'Complete'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
and ased_outreach_step3 is not null
and asf_outreach_step3 = 'N';

update corp_etl_clnt_outreach
set asf_outreach_step4 = 'Y'
where instance_status = 'Complete'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
and ased_outreach_step4 is not null
and asf_outreach_step4 = 'N';

-- process 11
update corp_etl_clnt_outreach
 set curr_Task_id = 211150712
     ,curr_task_status = 'TERMINATED'
     ,curr_task_type = 'Extra Effort Referral'
 where outreach_id = 49832004;
 
 update corp_etl_clnt_outreach
 set curr_Task_id = 211150706
     ,curr_task_status = 'TERMINATED'
     ,curr_task_type = 'Extra Effort Referral'
 where outreach_id = 49832000;
 
 update corp_etl_clnt_outreach
 set curr_task_status = 'TERMINATED'
 WHERE outreach_id in(46938453,
46942496,
46942333,
46942777,
46943587,
46943574,
46943581,
46941833,
46942774,
48420505,
48420520,
48925849,
48925794,
48925844,
48925852,
48925854,
48925799,
49753620,
49753624,
49753637,
49832004,
49832000,
49865271,
49865273,
51125532,
51125527,
51164286)
and curr_task_status != 'TERMINATED';
 
 update corp_etl_clnt_outreach
           set ased_outreach_step1 =  ased_perform_outreach  
               ,aspb_outreach_step1 = aspb_perform_outreach
               ,asf_outreach_step1 = 'Y'
               ,assd_outreach_step2 = ased_perform_outreach  
               ,ased_outreach_step2 = ased_perform_outreach  
               ,aspb_outreach_step2 = aspb_perform_outreach  
               ,asf_outreach_step2 = 'Y'
               ,assd_outreach_step3 = ased_perform_outreach  
               ,ased_outreach_step3 = ased_perform_outreach  
               ,aspb_outreach_step3 = aspb_perform_outreach  
               ,asf_outreach_step3 = 'Y'
               ,gwf_step2_required = 'Y'
               ,gwf_step3_required = 'Y'
               ,gwf_unsuccessful = 'N'         
WHERE outreach_id in(46938453,
46942496,
46942333,
46942777,
46943587,
46943574,
46943581,
46941833,
46942774,
48420505,
48420520,
48925849,
48925794,
48925844,
48925852,
48925854,
48925799,
49753620,
49753624,
49753637,
49832004,
49832000,
49865271,
49865273,
51125532,
51125527,
51164286); 

update corp_etl_clnt_outreach
set curr_Task_Status = 'TERMINATED'
where outreach_id  in(48488036,48487641);


commit;

--process 6
DECLARE  
  CURSOR temp_cur IS
  select o.outreach_id, ased_outreach_step1, aspb_outreach_step1, ased_outreach_step1 assd_outreach_step2, 'MAXDAT' aspb_outreach_step2,
     LEAST( CASE WHEN OUTREACH_STEP2_TYPE = 'Delay1' THEN
   CASE WHEN DELAY_DAYS1_UNIT LIKE '%CAL%'
      THEN 
            (CASE WHEN TRUNC(SYSDATE) - TRUNC(ased_outreach_step1) >= DELAY_DAYS1 
            THEN LEAST(TRUNC(ased_outreach_step1) + DELAY_DAYS1, TRUNC(SYSDATE))
            ELSE NULL
            END)
      WHEN DELAY_DAYS1_UNIT LIKE '%BUS%'
         THEN   CASE WHEN BUS_DAYS_BETWEEN(TRUNC(ased_outreach_step1),TRUNC(SYSDATE)) >= DELAY_DAYS1 
           THEN LEAST(GET_BUS_DATE(TRUNC(ased_outreach_step1),DELAY_DAYS1),TRUNC(SYSDATE))
           ELSE NULL
            END
           END 
 ELSE NULL END ,ased_outreach_step3) ased_outreach_step2, LEAST( CASE WHEN OUTREACH_STEP2_TYPE = 'Delay1' THEN
   CASE WHEN DELAY_DAYS1_UNIT LIKE '%CAL%'
      THEN 
            (CASE WHEN TRUNC(SYSDATE) - TRUNC(ased_outreach_step1) >= DELAY_DAYS1 
            THEN LEAST(TRUNC(ased_outreach_step1) + DELAY_DAYS1, TRUNC(SYSDATE))
            ELSE NULL
            END)
      WHEN DELAY_DAYS1_UNIT LIKE '%BUS%'
         THEN   CASE WHEN BUS_DAYS_BETWEEN(TRUNC(ased_outreach_step1),TRUNC(SYSDATE)) >= DELAY_DAYS1 
           THEN LEAST(GET_BUS_DATE(TRUNC(ased_outreach_step1),DELAY_DAYS1),TRUNC(SYSDATE))
           ELSE NULL
            END
           END 
 ELSE NULL END ,ased_outreach_step3) assd_outreach_step3, ased_outreach_step3, aspb_outreach_step3,
     ased_outreach_step3 assd_outreach_step4, ased_outreach_step3 ased_outreach_step4, 'MAXDAT' aspb_outreach_step4,
     ased_outreach_step3 assd_outreach_step5, ased_outreach_step3 ased_outreach_step5, aspb_outreach_step3 aspb_outreach_step5,
     'N' gwf_unsuccessful 
 from (
select outreach_id,delay_days1,create_dt,delay_days1_unit,OUTREACH_STEP2_TYPE,outreach_status,ased_perform_outreach,aspb_perform_outreach,
 coalesce((select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_outcome = 'Success'),ased_perform_outreach) ased_outreach_step3,
 coalesce((select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_outcome = 'Success'),aspb_perform_outreach) aspb_outreach_step3,
 (select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type = 'Consumer selected for Outbound Dialer') ased_outreach_step1,
 (select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type = 'Consumer selected for Outbound Dialer') aspb_outreach_step1

 from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and assd_outreach_step1 is not null
and ased_outreach_step1 is null
and generic_field2  = 'OUTREACH_REQUEST_6'
and outreach_status = 'Outreach Successful'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
) o;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set ased_outreach_step1 =  temp_tab(indx).ased_outreach_step1  
               ,aspb_outreach_step1 = temp_tab(indx).aspb_outreach_step1  
               ,asf_outreach_step1 = 'Y'
               ,assd_outreach_step2 = temp_tab(indx).assd_outreach_step2
               ,ased_outreach_step2 = temp_tab(indx).ased_outreach_step2
               ,aspb_outreach_step2 = temp_tab(indx).aspb_outreach_step2  
               ,asf_outreach_step2 = 'Y'
               ,assd_outreach_step3 = temp_tab(indx).assd_outreach_step3
               ,ased_outreach_step3 = temp_tab(indx).ased_outreach_step3
               ,aspb_outreach_step3 = temp_tab(indx).aspb_outreach_step3
               ,asf_outreach_step3 = 'Y'
               ,assd_outreach_step4 = temp_tab(indx).assd_outreach_step4
               ,ased_outreach_step4 = temp_tab(indx).ased_outreach_step4
               ,aspb_outreach_step4 = temp_tab(indx).aspb_outreach_step4
               ,asf_outreach_step4 = 'Y'
               ,assd_outreach_step5 = temp_tab(indx).assd_outreach_step5
               ,ased_outreach_step5 = temp_tab(indx).ased_outreach_step5
               ,aspb_outreach_step5 = temp_tab(indx).aspb_outreach_step5
               ,asf_outreach_step5 = 'Y'
               ,gwf_step2_required = 'Y'
               ,gwf_step3_required = 'Y'
               ,gwf_step4_required = 'Y'
               ,gwf_step5_required = 'Y'
               ,gwf_unsuccessful = 'N'
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
  select o.outreach_id, 
     LEAST( CASE WHEN OUTREACH_STEP2_TYPE = 'Delay1' THEN
   CASE WHEN DELAY_DAYS1_UNIT LIKE '%CAL%'
      THEN 
            (CASE WHEN TRUNC(SYSDATE) - TRUNC(ased_outreach_step1) >= DELAY_DAYS1 
            THEN LEAST(TRUNC(ased_outreach_step1) + DELAY_DAYS1, TRUNC(SYSDATE))
            ELSE NULL
            END)
      WHEN DELAY_DAYS1_UNIT LIKE '%BUS%'
         THEN   CASE WHEN BUS_DAYS_BETWEEN(TRUNC(ased_outreach_step1),TRUNC(SYSDATE)) >= DELAY_DAYS1 
           THEN LEAST(GET_BUS_DATE(TRUNC(ased_outreach_step1),DELAY_DAYS1),TRUNC(SYSDATE))
           ELSE NULL
            END
           END 
 ELSE NULL END ,ased_outreach_step3) ased_outreach_step2, LEAST( CASE WHEN OUTREACH_STEP2_TYPE = 'Delay1' THEN
   CASE WHEN DELAY_DAYS1_UNIT LIKE '%CAL%'
      THEN 
            (CASE WHEN TRUNC(SYSDATE) - TRUNC(ased_outreach_step1) >= DELAY_DAYS1 
            THEN LEAST(TRUNC(ased_outreach_step1) + DELAY_DAYS1, TRUNC(SYSDATE))
            ELSE NULL
            END)
      WHEN DELAY_DAYS1_UNIT LIKE '%BUS%'
         THEN   CASE WHEN BUS_DAYS_BETWEEN(TRUNC(ased_outreach_step1),TRUNC(SYSDATE)) >= DELAY_DAYS1 
           THEN LEAST(GET_BUS_DATE(TRUNC(ased_outreach_step1),DELAY_DAYS1),TRUNC(SYSDATE))
           ELSE NULL
            END
           END 
 ELSE NULL END ,ased_outreach_step3) assd_outreach_step3, ased_outreach_step3, aspb_outreach_step3,
     ased_outreach_step3 assd_outreach_step4, ased_outreach_step3 ased_outreach_step4, 'MAXDAT' aspb_outreach_step4,
     ased_outreach_step3 assd_outreach_step5, ased_outreach_step5, aspb_outreach_step5,
     'N' gwf_unsuccessful 
 from (
select outreach_id,delay_days1,create_dt,delay_days1_unit,OUTREACH_STEP2_TYPE,outreach_status,ased_perform_outreach,aspb_perform_outreach, ased_outreach_step1,
coalesce((select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type = 'Outreach Request - Letter Request has been created.'),ased_perform_outreach) ased_outreach_step3,
 coalesce((select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type = 'Outreach Request - Letter Request has been created.'),aspb_perform_outreach) aspb_outreach_step3,
 coalesce((select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_outcome = 'Success'),ased_perform_outreach) ased_outreach_step5,
 coalesce((select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_outcome = 'Success'),aspb_perform_outreach) aspb_outreach_step5

 from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and assd_outreach_step2 is not null
and ased_outreach_step2 is null
and generic_field2  = 'OUTREACH_REQUEST_6'
and outreach_status = 'Outreach Successful'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
) o;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set  ased_outreach_step2 = temp_tab(indx).ased_outreach_step2               
               ,asf_outreach_step2 = 'Y'
               ,assd_outreach_step3 = temp_tab(indx).assd_outreach_step3
               ,ased_outreach_step3 = temp_tab(indx).ased_outreach_step3
               ,aspb_outreach_step3 = temp_tab(indx).aspb_outreach_step3
               ,asf_outreach_step3 = 'Y'
               ,assd_outreach_step4 = temp_tab(indx).assd_outreach_step4
               ,ased_outreach_step4 = temp_tab(indx).ased_outreach_step4
               ,aspb_outreach_step4 = temp_tab(indx).aspb_outreach_step4
               ,asf_outreach_step4 = 'Y'
               ,assd_outreach_step5 = temp_tab(indx).assd_outreach_step5
               ,ased_outreach_step5 = temp_tab(indx).ased_outreach_step5
               ,aspb_outreach_step5 = temp_tab(indx).aspb_outreach_step5
               ,asf_outreach_step5 = 'Y'
               ,gwf_step2_required = 'Y'
               ,gwf_step3_required = 'Y'
               ,gwf_step4_required = 'Y'
               ,gwf_step5_required = 'Y'
               ,gwf_unsuccessful = 'N'
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
  select o.outreach_id, 
      ased_outreach_step3, aspb_outreach_step3,
     ased_outreach_step3 assd_outreach_step4, ased_outreach_step3 ased_outreach_step4, 'MAXDAT' aspb_outreach_step4,
     ased_outreach_step3 assd_outreach_step5, ased_outreach_step5, aspb_outreach_step5,
     'N' gwf_unsuccessful 
 from (
select outreach_id,delay_days1,create_dt,delay_days1_unit,OUTREACH_STEP2_TYPE,outreach_status,ased_perform_outreach,aspb_perform_outreach, ased_outreach_step1,
coalesce((select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type = 'Outreach Request - Letter Request has been created.'),ased_perform_outreach) ased_outreach_step3,
 coalesce((select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type = 'Outreach Request - Letter Request has been created.'),aspb_perform_outreach) aspb_outreach_step3,
 coalesce((select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_outcome = 'Success'),ased_perform_outreach) ased_outreach_step5,
 coalesce((select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_outcome = 'Success'),aspb_perform_outreach) aspb_outreach_step5

 from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and assd_outreach_step3 is not null
and ased_outreach_step3 is null
and generic_field2  = 'OUTREACH_REQUEST_6'
and outreach_status = 'Outreach Successful'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
) o;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set  ased_outreach_step3 = temp_tab(indx).ased_outreach_step3
               ,aspb_outreach_step3 = temp_tab(indx).aspb_outreach_step3
               ,asf_outreach_step3 = 'Y'
               ,assd_outreach_step4 = temp_tab(indx).assd_outreach_step4
               ,ased_outreach_step4 = temp_tab(indx).ased_outreach_step4
               ,aspb_outreach_step4 = temp_tab(indx).aspb_outreach_step4
               ,asf_outreach_step4 = 'Y'
               ,assd_outreach_step5 = temp_tab(indx).assd_outreach_step5
               ,ased_outreach_step5 = temp_tab(indx).ased_outreach_step5
               ,aspb_outreach_step5 = temp_tab(indx).aspb_outreach_step5
               ,asf_outreach_step5 = 'Y'
               ,gwf_step3_required = 'Y'
               ,gwf_step4_required = 'Y'
               ,gwf_step5_required = 'Y'
               ,gwf_unsuccessful = 'N'
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/
--process 9
DECLARE  
  CURSOR temp_cur IS
  select o.outreach_id, 
      assd_outreach_step1 ased_outreach_step1,
      created_by aspb_outreach_step1,
      assd_outreach_step1 assd_outreach_step2,
     ased_outreach_step3 ased_outreach_step2, 'MAXDAT' aspb_outreach_step2,
     ased_outreach_step3 assd_outreach_step3,
     ased_outreach_step3, aspb_outreach_step3,
     ased_outreach_step3 assd_outreach_step4, 'MAXDAT' aspb_outreach_step4,
     ased_outreach_step5 ased_outreach_step4,
     ased_outreach_step5 assd_outreach_step5,     
     ased_outreach_step5, aspb_outreach_step5,
     ased_outreach_step5 assd_outreach_step6, aspb_outreach_step5 aspb_outreach_step6, ased_outreach_step5 ased_outreach_step6,
     'N' gwf_unsuccessful 
 from (
select outreach_id,delay_days1,create_dt,delay_days1_unit,OUTREACH_STEP2_TYPE,outreach_status,ased_perform_outreach,aspb_perform_outreach, assd_outreach_step1,delay_days2_unit,delay_days2,OUTREACH_STEP4_TYPE,created_by,
coalesce((select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type in('Consumer selected for Outbound Dialer','Outreach Request - Client has no phone')),ased_perform_outreach) ased_outreach_step3,
 coalesce((select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_type in('Consumer selected for Outbound Dialer','Outreach Request - Client has no phone')),aspb_perform_outreach) aspb_outreach_step3,
 coalesce((select max(event_create_dt) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_outcome = 'Success'),ased_perform_outreach) ased_outreach_step5,
 coalesce((select max(event_created_by) from corp_etl_clnt_outreach_events e where e.event_outreach_id = o.outreach_id and event_outcome = 'Success'),aspb_perform_outreach) aspb_outreach_step5

 from corp_etl_clnt_outreach o
where instance_status = 'Complete'
and assd_outreach_step1 is not null
and ased_outreach_step1 is null
and generic_field2  = 'OUTREACH_REQUEST_9'
and outreach_status = 'Outreach Successful'
and complete_dt > add_months(trunc(sysdate,'mm'),-3)-1
) o;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_clnt_outreach
           set ased_outreach_step1 = temp_tab(indx).ased_outreach_step1
               ,aspb_outreach_step1 = temp_tab(indx).aspb_outreach_step1
               ,asf_outreach_step1 = 'Y'
               ,assd_outreach_step2 = temp_tab(indx).assd_outreach_step2
               ,ased_outreach_step2 = temp_tab(indx).ased_outreach_step2
               ,aspb_outreach_step2 = temp_tab(indx).aspb_outreach_step2               
               ,asf_outreach_step2 = 'Y'
               ,assd_outreach_step3 = temp_tab(indx).assd_outreach_step3
               ,ased_outreach_step3 = temp_tab(indx).ased_outreach_step3
               ,aspb_outreach_step3 = temp_tab(indx).aspb_outreach_step3
               ,asf_outreach_step3 = 'Y'
               ,assd_outreach_step4 = temp_tab(indx).assd_outreach_step4
               ,ased_outreach_step4 = temp_tab(indx).ased_outreach_step4
               ,aspb_outreach_step4 = temp_tab(indx).aspb_outreach_step4
               ,asf_outreach_step4 = 'Y'
               ,assd_outreach_step5 = temp_tab(indx).assd_outreach_step5
               ,ased_outreach_step5 = temp_tab(indx).ased_outreach_step5
               ,aspb_outreach_step5 = temp_tab(indx).aspb_outreach_step5               
               ,asf_outreach_step5 = 'Y'
               ,assd_outreach_step6 = temp_tab(indx).assd_outreach_step6
               ,ased_outreach_step6 = temp_tab(indx).ased_outreach_step6
               ,aspb_outreach_step6 = temp_tab(indx).aspb_outreach_step6               
               ,asf_outreach_step6 = 'Y'
               ,gwf_step2_required = 'Y'
               ,gwf_step3_required = 'Y'
               ,gwf_step4_required = 'Y'
               ,gwf_step5_required = 'Y'
               ,gwf_step6_required = 'Y'
               ,gwf_unsuccessful = 'N'
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/
