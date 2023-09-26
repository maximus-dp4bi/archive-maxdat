-- insert into CC_C_CALL_RESULT_LKUP

insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (2,'Error condition while dialing');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (3,'Number reported not in service by network');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (4,'No ringback from network when dial attempted');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (5,'Operator intercept returned from network when dial attempted');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (6,'No dial tone when dialer port went off hook');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (7,'Number reported as invalid by the network');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (8,'Customer phone did not answer');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (9,'Customer phone was busy');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (10,'Customer answered and was connected to agent');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (11,'Fax machine detected');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (12,'Answering machine detected');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (13,'Dialer stopped dialing customer due to lack of agents or network stopped dialing before it was complete');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (14,'Customer requested callback');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (16,'Call was abandoned by the dialer due to lack of agents');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (17,'Failed to reserve agent for personal callback');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (18,'Agent has skipped or rejected a preview call');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (19,'Agent has skipped or rejected a preview call with the close option');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (20,'Customer has been abandoned to an IVR');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (21,'Customer dropped call within configured abandoned time');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (22,'Mostly used with TDM switches - network answering machine, such as a network voicemail');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (23,'Number successfully contacted but wrong number');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (24,'Number successfully contacted but reached the wrong person');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (25,'Dialer has flushed this record due to a change in the skillgroup, the campaign, etc.');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (26,'The number was on the do not call list');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (27,'Call disconnected by the carrier or the network while ringing');
insert into CC_C_CALL_RESULT_LKUP (CALL_RESULT_CODE,CALL_RESULT_DESC) values (28,'Dead air or low voice volume call');

commit;

-- insert into CC_C_DIALING_MODE_LKUP

insert into CC_C_DIALING_MODE_LKUP (DIAL_MODE_CODE,DIAL_MODE_DESC) values (1,'Predictive only');
insert into CC_C_DIALING_MODE_LKUP (DIAL_MODE_CODE,DIAL_MODE_DESC) values (2,'Predictive blended');
insert into CC_C_DIALING_MODE_LKUP (DIAL_MODE_CODE,DIAL_MODE_DESC) values (3,'Preview only');
insert into CC_C_DIALING_MODE_LKUP (DIAL_MODE_CODE,DIAL_MODE_DESC) values (4,'Preview blended');
insert into CC_C_DIALING_MODE_LKUP (DIAL_MODE_CODE,DIAL_MODE_DESC) values (5,'Progressive only');
insert into CC_C_DIALING_MODE_LKUP (DIAL_MODE_CODE,DIAL_MODE_DESC) values (6,'Progressive blended');
insert into CC_C_DIALING_MODE_LKUP (DIAL_MODE_CODE,DIAL_MODE_DESC) values (7,'Direct preview only');
insert into CC_C_DIALING_MODE_LKUP (DIAL_MODE_CODE,DIAL_MODE_DESC) values (8,'Direct preview blended');

commit;
