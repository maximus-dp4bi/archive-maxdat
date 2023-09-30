alter session set plsql_code_type = native;

create or replace package Process_Claims as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/FEDQIC/createdb/Process_Appeals_pkg.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 21871 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2017-12-04 17:23:19 -0500 (Mon, 04 Dec 2017) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: gt83345 $';

  procedure CALC_DCLMCUR;

  type T_INS_MW_XML is record
    (
CECLM_ID varchar2(255)
, APPEAL_ID varchar2(255)
, CLAIM_ID varchar2(255) 
, CLAIM_NUMBER varchar2(255)  
, HCPCS_CODE varchar2(255) 
, ACTION_CODE varchar2(255)   
, APPELLANT_ARGUMENT varchar2(255)  
, DISPOSITION varchar2(255) 
, DISPOSITION_EXPLANATION varchar2(255)     
, REVERSAL_REASON varchar2(255) 
, PROCEDURAL_DECISION_REASON varchar2(255)   
, SUBSTANTIVE_REASON varchar2(255)  
, CITATION_SOURCE varchar2(255)  
, PROVIDER varchar2(255)
, PROVIDER_NAME varchar2(255)
, CLAIM_DIAGNOSIS_CODES varchar2(255)
, CLAIM_PROCEDURE_CODES varchar2(255)
, CLAIM_STATUS_CODE varchar2(255)
, CLAIM_ADJUSTMENT_CODE varchar2(255)
, NATIONAL_DRUG_CODE varchar2(255)
, TYPE_OF_COVERAGE varchar2(255)
, STG_EXTRACT_DATE varchar2(255)
, STG_LAST_UPDATE_DATE varchar2(255)
);
      
  type T_UPD_MW_XML is record
    (
 APPEAL_ID varchar2(255)
, CLAIM_ID varchar2(255) 
, CLAIM_NUMBER varchar2(255)  
, HCPCS_CODE varchar2(255) 
, ACTION_CODE varchar2(255)   
, APPELLANT_ARGUMENT varchar2(255)  
, DISPOSITION varchar2(255) 
, DISPOSITION_EXPLANATION varchar2(255)     
, REVERSAL_REASON varchar2(255) 
, PROCEDURAL_DECISION_REASON varchar2(255)   
, SUBSTANTIVE_REASON varchar2(255)  
, CITATION_SOURCE varchar2(255)  
, PROVIDER varchar2(255)
, PROVIDER_NAME varchar2(255)
, CLAIM_DIAGNOSIS_CODES varchar2(255)
, CLAIM_PROCEDURE_CODES varchar2(255)
, CLAIM_STATUS_CODE varchar2(255)
, CLAIM_ADJUSTMENT_CODE varchar2(255)
, NATIONAL_DRUG_CODE varchar2(255)
, TYPE_OF_COVERAGE varchar2(255)
, STG_EXTRACT_DATE varchar2(255)
, STG_LAST_UPDATE_DATE varchar2(255)
);

  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype);

  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype);

end Process_Claims;
/
create or replace package body Process_Claims as

v_bem_id number := 2004; -- 'Federal QIC'
  v_bil_id number := 3; -- 'Task ID' --???
  v_bsl_id number := 2006; -- 'FEDQIC_ETL_DOCUMENTS'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';

  v_calc_dnpacur_job_name varchar2(30) := 'CALC_DCLMCUR';



  -- Calculate column values in BPM Semantic table D_MW_TASK_INSTANCE.
  procedure CALC_DCLMCUR
  as
  v_test number :=1;
  begin
  select 1 into v_test from dual;
  end;

   -- Get record for Manage Work insert data.
 procedure GET_INS_MW_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_MW_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_MW_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin

