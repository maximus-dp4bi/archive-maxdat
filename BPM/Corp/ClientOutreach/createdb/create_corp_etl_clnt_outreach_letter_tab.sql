CREATE TABLE corp_etl_clnt_outreach_letter(letter_request_id NUMBER(18,0) NOT NULL
,outreach_ref_id NUMBER(18,0) NOT NULL
,letter_type_cd VARCHAR2(40)
,letter_create_date DATE
,letter_created_by VARCHAR2(100)
,outreach_step NUMBER(18,0)) TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX OUTREACH_LTR_UK ON corp_etl_clnt_outreach_letter(letter_request_id,outreach_ref_id) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON CORP_ETL_CLNT_OUTREACH_LETTER TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW d_outreach_letter_sv
AS
SELECT cl.letter_request_id
       ,cl.outreach_ref_id
       ,cl.letter_type_cd
       ,d.letter_type letter_description
       ,cl.letter_create_date
       ,cl.letter_created_by
       ,cl.outreach_step
       ,co.outreach_request_type
       ,co.generic_field_2 outreach_process
FROM corp_etl_clnt_outreach_letter cl
INNER JOIN d_letter_definition d
  ON cl.letter_type_cd = d.letter_name
INNER JOIN d_cor_current co
  ON cl.outreach_ref_id = co.outreach_request_id;

GRANT SELECT ON D_OUTREACH_LETTER_SV TO MAXDAT_READ_ONLY;  