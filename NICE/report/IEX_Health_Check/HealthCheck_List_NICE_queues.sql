/* Get lists of queues from the NICE db. */
/* NICE PRD DB: 10.150.140.20 */


-- Check for posting errors.
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

-- Get listing of new queues added in the last few days.
select 
  q.C_ACD,
  q.C_QTAG, 
  e.C_NAME,
  e.C_MOD
from nice_wfm_customer1.dbo.R_QUEUE q
inner join nice_wfm_customer1.dbo.R_ENTITY e on q.C_OID = e.C_OID and e.C_TYPE = 'Q'
where 
  e.C_DTIME is null
  and switchoffset(e.C_SDATE, '-08:00') >= getdate() - 4
order by 4 desc,1 asc,2 asc;


