select seq_cell_id.nextval from dual;

INSERT INTO maxdat_support.corp_etl_list_lkup(cell_id,name,list_type,value,out_var,start_date,end_date,comments,created_ts,updated_ts)
VALUES(seq_cell_id.nextval,'NUM_LOOKBACK_MONTHS','LOOKBACK','Number of Months Look back','32',TRUNC(sysdate,'mm'),TO_DATE('07/07/7777','mm/dd/yyyy'),'Number of months to look back for getting the data in the views',sysdate,sysdate);

commit;