/*
Created on 11-Jun-2013 by Raj A.
Team: MAXDAT.
Project: ICEB.
Business Process: Manage Enrollment Activity.

Description:
seq_ceme used by the TRG_CORP_ETL_MANAGE_ENRL on the corp_etl_Manage_enroll table.
seq_ceme used by the Rule_lkup_mng_enrl_followup table.
*/

CREATE SEQUENCE seq_mefr
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE SEQUENCE seq_ceme
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 20;