
-- Latest modified on 9/7/2017 GDT to create insert statements 
-- Copy the output of the script and run to do the inserts
-- Truncate the CC_HCO_IVR_RESPONSE table before running inserts

Select 'INSERT INTO MAXDAT.CC_HCO_IVR_RESPONSE (IVR_RESPONSE_ID, IVR_REQUEST_DATE, FAX_REQUEST_COUNT, FAX_RESPONSE_COUNT, MAIL_REQUEST_COUNT, MAIL_RESPONSE_COUNT, TOTAL_FAX_RESPONSE_TIME) VALUES (' +
          cast(row_number() over (order by (select 1)) as varchar) + ', to_date(''' + 
          cast(IVRRequestDate as varchar) + ''', ''yyyy-mm-dd''), ' +
          cast(Sum(FaxRequested) as varchar) + ', ' +
		  cast(Sum(FaxSent) as varchar) + ', ' +
          cast(Sum(MailRequested) as varchar) + ', ' +
          cast(Sum(MailSent) as varchar) + ', ' +
		  coalesce(cast((case when Sum(TimeinMins) < 0 then 0 else cast(round(Sum(TimeinMins),2) as decimal(10,2))  end) as varchar),'Null')  + ');'
--Select * 
From 
(
Select a.* 
          , Case when FaxSentdate is not null then 
                              cast(datediff(ss, Faxrequestdate, FaxSentdate) as numeric) / 60   
                       Else null End TimeInMins
From (
Select Beneficiaryid,
          Convert(date, RequestDate, 101) IVRRequestDate,
          Case when FaxRequestDate is not null Then 1 Else 0 End FaxRequested,
          Case when FaxMailId is not null and FaxMailId != '' then 1 Else 0 End FaxSent,
          Case when PacketRequestDate is not null Then 1 Else 0 End MailRequested,
          Case when PacketMailId is not NULL OR MailTab.MailID IS NOT NULL then 1 Else 0 End MailSent,
          FaxRequestDate, 
          --FaxResponseDate,
          Case When Convert(date,FaxRequestDate, 101) != Convert(date,v.CreatedOn, 101)  
                     Then FaxResponseDate
                     When FaxRequestDate is not null and MS.MailStatusDescription != 'DONE' 
                     Then FaxResponseDate
                     When FaxRequestDate is not null and MS.MailStatusDescription = 'DONE' 
                     Then v.CreatedOn
                     Else null End FaxSentDate
from dbo.IVRTransaction I with (nolock)
OUTER APPLY 
(
       SELECT m.MailID, ms.MailStatusID
       FROM Mail M WITH (NOLOCK)
             INNER JOIN MailBene MB WITH (NOLOCK) ON MB.MailID = M.MailID
             INNER JOIN VWMailStatus MS with (nolock) on MS.MAILID = M.MailID
       WHERE M.MailTypeID IN (2,3,14)
             AND M.ChannelID = 11
             AND MB.CIN = I.CIN
             AND M.CreatedOn >= I.PacketRequestDate
             AND M.CreatedOn <= DATEADD(HOUR,1,I.PacketRequestDate)
) AS MailTab
LEFT outer join dbo.VWMailStatus v with (nolock) on v.MailID = I.FaxMailId OR (I.FaxMailId IS NULL AND V.MailID = MailTab.MailID)
LEFT outer join dbo.MailStatus MS with (nolock) on MS.MailStatusID = V.MailStatusID
where ResponseStatus = 'SUCCESS'
and ( FaxRequestDate is not null OR PacketRequestDate is not null )
--and RequestDate > '1/1/2017'
) as a
) as b
where 1=1
Group by IVRRequestDate
order by IVRRequestDate