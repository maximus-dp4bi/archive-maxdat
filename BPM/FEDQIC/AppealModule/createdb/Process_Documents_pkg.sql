alter session set plsql_code_type = native;

create or replace package Process_Documents as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/FEDQIC/createdb/Process_Appeals_pkg.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 21871 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2017-12-04 17:23:19 -0500 (Mon, 04 Dec 2017) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: gt83345 $';

  procedure CALC_DDOCCUR;

  type T_INS_MW_XML is record
    (
  CEDOC_ID VARCHAR2(100)
, APPEAL_ID VARCHAR2(100)
, DOCUMENT_ID VARCHAR2(100)
, DOCUMENT_TYPE VARCHAR2(100) 
, ICN VARCHAR2(255 CHAR) 
, SOURCE VARCHAR2(100)  
, MAILED_DATE VARCHAR2(100)  
, DUE_DATE VARCHAR2(100) 
, UPLOADED_DATE VARCHAR2(100)
, DOCUMENT_CLAIMED_DATE VARCHAR2(100)
, SCANNED_DATE VARCHAR2(100)
, CLASSIFIED_DATE VARCHAR2(100) 
, ASSOCIATED_DATE VARCHAR2(100) 
, DATE_RECEIVED VARCHAR2(100) 
, REQUEST_INFORMATION VARCHAR2(100)  
, REQUEST_SENT_TO VARCHAR2(100)
, REQUESTOR VARCHAR2(100)
, DATE_OF_REQUEST VARCHAR2(100)
, STG_EXTRACT_DATE VARCHAR2(100)
, STG_LAST_UPDATE_DATE VARCHAR2(100)
    );
      
  type T_UPD_MW_XML is record
    (
  APPEAL_ID VARCHAR2(100)
, DOCUMENT_ID VARCHAR2(100)
, DOCUMENT_TYPE VARCHAR2(100) 
, ICN VARCHAR2(255 CHAR) 
, SOURCE VARCHAR2(100)  
, MAILED_DATE VARCHAR2(100)  
, DUE_DATE VARCHAR2(100) 
, UPLOADED_DATE VARCHAR2(100)
, DOCUMENT_CLAIMED_DATE VARCHAR2(100)
, SCANNED_DATE VARCHAR2(100)
, CLASSIFIED_DATE VARCHAR2(100) 
, ASSOCIATED_DATE VARCHAR2(100) 
, DATE_RECEIVED VARCHAR2(100) 
, REQUEST_INFORMATION VARCHAR2(100)  
, REQUEST_SENT_TO VARCHAR2(100)
, REQUESTOR VARCHAR2(100)
, DATE_OF_REQUEST VARCHAR2(100)
, STG_EXTRACT_DATE VARCHAR2(100)
, STG_LAST_UPDATE_DATE VARCHAR2(100)
    );

  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype);

  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype);

end Process_Documents;
/
create or replace package body Process_Documents as

