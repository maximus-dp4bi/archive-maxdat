--- NYHIX-35421 modify not null 

alter table maxdat.NYHBE_ETL_PROCESS_APPEALS 
modify INCIDENT_STATUS varchar2(80) NOT NULL;

alter table maxdat.NYHBE_ETL_PROCESS_APPEALS
modify instance_status varchar2(10) not null;

