--Test Case 1
select 'TestCase1' as TestNumber, DateTime, CallsOffered, CallsHandled, TotalCallsAband, CallsAnswered, CallsRequeried, CallsRONA, CallsRouted, CallsRoutedNonAgent
from Call_Type_Interval 
where CallsOffered != (CallsHandled + TotalCallsAband )
AND CallTypeID in ('5147','5188','5552','6561','6562','6695','5145','5146','6698','6704','6821','6853','6890','6894','6919','6920','5050','5051','5052','5055','5056','5483','5486','6718','6721','5094','5102','5197','5248','5474','5480','6683','6684','6691')
AND DateTime >= '2013-03-04 00:00:00'
AND DateTime < '2013-03-05 00:00:00'

--Test Case 7
select 'TestCase7' as TestNumber, DateTime, CallsHandled, (AnsInterval1+AnsInterval2+AnsInterval3+AnsInterval4+AnsInterval5+AnsInterval6+AnsInterval7+AnsInterval8+AnsInterval9+AnsInterval10) as AIntTot, AnsInterval1, AnsInterval2, AnsInterval3, AnsInterval4, AnsInterval5, AnsInterval6, AnsInterval7, AnsInterval8, AnsInterval9, AnsInterval10
from Call_Type_interval
where CallsHandled != (AnsInterval1+AnsInterval2+AnsInterval3+AnsInterval4+AnsInterval5+AnsInterval6+AnsInterval7+AnsInterval8+AnsInterval9+AnsInterval10)
AND CallTypeID in ('5147','5188','5552','6561','6562','6695','5145','5146','6698','6704','6821','6853','6890','6894','6919','6920','5050','5051','5052','5055','5056','5483','5486','6718','6721','5094','5102','5197','5248','5474','5480','6683','6684','6691')
AND DateTime >= '2013-03-04 00:00:00'
AND DateTime < '2013-03-05 00:00:00'

--Alternative Test Case 7 (Focuses on CallsAnswered instead of CallsHandled)
select 'TestCase7' as TestNumber, DateTime, CallsAnswered, (AnsInterval1+AnsInterval2+AnsInterval3+AnsInterval4+AnsInterval5+AnsInterval6+AnsInterval7+AnsInterval8+AnsInterval9+AnsInterval10) as AIntTot, AnsInterval1, AnsInterval2, AnsInterval3, AnsInterval4, AnsInterval5, AnsInterval6, AnsInterval7, AnsInterval8, AnsInterval9, AnsInterval10
from Call_Type_interval
where CallsAnswered != (AnsInterval1+AnsInterval2+AnsInterval3+AnsInterval4+AnsInterval5+AnsInterval6+AnsInterval7+AnsInterval8+AnsInterval9+AnsInterval10)
AND CallTypeID in ('5147','5188','5552','6561','6562','6695','5145','5146','6698','6704','6821','6853','6890','6894','6919','6920','5050','5051','5052','5055','5056','5483','5486','6718','6721','5094','5102','5197','5248','5474','5480','6683','6684','6691')
AND DateTime >= '2013-03-04 00:00:00'
AND DateTime < '2013-03-05 00:00:00'

--Test Case 7b (Sum of Day)
Select SUM(CallsHandled) as DailyCallsHandled, 
SUM(CallsAnswered) as DailyCallsAnswered,
SUM(AnsInterval1+AnsInterval2+AnsInterval3+AnsInterval4+AnsInterval5+AnsInterval6+AnsInterval7+AnsInterval8+AnsInterval9+AnsInterval10) as DailyAnsIntervalsCallsAnswered
from Call_Type_Interval
WHERE CallTypeID in ('5147','5188','5552','6561','6562','6695','5145','5146','6698','6704','6821','6853','6890','6894','6919','6920','5050','5051','5052','5055','5056','5483','5486','6718','6721','5094','5102','5197','5248','5474','5480','6683','6684','6691')
AND DateTime >= '2013-03-04 00:00:00'
AND DateTime < '2013-03-05 00:00:00'

--Test Case 9 (Also showing CallsAnswered)
SELECT cti.ServiceLevelCalls, cti.CallsAnswered, cti.CallsHandled
FROM Call_Type_Interval cti
WHERE cti.ServiceLevelCalls > cti.CallsHandled
AND CallTypeID in ('5147','5188','5552','6561','6562','6695','5145','5146','6698','6704','6821','6853','6890','6894','6919','6920','5050','5051','5052','5055','5056','5483','5486','6718','6721','5094','5102','5197','5248','5474','5480','6683','6684','6691')
AND DateTime >= '2013-03-04 00:00:00'
AND DateTime < '2013-03-05 00:00:00'

