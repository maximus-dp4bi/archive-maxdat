alter table CORP_ETL_PROC_LETTERS disable all triggers;

create index CORP_ETL_PROC_LETTERS_SLUD on CORP_ETL_PROC_LETTERS (STG_LAST_UPDATE_DATE) tablespace MAXDAT_INDX parallel compute statistics;

execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(12,1,'ENABLED','N');
execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(12,2,'ENABLED','N');

declare
  v_count number := 0;

  cursor c_new_cepl
  is
    select CEPN_ID       
    from CORP_ETL_PROC_LETTERS
    where 
      STG_LAST_UPDATE_DATE >= to_date('2013-12-18','YYYY-MM-DD')
      and COMPLETE_DT is null;

begin

  for r_new_cepl in c_new_cepl
  loop
      
    update CORP_ETL_PROC_LETTERS
    set 
      STATUS ='Requested',
      CANCEL_DT = null,
      CANCEL_BY = null,
      CANCEL_REASON = null,
      CANCEL_METHOD = null,
      INSTANCE_STATUS = 'Active',
      ASED_PROCESS_LETTER_REQ = null,
      ASSD_TRANSMIT = null,
      ASED_TRANSMIT = null,
      ASSD_RECEIVE_CONFIRMATION = null,
      ASED_RECEIVE_CONFIRMATION = null,
      ASSD_CREATE_ROUTE_WORK = null,
      ASED_CREATE_ROUTE_WORK = null,
      ASF_PROCESS_LETTER_REQ = 'N',
      ASF_TRANSMIT = 'N',
      ASF_RECEIVE_CONFIRMATION = 'N',
      ASF_CREATE_ROUTE_WORK = 'N',
      GWF_VALID = null,
      GWF_OUTCOME = null,
      GWF_WORK_REQUIRED = null,
      STAGE_DONE_DATE = null 
    where CEPN_ID = r_new_cepl.CEPN_ID;

    v_count := v_count + 1;
    if mod(v_count,10000) = 0
    then
      commit;	  
    end if;
       
  end loop;
    
  commit;

end;
/

execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(12,1,'ENABLED','Y');
execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(12,2,'ENABLED','Y');

alter table CORP_ETL_PROC_LETTERS enable all triggers;
