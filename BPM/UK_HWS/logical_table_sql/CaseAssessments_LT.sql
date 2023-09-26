
SELECT
distinct c.Id CaseId
, c.DischargeDate
, fc.FirstCreatedAssessmentId
, fc.FirstCreatedAssessmentCreatedDate
, fc.FirstCreatedAssessmentFinishedDate
, lc.LastCreatedAssessmentId
, lc.LastCreatedAssessmentCreatedDate
, lc.lastCreatedAssessmentFinishedDate
, lf.LastFinishedAssessmentId
, lf.LastFinishedAssessmentCreatedDate
, lf.LastFinishedAssessmentFinishedDate
, fp.FirstAssessmentPublishDate
, fp.FirstPublishedAssessmentId
, lp.LastAssessmentPublishDate
, lp.LastPublishedAssessmentId
, case when rwo.caseid is null then null when rwo.ConsentPubEmployerRTWP1 = 1 then 'Yes' else 'No' end as ConsentPubEmployerRTWP1
, case when rwo.caseid is null then null when rwo.ConsentPubEmployerRTWP2 = 1 then 'Yes' else 'No' end as ConsentPubEmployerRTWP2
, case when rwo.caseid is null then null when rwo.ConsentPubGPRTWP1 = 1 then 'Yes' else 'No' end as ConsentPubGPRTWP1
, case when rwo.caseid is null then null when rwo.ConsentPubGPRTWP2 = 1 then 'Yes' else 'No' end as ConsentPubGPRTWP2
, case when c.CaseFamilyId is null then 'No'
		when c.CaseFamilyId = '{00000000-0000-0000-0000-000000000000}' then 'No'
        when exists ( select 1 from [case].[case] c2
                      where c2.CaseFamilyId = c.CaseFamilyId
                      and c2.CreatedTimestamp < c.CreatedTimestamp
					) then 'Yes' else 'No' end as PreviousReferralExists
, ao1.FirstAssessmentOutcome
, ao2.SecondAssessmentOutcome
, SUBSTRING((SELECT distinct ',' +
			o.name
			from [assessment].[assessment] a
            inner join [assessment].[ReturnToWorkPlan] rtwp on rtwp.AssessmentId = a.id
            inner join [assessment].[ReturnToWorkObstacle] rtwo on rtwo.ReturnToWorkPlanId = rtwp.id
            inner join [assessment].[obstacle] o on o.id = rtwo.ObstacleId
            inner join [assessment].[obstacletype] ot on o.ObstacleTypeId = ot.id
            and ot.Name = 'Work'
            where a.caseid = c.id
	FOR XML PATH('')),2,200000) as RTWPWorkObstacles
, SUBSTRING((SELECT distinct ',' +
			o.name
			from [assessment].[assessment] a
            inner join [assessment].[ReturnToWorkPlan] rtwp on rtwp.AssessmentId = a.id
            inner join [assessment].[ReturnToWorkObstacle] rtwo on rtwo.ReturnToWorkPlanId = rtwp.id
            inner join [assessment].[obstacle] o on o.id = rtwo.ObstacleId
            inner join [assessment].[obstacletype] ot on o.ObstacleTypeId = ot.id
            and ot.Name = 'Social'
            where a.caseid = c.id
	FOR XML PATH('')),2,200000) as RTWPSocialObstacles
, SUBSTRING((SELECT distinct ',' +
			o.name
			from [assessment].[assessment] a
            inner join [assessment].[ReturnToWorkPlan] rtwp on rtwp.AssessmentId = a.id
            inner join [assessment].[ReturnToWorkObstacle] rtwo on rtwo.ReturnToWorkPlanId = rtwp.id
            and (rtwo.IsPrimary = 1)
            inner join [assessment].[obstacle] o on o.id = rtwo.ObstacleId
            inner join [assessment].[obstacletype] ot on o.ObstacleTypeId = ot.id
            and ot.Name = 'Health'
            where a.caseid = c.id
	FOR XML PATH('')),2,200000) as RTWPPrimaryHealthObstacles
, SUBSTRING((SELECT distinct ',' +
			o.name
			from [assessment].[assessment] a
            inner join [assessment].[ReturnToWorkPlan] rtwp on rtwp.AssessmentId = a.id
            inner join [assessment].[ReturnToWorkObstacle] rtwo on rtwo.ReturnToWorkPlanId = rtwp.id
            and (rtwo.IsPrimary = 0 or rtwo.IsPrimary is null)
            inner join [assessment].[obstacle] o on o.id = rtwo.ObstacleId
            inner join [assessment].[obstacletype] ot on o.ObstacleTypeId = ot.id
            and ot.Name = 'Health'
            where a.caseid = c.id
	FOR XML PATH('')),2,200000) as RTWPSecondaryHealthObstacles
