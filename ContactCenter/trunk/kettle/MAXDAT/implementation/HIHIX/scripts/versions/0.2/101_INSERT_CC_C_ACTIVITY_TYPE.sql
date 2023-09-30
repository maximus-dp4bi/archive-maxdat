
--- Insert into CC_C_ACTIVITY_TYPE
delete from cc_c_activity_type;

insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_ID,ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values (0,'Unknown','Unknown','Unknown','0','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('1-on-1','Agent in one on one meeting with supervisor','Meeting','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('Abandoned','Unknown','Unknown','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('Abandoned epChat','Unknown','Unknown','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('After Call Work','Agent performing aftercall work','Working Contact','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('Application Launch','Agent launching application','Other Not Ready','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('Break','Agent on break','Lunch and Break','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('Lunch','Agent on lunch','Lunch and Break','0','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('Not Ready','Agent not ready','Not Ready','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('On Outbound Call','Agent on outbound call','Outbound Call','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('Personal','Agent on personal break','Other Not Ready','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('Special Project','Agent performing special project','Special Project','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('WaitingForDisposition','Waiting for agent disposition from system','Other Not Ready','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('Login','Agent logged in','NA - agent logged in time','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('Ready','Agent in ready state','Available','1','1','1','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
INSERT INTO CC_C_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESCRIPTION,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT) 
values ('On Call','Agent is on call with customer','Working Contact','1','1','1','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));


--Insert into CC_D_ACTIVITY_TYPE

delete from cc_d_activity_type;

insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('1-on-1','Agent in one on one meeting with supervisor','Meeting','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('Abandoned','Unknown','Unknown','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('Abandoned epChat','Unknown','Unknown','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('After Call Work','Agent performing aftercall work','Working Contact','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('Application Launch','Agent launching application','Other Not Ready','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('Break','Agent on break','Lunch and Break','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('Lunch','Agent on lunch','Lunch and Break','0','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('Not Ready','Agent not ready','Not Ready','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('On Outbound Call','Agent on outbound call','Outbound Call','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('Personal','Agent on personal break','Other Not Ready','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('Special Project','Agent performing special project','Special Project','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('WaitingForDisposition','Waiting for agent disposition from system','Other Not Ready','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('Login','Agent logged in','NA - agent logged in time','1','0','0','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
insert into CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION) 
values ('Ready','Agent in ready state','Available','1','1','1','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);
INSERT INTO CC_D_ACTIVITY_TYPE (ACTIVITY_TYPE_NAME,ACTIVITY_TYPE_DESC,ACTIVITY_TYPE_CATEGORY,IS_PAID_FLAG,IS_AVAILABLE_FLAG,IS_READY_FLAG,IS_ABSENCE_FLAG, RECORD_EFF_DT, RECORD_END_DT, VERSION)  
values ('On Call','Agent is on call with customer','Working Contact','1','1','1','0', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 1);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2','101','101_INSERT_CC_C_ACTIVITY_TYPE');

COMMIT;
