-------------------------------------------------------------------  
-- Create table EnvelopeStats 
CREATE TABLE maxdat.EnvelopeStats(
	id varchar2(10) NULL,
	imagetrust_batch_name varchar2(100) NULL,
	ecn varchar2(50) NULL,
	envlope_batch_name varchar2(50) NULL,
	envelope_count int NULL,
	batch_create_dt varchar2(50) NULL,
	insert_dt varchar2(50) NULL,
	batch_class varchar2(50) NULL,
	dcn varchar2(50) NULL
);
CREATE INDEX MAXDAT.IDX1_EnvelopeStats_id ON MAXDAT.EnvelopeStats (id);
CREATE INDEX MAXDAT.IDX2_EnvelopeStats_ecn ON MAXDAT.EnvelopeStats (ecn);
CREATE INDEX MAXDAT.IDX3_EnvelopeStats_it ON MAXDAT.EnvelopeStats (insert_dt);
CREATE INDEX MAXDAT.IDX4_EnvelopeStats_ebn ON MAXDAT.EnvelopeStats (envlope_batch_name);
CREATE INDEX MAXDAT.IDX5_EnvelopeStats_bcd ON MAXDAT.EnvelopeStats (batch_create_dt);
CREATE INDEX MAXDAT.IDX6_EnvelopeStats_ibn ON MAXDAT.EnvelopeStats (imagetrust_batch_name);
CREATE INDEX MAXDAT.IDX7_EnvelopeStats_dcn ON MAXDAT.EnvelopeStats (dcn);


  GRANT SELECT ON MAXDAT.EnvelopeStats TO MAXDAT_READ_ONLY;
  GRANT DELETE ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIUD;
  GRANT SELECT ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIUD;
  GRANT UPDATE ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIU;
  GRANT SELECT ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIU;
  GRANT UPDATE ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIU;

-------------------------------------------------------------------  
-- Create table EnvelopeStats_OLTP 
CREATE TABLE maxdat.EnvelopeStats_OLTP(
	id varchar2(10) NULL,
	imagetrust_batch_name varchar2(100) NULL,
	ecn varchar2(50) NULL,
	envlope_batch_name varchar2(50) NULL,
	envelope_count int NULL,
	batch_create_dt varchar2(50) NULL,
	insert_dt varchar2(50) NULL,
	batch_class varchar2(50) NULL,
	dcn varchar2(50) NULL
);
CREATE INDEX MAXDAT.IDX1_EnvelopeStats_OLTP_id ON MAXDAT.EnvelopeStats_OLTP (id);
CREATE INDEX MAXDAT.IDX2_EnvelopeStats_OLTP_ecn ON MAXDAT.EnvelopeStats_OLTP (ecn);
CREATE INDEX MAXDAT.IDX3_EnvelopeStats_OLTP_it ON MAXDAT.EnvelopeStats_OLTP (insert_dt);
CREATE INDEX MAXDAT.IDX4_EnvelopeStats_OLTP_ebn ON MAXDAT.EnvelopeStats_OLTP (envlope_batch_name);
CREATE INDEX MAXDAT.IDX5_EnvelopeStats_OLTP_bcd ON MAXDAT.EnvelopeStats_OLTP (batch_create_dt);
CREATE INDEX MAXDAT.IDX6_EnvelopeStats_OLTP_ibn ON MAXDAT.EnvelopeStats_OLTP (imagetrust_batch_name);
CREATE INDEX MAXDAT.IDX7_EnvelopeStats_OLTP_dcn ON MAXDAT.EnvelopeStats_OLTP (dcn);


  GRANT SELECT ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_READ_ONLY;
  GRANT DELETE ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT SELECT ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT UPDATE ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIU;
  GRANT SELECT ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIU;
  GRANT UPDATE ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIU;

-------------------------------------------------------------------
--Create db view EnvelopeStats_SV
CREATE OR REPLACE FORCE EDITIONABLE VIEW MAXDAT.EnvelopeStats_SV (id,	imagetrust_batch_name, ecn,	envlope_batch_name, envelope_count, batch_create_dt, insert_dt, batch_class, dcn) AS
select
	id,
	imagetrust_batch_name,
	ecn,
	envlope_batch_name,
	envelope_count,
	to_date(batch_create_dt, 'yyyy-mm-dd hh24:mi:ss') batch_create_dt,
	insert_dt,
	batch_class,
	dcn
from maxdat.EnvelopeStats;
 
  GRANT SELECT ON MAXDAT.EnvelopeStats_SV TO MAXDAT_READ_ONLY;
  GRANT SELECT ON MAXDAT.EnvelopeStats_SV TO MAXDAT_OLTP_SIUD;
  GRANT SELECT ON MAXDAT.EnvelopeStats_SV TO MAXDAT_OLTP_SIU;

