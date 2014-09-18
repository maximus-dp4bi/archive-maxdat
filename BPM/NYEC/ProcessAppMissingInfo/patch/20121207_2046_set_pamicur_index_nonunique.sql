-- Set index to nonunique.
drop index DNPAMICUR_UIX1;
create index DNPAMICUR_IX1 on D_NYEC_PAMI_CURRENT ("Application ID") online tablespace MAXDAT_INDX parallel compute statistics; 
