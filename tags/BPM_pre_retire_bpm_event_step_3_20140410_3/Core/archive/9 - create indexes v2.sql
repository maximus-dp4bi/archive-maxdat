/*Code no longer in use.As per Randall B Kolb 02/20/13*/

/*CREATE INDEX bpm_d_dates_MONTH_NAME_IX ON BPM_D_DATES( D_MONTH_NAME ) TABLESPACE MAXDAT_INDX ;
CREATE INDEX bpm_d_dates_D_WEEK_OF_MONTH_IX ON BPM_D_DATES ("D_WEEK_OF_MONTH") TABLESPACE MAXDAT_INDX ;

CREATE UNIQUE INDEX VFBIBD_UIX1 ON V_F_BPM_INSTANCE_BY_DATE (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create index VFBIBD_D_DATE_IX on V_F_BPM_INSTANCE_BY_DATE (D_DATE) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create index VFBIBD_BEM_ID_IX on V_F_BPM_INSTANCE_BY_DATE (BEM_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create index VFBIBD_BI_ID_IX on V_F_BPM_INSTANCE_BY_DATE (BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdabd_uix1 on V_D_AGE_IN_BUSINESS_DAYS (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdabd_uix2 on V_D_AGE_IN_BUSINESS_DAYS ("Age in Business Days", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdacd_uix1 on V_D_AGE_IN_CALENDAR_DAYS (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdacd_uix2 on V_D_AGE_IN_CALENDAR_DAYS ("Age in Calendar Days", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdcwd_uix1 on V_D_CANCEL_WORK_DATE (BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdcwd_uix2 on V_D_CANCEL_WORK_DATE ("Cancel Work Date", BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdcwf_uix1 on V_D_CANCEL_WORK_FLAG (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdcwf_uix2 on V_D_CANCEL_WORK_FLAG ("Cancel Work Flag", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdcod_uix1 on V_D_COMPLETE_DATE (BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdcod_uix2 on V_D_COMPLETE_DATE ("Complete Date", BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdcof_uix1 on V_D_COMPLETE_FLAG (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdcof_uix2 on V_D_COMPLETE_FLAG ("Complete Flag", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdcrd_uix1 on V_D_CREATE_DATE (BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdcrd_uix2 on V_D_CREATE_DATE ("Create Date", BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdcbn_uix1 on V_D_CREATED_BY_NAME (BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdcbn_uix2 on V_D_CREATED_BY_NAME ("Created By Name", BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdef_uix1 on V_D_ESCALATED_FLAG (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdef_uix2 on V_D_ESCALATED_FLAG ("Escalated Flag", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdetn_uix1 on V_D_ESCALATED_TO_NAME (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdetn_uix2 on V_D_ESCALATED_TO_NAME ("Escalated To Name", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdfbn_uix1 on V_D_FORWARDED_BY_NAME (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdfbn_uix2 on V_D_FORWARDED_BY_NAME ("Forwarded By Name", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdff_uix1 on V_D_FORWARDED_FLAG (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdff_uix2 on V_D_FORWARDED_FLAG ("Forwarded Flag", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdgn_uix1 on V_D_GROUP_NAME (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdgnf_uix2 on V_D_GROUP_NAME ("Group Name", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdgpnf_uix1 on V_D_GROUP_PARENT_NAME (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdgpn_uix2 on V_D_GROUP_PARENT_NAME ("Group Parent Name", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdgsn_uix1 on V_D_GROUP_SUPERVISOR_NAME (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdgsn_uix2 on V_D_GROUP_SUPERVISOR_NAME ("Group Supervisor Name", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdjf_uix1 on V_D_JEOPARDY_FLAG (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique  index vdjf_uix2 on V_D_JEOPARDY_FLAG ("Jeopardy Flag", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdlubn_uix1 on V_D_LAST_UPDATE_BY_NAME (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique  index vdlubn_uix2 on V_D_LAST_UPDATE_BY_NAME ("Last Update By Name", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdlud_uix1 on V_D_LAST_UPDATE_DATE (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique  index vdlud_uix2 on V_D_LAST_UPDATE_DATE ("Last Update Date", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdon_uix1 on V_D_OWNER_NAME (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique  index vdon_uix2 on V_D_OWNER_NAME ("Owner Name", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdsd_uix1 on V_D_SLA_DAYS (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique  index vdsd_uix2 on V_D_SLA_DAYS ("SLA Days", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdsdt_uix1 on V_D_SLA_DAYS_TYPE (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique  index vdsdt_uix2 on V_D_SLA_DAYS_TYPE ("SLA Days Type", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdsjd_uix1 on V_D_SLA_JEOPARDY_DAYS (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique  index vdsjd_uix2 on V_D_SLA_JEOPARDY_DAYS ("SLA Jeopardy Days", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdstd_uix1 on V_D_SLA_TARGET_DAYS (D_DATE, BI_ID) COMPUTE STATISTICS;
create unique  index vdstd_uix2 on V_D_SLA_TARGET_DAYS ("SLA Target Days", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdsrid_uix1 on V_D_SOURCE_REFERENCE_ID (D_DATE, BI_ID) COMPUTE STATISTICS;
create unique  index vdsrid_uix2 on V_D_SOURCE_REFERENCE_ID ("Source Reference ID", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdsrt_uix1 on V_D_SOURCE_REFERENCE_TYPE (D_DATE, BI_ID) COMPUTE STATISTICS;
create unique  index vdsrt_uix2 on V_D_SOURCE_REFERENCE_TYPE ("Source Reference Type", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdsaibd_uix1 on V_D_STATUS_AGE_IN_BUS_DAYS (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique  index vdsaibd_uix2 on V_D_STATUS_AGE_IN_BUS_DAYS ("Status Age in Business Days", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdsaicd_uix1 on V_D_STATUS_AGE_IN_CAL_DAYS (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique  index vdsaicd_uix2 on V_D_STATUS_AGE_IN_CAL_DAYS ("Status Age in Calendar Days", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdstdt_uix1 on V_D_STATUS_DATE (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique  index vdstdt_uix2 on V_D_STATUS_DATE ("Status Date", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdtid_uix1 on V_D_TASK_ID (BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique  index vdtid_uix2 on V_D_TASK_ID ("Task ID", BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdts_uix1 on V_D_TASK_STATUS (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdts_uix2 on V_D_TASK_STATUS ("Task Status", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdtt_uix1 on V_D_TASK_TYPE (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdtt_uix2 on V_D_TASK_TYPE ("Task Type", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdtn_uix1 on V_D_TEAM_NAME (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdtn_uix2 on V_D_TEAM_NAME ("Team Name", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdtpn_uix1 on V_D_TEAM_PARENT_NAME (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdtpn_uix2 on V_D_TEAM_PARENT_NAME ("Team Parent Name", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdtsn_uix1 on V_D_TEAM_SUPERVISOR_NAME (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdtsn_uix2 on V_D_TEAM_SUPERVISOR_NAME ("Team Supervisor Name", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdtst_uix1 on V_D_TIMELINESS_STATUS (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdtst_uix2 on V_D_TIMELINESS_STATUS ("Timeliness Status", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create unique index vdtuow_uix1 on V_D_UNIT_OF_WORK (D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdtuow_uix2 on V_D_UNIT_OF_WORK ("Unit of Work", D_DATE, BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS; */
/