select B.Id,B.AssessmentTypeId,A.Value from   [HWSInternal].[Assessment].[Assessment] B
  inner join [HWSInternal].[Lookup].[LookupItem] A
  on A.Id = B.AssessmentTypeId