--Test Case 10
select 'TestCase10' as TestNumber, cti.CallsHandled, cti.ServiceLevelCalls, cti.AnsInterval1, cti.AnsInterval2, cti.AnsInterval3, cti.AnsInterval4, cti.AnsInterval5, cti.AnsInterval6, cti.AnsInterval7, cti.AnsInterval8, cti.AnsInterval9, cti.AnsInterval10
from Call_Type_Interval cti
where (cti.ServiceLevelCalls < cti.CallsHandled) and ((cti.AnsInterval8+cti.AnsInterval9+cti.AnsInterval10)!=(cti.CallsHandled - cti.ServiceLevelCalls))
AND CallTypeID in ('5147','5188','5552','6561','6562','6695','5145','5146','6698','6704','6821','6853','6890','6894','6919','6920','5050','5051','5052','5055','5056','5483','5486','6718','6721','5094','5102','5197','5248','5474','5480','6683','6684','6691')
AND DateTime >= '2013-03-04 00:00:00'
AND DateTime < '2013-03-05 00:00:00'

--Alternative Test Case 10 (Focuses on CallsAnswered instead of CallsHandled)
select 'TestCase10' as TestNumber, cti.CallsHandled, cti.CallsAnswered, cti.ServiceLevelCalls, 
	SUM(cti.AnsInterval7+cti.AnsInterval8+cti.AnsInterval9+cti.AnsInterval10) as nonServiceLevelCalls,
	cti.AnsInterval1, cti.AnsInterval2, cti.AnsInterval3, cti.AnsInterval4, cti.AnsInterval5, cti.AnsInterval6, cti.AnsInterval7, cti.AnsInterval8, cti.AnsInterval9, cti.AnsInterval10
from Call_Type_Interval cti
where (cti.ServiceLevelCalls < cti.CallsAnswered) and ((cti.AnsInterval7+cti.AnsInterval8+cti.AnsInterval9+cti.AnsInterval10)!=(cti.CallsAnswered - cti.ServiceLevelCalls))
AND CallTypeID in ('5147','5188','5552','6561','6562','6695','5145','5146','6698','6704','6821','6853','6890','6894','6919','6920','5050','5051','5052','5055','5056','5483','5486','6718','6721','5094','5102','5197','5248','5474','5480','6683','6684','6691')
AND DateTime >= '2013-03-04 00:00:00'
AND DateTime <= '2013-03-05 00:00:00'
GROUP BY cti.CallsHandled, cti.CallsAnswered, cti.ServiceLevelCalls, cti.AnsInterval1, cti.AnsInterval2, cti.AnsInterval3, cti.AnsInterval4, cti.AnsInterval5, cti.AnsInterval6, cti.AnsInterval7, cti.AnsInterval8, cti.AnsInterval9, cti.AnsInterval10

--Test Case 11
SELECT 'TestCase11' as TestNumber, cast(asgi.DateTime As Date) as DateTime , asgi.SkillTargetID, sub1.LoggedOnTime as Login_Seconds, 
	(SUM(TalkInTime)+SUM(HoldTime)+SUM(WorkNotReadyTime)+SUM(WorkReadyTime)+SUM(TalkOutTime)+SUM(TalkOtherTime)+SUM(TalkReserveTime)+SUM(TalkAutoOutTime)+SUM(TalkPreviewTime)+SUM(ReservedStateTime)+sub1.AvailTime+sub1.NotReadyTime) as ACTIVITYSUM, 
	(((ABS(sub1.LoggedOnTime - (SUM(TalkInTime)+SUM(HoldTime)+SUM(WorkNotReadyTime)+SUM(WorkReadyTime)+SUM(TalkOutTime)+SUM(TalkOtherTime)+SUM(TalkReserveTime)+SUM(TalkAutoOutTime)+SUM(TalkPreviewTime)+SUM(ReservedStateTime)+sub1.AvailTime+sub1.NotReadyTime)*1.00)) / sub1.LoggedOnTime)*100) as Percentage
