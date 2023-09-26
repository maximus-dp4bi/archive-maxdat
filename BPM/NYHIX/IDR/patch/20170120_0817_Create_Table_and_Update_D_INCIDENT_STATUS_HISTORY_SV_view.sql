declare  c int;
begin
   select count(*) into c from user_tables where table_name ='INCIDENT_STATUS_LOOKUP';
   if c = 1 then
      execute immediate 'drop table INCIDENT_STATUS_LOOKUP cascade constraints';
   end if;
end;
/

Create table maxdat.incident_status_lookup
(
Incident_status varchar2(80),
Status_cd varchar2(80),
start_stop varchar2(10),
module varchar2(80)
)
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

grant select on incident_status_lookup to MAXDAT_READ_ONLY;
grant select on incident_status_lookup to DP_SCORECARD;

insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Validity Check','APPEAL_VALID','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Hearing Set','HEAR_NO_DISP','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Notice of Dismissal','NOTICE_OF_DISMISSAL','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Schedule Hearing','SCHED_HEAR','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Valid Appeal','VALID_APPEAL','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Valid Appeal - Denied ATC','VALID_APPEAL_DENIED_ATC','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Valid Appeal - Granted ATC','VALID_APPEAL_GRANTED_ATC','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Valid Appeal - Process ATC','VALID_APPEAL_PROCESS_ATC','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('SBM Desk Review','SHOP_REVIEW','COUNT','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed','APPEAL_CLOSED','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed - Duplicate/Error','INC_CLOSED_DUP','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed - Failed to Attend Hearing','APL_CLOS_FAIL_TO_ATND_HEARING','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed - Non-Sworn Cancellation','APPEAL_CLOSE_NON_SWORN_CANCEL','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed - Written Withdrawal','APPEAL_CLOSED_WRITTEN_WITHDRL','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Dismissed','DISMISSED','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Dismissed - Death','DIS_DEATH','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Returned - Action Required','RETURN_ACTION_REQUIRED','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed - ARU Action Completed','APPEAL_CLOSED_ARU_ACTION','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Closed - DOH Action Completed','APPEAL_CLOSED_DOH_ACTION_COMP','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to ARU QC','REFER_TO_ARU_QC','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Returned - Refer to DOH Application Support','RETN_REF_TO_DOH_APPLN_SUPPORT','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Returned - Refer to DOH APTC/QHP/Plan Management','RETN_REF_TO_DOH_APTC_QHP_PLAN','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Returned - Refer to DOH MA/FHP','RETURNED_REFER_TO_DOH_MA_FHP','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Returned - Refer to DOH TPHI','RETURNED_REFER_TO_DOH_TPHI','FINISH','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Appeal Open','APPEAL_OPEN','START','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Adjournment','ADJOURNMENT','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Adjournment - Awaiting Documentation','ADJOURNMENT_AWAITING_DOCUMENT','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Awaiting Validity Amendment - Individual','AWAIT_VALID_INDV','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Dismissal - Failed to Attend Hearing','DIS_NO_ATTEND','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Invalid with Right to Cure','INVALID_RIGHT_TO_CURE','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Non-Sworn Cancellation','NON_SWORN_CANCELLATION','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Pending Withdrawal/Cancellation','PENDING_WITHDRAWAL_CANCEL','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Request to Vacate Dismissal','REQ_VACATE_DISM','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Reschedule Hearing','RESCHED_HEAR_DOH_REQ','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Written Withdrawal','AWAIT_WITH','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Awaiting Written Withdrawal','AWAIT_WITH','STOP','APPEAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Follow up Required','FOLLOW_UP_REQUIRED','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-Appeals','REFERRED_TO_STATE_APPEALS','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-Application Support','REFERRED_TO_STATE_APP_SUP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-APTC/QHP Plan Management','REFERRED_TO_STATE_RESEARCH','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-CHP','REFERRED_TO_STATE_CHP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-Financial Management','REFERRED_TO_STATE_FINANCE_MGT','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-MA/FHP','REFERRED_TO_STATE_MA_FHP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-Medicaid Managed Care','REFERRED_TO_STATE_MANAGED_CARE','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-SHOP','REFERRED_TO_STATE_SHOP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-TPHI','REFERRED_TO_STATE_TPHI','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to Supervisor','REFERRED_TO_SUPERVISOR','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Sent In Error','SENT_IN_ERROR','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-Appeals','STATE_SUP_APPEALS','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-Application Support','STATE_SUP_APP_SUP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-APTC/QHP Plan Management','STATE_SUP_RESEARCH','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-CHP','STATE_SUP_CHP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-Financial Management','STATE_SUP_FM','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-MA/FHP','STATE_SUP_MA_FHP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-Managed Care','STATE_SUP_MC','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-SHOP','STATE_SUP_SHOP','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-TPHI','STATE_SUP_TPHI','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-Transition','STATE_SUP_TRANSITION','COUNT','COMPLAINT/REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Awaiting Documentation','AWAIT_DOC','COUNT','IDR');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('IDR Closed - Duplicate/Error','INCIDENT_CLOSED','FINISH','IDR');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('IDR Not Resolved','CLOSED_IDR_FAIL','FINISH','IDR');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('IDR Resolved','CLOSED_IDR_SUCCESS','FINISH','IDR');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('IDR Open','INCIDENT_OPEN','START','IDR');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Refer to State-NY Appeals','REFER_TO_APPEAL','COUNT','REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('State Supervisory Review-NY Appeals','REF_APPEALS_SUPER','COUNT','REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Referral Withdrawn','REFERRAL WITHDRAWN','FINISH','REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Referral Closed','REFERRAL CLOSED','FINISH','REFERRAL');
insert into incident_status_lookup (Incident_status,Status_cd,start_stop,module) values ('Referral Open','REFERRAL_OPEN','START','REFERRAL');

