use schema ineo;
CREATE OR REPLACE VIEW INEO_D_CC_USER_PRODUCTIVITY_HISTORY_SV
AS
SELECT user_productivity_report_id,
as_of_date,
department,
last_name,
name,
i3_username,
offered,
answered,
abandoned,
transferred,
time_talk_acd,
filename,
percent_answered,
percent_abandoned,
flow_outs,
percent_flow_outs,
percent_transferred,
talk_time_hold_time,
talk_time_avg,
hold_time,
hold_time_avg,
acw_time,
acw_avg,
talkholdacw_duration_time,
talkholdacw_avg,
sf_create_ts,
sf_update_ts
FROM ineo.ineo_cc_user_productivity_report_history;

