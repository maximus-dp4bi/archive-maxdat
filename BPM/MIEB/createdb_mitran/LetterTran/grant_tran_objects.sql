
grant select,insert, update on d_tran_detail to MAXDAT_MITRAN_OLTP_SIU;
grant select,insert, update on d_tran_header to MAXDAT_MITRAN_OLTP_SIU;
grant select,insert, update on d_tran_event_lkup to MAXDAT_MITRAN_OLTP_SIU;
grant select,insert, update on d_tran_events to MAXDAT_MITRAN_OLTP_SIU;
grant select,insert, update on d_tran_action_lkup to MAXDAT_MITRAN_OLTP_SIU;
grant select,insert, update on d_tran_action to MAXDAT_MITRAN_OLTP_SIU;

grant select,insert, update, delete on d_tran_detail to MAXDAT_MITRAN_OLTP_SIUD;
grant select,insert, update, delete on d_tran_header to MAXDAT_MITRAN_OLTP_SIUD;
grant select,insert, update, delete on d_tran_event_lkup to MAXDAT_MITRAN_OLTP_SIUD;
grant select,insert, update, delete on d_tran_events to MAXDAT_MITRAN_OLTP_SIUD;
grant select,insert, update,delete  on d_tran_action_lkup to MAXDAT_MITRAN_OLTP_SIUD;
grant select,insert, update,delete  on d_tran_action to MAXDAT_MITRAN_OLTP_SIUD;

grant select on d_tran_detail to MAXDAT_MITRAN_READ_ONLY;
grant select on d_tran_header to MAXDAT_MITRAN_READ_ONLY;
grant select on d_tran_event_lkup to MAXDAT_MITRAN_READ_ONLY;
grant select on d_tran_events to MAXDAT_MITRAN_READ_ONLY;
grant select on d_tran_detail_sv to MAXDAT_MITRAN_READ_ONLY;
grant select on d_tran_header_sv to MAXDAT_MITRAN_READ_ONLY;
grant select on d_tran_event_lkup_sv to MAXDAT_MITRAN_READ_ONLY;
grant select on d_tran_events_sv to MAXDAT_MITRAN_READ_ONLY;
grant select on f_transmittal_details_sv to MAXDAT_MITRAN_READ_ONLY;
grant select on D_TRAN_LETTER_TYPE_SV to MAXDAT_MITRAN_READ_ONLY;
grant select on d_header_latest_events_sv to MAXDAT_MITRAN_READ_ONLY;
grant select on d_tran_action_lkup to MAXDAT_MITRAN_READ_ONLY;
grant select on d_tran_action_lkup_sv to MAXDAT_MITRAN_READ_ONLY;
grant select on d_tran_action to MAXDAT_MITRAN_READ_ONLY;
grant select on d_tran_action_sv to MAXDAT_MITRAN_READ_ONLY;

grant select on D_TRAN_LETTER_TYPE_SV to maxdat_reports;

grant MAXDAT_MITRAN_READ_ONLY to maxdat_reports;

select * from dba_roles where role like 'MAXDAT_MITRAN_READ_ONLY';

select * from all_users where username like '%MAXDAT%';
