/*
SELECT 5000 AS SkillGroupSkillTargetID
INTO #tmp_EB_Skill_Group
UNION SELECT 5001  
UNION SELECT 5002  
UNION SELECT 5003  
UNION SELECT 5004  
UNION SELECT 5182  
UNION SELECT 5183  
UNION SELECT 5184  
UNION SELECT 5185  
UNION SELECT 5186  
UNION SELECT 5187  
UNION SELECT 5188  
UNION SELECT 5189  
UNION SELECT 5190  
UNION SELECT 5192  
UNION SELECT 5193  
UNION SELECT 5194  
UNION SELECT 5195  
UNION SELECT 5196  
UNION SELECT 5197  
UNION SELECT 5198  
UNION SELECT 5199  
UNION SELECT 5200  
UNION SELECT 5201  
UNION SELECT 5202  
UNION SELECT 5203  
UNION SELECT 5204  
UNION SELECT 5205  
UNION SELECT 5206  
UNION SELECT 5207  
UNION SELECT 5257  
UNION SELECT 5313  
UNION SELECT 5314  
UNION SELECT 5317  
UNION SELECT 5318  
UNION SELECT 5319  
UNION SELECT 5320  
UNION SELECT 5436  
UNION SELECT 7284  
UNION SELECT 7285  
UNION SELECT 7286  
UNION SELECT 7287  
UNION SELECT 7288  
UNION SELECT 7289  
UNION SELECT 7290  
UNION SELECT 7291  
UNION SELECT 7568  
UNION SELECT 7606  
UNION SELECT 7609  
UNION SELECT 7610  
UNION SELECT 8220  
UNION SELECT 8221  
UNION SELECT 8242  
UNION SELECT 8243  
UNION SELECT 8244  
UNION SELECT 8245  
UNION SELECT 8250  
UNION SELECT 8251  
UNION SELECT 8329  
UNION SELECT 8330  
UNION SELECT 8406  
UNION SELECT 8407  
UNION SELECT 8408  
UNION SELECT 8409  
UNION SELECT 8410  
UNION SELECT 8411  
UNION SELECT 8412  
UNION SELECT 8413  
UNION SELECT 8436  
UNION SELECT 8607  
UNION SELECT 8913  
UNION SELECT 9100  
UNION SELECT 9101  
UNION SELECT 9282  
UNION SELECT 9283  
UNION SELECT 9284  
UNION SELECT 9285  
UNION SELECT 9286  
UNION SELECT 9287  
UNION SELECT 9827  
UNION SELECT 9828  
UNION SELECT 9829  
UNION SELECT 9830  
UNION SELECT 9831  
UNION SELECT 9832  
UNION SELECT 9833  
UNION SELECT 9834  
UNION SELECT 9835  
UNION SELECT 9836  
UNION SELECT 9837  
UNION SELECT 9838  
UNION SELECT 9839  
UNION SELECT 9840  
UNION SELECT 9841  
UNION SELECT 9842  
UNION SELECT 9843  
UNION SELECT 9844  
UNION SELECT 9845  
UNION SELECT 9846  
UNION SELECT 9847  
UNION SELECT 9848  
UNION SELECT 9849  
UNION SELECT 9850  
UNION SELECT 9851  
UNION SELECT 9852  
UNION SELECT 9853  
UNION SELECT 9854  
UNION SELECT 9855  
UNION SELECT 9856  
UNION SELECT 9857  
UNION SELECT 9858  
UNION SELECT 9859  
UNION SELECT 9860  
UNION SELECT 9861  
UNION SELECT 9862  
UNION SELECT 9863  
UNION SELECT 9864  
UNION SELECT 9865  
UNION SELECT 9866  
UNION SELECT 9867  
UNION SELECT 9868  
UNION SELECT 9869  
UNION SELECT 9870  
UNION SELECT 9871  
UNION SELECT 9872  
UNION SELECT 9873  
UNION SELECT 9874  
UNION SELECT 10163 
UNION SELECT 10540 
UNION SELECT 10541 
UNION SELECT 10544 
UNION SELECT 10545 
UNION SELECT 10546 
UNION SELECT 10547 
UNION SELECT 10548 
UNION SELECT 10549 
UNION SELECT 10720 
UNION SELECT 10721 
UNION SELECT 10882 
UNION SELECT 10988 
UNION SELECT 10989 
UNION SELECT 10990 
UNION SELECT 10991 
UNION SELECT 11229 
UNION SELECT 11230 
UNION SELECT 11236 
UNION SELECT 11237 
UNION SELECT 11238 
UNION SELECT 11239 
UNION SELECT 11240 
UNION SELECT 11241 
UNION SELECT 11538 
UNION SELECT 11539 
UNION SELECT 11714 
UNION SELECT 11715 
UNION SELECT 11759 
UNION SELECT 11760 
UNION SELECT 12739 
UNION SELECT 12740 
UNION SELECT 13711 
UNION SELECT 13712 
UNION SELECT 13717 
UNION SELECT 13718 
UNION SELECT 13719 
UNION SELECT 13720 
UNION SELECT 13958 
UNION SELECT 13959 
UNION SELECT 13960 
UNION SELECT 13961 
UNION SELECT 14100 
UNION SELECT 14101 
UNION SELECT 14102 
UNION SELECT 14103 
UNION SELECT 15446 
UNION SELECT 15894 
UNION SELECT 15895 
UNION SELECT 16181 
UNION SELECT 16182 
UNION SELECT 17021 
UNION SELECT 17022 
UNION SELECT 17023 
UNION SELECT 17024 
UNION SELECT 17025 
UNION SELECT 17026 
UNION SELECT 17053 
UNION SELECT 17054 
UNION SELECT 17055 
UNION SELECT 17056 
UNION SELECT 17057 
UNION SELECT 17058 

*/


-- CallsHandled by SkillGroup and Date
select 
	dateadd(d, 0, datediff(d, 0, DateTime))
--	, sg.EnterpriseName
	, sum(CallsHandled)
from 
	Agent_Skill_Group_Interval asgi
	inner join Skill_Group sg on asgi.SkillGroupSkillTargetID = sg.SkillTargetID
	inner join #tmp_EB_Skill_Group tmp on sg.SkillTargetID = tmp.SkillGroupSkillTargetID
where
	DateTime between '10/21/2013' and '10/26/2013'
group by 
	dateadd(d, 0, datediff(d, 0, DateTime))
--	, sg.EnterpriseName
order by 
	dateadd(d, 0, datediff(d, 0, DateTime)) desc
--	, sg.EnterpriseName




