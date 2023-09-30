  select B.EmployerTypeId,A.Value from  [HWSInternal].[Lookup].[LookupItem] A
  inner join [HWSInternal].[Referral].[Employer] B
  on A.Id = B.EmployerTypeId