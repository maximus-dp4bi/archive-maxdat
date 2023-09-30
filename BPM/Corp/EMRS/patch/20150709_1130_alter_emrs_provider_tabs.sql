alter table emrs_s_provider_stg
MODIFY(ADDRESS_2 VARCHAR2(50),
       ZIP VARCHAR2(32), 
	     COUNTY_ID VARCHAR2(64));

alter table emrs_d_provider
MODIFY(ADDRESS_2 VARCHAR2(50), 
	ZIP VARCHAR2(32), 
	COUNTY_ID VARCHAR2(64));