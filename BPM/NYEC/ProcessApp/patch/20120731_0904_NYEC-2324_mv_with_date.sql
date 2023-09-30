create or replace procedure TPRC_CR_MV_W_DATE_PATCH
  (p_datatype in varchar2, 
   p_attribute_name in varchar2, 
   p_view_name in varchar2, 
   p_view_abbr in varchar2) as

  v_drop_mv_sql varchar2(2000) := null;
  v_create_mv_sql varchar2(2000) := null;
  v_create_index1_sql varchar2(2000) := null;
  v_create_index2_sql varchar2(2000) := null;
  v_compile_view_sql varchar2(2000) := null;
  
begin

  v_drop_mv_sql := 'drop materialized view V_D_' || p_view_name;
  
  execute immediate v_drop_mv_sql;

  v_create_mv_sql := 
    'create materialized view V_D_' || p_view_name ||
   ' tablespace MAXDAT_DATA build immediate using index refresh fast on demand as 
     select 
       d.D_DATE,
       bia.BI_ID,
       bal.BAL_ID,
       bia.BA_ID,
       bia.VALUE_' || p_datatype || ' "' || p_attribute_name || '",
       d.rowid d_dates_rowid,
       bia.rowid ia_rowid,
       ba.rowid a_rowid,
       bal.rowid al_rowid
     from
       BPM_ATTRIBUTE ba,
       BPM_ATTRIBUTE_LKUP bal,
       BPM_INSTANCE_ATTRIBUTE bia,
       BPM_D_DATES d
     where 
       ba.BAL_ID = bal.BAL_ID
       and bal.NAME = ''' || p_attribute_name || '''
       and bia.BA_ID = ba.BA_ID
       and d.D_DATE >= trunc(bia.START_DATE (+)) 
       and d.D_DATE <  trunc(bia.END_DATE (+))';
       
  execute immediate v_create_mv_sql;
  
  v_create_index1_sql := 'create unique index VD' || p_view_abbr || '_UIX1 on V_D_' || p_view_name || ' (D_DATE,BI_ID) tablespace MAXDAT_INDX compute 
statistics';
  execute immediate v_create_index1_sql;
  
  v_create_index2_sql := 'create unique index VD' || p_view_abbr || '_UIX2 on V_D_' || p_view_name || ' ("' || p_attribute_name ||'",D_DATE,BI_ID) 
tablespace MAXDAT_INDX compute statistics';
  execute immediate v_create_index2_sql;
  
  v_compile_view_sql :=
    'alter view D_' || p_view_name || ' compile';
     
  execute immediate v_compile_view_sql;
     
end;
/

execute TPRC_CR_MV_W_DATE_PATCH('CHAR','App Status','APP_STATUS','AS');
execute TPRC_CR_MV_W_DATE_PATCH('CHAR','App Status Group','APP_STATUS_GROUP','ASG');
execute TPRC_CR_MV_W_DATE_PATCH('CHAR','Clockdown Indicator','CLOCKDOWN_INDICATOR','CI');
execute TPRC_CR_MV_W_DATE_PATCH('CHAR','County','COUNTY','CO');
execute TPRC_CR_MV_W_DATE_PATCH('CHAR','HEART App Status','HEART_APP_STATUS','HAS');
execute TPRC_CR_MV_W_DATE_PATCH('CHAR','HEART Synch Flag','HEART_SYNCH_FLAG','HSF');
execute TPRC_CR_MV_W_DATE_PATCH('CHAR','Receipt Date','RECEIPT_DATE','RD');
execute TPRC_CR_MV_W_DATE_PATCH('CHAR','Refer to LDSS Flag','REFER_TO_LDSS_FLAG','RTLF');

drop procedure TPRC_CR_MV_W_DATE_PATCH;