, SUBSTRING((SELECT distinct ',' +
			li.value
			from [assessment].[assessment] a
            inner join [assessment].[ReturnToWorkPlan] rtwp on rtwp.AssessmentId = a.id
            inner join [assessment].[ReturnToWorkPlanIntervention] rtwpi on rtwp.id = rtwpi.ReturnToWorkPlanId
            inner join [lookup].[LookupItem] li on rtwpi.InterventionId = li.id
            where a.caseid = c.id
FOR XML PATH('')),2,200000) as RTWPInterventions
, SUBSTRING((SELECT distinct ',' +
			li.value
			from [assessment].[assessment] a
            inner join [assessment].[ReturnToWorkPlan] rtwp on rtwp.AssessmentId = a.id
            inner join [assessment].[ReturnToWorkPlanSignposting] rtwps on rtwp.id = rtwps.ReturnToWorkPlanId
            inner join [lookup].[LookupItem] li on rtwps.SignpostingId = li.id
			where a.caseid = c.id
FOR XML PATH('')),2,200000) as RTWPSignposting
, SUBSTRING((SELECT distinct ',' +
			fs.name
			from [assessment].[ReturnToWorkPlan] rtwp
            inner join [assessment].[FitStatus] fs on rtwp.fitstatusid = fs.id
            where rtwp.id = lp.LastPublishedRTWPId
FOR XML PATH('')),2,200000) as RTWPRecommendations
, lp.LastPublishedRTWPExpiryDate
, SUBSTRING((SELECT distinct ',' +
			o.description
            from [assessment].[ReturnToWorkPlan] rtwp
            inner join [assessment].[Returntoworkplanoption] rtwpo on rtwp.id = rtwpo.returntoworkplanid
            inner join [assessment].[returntoworkoption] o on rtwpo.OptionId = o.id
            where rtwp.id = lp.LastPublishedRTWPId         
FOR XML PATH('')),2,200000) + 
                (   select  case when returntoworkoptioninfo <> '' then ',' + returntoworkoptioninfo
                   else '' end
                    from [assessment].[ReturnToWorkPlan] rtwp
                    where rtwp.id = lp.LastPublishedRTWPId   )
 as RTWPOptions
