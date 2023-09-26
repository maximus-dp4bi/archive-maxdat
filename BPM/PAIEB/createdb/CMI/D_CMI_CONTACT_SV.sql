CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_CMI_CONTACT_SV
AS
SELECT c.CONTACTID,
  d.CASENO,
  c.FIRSTNAME,
  c.LASTNAME,
  c.MIDDLENAME,
  c.ALIAS,
  c.DOB,
  c.SSN,
  c.PHONE,
  c.RESIDENCETYPE,
  c.GENDER,
  c.RACE,
  c.PLANGUAGE,
  c.SLANGUAGE,
  c.CURMARSTATUS,
  c.ETHNICITYLOOKUP,
  d.SECID,
  d.REFERRALSOURCE,
  ca.Street,
  ca.Street2,
  ca.City,
  ca.ZipCode,
  ca.State,
  c.RESCOUNTY  
FROM HARMONY_CONV.CONTACT c
join harmony_conv.demographics d on (c.contactid = d.contactid)
join harmony_conv.contactaddress ca on (d.CONTACTID = ca.CONTACTID and ca.primary = 1) ;
    
GRANT SELECT ON MAXDAT_SUPPORT.D_CMI_CONTACT_SV TO MAXDAT_REPORTS;  