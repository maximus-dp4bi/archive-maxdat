--This update should affect ~26k rows
update NYHIX_ETL_MAIL_FAX_DOC_APP_V2 set hx_link_id = null where app_doc_data_id < 5000000;
commit;