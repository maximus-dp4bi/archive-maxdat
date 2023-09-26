--Reg_Provider
UPDATE OHPNM_DP4BI_DEV.REG_PROVIDER rp
SET rp.last_name = CONCAT('LAST',reg_id), rp.first_name = 'PROVIDER'
WHERE rp.last_name IS NOT NULL;    

UPDATE OHPNM_DP4BI_DEV.REG_PROVIDER
SET name = CONCAT('PROVIDER',TO_CHAR(reg_id))
WHERE name IS NOT NULL;

UPDATE OHPNM_DP4BI_DEV.REG_PROVIDER
SET dba = CONCAT('PROVIDER',TO_CHAR(reg_id))
WHERE dba IS NOT NULL;

UPDATE OHPNM_DP4BI_DEV.REG_PROVIDER
SET npi = ROUND(LEFT(npi* uniform(2,10,random()),10))
WHERE npi IS NOT NULL;

UPDATE OHPNM_DP4BI_DEV.REG_PROVIDER
SET tax_id = LEFT(ROUND(regexp_replace(tax_id,'[^0-9 ]','')* uniform(2,10,random())),9)
WHERE tax_id IS NOT NULL;

UPDATE OHPNM_DP4BI_DEV.REG_PROVIDER
SET birth_date = DATEADD(DAY,-(uniform(1,60,random()) ),birth_date)
WHERE birth_date IS NOT NULL;

--Reg_Owner
UPDATE OHPNM_DP4BI_DEV.REG_OWNER
SET name = CONCAT('PROVIDER',TO_CHAR(reg_id))
WHERE name IS NOT NULL;

UPDATE OHPNM_DP4BI_DEV.REG_OWNER
SET dob = DATEADD(DAY,-(uniform(1,60,random()) ),dob)
WHERE dob IS NOT NULL;

UPDATE OHPNM_DP4BI_DEV.REG_OWNER
SET tax_id = LEFT(ROUND(regexp_replace(tax_id,'[^0-9 ]','')* uniform(1,10,random())),9)
WHERE tax_id IS NOT NULL;

UPDATE OHPNM_DP4BI_DEV.REG_OWNER rp
SET rp.last_name = CONCAT('LAST',TO_CHAR(reg_id)), rp.first_name = 'PROVIDER'
WHERE rp.last_name IS NOT NULL;    

--Reg_Address
UPDATE OHPNM_DP4BI_DEV.REG_ADDRESS
SET address1 = CONCAT(TO_CHAR(reg_id),'TEST DR')
WHERE address1 IS NOT NULL;    

UPDATE OHPNM_DP4BI_DEV.REG_ADDRESS
SET phone1 = LEFT(ROUND(regexp_replace(phone1,'[^0-9 ]','')* uniform(2,10,random())),10)
WHERE phone1 IS NOT NULL
AND length(regexp_replace(phone1,'[^0-9 ]','')) >= 10;  

UPDATE OHPNM_DP4BI_DEV.REG_ADDRESS
SET phone2 = LEFT(ROUND(regexp_replace(phone2,'[^0-9 ]','')* uniform(2,10,random())),10)
WHERE phone2 IS NOT NULL 
AND length(regexp_replace(phone2,'[^0-9 ]','')) >= 10;   


UPDATE OHPNM_DP4BI_DEV.REG_ADDRESS
SET fax1 = LEFT(ROUND(regexp_replace(fax1,'[^0-9]','')* uniform(2,10,random())),10)
WHERE fax1 IS NOT NULL; 

UPDATE OHPNM_DP4BI_DEV.REG_ADDRESS
SET fax2 = LEFT(ROUND(regexp_replace(fax2,'[^0-9]','')* uniform(2,10,random())),10)
WHERE fax2 IS NOT NULL; 

UPDATE OHPNM_DP4BI_DEV.REG_ADDRESS
SET email1 = null
WHERE email1 IS NOT NULL;

UPDATE OHPNM_DP4BI_DEV.REG_ADDRESS
SET email2 = null
WHERE email2 IS NOT NULL;

UPDATE OHPNM_DP4BI_DEV.REG_ADDRESS
SET practice_name = CONCAT('PROVIDER',TO_CHAR(reg_id))
WHERE practice_name IS NOT NULL;

UPDATE OHPNM_DP4BI_DEV.REG_ADDRESS rp
SET rp.last_name = CONCAT('LAST',TO_CHAR(reg_id)), rp.first_name = 'PROVIDER'
WHERE rp.last_name IS NOT NULL;  

--Reg_Medicaid
UPDATE OHPNM_DP4BI_DEV.REG_MEDICAID
SET medicaid_id = LEFT(ROUND(medicaid_id* uniform(2,10,random())),10)
WHERE medicaid_id IS NOT NULL;  

--Reg_Medicare
UPDATE OHPNM_DP4BI_DEV.REG_MEDICARE
SET medicare_number = CASE WHEN REGEXP_INSTR(medicare_number, '[^[:digit:]]') = 0 THEN TO_CHAR(LEFT(ROUND(TO_NUMBER(LEFT(medicare_number,10)) * uniform(2,10,random())),10)) ELSE CONCAT(UPPER(randstr(5, random())),TO_CHAR(reg_id)) END
WHERE medicare_number IS NOT NULL;  

--Reg_Email
UPDATE OHPNM_DP4BI_DEV.EMAIL
SET key_value_pair = null
WHERE key_value_pair IS NOT NULL;

--Reg_Mail
UPDATE OHPNM_DP4BI_DEV.MAIL
SET key_value_pair = null
WHERE key_value_pair IS NOT NULL;

--User_Account_Information
UPDATE OHPNM_DP4BI_DEV.USER_ACCOUNT_INFORMATION uai
SET uai.contact_name = ai.nw_contact_name
FROM (SELECT userid,CONCAT('USER',TO_CHAR(RANK() OVER(ORDER BY last_modified_date_time,userid ))) nw_contact_name
      FROM OHPNM_DP4BI_DEV.USER_ACCOUNT_INFORMATION
      WHERE contact_name is not null
     ) ai WHERE uai.userid = ai.userid;
     
UPDATE OHPNM_DP4BI_DEV.USER_ACCOUNT_INFORMATION
SET tax_id = LEFT(ROUND(tax_id* uniform(2,10,random())),9)
WHERE tax_id IS NOT NULL;

UPDATE OHPNM_DP4BI_DEV.USER_ACCOUNT_INFORMATION
SET medicaid_id = LEFT(ROUND(medicaid_id* uniform(2,10,random())),10)
WHERE medicaid_id IS NOT NULL;  

UPDATE OHPNM_DP4BI_DEV.USER_ACCOUNT_INFORMATION
SET npi = LEFT(ROUND(npi* uniform(2,10,random())),10)
WHERE npi IS NOT NULL;

UPDATE OHPNM_DP4BI_DEV.USER_ACCOUNT_INFORMATION
SET contact_phone = LEFT(ROUND(contact_phone* uniform(2,10,random())),10)
WHERE contact_phone IS NOT NULL;  