select
extractValue(p_data_xml,'/ROWSET/ROW/CECLM_ID') "CECLM_ID",
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_ID') "APPEAL_ID",
extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_ID') "CLAIM_ID",
extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_NUMBER') "CLAIM_NUMBER",
extractValue(p_data_xml,'/ROWSET/ROW/HCPCS_CODE') "HCPCS_CODE",
extractValue(p_data_xml,'/ROWSET/ROW/ACTION_CODE') "ACTION_CODE",
extractValue(p_data_xml,'/ROWSET/ROW/APPELLANT_ARGUMENT') "APPELLANT_ARGUMENT",  
extractValue(p_data_xml,'/ROWSET/ROW/DISPOSITION') "DISPOSITION", 
extractValue(p_data_xml,'/ROWSET/ROW/DISPOSITION_EXPLANATION') "DISPOSITION_EXPLANATION",
extractValue(p_data_xml,'/ROWSET/ROW/REVERSAL_REASON') "REVERSAL_REASON",  
extractValue(p_data_xml,'/ROWSET/ROW/PROCEDURAL_DECISION_REASON') "PROCEDURAL_DECISION_REASON", 
extractValue(p_data_xml,'/ROWSET/ROW/SUBSTANTIVE_REASON') "SUBSTANTIVE_REASON",
extractValue(p_data_xml,'/ROWSET/ROW/CITATION_SOURCE') "CITATION_SOURCE",  
extractValue(p_data_xml,'/ROWSET/ROW/PROVIDER') "PROVIDER",  
extractValue(p_data_xml,'/ROWSET/ROW/PROVIDER_NAME') "PROVIDER_NAME", 
extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_DIAGNOSIS_CODES') "CLAIM_DIAGNOSIS_CODES",
extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_PROCEDURE_CODES') "CLAIM_PROCEDURE_CODES",
extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_STATUS_CODE') "CLAIM_STATUS_CODE",
extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_ADJUSTMENT_CODE') "CLAIM_ADJUSTMENT_CODE",
extractValue(p_data_xml,'/ROWSET/ROW/NATIONAL_DRUG_CODE') "NATIONAL_DRUG_CODE",
extractValue(p_data_xml,'/ROWSET/ROW/TYPE_OF_COVERAGE') "TYPE_OF_COVERAGE",
extractValue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DATE') "STG_EXTRACT_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE" 
into p_data_record
from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;

  end;

  -- Get record for Manage Work update data XML.
  procedure GET_UPD_MW_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_MW_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_MW_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin

select
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_ID') "APPEAL_ID",
extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_ID') "CLAIM_ID",
extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_NUMBER') "CLAIM_NUMBER",
extractValue(p_data_xml,'/ROWSET/ROW/HCPCS_CODE') "HCPCS_CODE",
extractValue(p_data_xml,'/ROWSET/ROW/ACTION_CODE') "ACTION_CODE",
extractValue(p_data_xml,'/ROWSET/ROW/APPELLANT_ARGUMENT') "APPELLANT_ARGUMENT",  
extractValue(p_data_xml,'/ROWSET/ROW/DISPOSITION') "DISPOSITION", 
extractValue(p_data_xml,'/ROWSET/ROW/DISPOSITION_EXPLANATION') "DISPOSITION_EXPLANATION",
extractValue(p_data_xml,'/ROWSET/ROW/REVERSAL_REASON') "REVERSAL_REASON",  
extractValue(p_data_xml,'/ROWSET/ROW/PROCEDURAL_DECISION_REASON') "PROCEDURAL_DECISION_REASON", 
extractValue(p_data_xml,'/ROWSET/ROW/SUBSTANTIVE_REASON') "SUBSTANTIVE_REASON",
extractValue(p_data_xml,'/ROWSET/ROW/CITATION_SOURCE') "CITATION_SOURCE",  
extractValue(p_data_xml,'/ROWSET/ROW/PROVIDER') "PROVIDER",  
extractValue(p_data_xml,'/ROWSET/ROW/PROVIDER_NAME') "PROVIDER_NAME", 
extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_DIAGNOSIS_CODES') "CLAIM_DIAGNOSIS_CODES",
extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_PROCEDURE_CODES') "CLAIM_PROCEDURE_CODES",
extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_STATUS_CODE') "CLAIM_STATUS_CODE",
extractValue(p_data_xml,'/ROWSET/ROW/CLAIM_ADJUSTMENT_CODE') "CLAIM_ADJUSTMENT_CODE",
extractValue(p_data_xml,'/ROWSET/ROW/NATIONAL_DRUG_CODE') "NATIONAL_DRUG_CODE",
extractValue(p_data_xml,'/ROWSET/ROW/TYPE_OF_COVERAGE') "TYPE_OF_COVERAGE",
extractValue(p_data_xml,'/ROWSET/ROW/STG_EXTRACT_DATE') "STG_EXTRACT_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE" 
into p_data_record
from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;

  end;

  procedure SET_DMWCUR
      (p_set_type in varchar2,
       p_identifier in varchar2,
       p_bi_id in number
, p_APPEAL_ID in VARCHAR2
, p_CLAIM_ID in VARCHAR2 
, p_CLAIM_NUMBER in VARCHAR2  
, p_HCPCS_CODE in VARCHAR2 
, p_ACTION_CODE in VARCHAR2   
, p_APPELLANT_ARGUMENT in VARCHAR2  
, p_DISPOSITION in VARCHAR2 
, p_DISPOSITION_EXPLANATION in VARCHAR2     
, p_REVERSAL_REASON in VARCHAR2 
, p_PROCEDURAL_DECISION_REASON in VARCHAR2   
, p_SUBSTANTIVE_REASON in VARCHAR2  
, p_CITATION_SOURCE in VARCHAR2  
, p_PROVIDER in VARCHAR2
, p_PROVIDER_NAME in VARCHAR2
, p_CLAIM_DIAGNOSIS_CODES in VARCHAR2
, p_CLAIM_PROCEDURE_CODES in VARCHAR2
, p_CLAIM_STATUS_CODE in VARCHAR2
, p_CLAIM_ADJUSTMENT_CODE in VARCHAR2
, p_NATIONAL_DRUG_CODE in VARCHAR2
, p_TYPE_OF_COVERAGE in VARCHAR2
, p_STG_EXTRACT_DATE in VARCHAR2
, p_STG_LAST_UPDATE_DATE in VARCHAR2 )
  as

    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DMWCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dmwcur D_QIC_CLAIM%rowtype := null;
    v_dmwcur_rows number := null;

  begin