FROM Agent_Skill_Group_Interval asgi
INNER JOIN (
		SELECT cast(DateTime As Date) as DateTime , SkillTargetID, SUM(AvailTime) as AvailTime, SUM(NotReadyTime) as NotReadyTime, SUM(LoggedOnTime) as LoggedOnTime
		from Agent_Skill_Group_Interval asgi
		where SkillGroupSkillTargetID IN (5000,5001,5002,5003,5004)
		AND DateTime >= '2013-03-04 00:00:00'
		AND DateTime < '2013-03-05 00:00:00'
		GROUP BY SkillTargetID, cast(DateTime As Date)
) sub1 on (cast(asgi.DateTime As Date) = cast(sub1.DateTime as Date)) and (asgi.SkillTargetID = sub1.SkillTargetID)
WHERE SkillGroupSkillTargetID IN ('5182','5183','5184','5185','5186','5187','5188','5189','5190','5192','5193','5194','5195','5196','5197','5198','5199','5200','5201','5202','5203','5204','5205','5206','5207','5257','5313','5314','5317','5318','5319','5320','5436','7284','7285','7286','7287','7288','7289','7290','7291','7568','7606','7609','7610','8220','8221','8242','8243','8244','8245','8250','8251','8329','8330','8406','8407','8408','8409','8410','8411','8412','8413','8436','8607','8913','9100','9101','9282','9283','9284','9285','9286','9287','9827','9828','9829','9830','9831','9832','9833','9834','9835','9836','9837','9838','9839','9840','9841','9842','9843','9844','9845','9846','9847','9848','9849','9850','9851','9852','9853','9854','9855','9856','9857','9858','9859','9860','9861','9862','9863','9864','9865','9866','9867','9868','9869','9870','9871','9872','9873','9874','1016','1054','1072','1088','1098','1099','1122','1123','1124','1153','1171','1175','1176','1273','1274','1371','1372','1395','1396','1410','1544','1589','1618','1702','1705')
AND asgi.DateTime >= '2013-03-04 00:00:00'
AND asgi.DateTime < '2013-03-05 00:00:00'
GROUP BY asgi.SkillTargetID, cast(asgi.DateTime As Date), sub1.LoggedOnTime, sub1.AvailTime, sub1.NotReadyTime
HAVING sub1.LoggedOnTime != SUM(TalkInTime)+SUM(HoldTime)+SUM(WorkNotReadyTime)+SUM(WorkReadyTime)+SUM(TalkOutTime)+SUM(TalkOtherTime)+SUM(TalkReserveTime)+SUM(TalkAutoOutTime)+SUM(TalkPreviewTime)+SUM(ReservedStateTime)+sub1.AvailTime+sub1.NotReadyTime
AND (((ABS(sub1.LoggedOnTime - (SUM(TalkInTime)+SUM(HoldTime)+SUM(WorkNotReadyTime)+SUM(WorkReadyTime)+SUM(TalkOutTime)+SUM(TalkOtherTime)+SUM(TalkReserveTime)+SUM(TalkAutoOutTime)+SUM(TalkPreviewTime)+SUM(ReservedStateTime)+sub1.AvailTime+sub1.NotReadyTime)*1.00)) / sub1.LoggedOnTime)*100) > 0.25
ORDER BY SkillTargetID asc

--Test Case 12
select 'TestCase12' as TestNumber, cast(DateTime As Date) as DateTime , SkillTargetID, SUM(LoggedOnTime) as Login_Seconds, (8*60*60) as ShiftLength
from Agent_Skill_Group_Interval asgi
--Inner Join Agent a on asgi.SkillTargetID = a.SkillTargetID
where SkillGroupSkillTargetID IN (5000,5001,5002,5003,5004)
AND DateTime >= '2013-03-04 00:00:00'
AND DateTime < '2013-03-05 00:00:00'
GROUP BY SkillTargetID, cast(DateTime As Date)
Having SUM(LoggedOnTime) > (8*60*60)
order by SUM(LoggedOnTime) desc

--Test Case 20
select 'TestCase20' as TestNumber, DateTime, ShortCalls, TotalCallsAband
from Call_Type_Interval ai 
where ShortCalls > TotalCallsAband
AND CallTypeID in ('5147','5188','5552','6561','6562','6695','5145','5146','6698','6704','6821','6853','6890','6894','6919','6920','5050','5051','5052','5055','5056','5483','5486','6718','6721','5094','5102','5197','5248','5474','5480','6683','6684','6691')
AND DateTime >= '2013-03-04 00:00:00'
AND DateTime < '2013-03-05 00:00:00'