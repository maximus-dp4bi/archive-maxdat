insert into d_tran_Event_lkup(name, eventtype, description, report_label) 
values ('TRAN_INIT', 'SYSTEM', 'Transmittal Started for the date', 'Transmittal Built');

insert into d_tran_Event_lkup(name, eventtype, description, report_label) 
values ('TRAN_JOBID_ASSIGNED', 'SYSTEM', 'Transmittal Job ID Assigned', 'Transmittal Job ID Assigned');

insert into d_tran_Event_lkup(name, eventtype, description, report_label) 
values ('INITIAL_TRAN_SENT_TO_EYR', 'SYSTEM', 'Initial Transmittal sent to EYR','Initial Transmittal sent to EYR');

insert into d_tran_Event_lkup(name, eventtype, description, report_label) 
values ('TRAN_SENT_TO_EYR_REPEAT', 'SYSTEM', 'Initial Transmittal resent to EYR','Initial Transmittal resent to EYR');

insert into d_tran_Event_lkup(name, eventtype, description, report_label) 
values ('TRAN_CONFIRMATION_RCVD_FROM_EYR', 'SYSTEM', 'Transmittal confirmation from EYR received','Received Transmittal confirmation from EYR');

insert into d_tran_Event_lkup(name, eventtype, description, report_label) 
values ('TRAN_SENT_TO_EYR_QA', 'SYSTEM', 'Transmittal sent to EYR','Transmittal sent to EYR');

insert into d_tran_Event_lkup(name, eventtype, description, report_label) 
values ('TRAN_SENT_TO_EYR_QA_REPEAT', 'SYSTEM', 'Transmittal resent to EYR','Transmittal resent to EYR');

insert into d_tran_Event_lkup(name, eventtype, description, report_label) 
values ('TRAN_MAILED_BY_EYR', 'SYSTEM', 'Transmittal mailing confirmation received from EYR','Transmittal mailing confirmation received from EYR');

insert into d_tran_Event_lkup(name, eventtype, description, report_label) 
values ('TRAN_INVOICED','HUMAN_TASK','Transmittal Invoiced','Transmittal Invoiced');

insert into d_tran_Event_lkup(name, eventtype, description, report_label) values ('TRAN_LETTER_DETAIL_QA_DONE', 'HUMAN_TASK', 'Transmittal Letter QA Signed','Transmittal Letter QA Signed');
insert into d_tran_Event_lkup(name, eventtype, description, report_label) values ('TRAN_LETTER_DETAIL_QA_EDIT', 'HUMAN_TASK', 'Transmittal Letter QA Recorded','Transmittal Letter QA Recorded');
insert into d_tran_Event_lkup(name, eventtype, description, report_label) values ('TRAN_LETTER_DETAIL_ADDED', 'HUMAN_TASK', 'Transmittal Letter added', 'Letter added - Manual');
insert into d_tran_Event_lkup(name, eventtype, description, report_label) values ('TRAN_LETTER_DETAIL_ADDED_SYSTEM', 'SYSTEM', 'System added Letter', 'Letter added - System');
insert into d_tran_Event_lkup(name, eventtype, description, report_label) values ('TRAN_LETTER_DETAIL_UPDATED', 'HUMAN_TASK', 'Transmittal Letter updated', 'Letter updated - Manual');

commit;

--delete d_tran_Event_lkup;

create or replace view d_tran_event_lkup_sv as select * from d_tran_event_lkup;

select * from d_tran_event_lkup;

--when: When Laura confirms that Transmittal is ready to be sent to EYR
--where: Form
insert into d_tran_Event_lkup(name, eventtype, description, report_label) values ('TRAN_MANUAL_CONFIRM_SEND_TO_EYR', 'HUMAN_TASK',  'Manual Confirmation received to send to EYR', 'Manual Confirmation received to send to EYR');
--when: When Laura requests Transmittal to be sent to EYR
--where: Form
insert into d_tran_Event_lkup(name, eventtype, description, report_label) values ('TRAN_MANUAL_CONFIRM_SEND_TO_EYR', 'HUMAN_TASK', 'Request to Send Transmittal to EYR','Request to send Transmittal EYR');
delete d_tran_event_lkup where name in ('REQUEST_TRAN_SEND_TO_EYR','REQUEST_TRAN_SEND_TO_EYR_QA');

