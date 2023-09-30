create or replace TABLE D_PI_CONVERSATION_SLAS (
	CONVERSATIONSLATYPE VARCHAR(255),
	SLAVALUE NUMBER(38,4),
	SLAVALUETYPE VARCHAR(255),
	EFFECTIVETIME TIMESTAMP_NTZ(9),
	INEFFECTIVETIME TIMESTAMP_NTZ(9),
	PROJECTID NUMBER(38,0)
);

insert into public.d_pi_conversation_slas values ('Short Abandons',10.0000,'seconds',to_timestamp_ntz('2021-01-10 00:00:00.000'),null,'741');

create or replace TABLE D_PI_SESSION_SLAS (
	SESSIONSLATYPE VARCHAR(255),
	SLAVALUE NUMBER(38,4),
	SLAVALUETYPE VARCHAR(255),
	EFFECTIVETIME TIMESTAMP_NTZ(9),
	INEFFECTIVETIME TIMESTAMP_NTZ(9),
	PROGRAMID NUMBER(38,0)
);

insert into public.d_pi_session_slas values ('Short Abandons',10.0000,'seconds',to_timestamp_ntz('2021-01-10 00:00:00.000'),null,'741');

create or replace TABLE D_PI_PROGRAMS (
	PROGRAMID VARCHAR(255),
	PROGRAMNAME VARCHAR(255),
	PROJECTID VARCHAR(255)
);

create or replace TABLE D_PI_PROJECTS (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	AWSFOLDERNAME VARCHAR(255),
	PROJECTTIMEZONE VARCHAR(255)
);

insert into public.D_PI_Projects values ('741','NC UI','e529199f-f9a3-49ec-9701-0d26129da22f','America/New_York');

insert into public.D_PI_Projects values ('701','NCEB','3476b75e-94b2-4cf1-ab28-41ba3456de48','America/New_York');

insert into public.D_PI_Projects values ('9999','SANDBOX','609601d6-469f-4f96-b26c-4cea42ceeff4','America/New_York');

  insert into public.D_PI_Projects values ('6666','COVAC','b94dde1d-7aa3-4c7f-9531-a8d8d433a6bf','America/Denver');
insert into public.D_PI_Projects values ('7777','FLCT','4d5ee9a3-ce93-43cc-a2a7-0949382ffa80','America/New_York');
insert into public.D_PI_Projects values ('8888','PAIEB/CHC','b96863fb-d35e-42db-ab0f-a5bbfc1e4599','America/New_York');

