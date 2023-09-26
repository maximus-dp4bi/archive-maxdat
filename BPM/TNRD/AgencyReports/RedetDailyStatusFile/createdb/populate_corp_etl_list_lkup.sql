insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'REDET_DAILYSTATUS_CK_CODES'
,'REDET_DAILYSTATUS_CK_CODES'
,'CK MMIS Status'
,'''RFI_CK'',''PEND_CK'',''NR_CK'',''TRMDN_CK'',''APPR_CK'',''CK_APPR_MA'',''TRMDN'',''NR'''
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;

commit;  