r_dmwcur.clm_bi_id                      :=  p_bi_id;
r_dmwcur.APPEAL_ID         	:=  p_APPEAL_ID;
r_dmwcur.CLAIM_ID         	:=  p_CLAIM_ID;
r_dmwcur.CLAIM_NUMBER         		:=  p_CLAIM_NUMBER;
r_dmwcur.HCPCS_CODE         		:=  p_HCPCS_CODE;
r_dmwcur.ACTION_CODE         		:=  p_ACTION_CODE;
r_dmwcur.APPELLANT_ARGUMENT         		:=  p_APPELLANT_ARGUMENT;
r_dmwcur.DISPOSITION         		:=  p_DISPOSITION;
r_dmwcur.DISPOSITION_EXPLANATION         		:=  p_DISPOSITION_EXPLANATION;
r_dmwcur.REVERSAL_REASON         		:=  p_REVERSAL_REASON;
r_dmwcur.PROCEDURAL_DECISION_REASON         		:=  p_PROCEDURAL_DECISION_REASON;
r_dmwcur.SUBSTANTIVE_REASON         		:=  p_SUBSTANTIVE_REASON;
r_dmwcur.CITATION_SOURCE         		:=  p_CITATION_SOURCE;
r_dmwcur.PROVIDER         		:=  p_PROVIDER;
r_dmwcur.PROVIDER_NAME         		:=  p_PROVIDER_NAME;
r_dmwcur.CLAIM_DIAGNOSIS_CODES         		:=  p_CLAIM_DIAGNOSIS_CODES;
r_dmwcur.CLAIM_PROCEDURE_CODES         		:=  p_CLAIM_PROCEDURE_CODES;
r_dmwcur.CLAIM_STATUS_CODE         		:=  p_CLAIM_STATUS_CODE;
r_dmwcur.CLAIM_ADJUSTMENT_CODE         		:=  p_CLAIM_ADJUSTMENT_CODE;
r_dmwcur.NATIONAL_DRUG_CODE        		:=  p_NATIONAL_DRUG_CODE;
r_dmwcur.TYPE_OF_COVERAGE         		:=  p_TYPE_OF_COVERAGE;
r_dmwcur.STG_EXTRACT_DATE         	:=  to_timestamp(p_STG_EXTRACT_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.STG_LAST_UPDATE_DATE         	:=  to_timestamp(p_STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT);


    if p_set_type = 'INSERT' then
      insert into D_QIC_CLAIM
      values r_dmwcur;
    elsif p_set_type = 'UPDATE' then
      update D_QIC_CLAIM
      set row = r_dmwcur
      where CLM_BI_ID = p_bi_id;
    else
      v_log_message := 'Unexpected p_set_type value "' || p_set_type || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(-20001,v_log_message);
    end if;

  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
  end;

 
  -- Insert BPM Semantic model data.
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype)
  as

    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;
    v_new_data T_INS_MW_XML := null;
    v_bi_id number := null;
    v_identifier varchar2(255) := null;
    --v_bucket_start_date date := null;
    --v_bucket_end_date date := null;
    --v_dmwbd_id number := null;

  begin
  DBMS_OUTPUT.put_line('in MW.INSERT_BPM_SEMANTIC...');
    if p_data_version != 3
    then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for MW in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;

    GET_INS_MW_XML(p_new_data_xml,v_new_data);
  	v_identifier := v_new_data.CLAIM_ID;
    --v_BUCKET_START_DATE := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    --v_BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bi_id := SEQ_CLM_BI_ID.nextval;
    v_identifier := v_new_data.CLAIM_ID;

    -- Insert current dimension and fact as a single transaction.
    begin

      SET_DMWCUR
        ('INSERT',
		     v_identifier,
		     v_bi_id,
v_new_data.APPEAL_ID,
v_new_data.CLAIM_ID,
v_new_data.CLAIM_NUMBER,
v_new_data.HCPCS_CODE,
v_new_data.ACTION_CODE,  
v_new_data.APPELLANT_ARGUMENT, 
v_new_data.DISPOSITION,
v_new_data.DISPOSITION_EXPLANATION,  
v_new_data.REVERSAL_REASON, 
v_new_data.PROCEDURAL_DECISION_REASON,
v_new_data.SUBSTANTIVE_REASON, 
v_new_data.CITATION_SOURCE,  
v_new_data.PROVIDER, 
v_new_data.PROVIDER_NAME,
v_new_data.CLAIM_DIAGNOSIS_CODES,
v_new_data.CLAIM_PROCEDURE_CODES,
v_new_data.CLAIM_STATUS_CODE,
v_new_data.CLAIM_ADJUSTMENT_CODE,
v_new_data.NATIONAL_DRUG_CODE,
v_new_data.TYPE_OF_COVERAGE,
v_new_data.STG_EXTRACT_DATE,
v_new_data.STG_LAST_UPDATE_DATE
);
commit;

    exception

      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
	      v_log_message := 'Rolled back initial insert for current dimension and fact.  ' || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
        raise;

    end;

  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
      raise;

  end;


 -- Update BPM Semantic model data.
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype)
  as

    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;
    v_old_data T_UPD_MW_XML := null;
    v_new_data T_UPD_MW_XML := null;
    v_bi_id number := null;
    v_identifier number := null;
    v_dmwbd_id number := null;
    --v_bucket_start_date date := null;
    --v_bucket_end_date date := null;


  begin
