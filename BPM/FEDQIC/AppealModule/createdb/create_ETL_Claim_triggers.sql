alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_CORP_ETL_CLAIM
before insert or update on CORP_ETL_CLAIM_WIP
for each row
declare
  v_instance_start_date date := null;
  v_instance_end_date date := null;

begin

  if inserting then

    if
	  :new.CECLM_ID is null then  :new.CECLM_ID := SEQ_CECLM_ID.nextval;
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

create or replace trigger TRG_AI_CORP_ETL_CLAIM_Q
after insert on CORP_ETL_CLAIM
for each row

declare

  v_bsl_id number := 2006; -- 'FEDQIC_ETL'
  v_bil_id number := 3; -- 'Task ID'
  v_data_version number := 3; -- CDATA for varchar2 only and added STG_LAST_UPDATE_DATE
  v_identifier varchar2(100) := null;
  v_xml_string_new clob := null;
  v_sql_code number := null;
  v_log_message clob := null;
  v_event_date date := null;

begin

  v_event_date := :new.STG_LAST_UPDATE_DATE;
  v_identifier := :new.CLAIM_ID;

  /*
  Include:
    CECLM_ID
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_new :=
    '<?xml version="1.0"?>
    <ROWSET>
      <ROW>
        <CECLM_ID>' || :new.CECLM_ID || '</CECLM_ID>
         <APPEAL_ID><![CDATA[' || :new.APPEAL_ID || ']]></APPEAL_ID>
         <CLAIM_NUMBER><![CDATA[' || :new.CLAIM_NUMBER || ']]></CLAIM_NUMBER>
         <CLAIM_ID><![CDATA[' || :new.CLAIM_ID || ']]></CLAIM_ID>
         <HCPCS_CODE><![CDATA[' || :new.HCPCS_CODE || ']]></HCPCS_CODE>
        <ACTION_CODE><![CDATA[' || :new.ACTION_CODE || ']]></ACTION_CODE>
        <APPELLANT_ARGUMENT><![CDATA[' || :new.APPELLANT_ARGUMENT || ']]></APPELLANT_ARGUMENT>
        <DISPOSITION><![CDATA[' || :new.DISPOSITION || ']]></DISPOSITION>
        <DISPOSITION_EXPLANATION><![CDATA[' || :new.DISPOSITION_EXPLANATION || ']]></DISPOSITION_EXPLANATION>
        <REVERSAL_REASON><![CDATA[' || :new.REVERSAL_REASON || ']]></REVERSAL_REASON>
        <PROCEDURAL_DECISION_REASON><![CDATA[' || :new.PROCEDURAL_DECISION_REASON || ']]></PROCEDURAL_DECISION_REASON>
        <SUBSTANTIVE_REASON><![CDATA[' || :new.SUBSTANTIVE_REASON || ']]></SUBSTANTIVE_REASON>
        <CITATION_SOURCE><![CDATA[' || :new.CITATION_SOURCE || ']]></CITATION_SOURCE>
         <PROVIDER><![CDATA[' || :new.PROVIDER || ']]></PROVIDER>
        <PROVIDER_NAME><![CDATA[' || :new.PROVIDER_NAME || ']]></PROVIDER_NAME>
        <CLAIM_DIAGNOSIS_CODES><![CDATA[' || :new.CLAIM_DIAGNOSIS_CODES || ']]></CLAIM_DIAGNOSIS_CODES>
        <CLAIM_PROCEDURE_CODES><![CDATA[' || :new.CLAIM_PROCEDURE_CODES || ']]></CLAIM_PROCEDURE_CODES>
        <CLAIM_STATUS_CODE><![CDATA[' || :new.CLAIM_STATUS_CODE || ']]></CLAIM_STATUS_CODE>
        <CLAIM_ADJUSTMENT_CODE><![CDATA[' || :new.CLAIM_ADJUSTMENT_CODE || ']]></CLAIM_ADJUSTMENT_CODE>
        <NATIONAL_DRUG_CODE><![CDATA[' || :new.NATIONAL_DRUG_CODE || ']]></NATIONAL_DRUG_CODE>
        <TYPE_OF_COVERAGE><![CDATA[' || :new.TYPE_OF_COVERAGE || ']]></TYPE_OF_COVERAGE>
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


create or replace trigger TRG_AU_CORP_ETL_CLAIM_Q
after update on CORP_ETL_CLAIM
for each row

declare

  v_bsl_id number := 2006; -- 'FEDQIC_ETL'
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
  v_identifier := :new.CLAIM_ID;

  /*
  Include:
    STG_LAST_UPDATE_DATE
  */
  v_xml_string_old :=
    '<?xml version="1.0"?>
    <ROWSET>
