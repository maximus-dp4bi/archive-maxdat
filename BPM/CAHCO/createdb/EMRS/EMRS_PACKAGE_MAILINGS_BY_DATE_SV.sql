
CREATE OR REPLACE VIEW EMRS_PACKAGE_MAILINGS_BY_DATE_SV
AS
SELECT TRUNC(date_mailed) date_mailed
       ,packet_type||packet_subtype||CASE WHEN booklet_type1 IS NOT NULL OR booklet_type2 IS NOT NULL THEN '-'||booklet_type1||booklet_type2 ELSE NULL END packet_type_code
       ,COUNT(dim_packet_mailing_id) packet_count
FROM hco_d_packet_mailing
WHERE date_mailed IS NOT NULL
AND valid_flag = 'Y'
GROUP BY TRUNC(date_mailed)
       ,packet_type||packet_subtype||CASE WHEN booklet_type1 IS NOT NULL OR booklet_type2 IS NOT NULL THEN '-'||booklet_type1||booklet_type2 ELSE NULL END;
       
GRANT SELECT ON "EMRS_PACKAGE_MAILINGS_BY_DATE_SV" TO "MAXDAT_READ_ONLY"; 