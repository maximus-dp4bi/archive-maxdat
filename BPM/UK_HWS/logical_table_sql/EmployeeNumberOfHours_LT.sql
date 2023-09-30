  select B.NumberOfHoursId,A.Value from  [HWSInternal].[Lookup].[LookupItem] A
  inner join [HWSInternal].[Referral].[Employee] B
  on A.Id = B.NumberOfHoursId
