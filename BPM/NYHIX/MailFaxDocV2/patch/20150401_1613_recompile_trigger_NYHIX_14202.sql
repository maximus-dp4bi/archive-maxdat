alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_NYHIX_ETL_MFD_V2
before insert or update on NYHIX_ETL_MAIL_FAX_DOC_V2
for each row 

declare
  v_instance_start_date date := null;
  v_instance_end_date date := null;

begin 
  if :new.CREATE_DT >= TO_DATE('10-01-2013','MM-DD-YYYY') and (:new.CREATE_DT <= :new.MAXE_ORIGINATION_DT or :new.CREATE_DT <= sysdate) then
    v_instance_start_date := :new.CREATE_DT;
  elsif :new.MAXE_ORIGINATION_DT >= TO_DATE('10-01-2013','MM-DD-YYYY') and :new.MAXE_ORIGINATION_DT <= sysdate then
    v_instance_start_date := :new.MAXE_ORIGINATION_DT;
  else
    v_instance_start_date := sysdate;
  end if;
   
   if :new.COMPLETE_DT is not null and :new.COMPLETE_DT >= v_instance_start_date then
    v_instance_end_date := :new.COMPLETE_DT;
  elsif :new.CANCEL_DT is not null and :new.CANCEL_DT >= v_instance_start_date then
    v_instance_end_date := :new.CANCEL_DT;
  else
    v_instance_end_date := null;
  end if;

  :new.instance_start_date := v_instance_start_date;
  :new.instance_end_date := v_instance_end_date;
end;
/

alter session set plsql_code_type = interpreted;