commit;


CREATE OR REPLACE VIEW MAXDAT.D_INCIDENT_STATUS_HISTORY_SV
AS
WITH get_basic AS
(
select
INCIDENT_HEADER_STAT_HIST_ID,
INCIDENT_HEADER_ID AS INCIDENT_ID,
STATUS_CD,
INCIDENT_STATUS,
CREATE_TS INCIDENT_STATUS_DT,
CREATED_BY,
CREATED_BY_STAFF_ID,
(SELECT max(ishs2.create_ts) FROM INCIDENT_HEADER_STAT_HIST_STG ishs2
    WHERE ishs2.INCIDENT_HEADER_ID = ishs1.INCIDENT_HEADER_ID
    AND ishs2.STATUS_CD IN (SELECT status_cd FROM incident_status_lookup WHERE start_stop IN ('FINISH', 'STOP'))
)  end_date
from
INCIDENT_HEADER_STAT_HIST_STG ishs1
)
select
INCIDENT_HEADER_STAT_HIST_ID,
INCIDENT_ID,
STATUS_CD,
INCIDENT_STATUS,
INCIDENT_STATUS_DT,
CREATED_BY,
CREATED_BY_STAFF_ID,
end_date,
bus_days_between(INCIDENT_STATUS_DT, nvl(end_date,SYSDATE)) age_in_business_days,
trunc(nvl(end_date,SYSDATE) - trunc(INCIDENT_STATUS_DT)) age_in_calendar_days,
CASE WHEN incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH', 'STOP')) THEN 0 ELSE bus_days_between(INCIDENT_STATUS_DT, nvl(end_date,SYSDATE)) end age_in_business_days_flow,
CASE WHEN incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH', 'STOP')) THEN 0 ELSE trunc(nvl(end_date,SYSDATE) - trunc(INCIDENT_STATUS_DT)) END age_in_calendar_days_flow
FROM get_basic with read only;

GRANT SELECT ON MAXDAT.D_INCIDENT_STATUS_HISTORY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.D_INCIDENT_STATUS_HISTORY_SV TO DP_SCORECARD;


