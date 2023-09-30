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
,'CIR_MI_DOCS'
,'CIR_MI_DOCS'
,'CIR MI Docs'
,'''APPLICATION'',''INSURANCE_PROOF'',''INCOME_PROOF'',''CITIZENSHIP_PROOF'',''OTHER_MI'''
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;

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
,'CIR_TERM_LETTERS'
,'CIR_TERM_LETTERS'
,'CIR Term Letters'
,'''TN 411'',''TN 408'',''TN 408ftp'''
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;
commit;  