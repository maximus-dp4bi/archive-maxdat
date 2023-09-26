CREATE OR REPLACE VIEW HCO_F_CALLS_BY_PLAN_BY_DAY_SV
AS
SELECT dd.d_date
  ,cd.call_type
  ,COALESCE(clnt.participantlang,'7') language_code
  ,COALESCE(l.language, 'English') language
  ,p.plan_id
  ,p.plan_name
  ,p.county_code
  ,ct.county_name county
  ,SUM(cd.call_duration) total_call_duration
  ,COUNT(cd.call_id) total_calls
  ,ROUND(SUM(cd.call_duration)/CASE WHEN COUNT(cd.call_id) = 0 THEN 1 ELSE COUNT(cd.call_id) END,2) derived
FROM bpm_d_dates dd
  LEFT JOIN hco_f_call_details_sv cd ON dd.d_date = cd.call_date AND cd.campaign_name != 'BA'  
  LEFT JOIN emrs_d_client clnt ON cd.client_number =clnt.client_number
  LEFT JOIN emrs_d_plan p ON clnt.planoflasttrans = p.plan_id OR clnt.planoflastdtltrans = p.plan_id
  LEFT JOIN emrs_d_county ct ON p.county_code = ct.county_code
  LEFT JOIN emrs_d_language l ON clnt.participantlang = l.language_code
GROUP BY dd.d_date,cd.call_type,clnt.participantlang,l.language,p.plan_id,p.plan_name,p.county_code,ct.county_name;

GRANT SELECT ON "HCO_F_CALLS_BY_PLAN_BY_DAY_SV" TO "MAXDAT_READ_ONLY";
