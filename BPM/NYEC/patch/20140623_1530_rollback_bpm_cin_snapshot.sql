CREATE TABLE bpm_cin_snapshot_20140623 AS (SELECT * FROM bpm_cin_snapshot);

delete from bpm_cin_snapshot where snapshot_date > trunc(sysdate - 1);

commit;

/
