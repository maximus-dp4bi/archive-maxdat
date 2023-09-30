drop table tx_etl_recon_ctrl;
create table tx_etl_recon_ctrl (
etl_recon_ctrl_id number(38) not null
, job_name varchar2(15) not null
, job_slice number(2) not null
, job_id number(38) 
, rownum_from number(38)
, rownum_to number(38)
, capitation_partlist varchar2(1000)
, status varchar2(10) not null
, stat_disposition varchar2(10)
, status_dt date not null
, create_dt date not null
, created_by varchar2(50) not null
, stat_comment varchar2(1000)
);

grant select on tx_etl_recon_ctrl to MAXDAT_READ_ONLY;
grant all on tx_etl_recon_ctrl to maxdatread with grant option;

create sequence seq_etl_recon_ctrl_id 
start with 1
increment by 1
nocache
nocycle;

alter table tx_etl_recon_ctrl add constraint tx_etl_recon_ctrl_pk primary key (etl_recon_ctrl_id) using index tablespace MAXDAT_INDX;

alter table tx_etl_recon_ctrl add constraint tx_recon_ctrl_stat_check check (status in ('PEND','WORK','DONE','ERROR'));

alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_tx_etl_recon_ctrl
before insert or update on tx_etl_recon_ctrl 
for each row
begin
  if inserting then
  
    if :new.etl_recon_ctrl_id is null then
      :new.etl_recon_ctrl_id := seq_etl_recon_ctrl_id.nextval;
    end if;
    
    if :new.create_dt is null then
      :new.create_dt := sysdate;
    end if;
    
    if :new.created_by is null then
       :new.created_by := user;
    end if;
    
    if :new.status is null then
      :new.status := 'PEND';
      :new.status_dt := sysdate;
    end if;
    
  end if;
  if updating then
    if :new.status <> :old.status then
      :new.status_dt := sysdate;
  end if; 
  end if; 
end;
/


