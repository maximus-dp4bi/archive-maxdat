
INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('INFORMATION_REQ', 'Information Request','INBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('UPDATE_INFO_REQ', 'Update Information Request','INBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('MATERIALS_REQ', 'Materials Request','INBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('OTHER', 'Other','INBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('INFORMATION_REQ', 'Information Request','OUTBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('UPDATE_INFO_REQ', 'Update Information Request','OUTBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('MATERIALS_REQ', 'Materials Request','OUTBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('MISSING_INFO_REQ', 'Missing Information Request','OUTBOUND');

INSERT INTO d_sci_contact_reason(contact_reason_cd, contact_reason,contact_type_cd)
VALUES('OTHER', 'Other','OUTBOUND');

--truncate table d_sci_contact_action
INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('CASE_STATUS_INFO','Provided Case Status/Information','INFORMATION_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('ELIG_STATUS_INFO','Provided Eligibility Status/Information','INFORMATION_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('ENROLL_STATUS_INFO','Provided Enrollment Status/Information','INFORMATION_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('FINANCIAL_INFO','Provided Financial Information','INFORMATION_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('UPDATE_DEMOGRAPHIC','Updated Demographic Information','UPDATE_INFO_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('UPDATE_ELIG_INFO','Updated Eligibility Information','UPDATE_INFO_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('UPDATE_ENROLL_INFO','Updated Enrollment Information','UPDATE_INFO_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('PROGRAM_MATERIAL','Sent Program Materials','MATERIALS_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('RESENT_NOTICE','Re-Sent Notice','MATERIALS_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('REQ_UPDATE_CASE','Requested and Updated Case Member Information','MISSING_INFO_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('REQ_UPDATE_DEMO','Requested and Updated Demographic Information','MISSING_INFO_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('REQ_UPDATE_AR','Requested and Updated Authorized Representative Information','MISSING_INFO_REQ');

INSERT INTO d_sci_contact_action(contact_action_cd, contact_action,contact_reason_cd)
VALUES('OTHER','Other','OTHER');



INSERT INTO crm_random_word_stg(word) VALUES(replace('	ACD	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Active X controls	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Agent	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Agent Reports	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	ANI	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Analog	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	API	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Application	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	ASR	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Auto Dialer	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Automatic callback	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Average handling time (AHT)	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Back office optimization	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Barge-in	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Blended agent	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Business optimization	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Business to business (B2B)	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Business to consumer (B2C)	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Byte	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Call Center	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Call Center CRM	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Call center management	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Workforce optimization	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Workforce planning	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Call time	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Call distribution	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Call volume	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Caller	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	CCaaS	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Central office	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Channels	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Chat messages	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Container user interface	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Cloud	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Contact center	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Contact center agent	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Contact center CRM	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Management	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Conversant	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Cross-selling	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	CR Connect	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	CTI	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	CTI Server	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Customer engagement	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Customer effort score	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Customer experience	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Customer experience management	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Customer experience platform	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Customer journey	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	CSAT	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Customer service	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Database	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Decibel	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Direct inward dialing	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Directed dialog	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	DPR	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	DNIS	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	DTMF	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Echo cancellation	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Employee engagement	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Enterprise data window	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	ERM	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	FCR	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Grammar	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	GrXML	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	GUI	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Hardware	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Hosted Call Center	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Hosted dialer	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Integrated browser	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Interactions	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	ISDN	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	ISV	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	IVR	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Key stroke macros	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Listening post	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	LAN	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Logs	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Macro metric	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Marquee messages	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Megabyte	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Menu	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Mobile Voice	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Moment of truth	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Multichannel cloud call center	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	NLSR	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	NLU	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Omnichannel	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Phoneme	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Phrase	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Port	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	PBX	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Predictive dialing	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Processor	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Prompt	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Proxy server	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	PSTN	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Queue	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Recognizer	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	ROI	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	SaaS	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Supervisor	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Screen pop	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	SCSI	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Server	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	SMB	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	SME	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	SNMP	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Softphone controls	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Speech energy	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	SQL	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Switch	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	System Administrator	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Talk Time	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Task	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	TCP/IP	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Telephone network connection	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Touchpoint	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	TTS	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Trunk	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Upsell	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Utterance	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Virtual Agent	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	VCC	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	VCC	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Voice response unit (VRU)	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Vocabulary	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Voice authentication	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Voice of customer	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	VOIC	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Voice platform	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Voice print	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	VOIP	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	VUI	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	VXML	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	W3C	',chr(9),''));
INSERT INTO crm_random_word_stg(word) VALUES(replace('	Workflow Management	',chr(9),''));

--COMMIT;