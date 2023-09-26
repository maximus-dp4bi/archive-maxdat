update corp_etl_list_lkup
set out_var = 'Checkup Due Medical Letter,Checkup Reminder Medical Letter,Checkup Due Dental Letter,Checkup Reminder Dental Letter,Enrollment Reminder'
    ,value = 'Letters to Exclude'
where name = 'LETTER_TYPES_TO_EXCLUDE';

commit;