CREATE OR REPLACE FORCE VIEW D_LETTER_DEFINITION_SV
AS
select f.*,
       case when subprogram_code = 'MED' and letter_type = 'MANDATORY' then 'IA'
            when subprogram_code = 'MED' and letter_type = 'VOLUNTARY' then 'VM'
            when subprogram_code = 'MED' and letter_type = 'CONFIRMATION' then 'CN'
            when subprogram_code = 'MED' and letter_type = 'AUTO' then 'DE'
            when subprogram_code = 'MED' and letter_type = 'VOL-CONFIRMATION' then  'VC'
            when subprogram_code = 'HMP' and letter_type = 'MANDATORY' then 'IAH'
            when subprogram_code = 'HMP' and letter_type = 'VOLUNTARY' then 'VMH'
            when subprogram_code = 'HMP' and letter_type = 'CONFIRMATION' then 'CNH'
            when subprogram_code = 'HMP' and letter_type = 'AUTO' then 'DEH'
        --    when subprogram_code = 'HMP' and letter_type = 'VOL-CONFIRMATION' then  'CNVH'
            when subprogram_code = 'CSHCS' and letter_type = 'MANDATORY' then 'IAC'
            when subprogram_code = 'CSHCS' and letter_type = 'VOLUNTARY' then 'VMC'
            when subprogram_code = 'CSHCS' and letter_type = 'CONFIRMATION' then 'CNC'
            when subprogram_code = 'CSHCS' and letter_type = 'AUTO' then 'DEC'
            when subprogram_code = 'CSHCS' and letter_type = 'VOL-CONFIRMATION' then  'VCC'
            when subprogram_code = 'DUAL' and letter_type = 'VOLUNTARY' then 'DEM/C'
            when subprogram_code = 'DUAL' and letter_type = 'CONFIRMATION' then 'CNV/C'
            when subprogram_code = 'DUAL' and letter_type = 'AUTO' then 'MDE/C'
            ELSE ''
            END letter_type_label                            
from (
SELECT NAME , description, driver_type, effective_from_date, effective_thru_date
  , case when name in ('IA','VM','CN','DE') THEN 'MED'
         WHEN NAME IN ('IAM','VMM','CNM','MCDE') then 'MED'  --MC is MED
       --  WHEN NAME IN ('IAH','VMH','CNH','CNVH', 'DEH') THEN 'HMP'
         WHEN NAME IN ('IAH','VMH','CNH', 'DEH') THEN 'HMP'
         WHEN NAME IN ('IAHC','DEHC','CNHC', 'VMHC') THEN 'CSHCS' --includes 'HMP CSHCS' letters
         WHEN NAME IN ('IAC', 'CNC','DEC', 'VMC' ) THEN 'CSHCS'
         WHEN NAME IN ('MDE','DEM','MDEC','DEMC','CNV','CNVC') THEN 'DUAL'
         WHEN NAME IN ('IACM','VMCM','CNCM','DECM') THEN 'CSHCS' -- includes 'MC CSHCS' letters
    else ''
    end SUBPROGRAM_CODE
  , CASE WHEN NAME IN ('IA','IAC', 'IACM','IAH','IAHC','IAM') then 'MANDATORY'
         WHEN NAME IN ('VM','VMCM','VMH','VMM','VMC','VMHC', 'DEM','DEMC') THEN 'VOLUNTARY'
      --   WHEN NAME IN ('CNVH') THEN 'VOL-CONFIRMATION'
         WHEN NAME IN ('CNCM','CN','CNH','CHC','CNHC','CNM','CNC','CNV','CNVC') THEN 'CONFIRMATION'
         WHEN NAME IN ('MDE','MDEC','DECM','DE','DEH','DEHC','DEC','MCDE') THEN 'AUTO'
           ELSE ''
     END LETTER_TYPE
    --D_PL_LETTER_STATUS_SV
  FROM letter_definition 
  ) f
  ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_LETTER_DEFINITION_SV TO MAXDAT_REPORTS ;


