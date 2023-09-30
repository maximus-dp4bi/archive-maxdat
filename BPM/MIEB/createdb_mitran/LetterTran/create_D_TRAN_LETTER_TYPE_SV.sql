CREATE OR REPLACE VIEW D_TRAN_LETTER_TYPE_SV AS
SELECT LS.LETTER_INVOICE_GROUP_CODE
, LD.lmdef_id LETTER_DEFINITION_ID
, LX.PROGRAM_CON_XWALK_CODE
,(
  (CASE WHEN LS.LETTER_INVOICE_GROUP_NAME = LD.NAME THEN LS.LETTER_INVOICE_GROUP_NAME ELSE LS.LETTER_INVOICE_GROUP_NAME || ' - ' || LD.NAME END)
  ||
  case when LX.PROGRAM_CON_XWALK_CODE is not null then ' - ' || LX.PROGRAM_CON_XWALK_CODE else '' end
    )
   LETTER_TYPE_NAME
,(
   CASE WHEN LS.LETTER_INVOICE_GROUP_NAME = LD.NAME THEN LS.DESCRIPTION ELSE LS.DESCRIPTION || ' - ' || LD.DESCRIPTION END
     ||
     case when LX.PROGRAM_CON_XWALK_CODE is not null then ' - ' || LX.DESCRIPTION else '' end
 ) DESCRIPTION
,(
  CASE WHEN LS.REPORT_LABEL = LD.REPORT_LABEL  THEN LS.REPORT_LABEL ELSE LS.REPORT_LABEL|| ' - ' || LD.REPORT_LABEL END
     ||
     case when LX.PROGRAM_CON_XWALK_CODE is not null then ' - ' || LX.REPORT_LABEL else '' end
       ) REPORT_LABEL
,GREATEST(LS.EFFECTIVE_FROM_DATE, LD.EFFECTIVE_FROM_DATE, EFFECTIVE_DATE) EFFECTIVE_FROM_DATE
,nvl(LEAST(LS.EFFECTIVE_THRU_DATE, LD.EFFECTIVE_THRU_DATE, END_DATE),to_date('7/7/7777','mm/dd/yyyy')) EFFECTIVE_THRU_DATE
FROM D_LETTER_INVOICE_GROUP LS
JOIN D_LETTER_DEFINITION LD ON LD.LETTER_INVOICE_GROUP_CODE = LS.LETTER_INVOICE_GROUP_CODE
LEFT JOIN D_SUBPROGRAM_CON_XWALK LX ON LX.LMDEF_ID = LD.LMDEF_ID
WHERE NVL(LS.EFFECTIVE_THRU_DATE,SYSDATE+10) > SYSDATE
AND NVL(LD.EFFECTIVE_THRU_DATE, SYSDATE +10) > SYSDATE
and ld.LETTER_INVOICE_GROUP_CODE not in ('AP','HC', 'ADHOC');

grant select on D_TRAN_LETTER_TYPE_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select on D_TRAN_LETTER_TYPE_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_TRAN_LETTER_TYPE_SV to MAXDAT_MITRAN_READ_ONLY;
