alter session set plsql_code_type = native;

create or replace procedure PRC_BPM_ETL_BIA_INS 
  (p_bia_id in number,
   p_bi_id in number,
   p_ba_id in number,
   p_value_number in number,
   p_value_date in date,
   p_value_char in varchar2, 
   p_start_date in date,
   p_end_date in date,
   p_bue_id in number) as
   
begin

  insert into BPM_INSTANCE_ATTRIBUTE
    (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
     VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
  values
    (p_bia_id,p_bi_id,p_ba_id,p_value_number,p_value_date,
     p_value_char,p_start_date,p_end_date,p_bue_id);

end PRC_BPM_ETL_BIA_INS;
/

create or replace procedure PRC_BPM_ETL_BIA_UPD
  (p_attr_update_method in varchar2,
   p_source_id in varchar2, 
   p_bi_id in number, 
   p_ba_id in number,  
   p_value_number in number,
   p_value_date in date,
   p_value_char in varchar2,
   p_bue_id in number) as
   
  v_bia_id number := null;
  v_be_id  number := null;
   
  v_current_sysdate date := null;
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
  
  v_sql_code number := null;
  v_error_message varchar2(500) := null;

begin

  v_bia_id := SEQ_BIA_ID.nextval;
    
  v_current_sysdate := sysdate;
  
  if p_attr_update_method = 'INSERT' then
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = v_current_sysdate
    where 
      BI_ID = p_bi_id
      and BA_ID = p_ba_id
      and END_DATE = v_max_date;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,p_bi_id,p_ba_id,p_value_number,p_value_date,
       p_value_char,v_current_sysdate,v_max_date,p_bue_id);
       
  elsif p_attr_update_method = 'UPDATE' then
  
    update BPM_INSTANCE_ATTRIBUTE
    set  
      VALUE_NUMBER = p_value_number,
      VALUE_DATE = p_value_date,
      VALUE_CHAR = p_value_char,
      BUE_ID = p_bue_id
    where 
      BI_ID = p_bi_id
      and BA_ID = p_ba_id 
      and END_DATE = v_max_date;
      
  else

    rollback;
    
    v_error_message := 'Unsupported p_attr_update_method "' || p_attr_update_method || 
      ' for SOURCE_ID=' || p_source_id || ' BI_ID=' || p_bi_id || ' BA_ID=' || p_ba_id || ' .';
      
    v_be_id := SEQ_BE_ID.nextval;
    
    insert into BPM_ERRORS 
      (BE_ID,ERROR_DATE,RUN_DATA_OBJECT,SOURCE_ID,BI_ID,BIA_ID,
       ERROR_NUMBER,ERROR_MESSAGE) 
    values 
      (v_be_id,sysdate,$$PLSQL_UNIT,p_source_id,p_bi_id,v_bia_id,
       null,v_error_message);

    commit;
    
    dbms_output.put_line('Exception: ' || v_error_message || ' See BPM_ERRORS.BE_ID = ' || v_be_id || ' for more details.');

  end if;

exception

  when others then
    rollback;
    
    v_sql_code := SQLCODE;
    v_error_message := substr(SQLERRM,1,500);
    v_be_id := SEQ_BE_ID.nextval;
    
    insert into BPM_ERRORS 
      (BE_ID,ERROR_DATE,RUN_DATA_OBJECT,SOURCE_ID,BI_ID,BIA_ID,
       ERROR_NUMBER,ERROR_MESSAGE) 
    values 
      (v_be_id,sysdate,$$PLSQL_UNIT,p_source_id,p_bi_id,v_bia_id,
       v_sql_code,v_error_message);

    commit;
    
    dbms_output.put_line('Exception: ' || v_error_message || ' See BPM_ERRORS.BE_ID = ' || v_be_id || ' for more details.');
    
end;
/

create or replace procedure PRC_BPM_ETL_BIA_UPD_NUM
  (p_attr_update_method in varchar2,
   p_source_id in varchar2, 
   p_bi_id in number,
   p_ba_id in number,
   p_old_value in number,
   p_new_value in number,
   p_bue_id in number) as

begin

  if   (p_old_value is null and p_new_value is not null)
    or (p_old_value is not null and p_new_value is null)
    or  p_old_value != p_new_value then
    
    PRC_BPM_ETL_BIA_UPD(p_attr_update_method,p_source_id,p_bi_id,p_ba_id,p_new_value,null,null,p_bue_id);
       
  end if;

end;
/

create or replace procedure PRC_BPM_ETL_BIA_UPD_DATE
  (p_attr_update_method in varchar2,
   p_source_id in varchar2, 
   p_bi_id in number,
   p_ba_id in number,
   p_old_value in date,
   p_new_value in date,
   p_bue_id in number) as

begin

  if   (p_old_value is null and p_new_value is not null)
    or (p_old_value is not null and p_new_value is null)
    or  p_old_value != p_new_value then
    
    PRC_BPM_ETL_BIA_UPD(p_attr_update_method,p_source_id,p_bi_id,p_ba_id,null,p_new_value,null,p_bue_id);
       
  end if;

end;
/

create or replace procedure PRC_BPM_ETL_BIA_UPD_CHAR
  (p_attr_update_method in varchar2,
   p_source_id in varchar2,
   p_bi_id in number,
   p_ba_id in number,
   p_old_value in varchar2,
   p_new_value in varchar2,
   p_bue_id in number) as

begin

  if   (p_old_value is null and p_new_value is not null)
    or (p_old_value is not null and p_new_value is null)
    or  p_old_value != p_new_value then
    
    PRC_BPM_ETL_BIA_UPD(p_attr_update_method,p_source_id,p_bi_id,p_ba_id,null,null,p_new_value,p_bue_id);
       
  end if;

end;
/

commit;

alter session set plsql_code_type = interpreted;