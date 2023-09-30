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
v_invoiced varchar2(2);

BEGIN
  v_driver_key := nvl(to_char(IN_TRAN_HEADER_ID),'null');
  v_err_field := 'IN_TRAN_HEADER_ID';

  verrmsg := ' ';
  
  /* Setting up v_invoiced */ 
    begin
    select max(invoiced) into v_invoiced from f_transmittal_invoice_detail_sv 
    where tran_header_id = IN_TRAN_HEADER_ID and group_name = in_group_name;
    end;
    
  /* Setting up v_tran_header_id */ 
    begin
    select tran_header_id into v_tran_header_id from f_transmittal_invoice_sv 
    where tran_header_id = IN_TRAN_HEADER_ID and group_name = in_group_name;
    end;
    
if v_tran_header_id >0 then 

   if ( in_invoiced = 'Y' and v_invoiced is NULL ) then 
    if ( in_invoiced ='Y' or in_invoiced is null ) then 
   begin
 
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
      
    insert into d_tran_events ( event_date, event_name, tran_ref_table,tran_ref_pkid, detail1_name, detail1_value, detail2_name, detail2_value, detail3_name, detail3_value  ) 
values
( sysdate, 'TRAN_INVOICED', 'D_TRAN_HEADER', IN_TRAN_HEADER_ID,'GROUP_NAME', IN_GROUP_NAME, 'INVOICED_DATE',to_char(SYSDATE,'mm/dd/yyyy'), 'INVOICED_USER',in_inv_user_id); 
  END;
  END IF;
  END IF;
  
  
  /* UN-INVOICE : When INVOICED is marked null and previously it was 'Y'*/
      if ( in_invoiced is null and v_invoiced ='Y' ) then 
    if ( in_invoiced ='Y' or in_invoiced is null ) then 
   begin
   
             update d_tran_detail 
	  set invoiced =IN_INVOICED, invoiced_date=NULL, invoiced_user =NULL where tran_detail_id in (
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
    
       insert into d_tran_events ( event_date, event_name, tran_ref_table, tran_ref_pkid, detail1_name, detail1_value, detail2_name, detail2_value, detail3_name, detail3_value ) 
values
( sysdate, 'TRAN_UN-INVOICED', 'D_TRAN_HEADER', IN_TRAN_HEADER_ID,'GROUP_NAME', IN_GROUP_NAME, 'INVOICED_DATE',NULL, 'INVOICED_USER',NULL); 

  END;
      END IF;
     END IF;
     
      else
         verrmsg := verrmsg || 'Header ID not found; ' ||CHR(10);
         
  END IF;

exception when others then
            v_code := SQLCODE;
            v_desc := SQLERRM;

            corp_etl_stage_pkg.log_etl_msg(in_job_name => 'TRAN_INVOICE_FORM'
            , in_process_name => 'TRAN_INVOICE_FORM'
            , in_nr_of_error => 0
            , in_error_desc => v_Desc
            , in_error_field => v_err_field
            , in_error_codes => v_code
            , in_driver_table_name => 'D_TRAN_HEADER'
            , in_driver_key_number => v_driver_key
            );
            commit;
              raise_application_error(-20102, 'Oracle Error:' || v_code || ':' || substr(v_desc,1,500));
  
END;


grant execute on TRAN_INVOICE_FORM to MAXDAT_MITRAN_PFP_E;
grant execute on TRAN_INVOICE_FORM to MAXDAT_MITRAN_READ_ONLY;
grant execute on TRAN_INVOICE_FORM to MAXDAT_REPORTS;
