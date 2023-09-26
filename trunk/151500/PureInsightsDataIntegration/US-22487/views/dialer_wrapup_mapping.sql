WITH
    wrap AS (SELECT  id AS wrapupCodeId, name AS wrapupCodeName FROM raw_configuration_objects  WHERE type = 'wrapupcode')
select 
       wrap.wrapupCodeName,
       mapping.wrapupCodeId,
       if(contactUncallable, 1, 0) as contactUncallable,
       if(numberUncallable, 1, 0) as numberUncallable,
       if(rightPartyContact, 1, 0) as rightPartyContact
FROM raw_wrapup_mapping mapping
     LEFT OUTER JOIN wrap ON   AND mapping.wrapupCodeId  = wrap.wrapupCodeId