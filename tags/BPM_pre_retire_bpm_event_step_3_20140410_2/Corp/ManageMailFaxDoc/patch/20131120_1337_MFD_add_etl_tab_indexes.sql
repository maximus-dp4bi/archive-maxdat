-- 11/20/13 Add primary key indexes for Mail Fax Dox ETL tables; originally discovered TXEB, no Jira ticket

ALTER TABLE corp_etl_mailfaxdoc ADD CONSTRAINT corp_etl_mailfaxdoc_pk
  PRIMARY KEY ( cemfd_id ) USING INDEX TABLESPACE MAXDAT_INDX;

ALTER TABLE corp_etl_mailfaxdoc_wip_bpm ADD CONSTRAINT corp_etl_mailfaxdoc_wip_bpm_pk
  PRIMARY KEY ( cemfd_id ) USING INDEX TABLESPACE MAXDAT_INDX;

ALTER TABLE corp_etl_mailfaxdoc_oltp ADD CONSTRAINT corp_etl_mailfaxdoc_oltp_pk
  PRIMARY KEY ( cemfd_id ) USING INDEX TABLESPACE MAXDAT_INDX;

