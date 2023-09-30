alter session set current_schema = cisco_enterprise_cc;

/* DELETE QUEUE NUMBER 5281 - CHANGED FROM VM TO AFTER HOURS - FROM VM TABLES */

delete from cc_f_term_call_vm
where f_term_call_vm_id in (select f_term_call_vm_id from cc_f_term_call_vm a, cc_c_contact_queue b, cc_d_dates c
where a.queue_number = b.queue_number
and b.project_name = 'MIEB'
and a.queue_number = 5281
and b.queue_type = 'After Hours'
and a.d_date_id = c.d_date_id
and c.d_date >= '01-NOV-17');

delete from cc_s_term_call_vm
where term_call_vm_id in (select term_call_vm_id from cc_s_term_call_vm a, cc_c_contact_queue b
where a.call_type_id = b.queue_number
and b.project_name = 'MIEB'
and a.call_type_id = 5281
and b.queue_type = 'After Hours'
and a.interval_date >= '01-NOV-17'
);


commit;
