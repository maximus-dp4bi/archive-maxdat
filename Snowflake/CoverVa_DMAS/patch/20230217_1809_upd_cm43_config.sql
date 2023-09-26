 update coverva_dmas.dmas_file_load_lkup
 set select_fields = 'source,name,address,locality,filename,CASE WHEN LENGTH(date_received) > 8 THEN TRY_TO_DATE(date_received,''mm/dd/yyyy'') ELSE TRY_TO_DATE(date_received,''mm/dd/yy'') END AS date_received,processing_status,REGEXP_REPLACE(tracking_,''[^A-Za-z0-9]'','''')'
 where filename_prefix = 'CM_043';
 
 