DBMS_OUTPUT.put_line('in MW.INSERT_BPM_SEMANTIC...');
    if p_data_version != 3 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for MW procedure ' || v_procedure_name ||'.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;

	  GET_UPD_MW_XML(p_old_data_xml,v_old_data);
    GET_UPD_MW_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.CLAIM_ID;
    --v_bucket_start_date := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    --v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);

	select CLM_BI_ID
    into v_bi_id
    from D_QIC_CLAIM
    where CLAIM_ID = v_identifier;

begin
     SET_DMWCUR
        ('UPDATE',
		     v_identifier,
		     v_bi_id,
v_new_data.APPEAL_ID,
v_new_data.CLAIM_ID,
v_new_data.CLAIM_NUMBER,
v_new_data.HCPCS_CODE,
v_new_data.ACTION_CODE,  
v_new_data.APPELLANT_ARGUMENT, 
v_new_data.DISPOSITION,
v_new_data.DISPOSITION_EXPLANATION,  
v_new_data.REVERSAL_REASON, 
v_new_data.PROCEDURAL_DECISION_REASON,
v_new_data.SUBSTANTIVE_REASON, 
v_new_data.CITATION_SOURCE,  
v_new_data.PROVIDER, 
v_new_data.PROVIDER_NAME,
v_new_data.CLAIM_DIAGNOSIS_CODES,
v_new_data.CLAIM_PROCEDURE_CODES,
v_new_data.CLAIM_STATUS_CODE,
v_new_data.CLAIM_ADJUSTMENT_CODE,
v_new_data.NATIONAL_DRUG_CODE,
v_new_data.TYPE_OF_COVERAGE,
v_new_data.STG_EXTRACT_DATE,
v_new_data.STG_LAST_UPDATE_DATE
);

commit;

  exception
   when OTHERS then
   rollback;
    v_sql_code := SQLCODE;
    v_log_message := 'Rolled back latest current dimension and fact changes.'  || SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
   raise;
  end;

  exception
   when NO_DATA_FOUND then
    v_sql_code := SQLCODE;
    v_log_message := 'No BPM_INSTANCE found.'|| SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
  raise;

   when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);
   raise;

  end UPDATE_BPM_SEMANTIC;

end Process_Claims;
/

alter session set plsql_code_type = interpreted;