/* Obsolete - No longer kept up to date. */

/*
ALTER session SET plsql_code_type = native;
CREATE OR REPLACE
PROCEDURE INS_NYEC_PROCESS_APP_Q(
    p_bi_id      IN NUMBER,
    p_start_date IN DATE,
    p_identifier IN NUMBER)
AS
  v_bsl_id   NUMBER          := 2; -- 'NYEC_ETL_PROCESS_APP'
  v_bil_id   NUMBER          := 2; -- 'Application ID'
  v_sql_code NUMBER          := NULL;
  v_error_message CLOB       := NULL;
  v_string CLOB              := NULL;
  v_string2 CLOB             := NULL;
  v_string3 CLOB             := NULL;
  v_xml_string CLOB          := NULL;
  v_bue_id      NUMBER       := NULL;
  v_date_format VARCHAR2(21) := 'YYYY-MM-DD HH24:MI:SS';
  v_event_date DATE          := NULL;
  v_update_event_cutoff DATE := sysdate;
  v_data_version NUMBER      := 1;
  v_db_name varchar2(30)     := null;
  
BEGIN
  /*
  BEGIN
    SELECT NVL(MIN(WROTE_BPM_EVENT_DATE),sysdate) --event_date_cutoff
    INTO v_update_event_cutoff
    FROM BPM_UPDATE_EVENT_QUEUE
    WHERE bsl_id=2;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    NULL;
  END;
  */
  v_string2    :=NULL;
  FOR loop_rec IN
  (WITH min_bue AS
  (SELECT ba_id,
    MIN(bue_id) bue_id
  FROM bpm_instance_attribute bia
  WHERE bia.bi_id=p_bi_id
  GROUP BY ba_id
  ORDER BY ba_id
  )
SELECT
  CASE
    WHEN atc.data_type='DATE'
    THEN '        <'
      || atc.COLUMN_NAME
      || '><![CDATA['
      || TO_CHAR(bia.value_date,'YYYY-MM-DD HH24:MI:SS')
      || ']]></'
      || atc.COLUMN_NAME
      || '>'
      || chr(13)
    WHEN atc.data_type='VARCHAR2'
    THEN '        <'
      || atc.COLUMN_NAME
      || '><![CDATA['
      || bia.value_char
      || ']]></'
      || atc.COLUMN_NAME
      || '>'
      || chr(13)
    WHEN atc.data_type='NUMBER'
    THEN '        <'
      || atc.COLUMN_NAME
      || '><![CDATA['
      || TO_CHAR(bia.value_number)
      || ']]></'
      || atc.COLUMN_NAME
      || '>'
      || chr(13)
    ELSE NULL
  END column_elements,
  mb.bue_id bue_id
FROM bpm_attribute_staging_table bast,
  bpm_instance_attribute bia,
  ALL_TAB_COLUMNS atc,
  min_bue mb
WHERE bia.ba_id              =bast.ba_id
AND bast.staging_table_column=atc.column_name
AND atc.TABLE_NAME           = 'NYEC_ETL_PROCESS_APP'
AND bia.bi_id                =p_bi_id
AND bia.ba_id                =mb.ba_id
AND bia.bue_id               =mb.bue_id
ORDER BY bast.staging_table_column ASC
  )
  LOOP
    BEGIN
      v_string :=loop_rec.column_elements;
      v_string2:=v_string2||v_string;
      v_bue_id :=loop_rec.bue_id;
    END ;
  END LOOP;
  
  SELECT event_date
    INTO v_event_date
    FROM bpm_update_event
  WHERE bue_id    =v_bue_id;
  
  v_string3:='<STG_LAST_UPDATE_DATE>'|| TO_CHAR(v_event_date,'YYYY-MM-DD HH24:MI:SS')||'</STG_LAST_UPDATE_DATE>'||chr(13);
  
  v_xml_string:='      <?xml version="1.0"?>'||chr(13)||'      <ROWSET>'||chr(13)||'      <ROW>'||chr(13)||v_string2||v_string3||'    </ROW>'||chr(13)||'    </ROWSET>';
  
  IF(v_event_date < v_update_event_cutoff) THEN
    INSERT
    INTO BPM_UPDATE_EVENT_QUEUE_CONV
      (
        BUEQ_ID,
        BSL_ID,
        BIL_ID,
        BUE_ID,
        IDENTIFIER,
        QUEUE_DATE,
        EVENT_DATE,
        DATA_VERSION,
        WROTE_BPM_EVENT_DATE,
        NEW_DATA
      )
      VALUES
      (
        SEQ_BUEQ_ID.nextval,
        v_bsl_id,
        v_bil_id,
        v_bue_id,
        p_identifier,
        SYSDATE,
        v_event_date,
        v_data_version,
        p_start_date,
        xmltype(v_xml_string)
      );
    COMMIT;
  ELSE
    NULL;
  END IF;
EXCEPTION
WHEN OTHERS THEN
  v_sql_code      := SQLCODE;
  v_error_message := SQLERRM;
  BPM_COMMON.ERROR_MSG(sysdate,$$PLSQL_UNIT,NULL,NULL,NULL,v_sql_code,v_error_message);
END ;
/
COMMIT;
ALTER session SET plsql_code_type = interpreted;
*/