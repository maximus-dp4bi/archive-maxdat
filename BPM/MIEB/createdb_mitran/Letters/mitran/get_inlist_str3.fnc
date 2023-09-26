create or replace function GET_INLIST_STR3
    (p_name in varchar2,
     p_list_type in varchar2)
    return varchar2 parallel_enable
  as
  begin
    return ETL_COMMON.GET_INLIST_STR3(p_name,p_list_type);
  end;
/
grant execute on GET_INLIST_STR3 to MAXDAT_MIEB_PFP_E;
grant execute on GET_INLIST_STR3 to MAXDAT_MITRAN_READ_ONLY;


