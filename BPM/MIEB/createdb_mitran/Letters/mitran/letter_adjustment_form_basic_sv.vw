CREATE OR REPLACE FORCE VIEW LETTER_ADJUSTMENT_FORM_BASIC_SV AS
SELECT 
  LETTER_ADJUSTMENT_FORM_ID   
,  LMDEF_ID    LETTER_DEFINITION_ID 
,  PROGRAM_CON_XWALK_CODE        
--,  LETTER_TYPE_NAME              
,  ADJUSTMENT_DATE               
,  LETTER_ADJUST_REASON_CODE     
,  ADJUSTMENT_COUNT              
,  COMMENTS                      
,  CREATED_BY                    
,  CREATION_DATE                 
,  UPDATED_BY                    
,  UPDATED_DATE
FROM LETTER_ADJUSTMENT_FORM
;
grant select on LETTER_ADJUSTMENT_FORM_BASIC_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select on LETTER_ADJUSTMENT_FORM_BASIC_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on LETTER_ADJUSTMENT_FORM_BASIC_SV to MAXDAT_MITRAN_READ_ONLY;

