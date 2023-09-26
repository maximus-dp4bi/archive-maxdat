SELECT      
CaseId,
CTATeamId,
Id,
ClientId,
Name,
Case when IsDefaultTeam = 1 then 'Yes' else 'No' end IsDefaultTeam,
Case when IsHP = 1 then 'Yes' else 'No' end IsHP,
ShortName
FROM            
[Case].CaseCTATeam INNER JOIN Resources.CTATeam 
ON [Case].CaseCTATeam.CTATeamId = Resources.CTATeam.Id