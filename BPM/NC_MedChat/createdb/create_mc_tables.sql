drop table MAXDAT_SUPPORT.MC_TOPIC_METRIC;

Create table MAXDAT_SUPPORT.MC_TOPIC_METRIC
(
	Name						varchar2(50),
	Total						number(9),
	DefbyBot					number(9),
	MissedChats					number(9),
	MissedOpportunities			number(9),
	NoAgentNecessary			number(9)
)
TABLESPACE "MAXDAT_TBS";
	

GRANT SELECT ON MAXDAT_SUPPORT.MC_TOPIC_METRIC TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.MC_TOPIC_METRIC TO MAXDAT_REPORTS;

drop table MAXDAT_SUPPORT.MC_CHAT_TOTALS;

Create table MAXDAT_SUPPORT.MC_CHAT_TOTALS
(
	Total						number(9),
	MissedChats					number(9),
	MissedOpportunities			number(9),
	AverageHoldSeconds			number(9,2),
	AverageWaitSeconds			number(9,2),
	AverageServiceSeconds		number(9,2),
	AverageArchiveSeconds		number(9,2),
	AverageResponseTimeSeconds	number(9,2)
)
TABLESPACE "MAXDAT_TBS";

GRANT SELECT ON MAXDAT_SUPPORT.MC_CHAT_TOTALS TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.MC_CHAT_TOTALS TO MAXDAT_REPORTS;


drop table MAXDAT_SUPPORT.MC_AGENT_CHAT_METRIC;

Create table MAXDAT_SUPPORT.MC_AGENT_CHAT_METRIC
(
	Name						varchar2(50),
	Total						number(9),
	MissedChats					number(9),
	MissedOpportunities			number(9),
	AverageHoldSeconds			number(9,2),
	AverageWaitSeconds			number(9,2),
	AverageServiceSeconds		number(9,2),
	AverageArchiveSeconds		number(9,2),
	AverageResponseTimeSeconds	number(9,2)
)
TABLESPACE "MAXDAT_TBS";
	

GRANT SELECT ON MAXDAT_SUPPORT.MC_AGENT_CHAT_METRIC TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.MC_AGENT_CHAT_METRIC TO MAXDAT_REPORTS;

drop table MAXDAT_SUPPORT.MC_BUSIEST_TIME;

Create Table MAXDAT_SUPPORT.MC_BUSIEST_TIME
(
	BusyTimeCount	number(6),
	BusiestTime		varchar2(30),
	Weekday			varchar2(12)
)
TABLESPACE "MAXDAT_TBS";

GRANT SELECT ON MAXDAT_SUPPORT.MC_BUSIEST_TIME TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.MC_BUSIEST_TIME TO MAXDAT_REPORTS;

drop table MAXDAT_SUPPORT.MC_Virtual_Agent_Metrics;

Create Table MAXDAT_SUPPORT.MC_Virtual_Agent_Metrics
(
	DATEofrun				DATE,
	TotalArticleViews	number(6),
	UniqueSessions		number(6),
	MostPopularCategory	varchar2(50),
	MostPopularCategorySearches	number(9),
	MostSearchedTerm			varchar2(50),
	MostSearchedTermSearches	number(9)
)
TABLESPACE "MAXDAT_TBS";

GRANT SELECT ON MAXDAT_SUPPORT.MC_Virtual_Agent_Metrics TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.MC_Virtual_Agent_Metrics TO MAXDAT_REPORTS;

--drop table MAXDAT_SUPPORT.MC_SPREADSHEET_DATA;

--Create Table MAXDAT_SUPPORT.MC_SPREADSHEET_DATA
--(
--	rownumber		number(6),
--	columndata		varchar2(100)
--)
--TABLESPACE "MAXDAT_TBS";

--GRANT SELECT ON MAXDAT_SUPPORT.MC_SPREADSHEET_DATA TO MAXDATSUPPORT_READ_ONLY;
--GRANT SELECT ON MAXDAT_SUPPORT.MC_SPREADSHEET_DATA TO MAXDAT_REPORTS;
