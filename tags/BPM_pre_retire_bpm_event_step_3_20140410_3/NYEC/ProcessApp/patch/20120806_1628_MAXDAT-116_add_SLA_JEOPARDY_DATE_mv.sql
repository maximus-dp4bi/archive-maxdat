create or replace procedure TPRC_CR_MV_WO_DATE
  (p_datatype in varchar2, 
   p_attribute_name in varchar2, 
   p_view_name in varchar2, 
   p_view_abbr in varchar2) as

  v_create_mv_sql varchar2(2000) := null;
  v_create_index1_sql varchar2(2000) := null;
  v_create_index2_sql varchar2(2000) := null;
  v_create_view_sql varchar2(2000) := null;
  
begin

  v_create_mv_sql := 
    'create materialized view V_D_' || p_view_name ||
   ' tablespace MAXDAT_DATA build immediate using index refresh fast on demand as 
     select 
       bia.BI_ID,
       bal.BAL_ID,
       bia.BA_ID,
       bia.VALUE_' || p_datatype || ' "' || p_attribute_name || '",
       bia.rowid ia_rowid,
       ba.rowid a_rowid,
       bal.rowid al_rowid
     from
       BPM_ATTRIBUTE ba,
       BPM_ATTRIBUTE_LKUP bal,
       BPM_INSTANCE_ATTRIBUTE bia
     where 
       ba.BAL_ID = bal.BAL_ID
       and bal.NAME = ''' || p_attribute_name || '''
       and bia.BA_ID = ba.BA_ID';

  execute immediate v_create_mv_sql;
  
  BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('NYEC_PROCESS_APP','V_D_' || p_view_name);
  
  v_create_index1_sql := 'create unique index VD' || p_view_abbr || '_UIX1 on V_D_' || p_view_name || ' (BI_ID) tablespace MAXDAT_INDX compute 
statistics';
  execute immediate v_create_index1_sql;
  
  v_create_index2_sql := 'create unique index VD' || p_view_abbr || '_UIX2 on V_D_' || p_view_name || ' ("' || p_attribute_name ||'",BI_ID) tablespace 
MAXDAT_INDX compute statistics';
  execute immediate v_create_index2_sql;
  
  v_create_view_sql :=
    'create or replace view D_' || p_view_name || 
    ' as
     select
       BI_ID,
       BAL_ID,
       BA_ID,
       "' || p_attribute_name || '"
     from V_D_' || p_view_name;
     
  execute immediate v_create_view_sql;
     
end;
/

execute TPRC_CR_MV_WO_DATE('DATE','SLA Jeopardy Date','SLA_JEOPARDY_DATE','SJDT');

drop procedure TPRC_CR_MV_WO_DATE;

commit;