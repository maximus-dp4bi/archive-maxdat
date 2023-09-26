select count(*) from MAXDAT.bpm_cin_snapshot where snapshot_date = to_date('26-NOV-18 15:59:14', 'DD-MON-YY HH24:MI:SS');

delete from MAXDAT.bpm_cin_snapshot where snapshot_date = to_date('26-NOV-18 15:59:14', 'DD-MON-YY HH24:MI:SS');
commit;

select count(*) from MAXDAT.bpm_cin_snapshot where snapshot_date = to_date('26-NOV-18 15:59:14', 'DD-MON-YY HH24:MI:SS');
