create table D_ZIPCODES_GEONAME (
Country	varchar2(10) NOT NULL
, zipcode number(10) NOT NULL
, Place_name varchar2(50)
, state_name varchar2(20)
, state_code varchar2(10)
, County_name varchar2(20)
, county_code number(10)
, latitude number(20,4) NOT NULL
, longitude number(20,4) NOT NULL
, constraint d_zipcodes_geoname_pk PRIMARY KEY (COUNTRY, ZIPCODE)
)
tablespace maxdat_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

CREATE VIEW D_ZIPCODES_GEONAME_SV AS SELECT * FROM D_ZIPCODES_GEONAME;

GRANT SELECT ON D_ZIPCODES_GEONAME_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON D_ZIPCODES_GEONAME_SV TO MAXDAT_REPORTS;

--drop table D_ZIPCODES_GEONAME;
--drop view D_ZIPCODES_GEONAME_SV;
