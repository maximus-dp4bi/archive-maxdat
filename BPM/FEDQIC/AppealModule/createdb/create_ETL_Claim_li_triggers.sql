alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_CORP_ETL_CLAIM_LI
before insert or update on CORP_ETL_CLAIM_LINE_ITEM_WIP
for each row
declare
  v_instance_start_date date := null;
  v_instance_end_date date := null;

begin

  if inserting then

    if
	  :new.CECLI_ID is null then  :new.CECLI_ID := SEQ_CECLI_ID.nextval;
    end if;

    if
	   :new.STG_EXTRACT_DATE is null then :new.STG_EXTRACT_DATE  := sysdate;
    end if;

	/*
	If inserting and :new.change_flag is null, then ‘N’
    If updating  and :new.change_flag is null and :old.change_flag not ‘I’,  then ‘U’

    Then when you are inserting new records (MW_Insert.ktr) you force it to ‘I’

    When you are inserting the records that may be updated (while moving Active instances from BPM to WIP), you let the trigger set it to ‘N’

    Then when the update rules fire,  for an insert, it stays as I, for records that are not inserts, it will update it to ‘U’
	*/  
	--if
    --This condition applies to Active instances moved from BPM to WIP stage table.
	 -- :new.CHANGE_FLAG is null then :new.CHANGE_FLAG := 'N';
	--end if;

  end if;

  :new.STG_LAST_UPDATE_DATE := sysdate;
 -- if updating then
     --This condition applies to Active instances taht are updated only; Not for new inserts that get updated later.
--     if coalesce(:new.CHANGE_FLAG,'Z') <> 'I' and coalesce(:old.CHANGE_FLAG,'Z') <> 'I' then :new.CHANGE_FLAG := 'U';
--	   end if;
--  end if;

--  :new.instance_start_date := :new.CREATE_DATE;
--  :new.instance_end_date := coalesce(:new.COMPLETE_DATE, :new.CANCEL_WORK_DATE);

end;
/

create or replace trigger TRG_AI_CORP_ETL_CLAIM_LI_Q
after insert on CORP_ETL_CLAIM_LINE_ITEM
for each row

