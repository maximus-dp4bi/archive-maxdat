CREATE OR REPLACE FORCE VIEW "DP_SCORECARD"."WEBCHAT_ACTUALS_SV" as
select 
WCA.WEBCHAT_EID "EID",
WCA.WEBCHAT_STAFF_ID "STAFF_ID",
WCA.WEBCHAT_DATE "WEBCHAT DATE",
WCA.ASSIGNED "ASSIGNED",
WCA.TRANSFERRED "TRANSFERRED",
WCA.CONFERENCED "CONFERENCED",
WCA.TOTAL_NUMBER "TOTAL NUMBER",
WCA.AVG_TIME_WORK "AVERAGE TIME WORK",
WCA.AVG_TIME_WRAP "AVERAGE TIME WRAP",
WCA.AVG_TIME_HANDLE "AVERAGE TIME HANDLE"
FROM WEBCHAT_ACTUALS WCA;

grant select on WEBCHAT_ACTUALS to MAXDAT_READ_ONLY;
grant select on WEBCHAT_ACTUALS_SV to MAXDAT_READ_ONLY;
