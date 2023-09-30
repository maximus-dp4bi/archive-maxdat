update nyhix_etl_doc_notifications m
set action_type = (select action_type from document_notification_stg d where m.doc_notification_id = d.document_notification_id and m.action_type is null and d.action_type = '0')
where m.action_type is null
and exists (select 1 from document_notification_stg d where m.doc_notification_id = d.document_notification_id and m.action_type is null and d.action_type = '0');

commit;