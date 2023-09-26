insert into bpm_d_process_definition(process_name, label, record_eff_dt, record_end_dt)
values('MAIL_FAX_BATCH','Process Mail Fax Batch',trunc(sysdate), to_date('12/31/2099','mm/dd/yyyy'));

insert into bpm_d_process_definition(process_name, label, record_eff_dt, record_end_dt)
values('MAIL_FAX_DOC','CADIR Process Mail Fax Docs',trunc(sysdate), to_date('12/31/2099','mm/dd/yyyy'));

insert into bpm_d_process_definition(process_name, label, record_eff_dt, record_end_dt)
values('PROCESS_APPEALS','CADIR Process Appeals',trunc(sysdate), to_date('12/31/2099','mm/dd/yyyy'));

insert into bpm_d_process_definition(process_name, label, record_eff_dt, record_end_dt)
values('MANAGE_WORK','Manage Work',trunc(sysdate), to_date('12/31/2099','mm/dd/yyyy'));

insert into bpm_d_process_definition(process_name, label, record_eff_dt, record_end_dt)
values('PROCESS_COMPLAINTS','Process Complaints Incidents',trunc(sysdate), to_date('12/31/2099','mm/dd/yyyy'));

insert into bpm_d_process_definition(process_name, label, record_eff_dt, record_end_dt)
values('PROCESS_INCIDENTS','CADIR Process IDR Incidents',trunc(sysdate), to_date('12/31/2099','mm/dd/yyyy'));

insert into bpm_d_process_definition(process_name, label, record_eff_dt, record_end_dt)
values('PROCESS_LETTERS','Process Letters',trunc(sysdate), to_date('12/31/2099','mm/dd/yyyy'));

commit;