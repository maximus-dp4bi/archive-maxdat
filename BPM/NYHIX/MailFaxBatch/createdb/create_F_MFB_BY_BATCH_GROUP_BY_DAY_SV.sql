CREATE OR REPLACE VIEW MAXDAT.F_MFB_BY_BATCH_GROUP_BY_DAY_SV
as

SELECT
bdd.D_DATE,
bdd.WEEKEND_FLAG,
case 
    when d.batch_class   =  'NYSOH_NoPrep_FAX'                                   then 'Expedited Appeals'
    when d.batch_class   =  'NYSOH_FAX_NavCAC'                                   then 'Nav/CAC Faxes'
    when d.batch_class   =  'NYSOH_RETURNED_MAIL'                                then 'Returned Mail'
    when d.batch_class   =  'NYSOH_FAX_Channel'                                  then 'Fax Batches' --for DEV   
    when d.batch_class like '%FAX_NavCAC'                                        then 'Nav/CAC Faxes' --for UAT
    when d.batch_class like '%FAX'                                               then 'Fax Batches'
    when d.batch_class like '%MAIL'                                              then 'Mail Batches'  else 'NA' end as Batch_Group,
d.FAX_BATCH_SOURCE,
d.BATCH_CLASS,
CASE WHEN d.BATCH_CLASS LIKE 'NYHO%' THEN 'NYEC' ELSE 'NYHIX' END AS BATCH_PROGRAM,
sum(CASE WHEN bdd.D_DATE = TRUNC(d.CREATE_DT) THEN 1 else 0 END) AS CREATION_COUNT,
sum(CASE WHEN bdd.D_DATE = TRUNC(d.BATCH_COMPLETE_DT) THEN 1 else 0 END) AS COMPLETION_COUNT,
sum(CASE WHEN bdd.D_DATE = TRUNC(d.CANCEL_DT) THEN 1 else 0 END) AS CANCEL_COUNT,
sum(CASE WHEN bdd.D_DATE = TRUNC(d.CANCEL_DT) and d.REPROCESSED_FLAG = 'Y' THEN 1 else 0 END) AS REPROCESSED_COUNT
FROM maxdat.D_DATES bdd 
JOIN maxdat.D_MFB_CURRENT_SV d on (bdd.D_DATE = TRUNC(D.CREATE_DT) OR bdd.D_DATE = COALESCE(TRUNC(D.COMPLETE_DT),TRUNC(d.CANCEL_DT),TRUNC(sysdate))) 
GROUP BY 
bdd.D_DATE,
bdd.WEEKEND_FLAG,
case 
    when d.batch_class   =  'NYSOH_NoPrep_FAX'                                   then 'Expedited Appeals'
    when d.batch_class   =  'NYSOH_FAX_NavCAC'                                   then 'Nav/CAC Faxes'
    when d.batch_class   =  'NYSOH_RETURNED_MAIL'                                then 'Returned Mail'
    when d.batch_class   =  'NYSOH_FAX_Channel'                                  then 'Fax Batches' --for DEV   
    when d.batch_class like '%FAX_NavCAC'                                        then 'Nav/CAC Faxes' --for UAT
    when d.batch_class like '%FAX'                                               then 'Fax Batches'
    when d.batch_class like '%MAIL'                                              then 'Mail Batches'  else 'NA' end ,
d.FAX_BATCH_SOURCE,
d.BATCH_CLASS,
CASE WHEN d.BATCH_CLASS LIKE 'NYHO%' THEN 'NYEC' ELSE 'NYHIX' END
;

grant select on F_MFB_BY_BATCH_GROUP_BY_DAY_SV to MAXDAT_READ_ONLY;