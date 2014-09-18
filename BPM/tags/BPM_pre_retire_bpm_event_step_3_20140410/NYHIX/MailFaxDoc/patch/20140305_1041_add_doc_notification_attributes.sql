alter table nyhix_etl_mail_fax_doc add (app_doc_tracker_id number(18), doc_notification_id number(18), hx_account_id varchar2(64),doc_notification_status varchar2(64), HXID varchar2(64));
alter table nyhix_etl_mail_fax_doc_oltp add (hx_account_id varchar2(64),HXID varchar2(64), doc_notification_status varchar2(64));
alter table nyhix_etl_mail_fax_doc_wip_bpm add (app_doc_tracker_id number(18), doc_notification_id number(18), hx_account_id varchar2(64), HXID varchar2(64), doc_notification_status varchar2(64));

alter table nyhix_etl_mail_fax_doc_oltp rename column document_notification_id to doc_notification_id;

alter table nyhix_etl_mail_fax_doc_oltp modify app_doc_tracker_id number(18,0);

alter table d_nyhix_mfd_current add(app_doc_tracker_id number(18), doc_notification_id number(18), hx_account_id varchar2(64), HXID varchar2(64), doc_notification_status varchar2(64));

alter table document_notification_stg add (hx_account_id varchar2(64), HXID varchar2(64));

insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1611,1,'App Doc Tracker ID','Identifier in MAXe, representative of an envelope.  This attribute is use to relate between tasks and envelopes or documents.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1612,1,'Doc Notification ID','Identifier in MAXe, representative of the notification received from CSC for Verification documents.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1613,2,'Doc Nofication Status','Status of the Document Notification Record in MAXe');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1614,2,'HX Account ID','NYHIX Account ID. Attribute only applies to Verification Docs.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1615,2,'HX ID','Identifier for the NYHIX ID');


insert into BPM_ATTRIBUTE values (2611,1611,18,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE values (2612,1612,18,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE values (2613,1613,18,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE values (2614,1614,18,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE values (2615,1615,18,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');

insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.nextval,2611,18,'APP_DOC_TRACKER_ID');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.nextval,2612,18,'DOC_NOTIFICATION_ID');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.nextval,2613,18,'DOC_NOTIFICATION_STATUS');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.nextval,2614,18,'HX_ACCOUNT_ID');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.nextval,2615,18,'HXID');

commit;

alter trigger TRG_AI_NYHIX_ETL_MFD_Q disable;
alter trigger TRG_BIU_NYHIX_ETL_MFD disable;
alter trigger TRG_AU_NYHIX_ETL_MFD_Q disable;

declare
  cursor S1
  is
    select APP_DOC_TRACKER_ID, DOCUMENT_SET_ID from APP_DOC_TRACKER_STG;
begin
  for C1 in S1
  LOOP
    update NYHIX_ETL_MAIL_FAX_DOC
    set APP_DOC_TRACKER_ID = C1.APP_DOC_TRACKER_ID
    where DOC_SET_ID = C1.DOCUMENT_SET_ID;

    commit;

    update D_NYHIX_MFD_CURRENT
    set APP_DOC_TRACKER_ID = C1.APP_DOC_TRACKER_ID
    where DOCUMENT_SET_ID = C1.DOCUMENT_SET_ID;

    commit;
  end LOOP;
end;
/


DECLARE
  CURSOR S1
  IS
    SELECT DCN, DOCUMENT_NOTIFICATION_ID, STATUS FROM DOCUMENT_NOTIFICATION_STG;
BEGIN
  FOR C1 IN S1
  LOOP
    UPDATE NYHIX_ETL_MAIL_FAX_DOC
    set 
      DOC_NOTIFICATION_ID   = C1.DOCUMENT_NOTIFICATION_ID,
      DOC_NOTIFICATION_STATUS = C1.STATUS
    WHERE DCN = C1.DCN;

    commit;

    UPDATE D_NYHIX_MFD_CURRENT
    set 
      DOC_NOTIFICATION_ID   = C1.DOCUMENT_NOTIFICATION_ID,
      DOC_NOTIFICATION_STATUS = C1.STATUS
    WHERE DCN = C1.DCN;

    COMMIT;
  END LOOP;
END;
/

alter trigger TRG_AI_NYHIX_ETL_MFD_Q enable;
alter trigger TRG_BIU_NYHIX_ETL_MFD enable;
alter trigger TRG_AU_NYHIX_ETL_MFD_Q enable;


CREATE INDEX DNMFDCUR_IX5 ON D_NYHIX_MFD_CURRENT (CANCEL_BY) ONLINE TABLESPACE MAXDAT_INDX PARALLEL COMPUTE STATISTICS;

