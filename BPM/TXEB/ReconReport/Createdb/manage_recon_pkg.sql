alter session set plsql_code_type = native;

create or replace package manage_recon is

function ins_p79daily(p_job_id in number) return varchar2;

function ins_p79monthly(p_job_id in number, p_rownum_from in number, p_rownum_to in number) return varchar2;

function ins_pCaptmonthly( partlist in varchar2) return varchar2;

function ins_p34monthly(p_job_id in number, p_rownum_from in number, p_rownum_to in number) return varchar2;

end;
/

create or replace package body manage_recon as

function ins_p79daily(p_job_id in number) return varchar2 is
v_count number;
begin
  begin
    select count(1)
    into v_count
    from tx_etl_recon_ctrl
    where job_name = 'P79Daily'
    and job_slice = 1
    and job_id = p_job_id
    and status in ('DONE','PEND','WORK');

  exception when no_data_found then
            v_count := 0;
  end;
  if v_count > 0 then
    return 'NO';
  end if;
  insert into tx_etl_recon_ctrl ( job_name , job_slice , job_id ) values
                                  ('P79Daily', 1, p_job_id);
  commit;
  return 'YES';
end;

function ins_p79monthly(p_job_id in number, p_rownum_from in number, p_rownum_to in number) return varchar2 is
v_count number;
begin
  begin
    select count(1)
    into v_count
    from tx_etl_recon_ctrl
    where job_name = 'P79'
    and job_slice = 1
    and job_id = p_job_id
    and rownum_from = p_rownum_from
    and status in ('DONE','PEND','WORK');

  exception when no_data_found then
            v_count := 0;
  end;
  if v_count > 0 then
    return 'NO';
  end if;
    insert into tx_etl_recon_ctrl ( job_name , job_slice , job_id , rownum_from , rownum_to ) values
('P79', 1, p_job_id, p_rownum_from, p_rownum_to);

  commit;
  return 'YES';
end;

function ins_pCaptmonthly( partlist in varchar2) return varchar2 is
v_count number;
begin
  begin
    select count(1)
    into v_count
    from tx_etl_recon_ctrl
    where job_name = 'CAPITATION'
    and job_slice = 1
    and capitation_partlist = partlist
    and status in ('DONE','PEND','WORK');

  exception when no_data_found then
            v_count := 0;
  end;
  if v_count > 0 then
    return 'NO';
  end if;
  
  insert into tx_etl_recon_ctrl ( job_name , job_slice , CAPITATION_PARTLIST ) values ('CAPITATION', 1, partlist);

  commit;
  return 'YES';
end;

function ins_p34monthly(p_job_id in number, p_rownum_from in number, p_rownum_to in number) return varchar2 is
v_count number;
begin
  begin
    select count(1)
    into v_count
    from tx_etl_recon_ctrl
    where job_name = 'P3435'
    and job_slice = 1
    and job_id = p_job_id
    and status in ('DONE','PEND','WORK');

  exception when no_data_found then
            v_count := 0;
  end;
  if v_count > 0 then
    return 'NO';
  end if;
insert into tx_etl_recon_ctrl ( job_name , job_slice , job_id , rownum_from , rownum_to ) values
('P3435', 1, p_job_id, p_rownum_from, p_rownum_to);
  commit;
  return 'YES';
end;

end;
/

alter session set plsql_code_type = interpreted;
