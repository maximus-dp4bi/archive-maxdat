
CREATE OR REPLACE VIEW hco_f_material_requests_sv
AS
SELECT tmp.*
      ,lt.spd_flag
      ,lt.mandatory_voluntary mvx_status
      ,lt.material_type
      ,CASE WHEN letter_type_code_v2 IS NULL OR letter_type_code_v2 = '' THEN 'Manual Scan - No Type Information' ELSE letter_type_code END mail_type
      ,CASE WHEN letter_type_code_v2 IS NULL OR letter_type_code_v2 = '' THEN 'MS' ELSE letter_type_code END mail_type_code      
      ,ct.mvx_status county_mvx_status
FROM(
  SELECT 
    vendor_received_date,
    county_code,
    custom_mailing_indicator,
    letter_type_id,
    CASE WHEN custom_mailing_indicator = 'AnnualBDE' THEN 'BD'
         WHEN custom_mailing_indicator = '90DayBDE' THEN 'BD90'
      ELSE TRIM(letter_type_code||COALESCE(sub_type,'')) END letter_type_code,    
    CASE WHEN custom_mailing_indicator = 'AnnualBDE' THEN 'BD'
         WHEN custom_mailing_indicator = '90DayBDE' THEN 'BD90'
      ELSE letter_type_code END letter_type_code_v2,       
    TRIM(letter_type_code||COALESCE(sub_type,'')) letter_type_code_st,  
    job_id,
    lm.dcin,
    date_requested,
    date_mailed,
    null ship_date,
    null material_name,    
    ml.language material_language,
    GREATEST(record_date,modified_date) record_date,
    null packet_type,
    null packet_subtype,
    null booklet_type1,
    null booklet_type2,
    null ppd,
    null pdd2,
    0 packets_requested,
    0 packets_sent,
    'N' alternative_format_type,
    'N' bulk_request_flag,
    null alternative_format_flag,
    mail_status order_status_id,
    null order_status,
    valid_flag,
    case_id,
    null client_number,
    bad_address_flag,
    bad_address_record_date,
    bad_address_transaction_type,
    --dtl.spd_status spd_status,
    --dtl.maximus_status maximus_status,    
    null spd_status,
    null maximus_status,    
    null packet_type_derived,
    null material_code,
    null material_id ,
    null packet_type_ia,    
    null bulk_order_id
    FROM hco_d_letter_mailing lm
     -- LEFT JOIN (SELECT DISTINCT dcin,spd_status,maximus_status                           
       --           FROM  hco_d_letter_detail l ) dtl ON lm.dcin = dtl.dcin
      LEFT JOIN emrs_d_language ml ON lm.language_id = ml.language_code ) tmp
  LEFT JOIN hco_d_letter_mail_type lt ON tmp.letter_type_code = lt.type_code AND material_type = 'L'
  LEFT JOIN emrs_d_county ct ON tmp.county_code = ct.county_code
UNION ALL
SELECT tmp.*
      ,lt.spd_flag
      ,lt.mandatory_voluntary mvx_status
      ,lt.material_type
      ,packet_type mail_type
      ,CASE WHEN packet_type_derived IS NULL OR packet_type_derived = '' THEN 'MS' ELSE packet_type_derived END mail_type_code   
      ,ct.mvx_status county_mvx_status
FROM(
  SELECT 
    vendor_received_date,
    county_code,
    custom_mailing_indicator,
    null letter_type_id,
    null letter_type_code,
    null letter_type_code_v2,       
    null letter_type_code_st,
    job_id,
    lm.dcin,
    date_requested,
    date_mailed,
    ship_by_date ship_date,
    null material_name,    
    ml.language material_language,
    GREATEST(record_date,modified_date) record_date,
    packet_type,
    packet_subtype,
    booklet_type1,
    booklet_type2,
    ppd,
    CASE WHEN ppd = 'F' AND packet_type != 'PV' THEN 'C'
        WHEN ppd = 'S' THEN 'C'
        WHEN ppd = 'F' AND packet_type = 'PV' THEN 'PV2'
      ELSE ppd END ppd2,
    packets_requested,
    0 packets_sent,
    null alternative_format_type,
    'Y' bulk_request_flag,
    'N' alternative_format_flag,
    mail_status order_status_id,
    null order_status,
    valid_flag,
    case_id,
    null client_number,
    bad_address_flag,
    bad_address_record_date,
    bad_address_transaction_type,
    --dtl.spd_status spd_status,
    --dtl.maximus_status maximus_status,
    null spd_status,
    null maximus_status,
    packet_type||
       CASE WHEN packet_subtype IS NULL THEN '' ELSE packet_subtype END ||'-'||
       CASE WHEN booklet_type1 IS NULL THEN '' ELSE booklet_type1 END ||
       CASE WHEN booklet_type2 IS NULL THEN '' ELSE booklet_type2 END packet_type_derived,
    null material_code,
    null material_id,
    CASE WHEN packet_type IN ('IA') THEN
        packet_type||'-'||CASE WHEN booklet_type1 IS NULL THEN '' ELSE booklet_type1 END ||
                        CASE WHEN booklet_type2 IS NULL THEN '' ELSE booklet_type2 END 
      WHEN packet_type = 'IM' AND packet_subtype = '9' AND booklet_type1 = 'M' THEN 'IM-L'
      ELSE packet_type||
          CASE WHEN packet_subtype IS NULL THEN '' ELSE packet_subtype END ||'-'||
          CASE WHEN booklet_type1 IS NULL THEN '' ELSE booklet_type1 END ||
          CASE WHEN booklet_type2 IS NULL THEN '' ELSE booklet_type2 END  END packet_type_ia  ,
    null bulk_order_id          
    FROM hco_d_packet_mailing lm
      --LEFT JOIN (SELECT DISTINCT dcin, spd_status, maximus_status                              
      --            FROM  hco_d_letter_detail l ) dtl ON lm.dcin = dtl.dcin
      LEFT JOIN emrs_d_language ml ON lm.language_id = ml.language_code )tmp
  LEFT JOIN hco_d_letter_mail_type lt ON tmp.packet_type_ia = lt.type_code AND lt.material_type = 'P'
  LEFT JOIN emrs_d_county ct ON tmp.county_code = ct.county_code
