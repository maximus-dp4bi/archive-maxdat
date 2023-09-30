alter session set current_schema = MAXDAT;
alter session set nls_date_format = 'mm/dd/yyyy hh24:mi:ss';


UPDATE corp_etl_proc_letters
SET status = 'Mailed'
    ,status_dt = to_date('06/13/2019 09:04:25','mm/dd/yyyy hh24:mi:ss')
    ,instance_status = 'Complete'
    ,complete_dt = to_date('05/23/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,stage_done_date = sysdate
    ,mailed_dt = to_date('05/23/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,sent_dt = to_date('05/15/2019 20:53:21','mm/dd/yyyy hh24:mi:ss')
    ,print_dt = to_date('05/23/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,last_update_dt = to_date('06/13/2019 09:04:25','mm/dd/yyyy hh24:mi:ss')
    ,asf_process_letter_req = 'Y'
    ,ased_process_letter_req = to_date('05/15/2019 20:53:21','mm/dd/yyyy hh24:mi:ss')
    ,gwf_valid = 'Y'
    ,assd_transmit = to_date('05/15/2019 20:53:21','mm/dd/yyyy hh24:mi:ss') 
    ,asf_transmit = 'Y'
    ,ased_transmit = to_date('06/13/2019 09:03:42','mm/dd/yyyy hh24:mi:ss')
    ,assd_receive_confirmation = to_date('06/13/2019 09:03:42','mm/dd/yyyy hh24:mi:ss')
    ,asf_receive_confirmation = 'Y'
    ,ased_receive_confirmation = to_date('06/13/2019 09:04:25','mm/dd/yyyy hh24:mi:ss')
    ,gwf_outcome = 'M'
WHERE letter_request_id IN (114516673);

UPDATE corp_etl_proc_letters
SET status = 'Mailed'
    ,status_dt = to_date('06/28/2019 15:26:41','mm/dd/yyyy hh24:mi:ss')
    ,instance_status = 'Complete'
    ,complete_dt = to_date('06/17/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,stage_done_date = sysdate
    ,mailed_dt = to_date('06/17/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,sent_dt = to_date('06/12/2019 21:01:27','mm/dd/yyyy hh24:mi:ss')
    ,print_dt = to_date('06/17/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,last_update_dt = to_date('06/28/2019 15:26:41','mm/dd/yyyy hh24:mi:ss')
    ,asf_process_letter_req = 'Y'
    ,ased_process_letter_req = to_date('06/12/2019 21:01:27','mm/dd/yyyy hh24:mi:ss')
    ,gwf_valid = 'Y'
    ,assd_transmit = to_date('06/12/2019 21:01:27','mm/dd/yyyy hh24:mi:ss') 
    ,asf_transmit = 'Y'
    ,ased_transmit = to_date('06/28/2019 15:26:31','mm/dd/yyyy hh24:mi:ss')
    ,assd_receive_confirmation = to_date('06/28/2019 15:26:31','mm/dd/yyyy hh24:mi:ss')
    ,asf_receive_confirmation = 'Y'
    ,ased_receive_confirmation = to_date('06/28/2019 15:26:41','mm/dd/yyyy hh24:mi:ss')
    ,gwf_outcome = 'M'
WHERE letter_request_id IN (115838007);

UPDATE corp_etl_proc_letters
SET status = 'Mailed'
    ,status_dt = to_date('07/16/2019 12:12:21','mm/dd/yyyy hh24:mi:ss')
    ,instance_status = 'Complete'
    ,complete_dt = to_date('06/19/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,stage_done_date = sysdate
    ,mailed_dt = to_date('06/19/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,sent_dt = to_date('06/16/2019 21:02:26','mm/dd/yyyy hh24:mi:ss')
    ,print_dt = to_date('06/19/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,last_update_dt = to_date('07/16/2019 12:12:21','mm/dd/yyyy hh24:mi:ss')
    ,asf_process_letter_req = 'Y'
    ,ased_process_letter_req = to_date('06/16/2019 21:02:26','mm/dd/yyyy hh24:mi:ss')
    ,gwf_valid = 'Y'
    ,assd_transmit = to_date('06/12/2019 21:01:27','mm/dd/yyyy hh24:mi:ss') 
    ,asf_transmit = 'Y'
    ,ased_transmit = to_date('06/28/2019 21:44:46','mm/dd/yyyy hh24:mi:ss')
    ,assd_receive_confirmation = to_date('06/28/2019 21:44:46','mm/dd/yyyy hh24:mi:ss')
    ,asf_receive_confirmation = 'Y'
    ,ased_receive_confirmation = to_date('06/28/2019 21:44:46','mm/dd/yyyy hh24:mi:ss')
    ,gwf_outcome = 'M'
WHERE letter_request_id IN (115870449);


UPDATE corp_etl_proc_letters
SET status = 'Mailed'
    ,status_dt = to_date('07/06/2019 02:38:41','mm/dd/yyyy hh24:mi:ss')
    ,instance_status = 'Complete'
    ,complete_dt = to_date('07/03/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,stage_done_date = sysdate
    ,mailed_dt = to_date('07/03/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,sent_dt = to_date('06/30/2019 21:13:41','mm/dd/yyyy hh24:mi:ss')
    ,print_dt = to_date('07/03/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
    ,last_update_dt = to_date('07/06/2019 02:38:41','mm/dd/yyyy hh24:mi:ss')
    ,asf_process_letter_req = 'Y'
    ,ased_process_letter_req = to_date('06/30/2019 21:13:41','mm/dd/yyyy hh24:mi:ss')
    ,gwf_valid = 'Y'
    ,assd_transmit = to_date('06/30/2019 21:13:41','mm/dd/yyyy hh24:mi:ss') 
    ,asf_transmit = 'Y'
    ,ased_transmit = to_date('06/30/2019 21:13:41','mm/dd/yyyy hh24:mi:ss')
    ,assd_receive_confirmation = to_date('07/06/2019 02:38:41','mm/dd/yyyy hh24:mi:ss')
    ,asf_receive_confirmation = 'Y'
    ,ased_receive_confirmation = to_date('07/06/2019 02:38:41','mm/dd/yyyy hh24:mi:ss')
    ,gwf_outcome = 'M'
WHERE letter_request_id IN (117036579);

UPDATE corp_etl_proc_letters
SET status = 'Sent to Mailhouse'
WHERE letter_request_id IN (116915084,
116915065,
117274591);

DECLARE  
  CURSOR temp_cur IS
    select p.letter_request_id,letter_type_cd,p.status,p.complete_dt,s.letter_status,s.letter_update_ts,s.letter_updated_by
    from corp_etl_proc_letters p
    join letters_stg s on p.letter_request_id = s.letter_id
    where 1=1 
    and letter_create_ts >= to_date('03/01/2019 00:00:00','mm/dd/yyyy hh24:mi:ss') and letter_create_ts <= to_date('07/24/2019 23:59:59','mm/dd/yyyy hh24:mi:ss')
    and p.status <> s.letter_status
    ;
   

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
         update corp_etl_proc_letters
         set instance_status = 'Complete'
             ,status = temp_tab(indx).letter_status
             ,status_dt = temp_tab(indx).letter_update_ts
             ,complete_dt = CASE WHEN complete_dt IS NULL THEN temp_tab(indx).letter_update_ts ELSE complete_dt END             
             ,cancel_by = temp_tab(indx).letter_updated_by
             ,cancel_dt = temp_tab(indx).letter_update_ts
             ,cancel_reason = 'Clean up statuses TXEB-15038'
             ,cancel_method = 'Normal'             
             ,stage_done_date = sysdate
         where letter_request_id = temp_tab(indx).letter_request_id ;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

delete from  letters_stg t
where letter_id in(
47931169	,
47932067	,
47932877	,
47933428	,
50306004	,
50306032	,
50306099	,
50306230	,
50306237	,
50306313	,
50306316	,
50306321	,
50306337	,
50306363	,
50306497	,
50306609	,
50306753	,
50306783	,
50306835	,
50306880	,
50306906	,
50306910	,
50306930	,
50307060	,
50307348	,
50307431	,
50307475	,
50307507	,
50307666	,
50307687	,
50307769	,
50307784	,
50307817	,
50307927	,
50308091	,
50308192	,
50308226	,
50308272	,
50308275	,
50308317	,
50308353	,
50308377	,
50308523	,
50308668	,
50308730	,
50308744	,
50308791	,
50308967	,
50309147	,
50309185	,
50309187	,
50309249	,
56476629	,
56476977	,
56477062	,
56477128	,
56477213	,
56477266	,
56477325	,
56477429	,
56477495	,
56477546	,
56478218	,
56478335	,
56478497	,
56478802	,
56478994	,
56479020	,
56479061	,
56479072	,
56479205	,
56479237	,
56479384	,
56479794	,
56479882	,
56480045	,
56480097	,
58947945	,
58947971	,
58948031	,
58948044	,
58948076	,
58948085	,
58948121	,
58948126	,
58948137	,
58948149	,
58948206	,
58948256	,
58948304	,
58948360	,
58948411	,
58948479	,
58948501	,
58948542	,
58948543	,
58948544	,
58948548	,
58948588	,
58948613	,
58948644	,
58948658	,
58948675	,
58948738	,
58948747	,
58948775	,
58948779	,
58948794	,
58948820	,
58948912	,
58949029	,
58949058	,
58949158	,
58949165	,
58949176	,
58949214	,
58949252	,
58949288	,
58949467	,
58949533	,
58949540	,
58949795	,
58949836	,
58949839	,
58949840	,
58949909	,
58949924	,
58949941	,
58949942	,
58949983	,
58950016	,
58950017	,
58950034	,
58950066	,
58950157	,
58950213	,
58950214	,
58950273	,
58950346	,
58950534	,
58950535	,
58950552	,
58950614	,
58950697	,
58950719	,
58950727	,
58950820	,
58950835	,
58951025	,
114437373	,
114437374	,
114437375	,
114437376	,
114437377	,
114451040	,
114497339	,
114526125	,
114526133	,
114526377	,
114526382	,
115684958	,
115756742	,
115860751	,
115860864	,
116895143	,
116923199	,
117005228	,
117006244	,
117070615	,
117109446	,
117227615	,
117254530	,
118378732	,
118379053	)
and rowid in(select max(rowid) from letters_stg s where s.letter_id = t.letter_id);

commit;