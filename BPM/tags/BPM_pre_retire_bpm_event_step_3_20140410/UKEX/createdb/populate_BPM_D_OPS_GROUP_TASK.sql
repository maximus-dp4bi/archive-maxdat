-- insert Ops Group from template
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Exception','Manual Task');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Outbound Team','Initiate Welcoming Call to Client');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Outbound Team','Second Welcome Call');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Validation Team','Validation Complete');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Validation Team','Validation Failed');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Verification Team','Verification Failed');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('CMAC Admin','Change of Circumstance Verification Task');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Exception','BIT Task');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Exception','Site Escalation');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Verification Team','Verification Escalation');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Validation Team','Validation Escalation');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Verification Team','Verification Complete');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('CMAC Admin','WP07 - Back on Benefit');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('CMAC Admin','WP07 - Change of Benefit');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('CMAC Admin','WP07 - Change of contact details');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('CMAC Admin','WP07 - Other');
commit;