v_bem_id number := 2003; -- 'Federal QIC'
  v_bil_id number := 3; -- 'Task ID' --???
  v_bsl_id number := 2005; -- 'FEDQIC_ETL_DOCUMENTS'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';

  v_calc_dnpacur_job_name varchar2(30) := 'CALC_DDOCCUR';



  -- Calculate column values in BPM Semantic table D_MW_TASK_INSTANCE.
  procedure CALC_DDOCCUR
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
extractValue(p_data_xml,'/ROWSET/ROW/CEDOC_ID') "CEDOC_ID",
extractValue(p_data_xml,'/ROWSET/ROW/APPEAL_ID') "APPEAL_ID",
extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_ID') "DOCUMENT_ID",
extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_TYPE') "DOCUMENT_TYPE",
extractValue(p_data_xml,'/ROWSET/ROW/ICN') "ICN",
extractValue(p_data_xml,'/ROWSET/ROW/SOURCE') "SOURCE",
extractValue(p_data_xml,'/ROWSET/ROW/MAILED_DATE') "MAILED_DATE",  
extractValue(p_data_xml,'/ROWSET/ROW/DUE_DATE') "DUE_DATE", 
extractValue(p_data_xml,'/ROWSET/ROW/UPLOADED_DATE') "UPLOADED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_CLAIMED_DATE') "DOCUMENT_CLAIMED_DATE",  
extractValue(p_data_xml,'/ROWSET/ROW/SCANNED_DATE') "SCANNED_DATE", 
extractValue(p_data_xml,'/ROWSET/ROW/CLASSIFIED_DATE') "CLASSIFIED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/ASSOCIATED_DATE') "ASSOCIATED_DATE",  
extractValue(p_data_xml,'/ROWSET/ROW/DATE_RECEIVED') "DATE_RECEIVED",  
extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_INFORMATION') "REQUEST_INFORMATION", 
extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_SENT_TO') "REQUEST_SENT_TO",
extractValue(p_data_xml,'/ROWSET/ROW/REQUESTOR') "REQUESTOR",
extractValue(p_data_xml,'/ROWSET/ROW/DATE_OF_REQUEST') "DATE_OF_REQUEST",
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
extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_ID') "DOCUMENT_ID",
extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_TYPE') "DOCUMENT_TYPE",
extractValue(p_data_xml,'/ROWSET/ROW/ICN') "ICN",
extractValue(p_data_xml,'/ROWSET/ROW/SOURCE') "SOURCE",
extractValue(p_data_xml,'/ROWSET/ROW/MAILED_DATE') "MAILED_DATE",  
extractValue(p_data_xml,'/ROWSET/ROW/DUE_DATE') "DUE_DATE", 
extractValue(p_data_xml,'/ROWSET/ROW/UPLOADED_DATE') "UPLOADED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/DOCUMENT_CLAIMED_DATE') "DOCUMENT_CLAIMED_DATE",  
extractValue(p_data_xml,'/ROWSET/ROW/SCANNED_DATE') "SCANNED_DATE", 
extractValue(p_data_xml,'/ROWSET/ROW/CLASSIFIED_DATE') "CLASSIFIED_DATE",
extractValue(p_data_xml,'/ROWSET/ROW/ASSOCIATED_DATE') "ASSOCIATED_DATE",  
extractValue(p_data_xml,'/ROWSET/ROW/DATE_RECEIVED') "DATE_RECEIVED",  
extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_INFORMATION') "REQUEST_INFORMATION", 
extractValue(p_data_xml,'/ROWSET/ROW/REQUEST_SENT_TO') "REQUEST_SENT_TO",
extractValue(p_data_xml,'/ROWSET/ROW/REQUESTOR') "REQUESTOR",
extractValue(p_data_xml,'/ROWSET/ROW/DATE_OF_REQUEST') "DATE_OF_REQUEST",
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
       p_bi_id in number,
p_APPEAL_ID in varchar2,
p_DOCUMENT_ID in varchar2,
p_DOCUMENT_TYPE in varchar2,
p_ICN in varchar2,
p_SOURCE in varchar2,  
p_MAILED_DATE in varchar2, 
p_DUE_DATE in varchar2,
p_UPLOADED_DATE in varchar2,  
p_DOCUMENT_CLAIMED_DATE in varchar2, 
p_SCANNED_DATE in varchar2,
p_CLASSIFIED_DATE in varchar2, 
p_ASSOCIATED_DATE in varchar2,  
p_DATE_RECEIVED in varchar2, 
p_REQUEST_INFORMATION in varchar2,
p_REQUEST_SENT_TO in varchar2,
p_REQUESTOR in varchar2,
p_DATE_OF_REQUEST in varchar2,
p_STG_EXTRACT_DATE in VARCHAR2,
p_STG_LAST_UPDATE_DATE in VARCHAR2       )
  as

    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DMWCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dmwcur D_QIC_DOCUMENT%rowtype := null;
    v_dmwcur_rows number := null;

  begin

