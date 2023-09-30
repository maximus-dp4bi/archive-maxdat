-- cc_c_contact_queue and cc_d_contact_queue

update cc_c_contact_queue set QUEUE_TYPE = 'Inbound' where QUEUE_NUMBER = 61;

update cc_c_contact_queue set UNIT_OF_WORK_NAME = 'WebChat' where QUEUE_NUMBER = 21;
update cc_c_contact_queue set UNIT_OF_WORK_NAME = 'WebChat' where QUEUE_NUMBER = 22;
update cc_c_contact_queue set UNIT_OF_WORK_NAME = 'WebChat' where QUEUE_NUMBER = 23;
update cc_c_contact_queue set UNIT_OF_WORK_NAME = 'Voice Mail' where QUEUE_NUMBER = 43;



update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 81;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 62;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 62;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 63;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 63;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 64;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 64;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 82;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 83;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 101;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 84;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 85;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 86;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 121;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 102;
update cc_d_contact_queue set QUEUE_TYPE = 'Inbound' where QUEUE_NUMBER = 141;
update cc_d_contact_queue set QUEUE_TYPE = 'Vmail' where QUEUE_NUMBER = 87;

commit;