drop index DNPAAS_UIX1;
create unique index DNPAAS_UIX1 on D_NYEC_PA_APP_STATUS ("App Status","App Status Group","Heart App Status","Refer to LDSS Flag") online tablespace MAXDAT_INDX parallel;

