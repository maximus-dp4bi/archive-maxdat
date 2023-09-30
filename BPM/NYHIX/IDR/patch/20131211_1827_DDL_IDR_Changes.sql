INSERT INTO corp_etl_list_lkup
    (cell_id
    ,NAME
    ,list_type
    ,VALUE
    ,out_var
    ,ref_type
    ,ref_id
    ,start_date
    ,end_date
    ,comments
    ,created_ts
    ,updated_ts) 
VALUES
    (seq_cell_id.nextval
    ,'LAST_ETL_COMP_PIVOT'
    ,'PIVOT'
    ,'IDR_Incidents_RUN_ALL'
    ,'21'
    ,'BPM_EVENT_MASTER'
    ,21
    ,trunc(SYSDATE - 1)
    ,to_date('07077777', 'mmddyyyy')
    ,'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID'
    ,SYSDATE
    ,SYSDATE);
	
commit;	