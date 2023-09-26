select B.ReferralSourceId,A.Value from  [HWSInternal].[Lookup].[LookupItem] A
  inner join [HWSInternal].[Referral].[Referral] B
  on A.Id = B.ReferralSourceId