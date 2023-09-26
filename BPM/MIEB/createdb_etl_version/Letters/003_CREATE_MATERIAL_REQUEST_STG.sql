create table S_MATERIAL_REQUEST_DETAILS_STG
(
  material_request_details_id NUMBER(18) not null,
  material_request_id         NUMBER(18),
  material_cd                 VARCHAR2(32),
  language_cd                 VARCHAR2(32),
  media_cd                    VARCHAR2(20),
  ext_material_ref_id         NUMBER(18),
  number_requested            VARCHAR2(32),
  created_by                  VARCHAR2(80),
  created_ts                  DATE,
  updated_by                  VARCHAR2(80),
  updated_ts                  DATE,
  checksum                    number(10)
)
TABLESPACE MAXDAT_MIEB_DATA;

CREATE UNIQUE INDEX S_MRD_PK ON S_MATERIAL_REQUEST_DETAILS_STG (material_request_details_id ASC) TABLESPACE MAXDAT_MIEB_DATA;
ALTER TABLE S_MATERIAL_REQUEST_DETAILS_STG ADD CONSTRAINT S_MRD_PK PRIMARY KEY (material_request_details_id) USING INDEX S_MRD_PK ENABLE;

GRANT SELECT ON S_MATERIAL_REQUEST_DETAILS_STG TO MAXDAT_MIEB_READ_ONLY;
