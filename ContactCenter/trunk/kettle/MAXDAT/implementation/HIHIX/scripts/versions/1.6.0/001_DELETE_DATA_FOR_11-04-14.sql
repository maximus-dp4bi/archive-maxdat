delete from cc_s_call_detail
where trunc(call_date)=to_date('2014/11/04','yyyy/mm/dd');

delete from cc_s_acd_interval
where trunc(interval_date)=to_date('2014/11/04','yyyy/mm/dd');

delete from cc_f_actuals_queue_interval
where d_date_id in (select d_date_id from cc_d_dates
                    where d_date=to_date('2014/11/04','yyyy/mm/dd'));
                    
commit;                    