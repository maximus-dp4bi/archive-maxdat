SELECT f.RECORD_DATE, P.plan_name
, COMPLETED_CNT "Total Completed"
, completed_phone_cnt "Completed Phone"
, completed_phone_per "Completed Phone%"
, completed_web_cnt "Completed Online"
, completed_web_per "Completed Online%"
, avg_completed_min "Average Time to Complete Survey(min)"
, optout_cnt "Total Optout"
, optout_per "Opted out%"
, abandon_answered_cnt "Answered All Applicable Questions"
, abandon_notime_cnt "Not Enough Time"
, abandon_private_cnt "Private Information"
, abandon_other_cnt "Refused (other)"
, abandon_cnt "Total Abandoned"
, completed_phone_per + completed_web_per + optout_per + abandon_per total_per
 FROM F_SURVEY_COUNT_SV F, EMRS_D_PLAN_SV P
WHERE P.PLAN_ID = F.PLAN_ID
order by f.record_date, p.plan_name
