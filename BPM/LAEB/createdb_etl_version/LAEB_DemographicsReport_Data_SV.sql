Create or replace view LAEB_DemographicsReportData_SV as (
select case_id,
SSN, --  Project needs only last 4 digits
First_Name, 
Last_Name,  
DOB,
Mailing_address1,
Mailing_address2, 
Mailing_CITY,
Mailing_STATE, 
Mailing_ZIP,
Residence_address1,
Residence_address2, 
Residence_CITY,
Residence_STATE, 
Residence_ZIP, 
Mobile_Contact,
Home_Contact,
Business_Contact,
creation_date 
from (
select
distinct c.case_id,
c.SSN as SSN, --  Project needs only last 4 digits
c.FIRST_NAME as First_Name,
c.LAST_NAME as Last_Name,
trunc(c.DOB) as DOB,
 a.ADDR_STREET_1 as Mailing_address1,
 a.ADDR_STREET_2 as Mailing_address2,
 a.ADDR_CITY as Mailing_CITY,
a.ADDR_STATE_CD as Mailing_STATE,
 a.ADDR_ZIP as Mailing_ZIP,
 a1.ADDR_STREET_1 as Residence_address1,
 a1.ADDR_STREET_2 as Residence_address2,
 a1.ADDR_CITY as Residence_CITY,
 a1.ADDR_STATE_CD as Residence_STATE,
 a1.ADDR_ZIP as Residence_ZIP,
 p.phon_area_code || p.phon_phone_number as Mobile_Contact,
 p1.phon_area_code || p1.phon_phone_number as Home_Contact,
 p2.phon_area_code || p2.phon_phone_number as Business_Contact,
 a.record_date as creation_date
from emrs_d_client_supplementary_info c
inner join emrs_d_address a on (c.case_id= a.case_ID  and a.ADDR_END_DATE is null and a.addr_type_cd in ('MM'))
left join emrs_d_address a1 on (a.case_id= a1.case_ID  and a1.ADDR_END_DATE is null and a1.addr_type_cd = 'MR')
left join emrs_d_phone p on (a.case_id = p.case_id  and p.PHON_END_DATE is null and p.phon_type_cd ='CM')
left join emrs_d_phone p1 on (a.case_id = p1.case_id  and p1.PHON_END_DATE is null and p1.phon_type_cd ='CH')
left join emrs_d_phone p2 on (a.case_id = p2.case_id  and p2.PHON_END_DATE is null and p2.phon_type_cd ='CB')
--where a.record_date >= '01-DEC-2019'
--and a.record_date <=sysdate
 union
  select
distinct c.case_id,
c.SSN as SSN, --  Project needs only last 4 digits
c.FIRST_NAME as First_Name,
c.LAST_NAME as Last_Name,
trunc(c.DOB) as DOB,
 a.ADDR_STREET_1 as Mailing_address1,
 a.ADDR_STREET_2 as Mailing_address2,
 a.ADDR_CITY as Mailing_CITY,
a.ADDR_STATE_CD as Mailing_STATE,
 a.ADDR_ZIP as Mailing_ZIP,
 a1.ADDR_STREET_1 as Residence_address1,
 a1.ADDR_STREET_2 as Residence_address2,
 a1.ADDR_CITY as Residence_CITY,
 a1.ADDR_STATE_CD as Residence_STATE,
 a1.ADDR_ZIP as Residence_ZIP,
 p.phon_area_code || p.phon_phone_number as Mobile_Contact,
 p1.phon_area_code || p1.phon_phone_number as Home_Contact,
 p2.phon_area_code || p2.phon_phone_number as Business_Contact,
 a1.record_date creation_date
from emrs_d_client_supplementary_info c
inner join emrs_d_address a1 on (c.case_id= a1.case_id  and a1.ADDR_END_DATE is null and a1.addr_type_cd in ('MR'))
left join emrs_d_address a on (a1.case_id= a.case_id  and a.ADDR_END_DATE is null and a.addr_type_cd = 'MM')
left join emrs_d_phone p on (a1.case_id = p.case_id  and p.PHON_END_DATE is null and p.phon_type_cd ='CM')
left join emrs_d_phone p1 on (a1.case_id = p1.case_id  and p1.PHON_END_DATE is null and p1.phon_type_cd ='CH')
left join emrs_d_phone p2 on (a1.case_id = p2.case_id  and p2.PHON_END_DATE is null and p2.phon_type_cd ='CB')
where a.case_id is null) 
 );
 
GRANT SELECT ON LAEB_DemographicsReportData_SV TO &role_name; 

