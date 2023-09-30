update app_doc_data_stg
set received_date = to_date('08/25/2016','mm/dd/yyyy')
where dcn in('10266425','10266427');

update dms_documents_stg
set date_received = to_date('08/25/2016','mm/dd/yyyy')
where dcn in('10266425','10266427');

commit;