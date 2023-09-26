insert into d_tran_Action_lkup(action_code, action_Description, report_label, effective_from, effective_to, EVENT_NAME)
values ('INIT_TRAN','Initial Transmittal sent to EYR','Initial Transmittal sent to EYR',trunc(sysdate,'MM'), to_date('1/1/7777','mm/dd/yyyy'),'INITIAL_TRAN_SENT_TO_EYR' );
insert into d_tran_Action_lkup(action_code, action_Description, report_label, effective_from, effective_to, EVENT_NAME)
values ('REINIT_TRAN','Retransmit Initial File to EYR','Retransmit Initial File to EYR',trunc(sysdate,'MM'), to_date('1/1/7777','mm/dd/yyyy'), 'TRAN_SENT_TO_EYR_REPEAT');
insert into d_tran_Action_lkup(action_code, action_Description, report_label, effective_from, effective_to, EVENT_NAME)
values ('QA_TRAN','QA Approved Transmittal to EYR','QA Approved Transmittal to EYR',trunc(sysdate,'MM'), to_date('1/1/7777','mm/dd/yyyy'), 'TRAN_SENT_TO_EYR_QA');
insert into d_tran_Action_lkup(action_code, action_Description, report_label, effective_from, effective_to, EVENT_NAME)
values ('REQA_TRAN','Retransmit QA Transmittal to EYR','Retransmit QA Transmittal to EYR',trunc(sysdate,'MM'), to_date('1/1/7777','mm/dd/yyyy'), 'TRAN_SENT_TO_EYR_QA_REPEAT');
insert into d_tran_Action_lkup(action_code, action_Description, report_label, effective_from, effective_to, EVENT_NAME)
values ('OTHER','Other','Other',trunc(sysdate,'MM'), to_date('1/1/7777','mm/dd/yyyy'), null);
insert into d_tran_Action_lkup(action_code, action_Description, report_label, effective_from, effective_to, EVENT_NAME)
values ('QA_DONE','QA Review Done for this Transmittal','QA Review done for this Transmittal',trunc(sysdate,'MM'), to_date('1/1/7777','mm/dd/yyyy'), 'TRAN_SENT_TO_EYR_QA');

--delete d_tran_action_lkup;