UNION ALL
SELECT 
null vendor_received_date,
null county_code,
null custom_mailing_indicator,
null letter_type_id,
null letter_type_code,
null letter_type_code_v2,       
null letter_type_code_st,
null job_id,
dcin,
date_requested,
date_mailed,
null ship_date,
null material_name,
material_language,
date_requested record_date,
null packet_type,
null packet_subtype,
null booklet_type1,
null booklet_type2,
null ppd,
null pdd2,
0 packets_requested,
0 packets_sent,
alternative_format_type,
'N' bulk_request_flag,
'Y' alternative_format_flag,
null order_status_id,
null order_status,
valid_flag,
null case_id,
af.client_number,
bad_address_flag,
bad_address_record_date,
bad_address_transaction_type,
spdstatus spd_status,
maximusstatus maximus_status,
null packet_type_derived,
null material_code,
null material_id,
null packet_type_ia,
null bulk_order_id,
CASE WHEN spdstatus IN('M','V') THEN 'Y' ELSE 'N' END spd_flag,
mandatorvolunstatus mvx_status,
null material_type
,null mail_type
,NULL mail_type_code
,null county_mvx_status
FROM hco_d_alternative_format af
 LEFT JOIN emrs_d_client dc ON af.client_number = dc.client_number 
UNION ALL 
SELECT 
vendor_received_date,
COALESCE(ct.county_code,mo.county_name) county_code,
null custom_mailing_indicator,
null letter_type_id,
null letter_type_code,
null letter_type_code_v2,       
null letter_type_code_st,
null job_id,
null dcin,
date_requested,
null date_mailed,
ship_date,
material_name,
material_language,
record_date,
null packet_type,
null packet_subtype,
null booklet_type1,
null booklet_type2,
null ppd,
null pdd2,
0 packets_requested,
order_quantity packets_sent,
null alternative_format_type,
'Y' bulk_request_flag,
'N' alternative_format_flag,
'0' order_status_id,
null order_status,
null valid_flag,
null case_id,
null client_number,
null bad_address_flag,
null bad_address_record_date,
null bad_address_transaction_type,
null spd_status,
null maximus_status,
null packet_type_derived,
material_name material_code,
0 material_id,
null packet_type_ia,
mo.order_id bulk_order_id,
null spd_flag,
null mvx_status,
material_type,
null mail_type,
NULL mail_type_code,
ct.mvx_status county_mvx_status
FROM hco_d_material_order mo
  LEFT JOIN emrs_d_county ct ON mo.county_name = ct.county_name
UNION ALL
SELECT 
mo.vendor_received_date,
COALESCE(ct.county_code,mo.county_name) county_code,
null custom_mailing_indicator,
null letter_type_id,
null letter_type_code,
null letter_type_code_v2,       
null letter_type_code_st,
null job_id,
null dcin,
mo.date_requested,
null date_mailed,
mo.ship_date,
mo.material_name,
mo.material_language,
mo.record_date,
null packet_type,
null packet_subtype,
null booklet_type1,
null booklet_type2,
null ppd,
null pdd2,
0 packets_requested,
sd.amount packets_sent,
null alternative_format_type,
'Y' bulk_request_flag,
'N' alternative_format_flag,
TO_CHAR(mo.order_status_id) order_status_id,
mo.order_status,
null valid_flag,
null case_id,
null client_number,
null bad_address_flag,
null bad_address_record_date,
null bad_address_transaction_type,
null spd_status,
null maximus_status,
null packet_type_derived,
COALESCE(mo.material_code,mo.material_name) material_code,
mo.material_id,
null packet_type_ia,
mo.order_id bulk_order_id,
null spd_flag,
null mvx_status,
mo.material_type,
null mail_type,
NULL mail_type_code,
ct.mvx_status county_mvx_status
FROM hco_d_order mo
  LEFT JOIN hco_d_shipment_order sd ON mo.order_detail_id = sd.order_detail_id
  LEFT JOIN emrs_d_county ct ON mo.county_name = ct.county_name;
  
  GRANT SELECT ON "HCO_F_MATERIAL_REQUESTS_SV" TO "MAXDAT_READ_ONLY";