declare

  v_bsl_id number := 2007; -- 'FEDQIC_ETL'
  v_bil_id number := 3; -- 'Task ID'
  v_data_version number := 3; -- CDATA for varchar2 only and added STG_LAST_UPDATE_DATE

  v_identifier varchar2(100) := null;
  v_xml_string_new clob := null;
  v_sql_code number := null;
  v_log_message clob := null;
  v_event_date date := null;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.CLAIM_LINE_ITEM_ID;

  /*
  Include:
    CECLI_ID
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_new :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
        <CECLI_ID>' || :new.CECLI_ID || '</CECLI_ID>
         <CLAIM_ID><![CDATA[' || :new.CLAIM_ID || ']]></CLAIM_ID>
         <CLAIM_LINE_ITEM_ID><![CDATA[' || :new.CLAIM_LINE_ITEM_ID || ']]></CLAIM_LINE_ITEM_ID>
         <CLAIM_LINE_ITEM_NUMBER><![CDATA[' || :new.CLAIM_LINE_ITEM_NUMBER || ']]></CLAIM_LINE_ITEM_NUMBER>
         <MSG_ACTION_CODE><![CDATA[' || :new.MSG_ACTION_CODE || ']]></MSG_ACTION_CODE>
        <CLAIM_LINE_ADJUSTMENT_CODE><![CDATA[' || :new.CLAIM_LINE_ADJUSTMENT_CODE || ']]></CLAIM_LINE_ADJUSTMENT_CODE>
        <CLAIM_LINE_PROCEDURE_CODES><![CDATA[' || :new.CLAIM_LINE_PROCEDURE_CODES || ']]></CLAIM_LINE_PROCEDURE_CODES>
        <CLAIM_LINE_DRUG_CODES><![CDATA[' || :new.CLAIM_LINE_DRUG_CODES || ']]></CLAIM_LINE_DRUG_CODES>
        <HIPPS_CODE><![CDATA[' || :new.HIPPS_CODE || ']]></HIPPS_CODE>
        <DIAGNOSIS_CODE><![CDATA[' || :new.DIAGNOSIS_CODE || ']]></DIAGNOSIS_CODE>
        <MISC_CODES><![CDATA[' || :new.MISC_CODES || ']]></MISC_CODES>
        <CLAIM_LINE_DISPOSITION><![CDATA[' || :new.CLAIM_LINE_DISPOSITION || ']]></CLAIM_LINE_DISPOSITION>
        <CLAIM_LINE_DISPOSITION_EXPLANATION><![CDATA[' || :new.CLAIM_LINE_DISPOSITION_EXPLANATION || ']]></CLAIM_LINE_DISPOSITION_EXPLANATION>
        <CLAIM_LINE_PROCEDURAL_DECISION_REASON><![CDATA[' || :new.CLAIM_LINE_PROCEDURAL_DECISION_REASON || ']]></CLAIM_LINE_PROCEDURAL_DECISION_REASON>
        <CLAIM_LINE_SUBSTANTIVE_REASON><![CDATA[' || :new.CLAIM_LINE_SUBSTANTIVE_REASON || ']]></CLAIM_LINE_SUBSTANTIVE_REASON>
	<STG_EXTRACT_DATE>' || to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
	<STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
    </ROW>
    </ROWSET>
    ';


  insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
  values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_event_date,sysdate,v_data_version,null,xmltype(v_xml_string_new));

exception

  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM || '
      XML:
      ' || v_xml_string_new;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,$$PLSQL_UNIT,v_bsl_id,v_bil_id,v_identifier,null,v_log_message,v_sql_code);
    raise;

end;
/


create or replace trigger TRG_AU_CORP_ETL_CLAIM_LI_Q
after update on CORP_ETL_CLAIM_LINE_ITEM
for each row

declare

  v_bsl_id number := 2007; -- 'FEDQIC_ETL'
  v_bil_id number := 3; -- 'Task ID'
  v_data_version number := 3; -- CDATA for varchar2 only and added STG_LAST_UPDATE_DATE

  v_identifier varchar2(100) := null;

  v_xml_string_old clob := null;
  v_xml_string_new clob := null;

  v_sql_code number := null;
  v_log_message clob := null;

  v_event_date date := null;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.CLAIM_LINE_ITEM_ID;

  /*
  Include:
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_old :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
        <CECLI_ID>' || :old.CECLI_ID || '</CECLI_ID>
         <CLAIM_ID><![CDATA[' || :old.CLAIM_ID || ']]></CLAIM_ID>
         <CLAIM_LINE_ITEM_ID><![CDATA[' || :old.CLAIM_LINE_ITEM_ID || ']]></CLAIM_LINE_ITEM_ID>
         <CLAIM_LINE_ITEM_NUMBER><![CDATA[' || :old.CLAIM_LINE_ITEM_NUMBER || ']]></CLAIM_LINE_ITEM_NUMBER>
         <MSG_ACTION_CODE><![CDATA[' || :old.MSG_ACTION_CODE || ']]></MSG_ACTION_CODE>
        <CLAIM_LINE_ADJUSTMENT_CODE><![CDATA[' || :old.CLAIM_LINE_ADJUSTMENT_CODE || ']]></CLAIM_LINE_ADJUSTMENT_CODE>
        <CLAIM_LINE_PROCEDURE_CODES><![CDATA[' || :old.CLAIM_LINE_PROCEDURE_CODES || ']]></CLAIM_LINE_PROCEDURE_CODES>
        <CLAIM_LINE_DRUG_CODES><![CDATA[' || :old.CLAIM_LINE_DRUG_CODES || ']]></CLAIM_LINE_DRUG_CODES>
        <HIPPS_CODE><![CDATA[' || :old.HIPPS_CODE || ']]></HIPPS_CODE>
        <DIAGNOSIS_CODE><![CDATA[' || :old.DIAGNOSIS_CODE || ']]></DIAGNOSIS_CODE>
        <MISC_CODES><![CDATA[' || :old.MISC_CODES || ']]></MISC_CODES>
        <CLAIM_LINE_DISPOSITION><![CDATA[' || :old.CLAIM_LINE_DISPOSITION || ']]></CLAIM_LINE_DISPOSITION>
        <CLAIM_LINE_DISPOSITION_EXPLANATION><![CDATA[' || :old.CLAIM_LINE_DISPOSITION_EXPLANATION || ']]></CLAIM_LINE_DISPOSITION_EXPLANATION>
        <CLAIM_LINE_PROCEDURAL_DECISION_REASON><![CDATA[' || :old.CLAIM_LINE_PROCEDURAL_DECISION_REASON || ']]></CLAIM_LINE_PROCEDURAL_DECISION_REASON>
        <CLAIM_LINE_SUBSTANTIVE_REASON><![CDATA[' || :old.CLAIM_LINE_SUBSTANTIVE_REASON || ']]></CLAIM_LINE_SUBSTANTIVE_REASON>
	<STG_EXTRACT_DATE>' || to_char(:old.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
	<STG_LAST_UPDATE_DATE>' || to_char(:old.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
    </ROW>
    </ROWSET>
    ';

  /*
  Include:
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_new :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
         <CLAIM_ID><![CDATA[' || :new.CLAIM_ID || ']]></CLAIM_ID>
         <CLAIM_LINE_ITEM_ID><![CDATA[' || :new.CLAIM_LINE_ITEM_ID || ']]></CLAIM_LINE_ITEM_ID>
         <CLAIM_LINE_ITEM_NUMBER><![CDATA[' || :new.CLAIM_LINE_ITEM_NUMBER || ']]></CLAIM_LINE_ITEM_NUMBER>
         <MSG_ACTION_CODE><![CDATA[' || :new.MSG_ACTION_CODE || ']]></MSG_ACTION_CODE>
        <CLAIM_LINE_ADJUSTMENT_CODE><![CDATA[' || :new.CLAIM_LINE_ADJUSTMENT_CODE || ']]></CLAIM_LINE_ADJUSTMENT_CODE>
        <CLAIM_LINE_PROCEDURE_CODES><![CDATA[' || :new.CLAIM_LINE_PROCEDURE_CODES || ']]></CLAIM_LINE_PROCEDURE_CODES>
        <CLAIM_LINE_DRUG_CODES><![CDATA[' || :new.CLAIM_LINE_DRUG_CODES || ']]></CLAIM_LINE_DRUG_CODES>
        <HIPPS_CODE><![CDATA[' || :new.HIPPS_CODE || ']]></HIPPS_CODE>
        <DIAGNOSIS_CODE><![CDATA[' || :new.DIAGNOSIS_CODE || ']]></DIAGNOSIS_CODE>
        <MISC_CODES><![CDATA[' || :new.MISC_CODES || ']]></MISC_CODES>
        <CLAIM_LINE_DISPOSITION><![CDATA[' || :new.CLAIM_LINE_DISPOSITION || ']]></CLAIM_LINE_DISPOSITION>
        <CLAIM_LINE_DISPOSITION_EXPLANATION><![CDATA[' || :new.CLAIM_LINE_DISPOSITION_EXPLANATION || ']]></CLAIM_LINE_DISPOSITION_EXPLANATION>
        <CLAIM_LINE_PROCEDURAL_DECISION_REASON><![CDATA[' || :new.CLAIM_LINE_PROCEDURAL_DECISION_REASON || ']]></CLAIM_LINE_PROCEDURAL_DECISION_REASON>
        <CLAIM_LINE_SUBSTANTIVE_REASON><![CDATA[' || :new.CLAIM_LINE_SUBSTANTIVE_REASON || ']]></CLAIM_LINE_SUBSTANTIVE_REASON>
	<STG_EXTRACT_DATE>' || to_char(:new.STG_EXTRACT_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_EXTRACT_DATE>
	<STG_LAST_UPDATE_DATE>' || to_char(:new.STG_LAST_UPDATE_DATE,BPM_COMMON.GET_DATE_FMT) || '</STG_LAST_UPDATE_DATE>
    </ROW>
    </ROWSET>
    ';

  insert into BPM_UPDATE_EVENT_QUEUE
    (BUEQ_ID,BSL_ID,BIL_ID,IDENTIFIER,EVENT_DATE,QUEUE_DATE,DATA_VERSION,OLD_DATA,NEW_DATA)
    values (SEQ_BUEQ_ID.nextval,v_bsl_id,v_bil_id,v_identifier,v_event_date,sysdate,v_data_version,xmltype(v_xml_string_old),xmltype(v_xml_string_new));

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
/

alter session set plsql_code_type = interpreted;
