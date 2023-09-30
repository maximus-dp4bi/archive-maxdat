/* Obsolete - No longer kept up to date. */

/*
ALTER session SET plsql_code_type = native;
CREATE OR REPLACE
PROCEDURE UPD_CORP_ETL_MANAGE_WORK_Q(
    p_bi_id      IN NUMBER,
    p_start_date IN DATE,
    p_identifier IN NUMBER)
AS
  v_bsl_id   NUMBER        := 1; -- 'CORP_ETL_MANAGE_WORK'
  v_bil_id   NUMBER        := 3; -- 'Task ID'
  v_sql_code NUMBER        := NULL;
  v_error_message CLOB     := NULL;
  v_string CLOB            := NULL;
  v_string2 CLOB           := NULL;
  v_string3 CLOB           := NULL;
  v_string4 CLOB           := NULL;
  v_string5 CLOB           := NULL;
  v_string6 CLOB           := NULL;
  v_xml_string CLOB        := NULL;
  v_xml_string2 CLOB       := NULL;
  v_xml_string_old xmltype := NULL;
  v_bue_id      NUMBER          := NULL;
  v_bue_id2     NUMBER          := NULL;
  v_bue_id3     NUMBER          := NULL;
  v_date_format VARCHAR2(21)    := 'YYYY-MM-DD HH24:MI:SS';
  v_event_date DATE             := NULL;
  v_data_version NUMBER         := 2; -- Added CDATA
  v_update_event_cutoff DATE    :=NULL;
BEGIN
  BEGIN
    SELECT NVL(MIN(WROTE_BPM_EVENT_DATE),sysdate) --event_date_cutoff
    INTO v_update_event_cutoff
    FROM BPM_UPDATE_EVENT_QUEUE
    WHERE bsl_id=1;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    NULL;
  END;
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
  min_bue mb,
  bpm_attribute ba
WHERE bia.ba_id              =bast.ba_id
AND bast.ba_id               =ba.ba_id
AND bia.ba_id                =ba.ba_id
AND bast.staging_table_column=atc.column_name
AND atc.TABLE_NAME           = 'CORP_ETL_MANAGE_WORK'
AND bia.bi_id                =p_bi_id
AND bia.ba_id                =mb.ba_id
AND bia.bue_id               =mb.bue_id
AND ba.retain_history_flag   ='N'
ORDER BY bast.staging_table_column ASC
  )
  LOOP
    BEGIN
      v_string :=loop_rec.column_elements;
      v_string2:=v_string2||v_string;
    END ;
  END LOOP;
  v_xml_string  :='      <?xml version="1.0"?>'||chr(13)||'      <ROWSET>'||chr(13)||'      <ROW>'||chr(13)||v_string2;
  FOR loop_rec1 IN
  (WITH max_bue AS
  (SELECT MAX(bue_id) bue_id,
    bia.ba_id,
    TRUNC(start_date)
  FROM bpm_instance_attribute bia,
    bpm_attribute ba
  WHERE bi_id               =p_bi_id
  AND bia.ba_id             =ba.ba_id
  AND ba.retain_history_flag='Y'
  AND bia.bue_id!           =
    (SELECT MIN(bue_id) FROM bpm_instance_attribute WHERE bi_id=p_bi_id
    )
  GROUP BY bia.ba_id,
    TRUNC(start_date)
  ORDER BY bue_id ASC
  )
SELECT DISTINCT mxb.bue_id
FROM max_bue mxb,
  bpm_update_event bue
WHERE mxb.bue_id  =bue.bue_id
AND bue.event_date<v_update_event_cutoff
ORDER BY bue_id ASC
  )
  LOOP
    BEGIN
      v_string2     :=NULL;
      v_string5     :=NULL;
      v_string6     :=NULL;
      FOR loop_rec2 IN
      (SELECT DISTINCT bia.ba_id ba_id
      FROM bpm_instance_attribute bia,
        bpm_attribute ba
      WHERE bi_id               =p_bi_id
      AND bia.ba_id             =ba.ba_id
      AND ba.retain_history_flag='Y'
      ORDER BY ba_id ASC
      )
      LOOP
        BEGIN
          v_bue_id:=NULL;
          BEGIN
            SELECT bue_id
            INTO v_bue_id
            FROM bpm_instance_attribute
            WHERE bue_id =loop_rec1.bue_id
            AND ba_id    =loop_rec2.ba_id;
          EXCEPTION
          WHEN no_data_found THEN
            NULL;
          END;
          IF(v_bue_id IS NOT NULL) THEN
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
              END column_elements
            INTO v_string3
            FROM bpm_attribute_staging_table bast,
              bpm_instance_attribute bia,
              ALL_TAB_COLUMNS atc
            WHERE bia.ba_id              =bast.ba_id
            AND bast.staging_table_column=atc.column_name
            AND atc.TABLE_NAME           = 'CORP_ETL_MANAGE_WORK'
            AND bia.bi_id                =p_bi_id
            AND bia.bue_id               =loop_rec1.bue_id
            AND bia.ba_id                =loop_rec2.ba_id
            ORDER BY bast.staging_table_column ASC;
            v_string5:=v_string5||v_string3;
          ELSE
            v_bue_id2:=NULL;
            SELECT MAX(bue_id)
            INTO v_bue_id2
            FROM bpm_instance_attribute
            WHERE bue_id   <loop_rec1.bue_id
            AND ba_id      =loop_rec2.ba_id
            AND bi_id      =p_bi_id;
            IF (v_bue_id2 IS NOT NULL) THEN
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
                END column_elements
              INTO v_string4
              FROM bpm_attribute_staging_table bast,
                bpm_instance_attribute bia,
                ALL_TAB_COLUMNS atc
              WHERE bia.ba_id              =bast.ba_id
              AND bast.staging_table_column=atc.column_name
              AND atc.TABLE_NAME           = 'CORP_ETL_MANAGE_WORK'
              AND bia.bi_id                =p_bi_id
              AND bia.bue_id               =v_bue_id2
              AND bia.ba_id                =loop_rec2.ba_id
              ORDER BY bast.staging_table_column ASC;
              v_string6:=v_string6||v_string4;
            ELSE
              NULL;
            END IF;
          END IF;
        END;
      END LOOP;-- ba_id loop
      SELECT event_date
      INTO v_event_date
      FROM bpm_update_event
      WHERE bue_id   =loop_rec1.bue_id;
      v_xml_string2 :=v_xml_string||v_string5||v_string6||'    </ROW>'||chr(13)||'    </ROWSET>';
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
          loop_rec1.bue_id,
          p_identifier,
          SYSDATE,
          v_event_date,
          v_data_version,
          p_start_date,
          xmltype(v_xml_string2)
        );
      COMMIT;
      v_xml_string_old:=NULL;
      SELECT new_data
      INTO v_xml_string_old
      FROM bpm_update_event_queue_conv
      WHERE bue_id=
        (SELECT MAX(bue_id)
        FROM bpm_update_event_queue_conv
        WHERE identifier=p_identifier
        AND bsl_id      =1
        AND bue_id      < loop_rec1.bue_id
        );
      UPDATE BPM_UPDATE_EVENT_QUEUE_CONV
      SET old_data    =v_xml_string_old
      WHERE identifier=p_identifier
      AND bue_id      =loop_rec1.bue_id
      AND bsl_id      =1
      AND old_data   IS NULL;
      COMMIT;
    END;
  END LOOP;-- bue_id loop
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