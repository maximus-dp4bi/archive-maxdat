-- NYHIX-8630

UPDATE bpm_d_ops_group_task SET ops_group = 'Eligibility A'
 WHERE task_type IN ('DPR - Account Correction'
                    ,'DPR - Other');

UPDATE bpm_d_ops_group_task SET ops_group = 'Eligibility B'
 WHERE task_type IN ('DPR - Multiple Applications');

UPDATE bpm_d_ops_group_task SET ops_group = 'DOH'
 WHERE task_type IN ('Hearing Set - No Disposition Review');

UPDATE bpm_d_ops_group_task SET ops_group = 'Eligibility C'
 WHERE task_type IN ('Evidence Packet Correction Task');

COMMIT;