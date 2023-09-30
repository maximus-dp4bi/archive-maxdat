create or replace Procedure  TRAN_INVOICE_FORM
    (
IN_TRAN_HEADER_ID IN NUMBER
,IN_GROUP_NAME IN VARCHAR2
,IN_LMDEF_ID_AGG IN VARCHAR2
,IN_INVOICED IN VARCHAR2
,IN_INV_USER_ID IN VARCHAR2
   )

AS

v_code corp_etl_error_log.error_codes%TYPE;
v_desc corp_etl_error_log.error_desc%TYPE;
v_driver_key varchar2(100);
v_err_field varchar2(100);
verrmsg varchar2(1000);
v_tran_header_id number(32);

BEGIN
  v_driver_key := nvl(to_char(IN_TRAN_HEADER_ID),'null');
  v_err_field := 'IN_TRAN_HEADER_ID';

  verrmsg := ' ';

   
 
          update d_tran_detail 
	  set invoiced =IN_INVOICED, invoiced_date=sysdate, invoiced_user =IN_INV_USER_ID where tran_detail_id in (
  select dtd.tran_detail_id from d_tran_detail dtd 
join (
with rws as (
  select tran_header_id, group_name, lmdef_id_agg str from f_transmittal_invoice_sv where group_name = in_group_name and tran_header_id = in_tran_header_id
)
  select regexp_substr (
           str,
           '[^,]+',
           1,
           level
         ) lmdef_id
         , tran_header_id
         , group_name
  from   rws
  connect by level <= 
    length ( str ) - length ( replace ( str, ',' ) ) + 1 ) lmdef_id_split
   on lmdef_id_split.tran_header_id = dtd.tran_header_id 
    and lmdef_id_split.lmdef_id = dtd.lmdef_id
    where lmdef_id_split.group_name = in_group_name and lmdef_id_split.tran_header_id = in_tran_header_id);
      
      
END;


grant execute on TRAN_INVOICE_FORM to MAXDAT_MITRAN_PFP_E;
grant execute on TRAN_INVOICE_FORM to MAXDAT_MITRAN_READ_ONLY;
grant execute on TRAN_INVOICE_FORM to MAXDAT_REPORTS;
