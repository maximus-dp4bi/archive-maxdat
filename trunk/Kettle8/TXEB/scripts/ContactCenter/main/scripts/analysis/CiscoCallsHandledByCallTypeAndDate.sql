/*

-- select distinct * into #tmp_EB_Call_Type from (values (6971),(6972),(6973),(6974),(6975),(6976),(6964),(6965),(6966),(6967),(6968),(6969),(5105),(5097),(5145),(5146),(5147),(5188),(5552),(6561),(6562),(6695),(6698),(6704),(6821),(6853),(6890),(6894),(6919),(6920),(5050),(5051),(5052),(5055),(5056),(5483),(5486),(6718),(6721),(5094),(5102),(5197),(5248),(5474),(5480),(6683),(6684),(6691)) as X(CallTypeID)

SELECT 6971 AS CallTypeID
INTO #tmp_EB_Call_Type
UNION SELECT 6972
UNION SELECT 6973
UNION SELECT 6974
UNION SELECT 6975
UNION SELECT 6976
UNION SELECT 6964
UNION SELECT 6965
UNION SELECT 6966
UNION SELECT 6967
UNION SELECT 6968
UNION SELECT 6969
UNION SELECT 5105
UNION SELECT 5097
UNION SELECT 5145
UNION SELECT 5146
UNION SELECT 5147
UNION SELECT 5188
UNION SELECT 5552
UNION SELECT 6561
UNION SELECT 6562
UNION SELECT 6695
UNION SELECT 6698
UNION SELECT 6704
UNION SELECT 6821
UNION SELECT 6853
UNION SELECT 6890
UNION SELECT 6894
UNION SELECT 6919
UNION SELECT 6920
UNION SELECT 5050
UNION SELECT 5051
UNION SELECT 5052
UNION SELECT 5055
UNION SELECT 5056
UNION SELECT 5483
UNION SELECT 5486
UNION SELECT 6718
UNION SELECT 6721
UNION SELECT 5094
UNION SELECT 5102
UNION SELECT 5197
UNION SELECT 5248
UNION SELECT 5474
UNION SELECT 5480
UNION SELECT 6683
UNION SELECT 6684
UNION SELECT 6691
*/

-- CallsHandled by CallType and Date
select 
	dateadd(d, 0, datediff(d, 0, DateTime)) DateTime
--	, ct.EnterpriseName
	, sum(CallsOffered) CallsOffered
	, sum(CallsHandled) CallsHandled
	, sum(TotalCallsAband) TotalCallsAband
	, sum(OverflowOut) OverflowOut
	, sum(AgentErrorCount) AgentErrorCount
	, sum(ErrorCount) ErrorCount
	, sum(CallsRONA) CallsRONA
	, sum(ReturnRelease) ReturnRelease
	, sum(ReturnBusy) ReturnBusy
	, sum(NetworkDefaultRouted) NetworkDefaultRouted
	, sum(ICRDefaultRouted) ICRDefaultRouted
	, sum(RouterQueueCallTypeLimit) RouterQueueCallTypeLimit
	, sum(RouterQueueGlobalLimit) RouterQueueGlobalLimit

	, sum(ReturnRing) ReturnRing
	, sum(IncompleteCalls) IncompleteCalls
from 
	Call_Type_Interval cti
	inner join Call_Type ct on cti.CallTypeID = ct.CallTypeID
	inner join #tmp_EB_Call_Type tmp on ct.CallTypeID = tmp.CallTypeID
where
	DateTime > '10/01/2013'
group by 
	dateadd(d, 0, datediff(d, 0, DateTime))
--	, ct.EnterpriseName
order by 
	dateadd(d, 0, datediff(d, 0, DateTime)) desc
--	, ct.EnterpriseName