from [case].[case] c
left outer join (
SELECT
distinct a.CaseId
, FIRST_VALUE(a.Id) over(partition by a.CaseId order by a.CreatedDate) FirstCreatedAssessmentId
, FIRST_VALUE(a.CreatedDate) over(partition by a.CaseId order by a.CreatedDate) FirstCreatedAssessmentCreatedDate
, FIRST_VALUE(a.FinishDate) over(partition by a.CaseId order by a.CreatedDate) FirstCreatedAssessmentFinishedDate
from [assessment].[assessment] a
) fc on c.id = fc.caseid
left outer join (
SELECT
distinct a.CaseId
, FIRST_VALUE(a.Id) over(partition by a.CaseId order by a.CreatedDate desc) LastCreatedAssessmentId
, FIRST_VALUE(a.CreatedDate) over(partition by a.CaseId order by a.CreatedDate desc) LastCreatedAssessmentCreatedDate
, FIRST_VALUE(a.FinishDate) over(partition by a.CaseId order by a.CreatedDate desc) LastCreatedAssessmentFinishedDate
from [assessment].[assessment] a
) lc on c.id = lc.caseid
left outer join (
SELECT
distinct a.CaseId
, FIRST_VALUE(a.Id) over(partition by a.CaseId order by a.FinishDate desc) LastFinishedAssessmentId
, FIRST_VALUE(a.CreatedDate) over(partition by a.CaseId order by a.FinishDate desc) LastFinishedAssessmentCreatedDate
, FIRST_VALUE(a.FinishDate) over(partition by a.CaseId order by a.FinishDate desc) LastFinishedAssessmentFinishedDate
from [assessment].[assessment] a
) lf on c.id = lf.caseid
left outer join (
select distinct pa.CaseId
, FIRST_VALUE(pa.FirstPublishDate) over(partition by pa.CaseId order by pa.CreatedDate) FirstAssessmentPublishDate
, FIRST_VALUE(pa.id) over(partition by pa.CaseId order by pa.CreatedDate) FirstPublishedAssessmentId
from (
select distinct a.*
, min(cn1.CreatedDate) over(partition by a.Id) as FirstPublishDate
from  (
select distinct aa.CaseId
, aa.Id
, aa.FinishDate
, aa.CreatedDate
, aa.DateOfAssessment
, lead(aa.FinishDate) over(partition by aa.CaseId order by aa.VersionNumber) NextAssessFinishDate
from [HWSInternal].[Assessment].[Assessment] aa
  inner join [HWSInternal].[Assessment].[ReturnToWorkPlan] rtwp on rtwp.AssessmentId = aa.Id
  inner join [HWSInternal].[casE].[CASE] c on aa.CaseId = c.Id
Where aa.IsPublished = 1
  and aa.FinishDate is not null
) a
  inner join [HWSInternal].[CASE].[CASENOTE] cn1 ON
                a.CaseId = cn1.CaseId and (cn1.CreatedBy = 'Service: Return To Work Plan'
                and cn1.comment like 'RTWP%Sent' OR cn1.comment like 'RTWP%dispatched%')
                and cn1.CreatedDate >= a.FinishDate
                and cn1.CreatedDate < coalesce(a.NextAssessFinishDate,getdate())
) pa
) fp on c.Id = fp.CaseId
left outer join (
select distinct pa.CaseId
, FIRST_VALUE(pa.FirstPublishDate) over(partition by pa.CaseId order by pa.CreatedDate desc) LastAssessmentPublishDate
, FIRST_VALUE(pa.Id) over(partition by pa.CaseId order by pa.CreatedDate desc) LastPublishedAssessmentId
, FIRST_VALUE(pa.validto) over(partition by pa.CaseId order by pa.CreatedDate desc) LastPublishedRTWPExpiryDate
, FIRST_VALUE(pa.rtwpid) over(partition by pa.CaseId order by pa.CreatedDate desc) LastPublishedRTWPId
from (
select distinct a.*
, min(cn1.CreatedDate) over(partition by a.Id) as FirstPublishDate
from  (
select distinct aa.CaseId
, aa.Id
, aa.FinishDate
, aa.CreatedDate
, aa.DateOfAssessment
, rtwp.ValidTo
, rtwp.id rtwpid
, lead(aa.FinishDate) over(partition by aa.CaseId order by aa.VersionNumber) NextAssessFinishDate
from [HWSInternal].[Assessment].[Assessment] aa
  inner join [HWSInternal].[Assessment].[ReturnToWorkPlan] rtwp on rtwp.AssessmentId = aa.Id
  inner join [HWSInternal].[casE].[CASE] c on aa.CaseId = c.Id
Where aa.IsPublished = 1
  and aa.FinishDate is not null
) a
  inner join [HWSInternal].[CASE].[CASENOTE] cn1 ON
                a.CaseId = cn1.CaseId and (cn1.CreatedBy = 'Service: Return To Work Plan'
                and cn1.comment like 'RTWP%Sent' OR cn1.comment like 'RTWP%dispatched%')
                and cn1.CreatedDate >= a.FinishDate
                and cn1.CreatedDate < coalesce(a.NextAssessFinishDate,getdate())
) pa
) lp on c.Id = lp.CaseId
left outer join
(
select distinct CaseId
, max(ConsentPubEmployerRTWP1 + 0) ConsentPubEmployerRTWP1
, max(ConsentPubEmployerRTWP2 + 0) ConsentPubEmployerRTWP2
, max(ConsentPubGPRTWP1 + 0) ConsentPubGPRTWP1
, max(ConsentPubGPRTWP2 + 0) ConsentPubGPRTWP2
from
(select distinct
asseq.CaseId
, asseq.Id
, asseq.ReturnToWorkPlanId
, asseq.AssessmentSequence
, case when asseq.assessmentsequence = 1 then o.employerconsent else 0 end as ConsentPubEmployerRTWP1
, case when asseq.assessmentsequence = 2 then o.employerconsent else 0 end as ConsentPubEmployerRTWP2
, case when asseq.assessmentsequence = 1 then o.GPConsent else 0 end as ConsentPubGPRTWP1
, case when asseq.assessmentsequence = 2 then o.GPConsent else 0 end as ConsentPubGPRTWP2
from (
select distinct p.*
, RANK() OVER (PARTITION BY p.CaseId ORDER BY p.CreatedDate) AS AssessmentSequence
from (
select distinct a.*
, min(cn1.CreatedDate) over(partition by a.Id) as FirstPublishDate
from (
select distinct aa.CaseId
, aa.Id
, aa.FinishDate
, aa.CreatedDate
, rtwp.id ReturnToWorkPlanId
, lead(aa.FinishDate) over(partition by aa.CaseId order by aa.VersionNumber) NextAssessFinishDate
from [HWSInternal].[Assessment].[Assessment] aa
  inner join [HWSInternal].[Assessment].[ReturnToWorkPlan] rtwp on rtwp.AssessmentId = aa.Id
Where aa.IsPublished = 1
  and aa.FinishDate is not null) as a
  left outer join [HWSInternal].[CASE].[CASENOTE] cn1 ON
                a.CaseId = cn1.CaseId and (cn1.CreatedBy = 'Service: Return To Work Plan' and cn1.comment like 'RTWP%Sent' OR cn1.comment like 'RTWP%dispatched%') and cn1.CreatedDate >= a.FinishDate and cn1.CreatedDate < coalesce(a.NextAssessFinishDate,getdate())
) as p
where p.FirstPublishDate is not null
) as asseq
inner join [assessment].[ReturnToWorkObstacle] o on asseq.returntoworkplanid = o.ReturnToWorkPlanId
where asseq.assessmentsequence in(1,2)
) as r
group by CaseId) rwo on c.Id = rwo.CaseId