r_dmwcur.doc_bi_id                      :=  p_bi_id;
r_dmwcur.APPEAL_ID         	:=  p_APPEAL_ID;
r_dmwcur.DOCUMENT_ID         	:=  p_DOCUMENT_ID;
r_dmwcur.DOCUMENT_TYPE         	:=  p_DOCUMENT_TYPE;
r_dmwcur.ICN         		:=  p_ICN;
r_dmwcur.SOURCE        	:=  p_SOURCE;
r_dmwcur.MAILED_DATE         	:=  to_timestamp(p_MAILED_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.DUE_DATE         	:=  to_timestamp(p_DUE_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.UPLOADED_DATE         	:=  to_timestamp(p_UPLOADED_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.DOCUMENT_CLAIMED_DATE 	:=  to_timestamp(p_DOCUMENT_CLAIMED_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.SCANNED_DATE         	:=  to_timestamp(p_SCANNED_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.CLASSIFIED_DATE        :=  to_timestamp(p_CLASSIFIED_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.ASSOCIATED_DATE        :=  to_timestamp(p_ASSOCIATED_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.DATE_RECEIVED         	:=  to_timestamp(p_DATE_RECEIVED,BPM_COMMON.DATE_FMT);
r_dmwcur.REQUEST_INFORMATION 	:=  p_REQUEST_INFORMATION;
r_dmwcur.REQUEST_SENT_TO        	:=  p_REQUEST_SENT_TO;
r_dmwcur.REQUESTOR         	:=  p_REQUESTOR;
r_dmwcur.DATE_OF_REQUEST         	:=  to_timestamp(p_DATE_OF_REQUEST,BPM_COMMON.DATE_FMT);
r_dmwcur.STG_EXTRACT_DATE         	:=  to_timestamp(p_STG_EXTRACT_DATE,BPM_COMMON.DATE_FMT);
r_dmwcur.STG_LAST_UPDATE_DATE         	:=  to_timestamp(p_STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT);

    if p_set_type = 'INSERT' then
      insert into D_QIC_DOCUMENT
      values r_dmwcur;
    elsif p_set_type = 'UPDATE' then
      update D_QIC_DOCUMENT
      set row = r_dmwcur
      where DOC_BI_ID = p_bi_id;
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
    v_identifier varchar2(100) := null;
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
  	v_identifier := v_new_data.DOCUMENT_ID;
    --v_BUCKET_START_DATE := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    --v_BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    v_bi_id := SEQ_DOC_BI_ID.nextval;
    v_identifier := v_new_data.DOCUMENT_ID;

    -- Insert current dimension and fact as a single transaction.
    begin

      SET_DMWCUR
        ('INSERT',
		     v_identifier,
		     v_bi_id,
v_new_data.APPEAL_ID,
v_new_data.DOCUMENT_ID,
v_new_data.DOCUMENT_TYPE,
v_new_data.ICN,
v_new_data.SOURCE,  
v_new_data.MAILED_DATE, 
v_new_data.DUE_DATE,
v_new_data.UPLOADED_DATE,  
v_new_data.DOCUMENT_CLAIMED_DATE, 
v_new_data.SCANNED_DATE,
v_new_data.CLASSIFIED_DATE, 
v_new_data.ASSOCIATED_DATE,  
v_new_data.DATE_RECEIVED, 
v_new_data.REQUEST_INFORMATION,
v_new_data.REQUEST_SENT_TO,
v_new_data.REQUESTOR,
v_new_data.DATE_OF_REQUEST,
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
    v_identifier := v_new_data.DOCUMENT_ID;
    --v_bucket_start_date := to_date(to_char(BPM_COMMON.MIN_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);
    --v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_GDATE,v_date_bucket_fmt),v_date_bucket_fmt);

	select DOC_BI_ID
    into v_bi_id
    from D_QIC_DOCUMENT
    where DOCUMENT_ID = v_identifier;

begin
     SET_DMWCUR
        ('UPDATE',
		     v_identifier,
		     v_bi_id,
v_new_data.APPEAL_ID,
v_new_data.DOCUMENT_ID,
v_new_data.DOCUMENT_TYPE,
v_new_data.ICN,
v_new_data.SOURCE,  
v_new_data.MAILED_DATE, 
v_new_data.DUE_DATE,
v_new_data.UPLOADED_DATE,  
v_new_data.DOCUMENT_CLAIMED_DATE, 
v_new_data.SCANNED_DATE,
v_new_data.CLASSIFIED_DATE, 
v_new_data.ASSOCIATED_DATE,  
v_new_data.DATE_RECEIVED, 
v_new_data.REQUEST_INFORMATION,
v_new_data.REQUEST_SENT_TO,
v_new_data.REQUESTOR,
v_new_data.DATE_OF_REQUEST,
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

end Process_Documents;
/

alter session set plsql_code_type = interpreted;