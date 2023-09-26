create or replace procedure upd_transform_sqls_xt is
--declare
v_slct_stmt varchar2(4000);
v_ins_stmt varchar2(4000);
v_func_stmt varchar2(4000);
vc varchar2(2000);
begin

for vfile in (select program,subprogram , target_tablename, where_clause from txkpr10_xls_transform where status <> 'VOID')
  loop
    v_slct_stmt := 'select  ' ;
    v_ins_stmt := 'insert into ' || vfile.target_tablename || '(' || chr(10);
    v_func_Stmt := 'Create or replace function map_'|| vfile.program || '_' || vfile.subprogram || '_rec (prec in txkpr10_xls_stg%rowtype) return txkpr10_med_xls%rowtype is ';
    v_func_stmt := v_func_stmt || chr(10) || ' orec txkpr10_med_xls%rowtype; ';
    v_func_stmt := v_func_stmt || chr(10) || ' begin ' || chr(10);

  for vcol in (
      select source_col, target_col, source_type, target_type, transform_action ,colorder, ac.column_name
      from all_tab_columns ac, txkpr10_xls_transform_dtl xtd
      where ac.owner = 'MAXDAT'
      and upper(ac.TABLE_NAME) = upper(vfile.target_tablename)
      and upper(ac.COLUMN_NAME) = upper(xtd.target_col(+))
      and xtd.program(+) = vfile.program
      and xtd.subprogram(+) = vfile.subprogram
      and xtd.status(+) = 'VALID'
      order by nvl(xtd.colorder,999)
      )
  loop
      if vcol.colorder > 1 or (vcol.colorder is null and vcol.column_name is not null) then
         v_slct_stmt := v_slct_stmt || chr(10) || ', ';
         v_ins_Stmt := v_ins_stmt || chr(10) || ', ';
         v_func_stmt := v_func_stmt || chr(10);
         vc := null;
      end if;
      case
        when vcol.source_type = 'STR' and vcol.target_type = 'DATE' and vcol.transform_action = 'TO_Date_ddmonyyyy' then
           v_slct_stmt := v_slct_stmt || 'to_Date(substr(' || vcol.source_col || ',1, instr(' || vcol.source_col || ',''-20'',-1) +4),''dd-mon-yyyy'')' ;
           vc := 'to_Date(substr(' || 'prec.'|| vcol.source_col || ',1, instr(' || 'prec.'||vcol.source_col || ',''-20'',-1) +4),''dd-mon-yyyy'')' ;
        when vcol.source_type = 'STR' and vcol.target_type = 'DATE' and vcol.transform_action = 'TO_DATE_mmddyyyy' then
           v_slct_stmt := v_slct_stmt ||  'to_Date(substr(' || vcol.source_col || ',1, instr(' || vcol.source_col || ',''/20'',-1) +4),''mm/dd/yyyy'')' ;
           vc := 'to_Date(substr(' || 'prec.'||vcol.source_col || ',1, instr(' || 'prec.'||vcol.source_col || ',''/20'',-1) +4),''mm/dd/yyyy'')' ;
        when vcol.source_type = 'CONST' and vcol.target_type = 'STR' and vcol.transform_action = 'QUOTE' then
           v_slct_stmt := v_slct_stmt || '''' || vcol.source_col || '''' ;
           vc :=  '''' || vcol.source_col || '''' ;
        when vcol.source_type = 'CONST' and vcol.target_type = 'DATE' and vcol.transform_action is null then
           v_slct_stmt := v_slct_stmt || vcol.source_col ;
           vc := vcol.source_col ;
        when vcol.source_type = 'STR' and vcol.target_type = 'STR' and vcol.transform_action = 'TRIM' then
           v_slct_stmt := v_slct_stmt || 'substr(' || vcol.source_col || ',1,1999)' ;
           vc:=  'substr(' || 'prec.'||vcol.source_col || ',1,1999)' ;
        when vcol.source_type = 'STR' and vcol.target_type = 'NUMBER' and vcol.transform_action = 'TO_NUMBER' then
          v_slct_stmt := v_slct_stmt ||  'to_number(trim(' || vcol.source_col || '))' ;
          vc:= 'to_number(trim(' || 'prec.'|| vcol.source_col || '))' ;
        when vcol.source_col is null and vcol.column_name is not null then
          v_slct_stmt := v_slct_stmt || 'null' ;
          vc:=  'null' ;
        else
                       v_slct_stmt := v_slct_stmt || vcol.source_col ;
                       vc := 'prec.'|| vcol.source_col ;
           end case;
           v_ins_stmt := v_ins_Stmt || vcol.column_name;
           if vc is not null then
              v_func_stmt := v_func_stmt || ' orec.' || vcol.column_name || ' := ' || vc || '; ';
           end if;
  end loop;
  v_slct_stmt := v_slct_stmt || chr(10) || ' from txkpr10_xls_stg xt where regexp_like(upper(filename),''.*' || vfile.program || '.*' || vfile.subprogram || '.*'')
                                           and rownumber >1
                                           and col3 is not null
                                           and etl_recon_ctrl_id = :1 and rownumber between :2 and :3 ' || vfile.where_clause;
  V_SLCT_STMT := v_slct_stmt || chr(10);
  V_ins_STMT := v_ins_stmt || chr(10) || ')';
  v_func_stmt := v_func_stmt ||  ' return orec; ' || chr(10) || ' end; ' ;

  --dbms_output.put_line(v_slct_stmt);
  update txkpr10_xls_transform set slct_stmt = v_slct_stmt, ins_stmt = v_ins_stmt
  , exe_code1 = v_func_stmt
  where program = vfile.program and subprogram = vfile.subprogram and status <> 'VOID';
  --execute immediate v_func_Stmt;
  commit;
end loop;

exception when others then
    DECLARE
      V_CODE VARCHAR2(30);
      V_ERROR VARCHAR2(200);
    BEGIN
        V_CODE := SQLCODE;
        V_ERROR := SUBSTR(SQLERRM,1,200);
              INSERT INTO  CORP_ETL_ERROR_LOG(ERR_DATE
            ,ERR_LEVEL
            ,PROCESS_NAME
            ,JOB_NAME
            ,NR_OF_ERROR
            ,ERROR_DESC
            ,ERROR_CODES
            ,DRIVER_TABLE_NAME
            ,DRIVER_KEY_NUMBER
        ) VALUES (
            SYSDATE
            , 'CRITICAL'
            , 'upd_transform_sqls'
            , 'upd_transform_sqls'
            , 1
            , SUBSTR(V_ERROR,1,200)
            , V_CODE
            , NULL
            , NULL
        );
        commit;
    END;

 end;
/
