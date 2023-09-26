--MAXDAT-3241 as per the latest config spreadsheet v1.9

alter session set current_schema = CISCO_ENTERPRISE_CC;

update cc_c_contact_queue
set queue_type = 'IVR'
where queue_number in (5432,
5433,
5434,
5435,
5436,
5437,
5438,
5439,
5444,
5445,
5446,
5447,
5448,
5449,
5450,
5451,
5452
);

update cc_s_contact_queue
set queue_type = 'IVR'
where queue_number in (5432,
5433,
5434,
5435,
5436,
5437,
5438,
5439,
5444,
5445,
5446,
5447,
5448,
5449,
5450,
5451,
5452
);

update cc_d_contact_queue
set queue_type = 'IVR'
where queue_number in (5432,
5433,
5434,
5435,
5436,
5437,
5438,
5439,
5444,
5445,
5446,
5447,
5448,
5449,
5450,
5451,
5452
);


commit;

