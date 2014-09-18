create index IDX1_ENR_NOTIFICATION ON EMRS_D_ENROLLMENT_NOTIFICATION(notification_id) tablespace MAXDAT_INDX;

create index IDX1_SRC_NOTIFICATION ON EMRS_D_NOTIFICATION(source_record_id) tablespace MAXDAT_INDX;
create index IDX2_MTC_NOTIFICATION ON EMRS_D_NOTIFICATION(maintenance_type_cd) tablespace MAXDAT_INDX;
create index IDX3_SND_NOTIFICATION ON EMRS_D_NOTIFICATION(send_date) tablespace MAXDAT_INDX;

drop table emrs_s_client_stg_adhoc;