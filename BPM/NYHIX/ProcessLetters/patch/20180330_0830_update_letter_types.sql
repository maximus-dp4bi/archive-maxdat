alter session set current_schema = MAXDAT;

update d_pl_current                   set letter_type = 'Missing ID Verification Form' where letter_type = 'Notice of Missing ID Verification Form';
commit;