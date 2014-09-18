--select * from step_definition_stg
--where name in ('Awaiting Validity Amendment - Individual','Manual Linking','Refer to NY Appeals','Awaiting Validity Amendment - SHOP');
--select * from BPM_D_OPS_GROUP_TASK where task_type
--in ('Awaiting Validity Amendment - Individual','Manual Linking','Refer to NY Appeals','Awaiting Validity Amendment - SHOP');

insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Eligibility C','Awaiting Validity Amendment - Individual');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Eligibility C','Awaiting Validity Amendment - SHOP');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Eligibility C','Refer to NY Appeals');
insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values ('Exception','Manual Linking');
commit;

