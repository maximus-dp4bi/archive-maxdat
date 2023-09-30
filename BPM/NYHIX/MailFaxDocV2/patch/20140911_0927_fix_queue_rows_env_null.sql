UPDATE
  BPM_UPDATE_EVENT_QUEUE
SET
  OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/ENV_STATUS'),
  NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/ENV_STATUS')
WHERE
  BSL_ID        = 24
AND IDENTIFIER IN
  (
    SELECT
      dcn
    FROM
      nyhix_etl_mail_fax_doc_v2
    WHERE
      env_status IS NULL
  )
AND existsnode(old_data,'ROWSET/ROW/ENV_STATUS') = 1;

UPDATE
  BPM_UPDATE_EVENT_QUEUE
SET
  OLD_DATA = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE(
  '<ENV_STATUS>![CDATA[Received]]</ENV_STATUS>')),
  NEW_DATA = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE(
  '<ENV_STATUS>![CDATA[Received]]</ENV_STATUS>'))
WHERE
  BSL_ID        = 24
AND IDENTIFIER IN
  (
    SELECT
      dcn
    FROM
      nyhix_etl_mail_fax_doc_v2
    WHERE
      env_status IS NULL
  );

commit;

update nyhix_etl_mail_fax_doc_v2
set env_status = 'Received'
where env_status is null;
commit;