/*
Created on 01-APR-2014 by Raj A.
Project: TXEB
Process: Manage Enrollment Activity.
*/
create index IDX_CEME_ceme_id on CORP_ETL_MANAGE_ENROLL_OLTP (ceme_id );
create index IDX_WIP_ceme_id on CORP_ETL_MANAGE_ENROLL_WIP (ceme_id );