CREATE OR REPLACE FORCE EDITIONABLE VIEW MAXDAT_MITRAN.F_TRANSMITTAL_INVOICE_DETAIL_SV
AS
with trc as (
select h.tran_header_id
, d.tran_detail_id
, h.tran_date
, elc.*
, lmdef.lmdef_id
, d.eyr_mailed_qty
, d.invoiced
, d.invoiced_date
, d.invoiced_user
, ROW_NUMBER() OVER (PARTITION BY h.tran_header_id, elc.group_name  ORDER BY elc.eff_start_date desc) as ROWN
FROM D_TRAN_HEADER H
JOIN D_TRAN_dETAIL D ON H.TRAN_HEADER_ID = D.TRAN_HEADER_ID
JOIN D_LETTER_DEFINITION LMDEF ON LMDEF.LMDEF_ID = D.LMDEF_ID
JOIN D_EYR_LETTERS_COST ELC on LMDEF.GROUP_NAME = ELC.GROUP_NAME
     and h.tran_date >= elc.eff_start_date and (h.tran_date <=eff_end_date or eff_end_Date is null)
WHERE D.EYR_MAILED_DATE IS NOT NULL
)
, grc as (
select * from trc where rown = 1
)
select
TRAN_HEADER_ID
, tran_detail_id
, group_name AS GROUP_NAME
, production_cost GROUP_PRODUCTION_COST
, POSTAGE_COST AS GROUP_POSTAGE_COST
, eyr_mailed_qty
, round(nvl(eyr_mailed_Qty,0) * production_cost,2) letter_production_cost
, round(nvl(eyr_mailed_qty,0) * postage_Cost,2) letter_postage_cost
, round(nvl(eyr_mailed_Qty,0) * production_cost,2) + round(nvl(eyr_mailed_qty,0) * postage_Cost,2) letter_cost
, lmdef_id
, INVOICED_DATE AS INVOICED_DATE
, INVOICED AS INVOICED
,invoiced_user AS INVOICED_USER
FROM grc;

GRANT SELECT ON "MAXDAT_MITRAN"."F_TRANSMITTAL_INVOICE_DETAIL_SV" TO "MAXDAT_MITRAN_READ_ONLY";
GRANT SELECT ON "MAXDAT_MITRAN"."F_TRANSMITTAL_INVOICE_DETAIL_SV" TO "MAXDAT_MITRAN_OLTP_SIU";
GRANT SELECT ON "MAXDAT_MITRAN"."F_TRANSMITTAL_INVOICE_DETAIL_SV" TO "MAXDAT_MITRAN_OLTP_SIUD";
GRANT SELECT ON "MAXDAT_MITRAN"."F_TRANSMITTAL_INVOICE_DETAIL_SV" TO "MAXDAT_REPORTS";


commit;