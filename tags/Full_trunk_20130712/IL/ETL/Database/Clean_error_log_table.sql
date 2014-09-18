delete from corp_etl_error_log  
where ERR_DATE < trunc(sysdate-.075);
commit;
