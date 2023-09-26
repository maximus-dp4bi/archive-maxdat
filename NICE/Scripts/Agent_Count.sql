/**** SCRIPT TO GET A COUNT OF ALL AGENTS ****/

select E.C_ID, E.C_NAME, A.C_ExternalID, A.C_ID, U.FirstName, U.LastName
from nice_wfm_customer1..r_muroster M
inner join nice_wfm_customer1..r_entity E
	on M.C_MU = E.C_OID
inner join nice_wfm_customer1..r_agt A
	on A.C_OID = M.c_agt
Inner join (Select screenName, FirstName, LastName from Nice_wfm_liferay..User_ where  screenName not like '%portaladmin%' and screenName not like '%test%' ) U --and screenName not like '%sup%') U
	on A.C_ExternalID = U.screenName COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE 
	E.C_NAME not like '%SOA Test%'
	AND E.C_NAME not like '%Inactive%'
	AND	M.C_ACT IS NOT NULL 
	AND M.C_EDATE IS NULL
order by E.C_ID, FirstName, C_NAME, C_EXTERNALID DESC
