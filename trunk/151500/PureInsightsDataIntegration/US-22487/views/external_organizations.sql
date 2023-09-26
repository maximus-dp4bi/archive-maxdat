SELECT 
       id,
       name,
       address1,
       address2,
       city,
       state,
       postalCode,
       countryCode,
       phoneNumber,
       modifyDate AS lastModifiedTime,
       createDate AS createdTime
FROM raw_external_organizations