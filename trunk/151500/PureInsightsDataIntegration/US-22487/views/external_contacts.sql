select
    
    c.id,
    c.firstName,
    c.lastName,
    c.title,
    raw_external_organizations.name as externalOrganizationName,
    c.external
    c.TYPE AS contactType,
    c.workPhone,
    c.workPhoneExtension,
    c.cellPhone,
    c.homePhone,
    c.workEmail,
    c.personalEmail,
    c.modifyDate AS lastModifiedTime,
    c.createDate AS createdTime
from raw_external_contacts c
         LEFT JOIN raw_external_organizations on c.external raw_external_organizations.id