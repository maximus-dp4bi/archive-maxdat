
alter table FEDQIC_APPEAL_STG add (CLOSED_DATE TIMESTAMP(6));
alter table FEDQIC_APPEAL_STG add (WITHDRAWN_DATE TIMESTAMP(6));

alter table CORP_ETL_APPEAL add (CLOSED_DATE TIMESTAMP(6));
alter table CORP_ETL_APPEAL add (WITHDRAWN_DATE TIMESTAMP(6));

alter table CORP_ETL_APPEAL_WIP add (CLOSED_DATE TIMESTAMP(6));
alter table CORP_ETL_APPEAL_WIP add (WITHDRAWN_DATE TIMESTAMP(6));

alter table D_MW_APPEAL_INSTANCE add (CLOSED_DATE TIMESTAMP(6));
alter table D_MW_APPEAL_INSTANCE add (WITHDRAWN_DATE TIMESTAMP(6));


