update maxdat.fedqic_appeal_stg
set closed_date = complete_date;

ALTER TABLE corp_etl_appeal DISABLE ALL TRIGGERS;

update maxdat.corp_etl_appeal
set closed_date = complete_date;

update maxdat.d_mw_appeal_instance
set closed_date = complete_date;
         
ALTER TABLE corp_etl_appeal ENABLE ALL TRIGGERS;

commit;

update maxdat.fedqic_appeal_stg
set complete_date = case when C_VERBAL_NOTICE is not null then C_VERBAL_NOTICE ELSE C_DECISION_LETTER_MAILED_DATE END;

ALTER TABLE corp_etl_appeal DISABLE ALL TRIGGERS;

update maxdat.corp_etl_appeal
set complete_date = case when APPEAL_NOTICE_DATE is not null then APPEAL_NOTICE_DATE ELSE DECISION_MAILED_DATE END;

update maxdat.d_mw_appeal_instance
set complete_date = case when APPEAL_NOTICE_DATE is not null then APPEAL_NOTICE_DATE ELSE DECISION_MAILED_DATE END; 
         
ALTER TABLE corp_etl_appeal ENABLE ALL TRIGGERS;

commit;