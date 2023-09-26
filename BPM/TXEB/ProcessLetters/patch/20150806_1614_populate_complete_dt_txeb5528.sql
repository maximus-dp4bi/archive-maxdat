DECLARE  
  CURSOR temp_cur IS
     select letter_request_id,complete_dt
     from corp_etl_proc_letters
     where instance_status = 'Complete'
     and status not in('Errored','Voided','Mailed','Rejected by Mailhouse','Combined Similar Requests','Overcome by Events','Canceled')
     and cancel_reason is not null;

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
         update corp_etl_proc_letters nf
           set status = 'Canceled'
              ,status_dt = temp_tab(indx).complete_dt              
	 where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters
     where instance_status = 'Complete'
      and complete_dt is null;      

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
         update corp_etl_proc_letters nf
           set stage_done_date = sysdate
               ,complete_dt = sysdate
	   where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

update corp_etl_proc_letters
set instance_status = 'Complete'
    ,complete_dt = sysdate
    ,stage_done_date = sysdate
    ,gwf_outcome = 'M'
where  instance_status = 'Active'
and status = 'Mailed'
;   

UPDATE corp_etl_proc_letters
SET cancel_reason = 'Voided or Canceled in Source'
   ,instance_status = 'Complete'
   ,complete_dt = sysdate
   ,stage_done_date = sysdate
   ,cancel_dt = status_dt
   ,cancel_by = 'TXEB-5528'
   ,cancel_method = 'Exception'   
where  instance_status = 'Active'
and status = 'Canceled';

update corp_etl_proc_letters
set status = 'Canceled'
    ,status_dt = complete_dt              
where letter_request_id = 34750722;

 UPDATE corp_etl_proc_letters
SET cancel_reason = 'Old, clean-up effort'
   ,cancel_dt = sysdate
   ,cancel_by = 'TXEB-5528'
   ,cancel_method = 'Exception' 
   ,status = 'Canceled'
where  letter_request_id in(18429648,
18345993,
18429642,
18429673,
18497437,
18508059,
18523278,
18523231,
18523232,
18523290,
18497435);


update corp_etl_proc_letters l
set status = 'Canceled'
,status_dt = (select letter_update_ts from letters_stg s where s.letter_id = l.letter_request_id)
where letter_request_id in(34760691,
34744305,
34738742,
34756768,
34760685,
34765993,
34762881,
34747517,
34754375,
34748904,
34739667,
34749987,
34745727,
34763381,
34742083,
34758511,
34749993);

--TXEB=5535
UPDATE corp_etl_proc_letters l
SET cancel_reason = 'Letter error in production July 2014 - bad address'
   ,instance_status = 'Complete'
   ,status = 'Errored'
   ,complete_dt = (select letter_update_ts from letters_stg s where s.letter_id = l.letter_request_id)
   ,status_dt = (select letter_update_ts from letters_stg s where s.letter_id = l.letter_request_id)
   ,stage_done_date = sysdate
   ,cancel_dt = (select letter_update_ts from letters_stg s where s.letter_id = l.letter_request_id)
   ,cancel_by_id = (select letter_updated_by from letters_stg s where s.letter_id = l.letter_request_id)
   ,cancel_by = (select letter_updated_by from letters_stg s where s.letter_id = l.letter_request_id)
   ,last_updated_by_id = (select letter_updated_by from letters_stg s where s.letter_id = l.letter_request_id)
   ,cancel_method = 'Exception'   
where  letter_request_id in(14877236, 14877247, 14877304, 15071941, 15072720, 15072932);

 UPDATE corp_etl_proc_letters
SET cancel_reason = 'Voided or Canceled in Source'
   ,instance_status = 'Complete'
   ,complete_dt = status_dt
   ,stage_done_date = sysdate
   ,cancel_dt = status_dt
   ,cancel_by = 'TXEB-5528'
   ,cancel_method = 'Exception'   
where  letter_request_id in (36464807, 36468094, 36518483, 36561069);

commit;

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id,complete_dt
     from corp_etl_proc_letters
     where letter_request_id in(37106165	,
37106213	,
37106324	,
37106434	,
37106439	,
37106441	,
37106462	,
37106605	,
37106641	,
37106727	,
37106770	,
37106813	,
37106823	,
37106864	,
37106877	,
37106898	,
37106981	,
37106999	,
37107029	,
37107119	,
37107130	,
37107158	,
37107159	,
37107164	,
37107172	,
37107210	,
37107220	,
37107222	,
37107299	,
37107337	,
37107403	,
37107431	,
37107450	,
37107459	,
37107461	,
37107468	,
37107528	,
37107541	,
37107571	,
37107575	,
37107605	,
37107609	,
37107611	,
37107776	,
37107791	,
37107795	,
37107797	,
37107798	,
37107799	,
37107800	,
37107811	,
37107820	,
37108229	,
37108755	,
37109182	,
37109221	,
37109261	,
37109933	,
37109947	,
37109948	,
37110036	,
37110190	,
37110221	,
37110233	,
37110262	,
37110345	,
37110351	,
37110355	,
37110379	,
37110383	,
37110503	,
37110546	,
37110563	,
37110566	,
37110625	,
37110713	,
37110731	,
37110741	,
37110922	,
37110929	,
37110936	,
37110962	,
37111055	,
37111299	,
37111364	);

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
         update corp_etl_proc_letters nf
           set status = 'Bad Address'
              ,status_dt = temp_tab(indx).complete_dt              
	 where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/
