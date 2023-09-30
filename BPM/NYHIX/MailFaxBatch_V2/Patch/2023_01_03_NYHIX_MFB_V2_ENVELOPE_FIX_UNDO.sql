create table maxdat.nyhix_mfb_v2_envelope_backup_20230101
as select * from maxdat.nyhix_mfb_v2_envelope
where batch_guid 
in ( select batch_guid from maxdat.nyhix_mfb_v2_envelope_fixes);  

Delete from maxdat.nyhix_mfb_v2_envelope
where batch_guid in 
( select batch_guid from maxdat.nyhix_mfb_v2_envelope_backup_20230101 );

insert into maxdat.nyhix_mfb_v2_envelope
select * from maxdat.nyhix_mfb_v2_envelope_backup_20230101;

commit;