CREATE OR REPLACE VIEW D_NYHIX_MFD_CURRENT_SV AS
SELECT NYHIX_MFD_BI_ID,
  DCN,
  CREATE_DT,
  ECN,
  INSTANCE_STATUS,
  INSTANCE_STATUS_DT,
  BATCH_ID,
  CHANNEL,
  PAGE_COUNT,
  DOCUMENT_STATUS,
  DOCUMENT_STATUS_DT,
  ENVELOPE_STATUS,
  ENVELOPE_STATUS_DT,
  DOCUMENT_TYPE,
  DOCUMENT_SUBTYPE,
  FORM_TYPE,
  FREE_FORM_TEXT,
  SCAN_DT,
  RELEASE_DT,
  MAXE_CREATE_DOC_START,
  MAXE_CREATE_DOC_END,
  DOCUMENT_ID,
  DOCUMENT_SET_ID,
  MAXE_DOC_CREATE_DT,
  LANGUAGE,
  COMPLAINT_DATA_ENTRY_TASK_ID,
  CREATE_COMPLAINT_START,
  CREATE_COMPLAINT_END,
  APPEAL_DATA_ENTRY_TASK_ID,
  CREATE_APPEAL_START,
  CREATE_APPEAL_END,
  INCIDENT_ID,
  HSDE_QC_TASK_ID,
  RESOLVE_HSDE_QC_TASK_START,
  RESOLVE_HSDE_QC_TASK_END,
  HSDE_ERROR,
  MANUAL_LINKING_TASK_ID,
  MANUAL_LINK_DOCUMENT_START,
  MANUAL_LINK_DOCUMENT_END,
  DOC_SET_LINK_QC_TASK_ID,
  DOC_SET_LINK_QC_START,
  DOC_SET_LINK_QC_END,
  ESCALATED_TASK_ID,
  RESOLVE_ESC_TASK_START,
  RESOLVE_ESC_TASK_END,
  DATA_ENTRY_TASK_ID,
  DATA_ENTRY_START,
  DATA_ENTRY_END,
  MAXIMUS_QC_TASK_ID,
  MAXIMUS_QC_START,
  MAXIMUS_QC_END,
  ESCALATED_TASK_ID2,
  RESOLVE_ESC_TASK2_START,
  RESOLVE_ESC_TASK2_END,
  TRANSMIT_TO_NYHBE_START,
  TRANSMIT_TO_NYHBE_END,
  CANCEL_DT,
  CASE
    WHEN length(S.LAST_NAME || ', ' || S.FIRST_NAME) > 2 THEN S.LAST_NAME || ', ' || S.FIRST_NAME
    WHEN length(E.LAST_NAME || ', ' || E.FIRST_NAME) > 2 THEN E.LAST_NAME || ', ' || E.FIRST_NAME
    ELSE C.CANCEL_BY
  END CANCEL_BY,
  CANCEL_REASON,
  CANCEL_METHOD,
  LINK_METHOD,
  LINK_ID,
  LINKED_CLIENT,
  COMPLETE_DT,
  RESCANNED,
  RETURNED_MAIL,
  RETURNED_MAIL_REASON,
  RESCAN_COUNT,
  LAST_UPDATED_BY,
  LAST_UPDATED_DT,
  DOCUMENT_TRASHED,
  DOCUMENT_NOTE_ID,
  ORIGINAL_DOC_TYPE,
  ORIGINAL_FORM_TYPE,
  EXPEDITED,
  RESEARCH_REQUESTED,
  AGE_IN_BUSINESS_DAYS,
  AGE_IN_CALENDAR_DAYS,
  TIMELINESS_STATUS,
  TIMELINESS_DAYS,
  TIMELINESS_DAYS_TYPE,
  TIMELINESS_DATE,
  JEOPARDY_FLAG,
  JEOPARDY_DAYS,
  JEOPARDY_DAYS_TYPE,
  JEOPARDY_DATE,
  TARGET_DAYS,
  CURRENT_TASK_ID,
  KOFAX_DCN,
  CURRENT_STEP,
  BATCH_NAME,
  ORIGINATION_DT,
  PREVIOUS_KOFAX_DCN,
  PAPER_SLA_TIME_STATUS,
  APP_DOC_TRACKER_ID,
  DOC_NOTIFICATION_ID,
  DOC_NOTIFICATION_STATUS,
  HX_ACCOUNT_ID,
  HXID
FROM D_NYHIX_MFD_CURRENT C
LEFT OUTER JOIN D_STAFF S
ON C.CANCEL_BY = to_char(S.STAFF_ID)
LEFT OUTER JOIN D_STAFF E
ON C.CANCEL_BY = E.EXT_STAFF_NUMBER;