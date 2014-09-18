alter table BPM_INSTANCE_ATTRIBUTE enable row movement;

UPDATE BPM_INSTANCE_ATTRIBUTE
set ba_id   = 2609
WHERE BA_ID = 2604;
COMMIT;

alter table bpm_instance_attribute disable row movement;

delete from bpm_attribute where ba_id = 2604 and bal_id = 1609;
commit;