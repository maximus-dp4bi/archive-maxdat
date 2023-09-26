-- Query to Check for posting errors for Avaya and Cisco Historical data

select 
 convert(varchar(16),f.C_MOD,120) LogTimeUTC,
  acd.C_NAME AcdName,
  substring(f.C_FILENAME,1,10) + ' ' + 
  substring(f.C_FILENAME,12,5) + ' - ' + 
  substring(f.C_FILENAME,26,10) + ' ' + 
  substring(f.C_FILENAME,37,5) LastMissingIntervalUTC
from nice_wfm_customer1.dbo.R_FILESRCVD f
inner join nice_wfm_customer1.dbo.R_ACD acd on f.C_ACD = acd.C_OID
where f.C_STATUS = 'FAIL'
order by f.C_MOD desc;
