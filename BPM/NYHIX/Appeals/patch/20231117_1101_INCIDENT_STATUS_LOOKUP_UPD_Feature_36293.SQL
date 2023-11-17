-- FEATURE 36293 - ARU - AOP/Bad Number Cancellation Request to Update clock CR3464.

update maxdat.incident_status_lookup
set start_stop = 'STOP'
where status_cd in ('PENDING_AOP_BAD_NMBR_CNCLTN','AOP_BAD_NMBR_CNCLTN');

Commit;

