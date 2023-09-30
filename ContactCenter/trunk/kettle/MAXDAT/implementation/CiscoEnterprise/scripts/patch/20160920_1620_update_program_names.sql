update cc_c_contact_queue
set program_name = 'Healthline'
where queue_number in (6181,
6182,
6183,
6190,
6191,
6192,
6193,
6194,
6197,
6200
);


update cc_d_contact_queue
set d_program_id = 243
where queue_number in (6181,
6182,
6183,
6190,
6191,
6192,
6193,
6194,
6197,
6200
);

update cc_f_acd_agent_interval
set d_program_id = 243
where d_contact_queue_id in (
select d_contact_queue_id from cc_d_contact_queue
where queue_number in (6181,
6182,
6183,
6190,
6191,
6192,
6193,
6194,
6197,
6200
));

update cc_c_contact_queue
set program_name = 'Ombudsman'
where queue_number in (6201,
6202,
6203,
6210,
6211,
6212,
6213,
6214,
6217,
6220
);

update cc_d_contact_queue
set d_program_id = 244
where queue_number in (6201,
6202,
6203,
6210,
6211,
6212,
6213,
6214,
6217,
6220
);

update cc_f_acd_agent_interval
set d_program_id = 244
where d_contact_queue_id in (
select d_contact_queue_id from cc_d_contact_queue
where queue_number in (6201,
6202,
6203,
6210,
6211,
6212,
6213,
6214,
6217,
6220
));