left outer join
(
select distinct
asseq.CaseId
, SUBSTRING((SELECT distinct ',' + otli.Value
              FROM [assessment].[ReturnToWorkPlanOutcome] ot
              inner join [lookup].[lookupitem] otli on ot.OutcomeId = otli.id
              inner join [assessment].[ReturnToWorkPlan] rwp on asseq.returntoworkplanid = ot.ReturnToWorkPlanId
              and asseq.assessmentsequence = 1
              FOR XML PATH('')),2,200000) as FirstAssessmentOutcome
from (
select distinct p.*
, RANK() OVER (PARTITION BY p.CaseId ORDER BY p.CreatedDate) AS AssessmentSequence
from (
select distinct a.*
, min(cn1.CreatedDate) over(partition by a.Id) as FirstPublishDate
from (
select distinct aa.CaseId
, aa.Id
, aa.FinishDate
, aa.CreatedDate
, rtwp.id ReturnToWorkPlanId
, lead(aa.FinishDate) over(partition by aa.CaseId order by aa.VersionNumber) NextAssessFinishDate
from [HWSInternal].[Assessment].[Assessment] aa
  inner join [HWSInternal].[Assessment].[ReturnToWorkPlan] rtwp on rtwp.AssessmentId = aa.Id
Where aa.IsPublished = 1
  and aa.FinishDate is not null) as a
  left outer join [HWSInternal].[CASE].[CASENOTE] cn1 ON
                a.CaseId = cn1.CaseId and (cn1.CreatedBy = 'Service: Return To Work Plan' and cn1.comment like 'RTWP%Sent' OR cn1.comment like 'RTWP%dispatched%') and cn1.CreatedDate >= a.FinishDate and cn1.CreatedDate < coalesce(a.NextAssessFinishDate,getdate())
) as p
where p.FirstPublishDate is not null
) as asseq
where asseq.assessmentsequence = 1
) ao1 on c.id = ao1.caseid
left outer join (
select distinct
asseq.CaseId
, SUBSTRING((SELECT distinct ',' + otli.Value
              FROM [assessment].[ReturnToWorkPlanOutcome] ot
              inner join [lookup].[lookupitem] otli on ot.OutcomeId = otli.id
              inner join [assessment].[ReturnToWorkPlan] rwp on asseq.returntoworkplanid = ot.ReturnToWorkPlanId
              and asseq.assessmentsequence = 2
              FOR XML PATH('')),2,200000) as SecondAssessmentOutcome
from (
select distinct p.*
, RANK() OVER (PARTITION BY p.CaseId ORDER BY p.CreatedDate) AS AssessmentSequence
from (
select distinct a.*
, min(cn1.CreatedDate) over(partition by a.Id) as FirstPublishDate
from (
select distinct aa.CaseId
, aa.Id
, aa.FinishDate
, aa.CreatedDate
, rtwp.id ReturnToWorkPlanId
, lead(aa.FinishDate) over(partition by aa.CaseId order by aa.VersionNumber) NextAssessFinishDate
from [HWSInternal].[Assessment].[Assessment] aa
  inner join [HWSInternal].[Assessment].[ReturnToWorkPlan] rtwp on rtwp.AssessmentId = aa.Id
Where aa.IsPublished = 1
  and aa.FinishDate is not null) as a
  left outer join [HWSInternal].[CASE].[CASENOTE] cn1 ON
                a.CaseId = cn1.CaseId
                and (cn1.CreatedBy = 'Service: Return To Work Plan'   and cn1.comment like 'RTWP%Sent' OR cn1.comment like 'RTWP%dispatched%')
                and cn1.CreatedDate >= a.FinishDate
                and cn1.CreatedDate < coalesce(a.NextAssessFinishDate,getdate())
) as p
where p.FirstPublishDate is not null
) as asseq
where asseq.assessmentsequence = 2
) ao2 on c.id = ao2.caseid

