CREATE OR REPLACE VIEW EMRS_D_CALL_TYPE_SV AS 
select 
  value CALL_TYPE_CD
  , description CALL_TYPE
  , report_label CALL_TYPE_LABEL
  from EB.ENUM_CALL_TYPE
union 
select 
  'WEBCHAT' CALL_TYPE_CD
  ,'Webchat' CALL_TYPE
  ,'Webchat' CALL_TYPE_LABEL
  from dual
;

GRANT SELECT ON maxdat_support.EMRS_D_CALL_TYPE_SV TO MAXDAT_REPORTS;