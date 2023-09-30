
select distinct
asseq.CaseId
, asseq.Id
, asseq.AssessmentSequence
, CASE   WHEN asseq.AssessmentSequence is null then null
                                WHEN asseq.AssessmentSequence = 1 then 'Initial'
        else 'Further' end as AssessmentSequenceType
, CASE WHEN asseq.AssessmentSequence = 1 then coalesce(asseq.MIReceivedDate,asseq.ReceivedTimestamp)
       WHEN asseq.AppointmentBookingDate IS NOT NULL then asseq.AppointmentBookingDate
      ELSE asseq.DateOfAssessment END as AssessmentRequiredDT
, asseq.FinishDate 
, asseq.CreatedDate
,asseq.DateOfAssessment
, asseq.PublishToEmployeeDate
, asseq.FirstPublishDate
, asseq.AppointmentBookingDate
, asseq.AssessmentType
, asseq.PublishToEmployerDate
, asseq.PublishToGPDate
, asseq.SentForEmployeeReviewDate
from (
select distinct p.*
, RANK() OVER (PARTITION BY p.CaseId ORDER BY p.CreatedDate) AS AssessmentSequence
from (
select distinct a.*
, min(cn2.CreatedDate) over(partition by a.Id) as PublishToEmployeeDate
, min(cn1.CreatedDate) over(partition by a.Id) as FirstPublishDate
, min(cn3.CreatedDate) over(partition by a.Id) as PublishToEmployerDate
, min(cn4.CreatedDate) over(partition by a.Id) as PublishToGPDate
, min(cn5.CreatedDate) over(partition by a.Id) as SentForEmployeeReviewDate
, min(cn6.CreatedDate) over(partition by a.Id) as MIReceivedDate
from (
select distinct aa.CaseId
, aa.Id
, aa.FinishDate
, aa.CreatedDate
, min(ap.AppointmentBookingDate) over(partition by aa.Id) AppointmentBookingDate
, l.value AssessmentType
, aa.DateOfAssessment
, r.ReceivedTimestamp
, lead(aa.FinishDate) over(partition by aa.CaseId order by aa.VersionNumber) NextAssessFinishDate
from [HWSInternal].[Assessment].[Assessment] aa
  inner join [HWSInternal].[Assessment].[ReturnToWorkPlan] rtwp on rtwp.AssessmentId = aa.Id
  INNER JOIN [HWSInternal].[Lookup].[LookupItem] l ON l.Id =  aa.ASSESSMENTTYPEID
  inner join [HWSInternal].[casE].[CASE] c on aa.CaseId = c.Id
  INNER JOIN HWSInternal.Referral.Referral r on c.ReferralId = r.Id
  LEFT OUTER JOIN HWSInternal.Appointment.Appointment ap on aa.CaseId = ap.CaseId
                AND aa.DateOfAssessment = ap.AppointmentDate
Where aa.IsPublished = 1
  and aa.FinishDate is not null) as a
  left outer join [HWSInternal].[CASE].[CASENOTE] cn1 ON
                a.CaseId = cn1.CaseId and (cn1.CreatedBy = 'Service: Return To Work Plan' and cn1.comment like 'RTWP%Sent' OR cn1.comment like 'RTWP%dispatched%')  and cn1.CreatedDate >= a.FinishDate and cn1.CreatedDate < coalesce(a.NextAssessFinishDate,getdate())
  left outer join [HWSInternal].[CASE].[CASENOTE] cn2 ON
                a.CaseId = cn2.CaseId and (cn2.CreatedBy = 'Service: Return To Work Plan' and cn2.comment like 'RTWP%Employee%Sent' OR cn2.comment like 'RTWP%dispatched%employee%') and cn2.CreatedDate >= a.FinishDate and cn2.CreatedDate < coalesce(a.NextAssessFinishDate,getdate())
  left outer join [HWSInternal].[CASE].[CASENOTE] cn3 ON
                a.CaseId = cn3.CaseId and (cn3.CreatedBy = 'Service: Return To Work Plan' and cn3.comment like 'RTWP%Employer%Sent' OR cn3.comment like 'RTWP%dispatched%employer%') and cn3.CreatedDate >= a.FinishDate and cn3.CreatedDate < coalesce(a.NextAssessFinishDate,getdate())
  left outer join [HWSInternal].[CASE].[CASENOTE] cn4 ON
                a.CaseId = cn4.CaseId and (cn4.CreatedBy = 'Service: Return To Work Plan' and cn4.comment like 'RTWP%GP%Sent' OR cn4.comment like 'RTWP%dispatched%GP%') and cn4.CreatedDate >= a.FinishDate and cn4.CreatedDate < coalesce(a.NextAssessFinishDate,getdate())
  left outer join [HWSInternal].[CASE].[CASENOTE] cn5 ON
                a.CaseId = cn5.CaseId and cn5.CreatedBy = 'RTWP Service' and cn5.comment like 'Employee RTWP approval%' and cn5.CreatedDate >= a.FinishDate and cn5.CreatedDate < coalesce(a.NextAssessFinishDate,getdate())
   left outer join [HWSInternal].[CASE].[CASENOTE] cn6 ON
                a.CaseId = cn6.CaseId and cn6.comment like '%Referrer Contact Required%Initial Contact Required%' and cn6.CreatedDate <= a.FinishDate and cn6.CreatedDate < coalesce(a.NextAssessFinishDate,getdate())

) as p
where p.FirstPublishDate is not null
) as asseq
where asseq.FirstPublishDate is not null
