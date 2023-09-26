declare

  v_bsl_id number := 16; -- 'CORP_ETL_MFB_BATCH'
  v_bil_id number := 4; -- 'Batch ID'
  v_data_version number:=1;

  v_xml_string_old clob := null;
  v_xml_string_new clob := null;

  v_identifier varchar2(100) := null;

  v_sql_code number := null;
  v_log_message clob := null;
  v_cejs_job_id number := null;

  v_event_date date := null;

begin

  v_event_date := sysdate;
  v_identifier := '{858e3ad9-23a2-4cb9-b933-a748142db93d}';
  v_cejs_job_id := 697755;

  v_xml_string_old :=
'<?xml version="1.0"?>
<ROWSET>
  <ROW>
    <ASED_CLASSIFICATION/>
    <ASED_CREATE_PDF/>
    <ASED_PERFORM_QC/>
    <ASED_POPULATE_REPORTS/>
    <ASED_RECOGNITION>2018-07-25 15:17:49</ASED_RECOGNITION>
    <ASED_RELEASE_DMS/>
    <ASED_SCAN_BATCH>2018-07-25 15:13:05</ASED_SCAN_BATCH>
    <ASED_VALIDATE_DATA/>
    <ASF_CLASSIFICATION><![CDATA[N]]></ASF_CLASSIFICATION>
    <ASF_CREATE_PDF><![CDATA[N]]></ASF_CREATE_PDF>
    <ASF_PERFORM_QC><![CDATA[N]]></ASF_PERFORM_QC>
    <ASF_POPULATE_REPORTS><![CDATA[N]]></ASF_POPULATE_REPORTS>
    <ASF_RECOGNITION><![CDATA[Y]]></ASF_RECOGNITION>
    <ASF_RELEASE_DMS><![CDATA[N]]></ASF_RELEASE_DMS>
    <ASF_SCAN_BATCH><![CDATA[Y]]></ASF_SCAN_BATCH>
    <ASF_VALIDATE_DATA><![CDATA[N]]></ASF_VALIDATE_DATA>
    <ASPB_PERFORM_QC><![CDATA[]]></ASPB_PERFORM_QC>
    <ASPB_SCAN_BATCH><![CDATA[SVC_VAR_KFXSQL_NYSOH]]></ASPB_SCAN_BATCH>
    <ASPB_VALIDATE_DATA><![CDATA[]]></ASPB_VALIDATE_DATA>
    <ASPB_VALIDATE_DATA_USER_ID><![CDATA[SVC_VAR_KFXSQL_NYSOH]]></ASPB_VALIDATE_DATA_USER_ID>
    <ASSD_CLASSIFICATION>2018-07-25 15:13:05</ASSD_CLASSIFICATION>
    <ASSD_CREATE_PDF/>
    <ASSD_PERFORM_QC/>
    <ASSD_POPULATE_REPORTS/>
    <ASSD_RECOGNITION>2018-07-25 15:13:05</ASSD_RECOGNITION>
    <ASSD_RELEASE_DMS/>
    <ASSD_SCAN_BATCH>2018-07-25 15:13:04</ASSD_SCAN_BATCH>
    <ASSD_VALIDATE_DATA>2018-07-25 15:17:49</ASSD_VALIDATE_DATA>
    <BATCH_CLASS><![CDATA[NYSOH-FAX]]></BATCH_CLASS>
    <BATCH_CLASS_DES><![CDATA[v2.1.18.f]]></BATCH_CLASS_DES>
    <BATCH_COMPLETE_DT/>
    <BATCH_DELETED><![CDATA[N]]></BATCH_DELETED>
    <BATCH_DESCRIPTION><![CDATA[]]></BATCH_DESCRIPTION>
    <BATCH_DOC_COUNT>1</BATCH_DOC_COUNT>
    <BATCH_ENVELOPE_COUNT>0</BATCH_ENVELOPE_COUNT>
    <BATCH_GUID><![CDATA[{858e3ad9-23a2-4cb9-b933-a748142db93d}]]></BATCH_GUID>
    <BATCH_ID>3771296</BATCH_ID>
    <BATCH_NAME><![CDATA[NYSOH-FAX-7/25/2018-3:13:04 PM]]></BATCH_NAME>
    <BATCH_PAGE_COUNT>6</BATCH_PAGE_COUNT>
    <BATCH_PRIORITY>4</BATCH_PRIORITY>
    <BATCH_TYPE><![CDATA[Other Docs Only]]></BATCH_TYPE>
    <CANCEL_BY><![CDATA[NYHIX-42611]]></CANCEL_BY>
    <CANCEL_DT>2018-07-26 00:00:00</CANCEL_DT>
    <CANCEL_METHOD><![CDATA[Exception]]></CANCEL_METHOD>
    <CANCEL_REASON><![CDATA[Reprocessed]]></CANCEL_REASON>
    <CLASSIFICATION_DT/>
    <COMPLETE_DT>2018-07-26 00:00:00</COMPLETE_DT>
    <CREATE_DT>2018-07-25 15:13:04</CREATE_DT>
    <CREATION_STATION_ID><![CDATA[NYAP1MLAPP05KX]]></CREATION_STATION_ID>
    <CREATION_USER_ID><![CDATA[MAXIMUS\SVC_VAR_KFXSQL_NYSOH]]></CREATION_USER_ID>
    <CREATION_USER_NAME><![CDATA[SVC_VAR_KFXSQL_NYSOH]]></CREATION_USER_NAME>
    <CURRENT_BATCH_MODULE_ID><![CDATA[{df0f1349-351e-4838-a0c0-e3fd8febfe54}]]></CURRENT_BATCH_MODULE_ID>
    <CURRENT_STEP><![CDATA[End - Cancelled]]></CURRENT_STEP>
    <DOCS_CREATED_FLAG><![CDATA[Y]]></DOCS_CREATED_FLAG>
    <DOCS_DELETED_FLAG><![CDATA[N]]></DOCS_DELETED_FLAG>
    <GWF_QC_REQUIRED><![CDATA[N]]></GWF_QC_REQUIRED>
    <INSTANCE_STATUS><![CDATA[Complete]]></INSTANCE_STATUS>
    <INSTANCE_STATUS_DT>2018-07-25 00:00:00</INSTANCE_STATUS_DT>
    <KOFAX_QC_REASON><![CDATA[]]></KOFAX_QC_REASON>
    <PAGES_DELETED_FLAG><![CDATA[N]]></PAGES_DELETED_FLAG>
    <PAGES_REPLACED_FLAG><![CDATA[N]]></PAGES_REPLACED_FLAG>
    <PAGES_SCANNED_FLAG><![CDATA[Y]]></PAGES_SCANNED_FLAG>
    <RECOGNITION_DT/>
    <REPROCESSED_FLAG><![CDATA[Y]]></REPROCESSED_FLAG>
    <SOURCE_SERVER><![CDATA[REMOTE]]></SOURCE_SERVER>
    <STG_LAST_UPDATE_DATE>2018-08-08 17:51:56</STG_LAST_UPDATE_DATE>
    <VALIDATION_DT/>
  </ROW>
