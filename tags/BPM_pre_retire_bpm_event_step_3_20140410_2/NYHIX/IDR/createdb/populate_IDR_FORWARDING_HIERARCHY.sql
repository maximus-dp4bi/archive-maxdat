/*
Created on 13-Sep-2013 by Raj A.
Team: MAXDAT.
Business Process: NYHIX IDR Incidents.

Description:
This table has the hierarchy for incident forwarding. This determines until what status of incident the Forwarded_To attribute
should be updated.

For ex: If an incident gets forwarded to the level-1 i.e., REFERRED_TO_ES_C, then ETL stage will NOT be updated. 
Then, if it moves to level-2, REFERRED_TO_ES_C_SUPERVISOR, ETL is updated as it is the max level of escalation.
*/
insert into IDR_FORWARDING_HIERARCHY
VALUES (
1, 'REFER_TO_ESC', 'Refer to ES-C'
);

insert into IDR_forwarding_Hierarchy
values (
2, 'REFER_TO_ESC_SUPER', 'Refer to ES-C Supervisor'
);
commit;

