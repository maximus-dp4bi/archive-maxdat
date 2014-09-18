-- Agent Skill Groups
select * from Skillset;

-- Contact Queues
select * from Application;

-- Distinct queues offered calls in the past year
select distinct a.Name
from Application a
inner join dApplicationStat das on a.ApplicationID = das.ApplicationID
where "Timestamp" > DATEADD(yy, -1, {fn CURDATE})
and CallsOffered > 0;

-- Distinct skill groups offered calls in the past year
select distinct s.Skillset
from Skillset s
inner join dAgentBySkillsetStat dass on s.SkillsetID = dass.SkillsetID
where "Timestamp" > DATEADD(yy, -1, {fn CURDATE})
and CallsOffered > 0;