<ROW>
         <APPEAL_ID><![CDATA[' || :old.APPEAL_ID || ']]></APPEAL_ID>
         <CLAIM_ID><![CDATA[' || :old.CLAIM_ID || ']]></CLAIM_ID>
         <CLAIM_NUMBER><![CDATA[' || :old.CLAIM_NUMBER || ']]></CLAIM_NUMBER>
         <HCPCS_CODE><![CDATA[' || :old.HCPCS_CODE || ']]></HCPCS_CODE>
        <ACTION_CODE><![CDATA[' || :old.ACTION_CODE || ']]></ACTION_CODE>
        <APPELLANT_ARGUMENT><![CDATA[' || :old.APPELLANT_ARGUMENT || ']]></APPELLANT_ARGUMENT>
        <DISPOSITION><![CDATA[' || :old.DISPOSITION || ']]></DISPOSITION>
        <DISPOSITION_EXPLANATION><![CDATA[' || :old.DISPOSITION_EXPLANATION || ']]></DISPOSITION_EXPLANATION>
        <REVERSAL_REASON><![CDATA[' || :old.REVERSAL_REASON || ']]></REVERSAL_REASON>
        <PROCEDURAL_DECISION_REASON><![CDATA[' || :old.PROCEDURAL_DECISION_REASON || ']]></PROCEDURAL_DECISION_REASON>
        <SUBSTANTIVE_REASON><![CDATA[' || :old.SUBSTANTIVE_REASON || ']]></SUBSTANTIVE_REASON>
        <CITATION_SOURCE><![CDATA[' || :old.CITATION_SOURCE || ']]></CITATION_SOURCE>
        <PROVIDER><![CDATA[' || :old.PROVIDER || ']]></PROVIDER>
        <PROVIDER_NAME><![CDATA[' || :old.PROVIDER_NAME || ']]></PROVIDER_NAME>
        <CLAIM_DIAGNOSIS_CODES><![CDATA[' || :old.CLAIM_DIAGNOSIS_CODES || ']]></CLAIM_DIAGNOSIS_CODES>
        <CLAIM_PROCEDURE_CODES><![CDATA[' || :old.CLAIM_PROCEDURE_CODES || ']]></CLAIM_PROCEDURE_CODES>
        <CLAIM_STATUS_CODE><![CDATA[' || :old.CLAIM_STATUS_CODE || ']]></CLAIM_STATUS_CODE>
        <CLAIM_ADJUSTMENT_CODE><![CDATA[' || :old.CLAIM_ADJUSTMENT_CODE || ']]></CLAIM_ADJUSTMENT_CODE>
        <NATIONAL_DRUG_CODE><![CDATA[' || :old.NATIONAL_DRUG_CODE || ']]></NATIONAL_DRUG_CODE>
        <TYPE_OF_COVERAGE><![CDATA[' || :old.TYPE_OF_COVERAGE || ']]></TYPE_OF_COVERAGE>
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
         <APPEAL_ID><![CDATA[' || :new.APPEAL_ID || ']]></APPEAL_ID>
         <CLAIM_ID><![CDATA[' || :new.CLAIM_ID || ']]></CLAIM_ID>
         <CLAIM_NUMBER><![CDATA[' || :new.CLAIM_NUMBER || ']]></CLAIM_NUMBER>
         <HCPCS_CODE><![CDATA[' || :new.HCPCS_CODE || ']]></HCPCS_CODE>
        <ACTION_CODE><![CDATA[' || :new.ACTION_CODE || ']]></ACTION_CODE>
        <APPELLANT_ARGUMENT><![CDATA[' || :new.APPELLANT_ARGUMENT || ']]></APPELLANT_ARGUMENT>
        <DISPOSITION><![CDATA[' || :new.DISPOSITION || ']]></DISPOSITION>
        <DISPOSITION_EXPLANATION><![CDATA[' || :new.DISPOSITION_EXPLANATION || ']]></DISPOSITION_EXPLANATION>
        <REVERSAL_REASON><![CDATA[' || :new.REVERSAL_REASON || ']]></REVERSAL_REASON>
        <PROCEDURAL_DECISION_REASON><![CDATA[' || :new.PROCEDURAL_DECISION_REASON || ']]></PROCEDURAL_DECISION_REASON>
        <SUBSTANTIVE_REASON><![CDATA[' || :new.SUBSTANTIVE_REASON || ']]></SUBSTANTIVE_REASON>
        <CITATION_SOURCE><![CDATA[' || :new.CITATION_SOURCE || ']]></CITATION_SOURCE>
        <PROVIDER><![CDATA[' || :new.PROVIDER || ']]></PROVIDER>
        <PROVIDER_NAME><![CDATA[' || :new.PROVIDER_NAME || ']]></PROVIDER_NAME>
        <CLAIM_DIAGNOSIS_CODES><![CDATA[' || :new.CLAIM_DIAGNOSIS_CODES || ']]></CLAIM_DIAGNOSIS_CODES>
        <CLAIM_PROCEDURE_CODES><![CDATA[' || :new.CLAIM_PROCEDURE_CODES || ']]></CLAIM_PROCEDURE_CODES>
        <CLAIM_STATUS_CODE><![CDATA[' || :new.CLAIM_STATUS_CODE || ']]></CLAIM_STATUS_CODE>
        <CLAIM_ADJUSTMENT_CODE><![CDATA[' || :new.CLAIM_ADJUSTMENT_CODE || ']]></CLAIM_ADJUSTMENT_CODE>
        <NATIONAL_DRUG_CODE><![CDATA[' || :new.NATIONAL_DRUG_CODE || ']]></NATIONAL_DRUG_CODE>
        <TYPE_OF_COVERAGE><![CDATA[' || :new.TYPE_OF_COVERAGE || ']]></TYPE_OF_COVERAGE>
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
