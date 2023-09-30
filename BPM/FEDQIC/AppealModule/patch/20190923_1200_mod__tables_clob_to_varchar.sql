alter table fedqic_appeal_stg add (reason_for_appeal_varchar VARCHAR2(4000));
update fedqic_appeal_stg set reason_for_appeal_varchar = c_reason_for_appeal;
alter table fedqic_appeal_stg drop (c_reason_for_appeal);
alter table fedqic_appeal_stg rename column reason_for_appeal_varchar TO c_reason_for_appeal;
commit;
ALTER TABLE corp_etl_appeal DISABLE ALL TRIGGERS;
alter table corp_etl_appeal add (reason_for_appeal_varchar VARCHAR2(4000));
update corp_etl_appeal set reason_for_appeal_varchar = reason_for_appeal;
alter table corp_etl_appeal drop (reason_for_appeal);
alter table corp_etl_appeal rename column reason_for_appeal_varchar TO reason_for_appeal;
ALTER TABLE corp_etl_appeal ENABLE ALL TRIGGERS;
commit;
alter table corp_etl_appeal_wip add (reason_for_appeal_varchar VARCHAR2(4000));
update corp_etl_appeal_wip set reason_for_appeal_varchar = reason_for_appeal;
alter table corp_etl_appeal_wip drop (reason_for_appeal);
alter table corp_etl_appeal_wip rename column reason_for_appeal_varchar TO reason_for_appeal;
commit;
alter table d_mw_appeal_instance add (reason_for_appeal_varchar VARCHAR2(4000));
update d_mw_appeal_instance set reason_for_appeal_varchar = reason_for_appeal;
alter table d_mw_appeal_instance drop (reason_for_appeal);
alter table d_mw_appeal_instance rename column reason_for_appeal_varchar TO reason_for_appeal;
commit;

alter table fedqic_appeal_stg add (expert_review_citation_varchar VARCHAR2(4000));
update fedqic_appeal_stg set expert_review_citation_varchar = c_expert_review_citation;
alter table fedqic_appeal_stg drop (c_expert_review_citation);
alter table fedqic_appeal_stg rename column expert_review_citation_varchar TO c_expert_review_citation;
commit;
ALTER TABLE corp_etl_appeal DISABLE ALL TRIGGERS;
alter table corp_etl_appeal add (expert_review_citation_varchar VARCHAR2(4000));
update corp_etl_appeal set expert_review_citation_varchar = expert_review_citation;
alter table corp_etl_appeal drop (expert_review_citation);
alter table corp_etl_appeal rename column expert_review_citation_varchar TO expert_review_citation;
ALTER TABLE corp_etl_appeal ENABLE ALL TRIGGERS;
commit;
alter table corp_etl_appeal_wip add (expert_review_citation_varchar VARCHAR2(4000));
update corp_etl_appeal_wip set expert_review_citation_varchar = expert_review_citation;
alter table corp_etl_appeal_wip drop (expert_review_citation);
alter table corp_etl_appeal_wip rename column expert_review_citation_varchar TO expert_review_citation;
commit;
alter table d_mw_appeal_instance add (expert_review_citation_varchar VARCHAR2(4000));
update d_mw_appeal_instance set expert_review_citation_varchar = expert_review_citation;
alter table d_mw_appeal_instance drop (expert_review_citation);
alter table d_mw_appeal_instance rename column expert_review_citation_varchar TO expert_review_citation;
commit;