</ROWSET>';

  v_xml_string_new :=
    '<?xml version="1.0"?>
<ROWSET>
  <ROW>
    <ASED_CLASSIFICATION/>
    <ASED_CREATE_PDF/>
    <ASED_PERFORM_QC/>
    <ASED_POPULATE_REPORTS/>
    <ASED_RECOGNITION>2018-07-25 15:17:49</ASED_RECOGNITION>
    <ASED_RELEASE_DMS/>
    <ASED_SCAN_BATCH>2018-07-25 15:13:05</ASED_SCAN_BATCH>
    <ASED_VALIDATE_DATA/>
    <ASF_CLASSIFICATION><![CDATA[N]]></ASF_CLASSIFICATION>
    <ASF_CREATE_PDF><![CDATA[N]]></ASF_CREATE_PDF>
    <ASF_PERFORM_QC><![CDATA[N]]></ASF_PERFORM_QC>
    <ASF_POPULATE_REPORTS><![CDATA[N]]></ASF_POPULATE_REPORTS>
    <ASF_RECOGNITION><![CDATA[Y]]></ASF_RECOGNITION>
    <ASF_RELEASE_DMS><![CDATA[N]]></ASF_RELEASE_DMS>
    <ASF_SCAN_BATCH><![CDATA[Y]]></ASF_SCAN_BATCH>
    <ASF_VALIDATE_DATA><![CDATA[N]]></ASF_VALIDATE_DATA>
    <ASPB_PERFORM_QC><![CDATA[]]></ASPB_PERFORM_QC>
    <ASPB_SCAN_BATCH><![CDATA[SVC_VAR_KFXSQL_NYSOH]]></ASPB_SCAN_BATCH>
    <ASPB_VALIDATE_DATA><![CDATA[]]></ASPB_VALIDATE_DATA>
    <ASPB_VALIDATE_DATA_USER_ID><![CDATA[SVC_VAR_KFXSQL_NYSOH]]></ASPB_VALIDATE_DATA_USER_ID>
    <ASSD_CLASSIFICATION>2018-07-25 15:13:05</ASSD_CLASSIFICATION>
    <ASSD_CREATE_PDF/>
    <ASSD_PERFORM_QC/>
    <ASSD_POPULATE_REPORTS/>
    <ASSD_RECOGNITION>2018-07-25 15:13:05</ASSD_RECOGNITION>
    <ASSD_RELEASE_DMS/>
    <ASSD_SCAN_BATCH>2018-07-25 15:13:04</ASSD_SCAN_BATCH>
    <ASSD_VALIDATE_DATA>2018-07-25 15:17:49</ASSD_VALIDATE_DATA>
    <BATCH_CLASS><![CDATA[NYSOH-FAX]]></BATCH_CLASS>
    <BATCH_CLASS_DES><![CDATA[v2.1.18.f]]></BATCH_CLASS_DES>
    <BATCH_COMPLETE_DT/>
    <BATCH_DELETED><![CDATA[N]]></BATCH_DELETED>
    <BATCH_DESCRIPTION><![CDATA[]]></BATCH_DESCRIPTION>
    <BATCH_DOC_COUNT>1</BATCH_DOC_COUNT>
    <BATCH_ENVELOPE_COUNT>0</BATCH_ENVELOPE_COUNT>
    <BATCH_GUID><![CDATA[{858e3ad9-23a2-4cb9-b933-a748142db93d}]]></BATCH_GUID>
    <BATCH_ID>3771296</BATCH_ID>
    <BATCH_NAME><![CDATA[NYSOH-FAX-7/25/2018-3:13:04 PM]]></BATCH_NAME>
    <BATCH_PAGE_COUNT>6</BATCH_PAGE_COUNT>
    <BATCH_PRIORITY>4</BATCH_PRIORITY>
    <BATCH_TYPE><![CDATA[Other Docs Only]]></BATCH_TYPE>
    <CANCEL_BY><![CDATA[NYHIX-42611]]></CANCEL_BY>
    <CANCEL_DT>2018-07-25 00:00:00</CANCEL_DT>
    <CANCEL_METHOD><![CDATA[Exception]]></CANCEL_METHOD>
    <CANCEL_REASON><![CDATA[Reprocessed]]></CANCEL_REASON>
    <CLASSIFICATION_DT/>
    <COMPLETE_DT>2018-08-06 00:00:00</COMPLETE_DT>
    <CREATE_DT>2018-08-06 00:00:00</CREATE_DT>
    <CREATION_STATION_ID><![CDATA[NYAP1MLAPP05KX]]></CREATION_STATION_ID>
    <CREATION_USER_ID><![CDATA[MAXIMUS\SVC_VAR_KFXSQL_NYSOH]]></CREATION_USER_ID>
    <CREATION_USER_NAME><![CDATA[SVC_VAR_KFXSQL_NYSOH]]></CREATION_USER_NAME>
    <CURRENT_BATCH_MODULE_ID><![CDATA[{df0f1349-351e-4838-a0c0-e3fd8febfe54}]]></CURRENT_BATCH_MODULE_ID>
    <CURRENT_STEP><![CDATA[End - Cancelled]]></CURRENT_STEP>
    <DOCS_CREATED_FLAG><![CDATA[Y]]></DOCS_CREATED_FLAG>
    <DOCS_DELETED_FLAG><![CDATA[N]]></DOCS_DELETED_FLAG>
    <GWF_QC_REQUIRED><![CDATA[N]]></GWF_QC_REQUIRED>
    <INSTANCE_STATUS><![CDATA[Complete]]></INSTANCE_STATUS>
    <INSTANCE_STATUS_DT>2018-08-06 00:00:00</INSTANCE_STATUS_DT>
    <KOFAX_QC_REASON><![CDATA[]]></KOFAX_QC_REASON>
    <PAGES_DELETED_FLAG><![CDATA[N]]></PAGES_DELETED_FLAG>
    <PAGES_REPLACED_FLAG><![CDATA[N]]></PAGES_REPLACED_FLAG>
    <PAGES_SCANNED_FLAG><![CDATA[Y]]></PAGES_SCANNED_FLAG>
    <RECOGNITION_DT/>
    <REPROCESSED_FLAG><![CDATA[Y]]></REPROCESSED_FLAG>
    <SOURCE_SERVER><![CDATA[REMOTE]]></SOURCE_SERVER>
    <STG_LAST_UPDATE_DATE>2018-08-08 17:51:56</STG_LAST_UPDATE_DATE>
    <VALIDATION_DT/>
  </ROW>
</ROWSET>';
 insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,CEJS_JOB_ID,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
  values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_cejs_job_id,v_event_date,sysdate,v_data_version,xmltype(v_xml_string_old),xmltype(v_xml_string_new));

exception

  when OTHERS then

    v_sql_code := SQLCODE;
    v_log_message := SQLERRM || '
      XML (old):
      ' || v_xml_string_old || '
      XML (new):
      ' || v_xml_string_new;

    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,v_log_message,v_sql_code);
    raise;

end;