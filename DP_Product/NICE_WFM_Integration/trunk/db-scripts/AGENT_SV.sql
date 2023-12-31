-- DecisionPoint - NICE WFM
-- Functional Requirement 12.01
-- Agent
-- All Agents

use nice_wfm_integration
go

create view AGENT_SV as
select 
   a.C_ID as AGENT_WFM_ID,
   case
     when right(a.C_EXTERNALID,5) = '-Lead' then substring(a.C_EXTERNALID,1,len(a.C_EXTERNALID) - 5)
	 when right(a.C_EXTERNALID,4) = '-Sup' then substring(a.C_EXTERNALID,1,len(a.C_EXTERNALID) - 4)
	 else a.C_EXTERNALID 
	 end as EMPLOYEE_ID,
   p.C_FNAME as FIRST_NAME,
   p.C_LNAME as LAST_NAME,
   case 
     when a.C_EXTERNALID = '999999991' then 'Y' 
	 when a.C_EXTERNALID = 'NICEWFMAGENT' then 'Y' 
	 when left(a.C_EXTERNALID,1) = 'A' then 'Y' 
     when left(a.C_EXTERNALID,1) = 'a' then 'Y' 
	 else 'N' 
     end as IS_TEST_AGENT_ID,
   cast(a.C_ACCRUALDATE as date) as ACCRUAL_DATE,
   cast(a.C_SENDATE as date) as SENIORITY_DATE,
   a.C_SENEXT as SENIORITY_EXTENSION,
   cast(a.C_ALTSENDATE as date) as ALTERNATE_SENIORITY_DATE,
   a.C_ALTSENEXT as ALTERNATE_SENIORITY_EXTENSION,
   cast(a.C_SDATE as date) as START_DATE,
   a.C_WORKDAYSPERWEEK as WORK_DAYS_PER_WEEK,
   cur_emp_status.C_ALPHAVAL as CURRENT_EMPLOYMENT_STATUS,
   cur_lang1.C_ALPHAVAL as CURRENT_LANGUAGE_1,
   cur_lang2.C_ALPHAVAL as CURRENT_LANGUAGE_2,
   cur_location.C_ALPHAVAL as CURRENT_LOCATION,
   cur_emu.C_NAME as CURRENT_MANAGEMENT_UNIT_NAME,
   cur_role.C_ALPHAVAL as CURRENT_ROLE,
   cur_site.C_ALPHAVAL as CURRENT_SITE,
   left(cur_team.C_DESCR,(len(cur_team.C_DESCR) - len(' Supervisor'))) as CURRENT_TEAM_SET_NAME,
   cur_team.C_ALPHAVAL as CURRENT_TEAM,
   cur_tenure_status.C_ALPHAVAL as CURRENT_TENURE_STATUS,
   cur_work_Status.C_ALPHAVAL as CURRENT_WORK_STATUS
from nice_wfm_customer1.dbo.R_AGT a
inner join nice_wfm_customer1.dbo.R_PERSON p on a.C_PERSON = p.C_OID and a.C_ACT = 'A'
left outer join
  (select 
     a.C_ID,
     adv.C_ALPHAVAL
   from nice_wfm_customer1.dbo.R_AGTDATADEF addef
   inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Employment Status' and addef.C_OID = adv.C_AGTDATADEF
   inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
   inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
   inner join
     (select 
        a.C_ID,
        max(ad.C_SDATE) cur_sdate
      from nice_wfm_customer1.dbo.R_AGTDATADEF addef
      inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Employment Status' and addef.C_OID = adv.C_AGTDATADEF
      inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
      inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
      group by a.C_ID) cur_emp_status_date
      on a.C_ID = cur_emp_status_date.C_ID and ad.C_SDATE = cur_emp_status_date.cur_sdate) cur_emp_status
  on a.C_ID = cur_emp_status.C_ID
left outer join
  (select 
     a.C_ID,
     adv.C_ALPHAVAL
   from nice_wfm_customer1.dbo.R_AGTDATADEF addef
   inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Language 1' and addef.C_OID = adv.C_AGTDATADEF
   inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
   inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
   inner join
     (select 
        a.C_ID,
        max(ad.C_SDATE) cur_sdate
      from nice_wfm_customer1.dbo.R_AGTDATADEF addef
      inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Language 1' and addef.C_OID = adv.C_AGTDATADEF
      inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
      inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
      group by a.C_ID) cur_lang1_date
      on a.C_ID = cur_lang1_date.C_ID and ad.C_SDATE = cur_lang1_date.cur_sdate) cur_lang1
  on a.C_ID = cur_lang1.C_ID
left outer join
  (select 
     a.C_ID,
     adv.C_ALPHAVAL
   from nice_wfm_customer1.dbo.R_AGTDATADEF addef
   inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Language 2' and addef.C_OID = adv.C_AGTDATADEF
   inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
   inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
   inner join
     (select 
        a.C_ID,
        max(ad.C_SDATE) cur_sdate
      from nice_wfm_customer1.dbo.R_AGTDATADEF addef
      inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Language 2' and addef.C_OID = adv.C_AGTDATADEF
      inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
      inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
      group by a.C_ID) cur_lang2_date
      on a.C_ID = cur_lang2_date.C_ID and ad.C_SDATE = cur_lang2_date.cur_sdate) cur_lang2
  on a.C_ID = cur_lang2.C_ID
left outer join
  (select 
     a.C_ID,
     adv.C_ALPHAVAL
   from nice_wfm_customer1.dbo.R_AGTDATADEF addef
   inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Location' and addef.C_OID = adv.C_AGTDATADEF
   inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
   inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
   inner join
     (select 
        a.C_ID,
        max(ad.C_SDATE) cur_sdate
      from nice_wfm_customer1.dbo.R_AGTDATADEF addef
      inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Location' and addef.C_OID = adv.C_AGTDATADEF
      inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
      inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
      group by a.C_ID) cur_location_date
      on a.C_ID = cur_location_date.C_ID and ad.C_SDATE = cur_location_date.cur_sdate) cur_location
  on a.C_ID = cur_location.C_ID
left outer join
  (select 
     a.C_ID,
     emu.C_NAME
   from nice_wfm_customer1.dbo.R_AGT a
   inner join nice_wfm_customer1.dbo.R_MUROSTER mr on a.C_OID = mr.C_AGT and a.C_ACT = 'A' and mr.C_ACT = 'A'
   inner join nice_wfm_customer1.dbo.R_MU mu on mr.C_MU = mu.C_OID
   inner join nice_wfm_customer1.dbo.R_ENTITY emu on mu.C_OID = emu.C_oID and emu.C_TYPE = 'M' and emu.C_ACT = 'A'
   inner join
     (select 
        a.C_ID,
        max(mr.C_SDATE) cur_sdate
	  from nice_wfm_customer1.dbo.R_AGT a
	  inner join nice_wfm_customer1.dbo.R_MUROSTER mr on a.C_OID = mr.C_AGT and a.C_ACT = 'A' and mr.C_ACT = 'A'
	  inner join nice_wfm_customer1.dbo.R_MU mu on mr.C_MU = mu.C_OID
	  inner join nice_wfm_customer1.dbo.R_ENTITY emu on mu.C_OID = emu.C_oID and emu.C_TYPE = 'M' and emu.C_ACT = 'A'
	  group by a.C_ID) cur_emu_date
      on a.C_ID = cur_emu_date.C_ID and mr.C_SDATE = cur_emu_date.cur_sdate) cur_emu
  on a.C_ID = cur_emu.C_ID
left outer join
  (select 
     a.C_ID,
     adv.C_ALPHAVAL
   from nice_wfm_customer1.dbo.R_AGTDATADEF addef
   inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Role' and addef.C_OID = adv.C_AGTDATADEF
   inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
   inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
   inner join
     (select 
        a.C_ID,
        max(ad.C_SDATE) cur_sdate
      from nice_wfm_customer1.dbo.R_AGTDATADEF addef
      inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Role' and addef.C_OID = adv.C_AGTDATADEF
      inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
      inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
      group by a.C_ID) cur_role_date
      on a.C_ID = cur_role_date.C_ID and ad.C_SDATE = cur_role_date.cur_sdate) cur_role
  on a.C_ID = cur_role.C_ID
left outer join
  (select 
     a.C_ID,
     adv.C_ALPHAVAL
   from nice_wfm_customer1.dbo.R_AGTDATADEF addef
   inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Site' and addef.C_OID = adv.C_AGTDATADEF
   inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
   inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
   inner join
     (select 
        a.C_ID,
        max(ad.C_SDATE) cur_sdate
      from nice_wfm_customer1.dbo.R_AGTDATADEF addef
      inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Site' and addef.C_OID = adv.C_AGTDATADEF
      inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
      inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
      group by a.C_ID) cur_site_date
      on a.C_ID = cur_site_date.C_ID and ad.C_SDATE = cur_site_date.cur_sdate) cur_site
  on a.C_ID = cur_site.C_ID
left outer join
  (select
     a.C_ID,
	 addef.C_DESCR,
     adv.C_ALPHAVAL
   from nice_wfm_customer1.dbo.R_AGTDATADEF addef
   inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR like '%Supervisor' and addef.C_OID = adv.C_AGTDATADEF
   inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
   inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
   inner join
     (select
         a.C_ID,
         max(ad.C_SDATE) cur_sdate
	  from nice_wfm_customer1.dbo.R_AGTDATADEF addef
      inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR like '%Supervisor' and addef.C_OID = adv.C_AGTDATADEF
      inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
      inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
      group by a.C_ID) cur_team_date
      on a.C_ID = cur_team_date.C_ID and ad.C_SDATE = cur_team_date.cur_sdate) cur_team
  on a.C_ID = cur_team.C_ID
left outer join
  (select 
     a.C_ID,
     adv.C_ALPHAVAL
   from nice_wfm_customer1.dbo.R_AGTDATADEF addef
   inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Tenure Status' and addef.C_OID = adv.C_AGTDATADEF
   inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
   inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
   inner join
     (select 
        a.C_ID,
        max(ad.C_SDATE) cur_sdate
      from nice_wfm_customer1.dbo.R_AGTDATADEF addef
      inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Tenure Status' and addef.C_OID = adv.C_AGTDATADEF
      inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
      inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
      group by a.C_ID) cur_tenure_status_date
      on a.C_ID = cur_tenure_status_date.C_ID and ad.C_SDATE = cur_tenure_status_date.cur_sdate) cur_tenure_status
  on a.C_ID = cur_tenure_status.C_ID
left outer join
  (select 
     a.C_ID,
     adv.C_ALPHAVAL
   from nice_wfm_customer1.dbo.R_AGTDATADEF addef
   inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Work Status' and addef.C_OID = adv.C_AGTDATADEF
   inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
   inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
   inner join
     (select 
        a.C_ID,
        max(ad.C_SDATE) cur_sdate
      from nice_wfm_customer1.dbo.R_AGTDATADEF addef
      inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Work Status' and addef.C_OID = adv.C_AGTDATADEF
      inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
      inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A'
      group by a.C_ID) cur_work_status_date
      on a.C_ID = cur_work_status_date.C_ID and ad.C_SDATE = cur_work_status_date.cur_sdate) cur_work_status
  on a.C_ID = cur_work_status.C_ID;