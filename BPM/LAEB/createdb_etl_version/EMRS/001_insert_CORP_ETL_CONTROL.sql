
-- Control variable for load of EMRS_D_CASE

INSERT 
  INTO  CORP_ETL_CONTROL (NAME,                     VALUE_TYPE,     VALUE,                  DESCRIPTION) 
VALUES                  ('EMRS_CASE_UPDATE_DATE',   'D',            '1900/01/01 00:00:00',  'Max Case update date from source');

-- Control variable for load of EMRS_D_CLIENT

INSERT 
  INTO  CORP_ETL_CONTROL (NAME,                         VALUE_TYPE,     VALUE,                      DESCRIPTION) 
VALUES                  ('EMRS_CLIENT_UPDATE_DATE',     'D',            '1900/01/01 00:00:00',      'Max Beneficiary update date from source');

-- Control variable for load of EMRS_D_CASE_CLIENT

INSERT 
  INTO  CORP_ETL_CONTROL (NAME,                             VALUE_TYPE,      VALUE,                      DESCRIPTION) 
VALUES                  ('EMRS_CASE_CLIENT_UPDATE_DATE',     'D',            '1900/01/01 00:00:00',      'Max Case Client update date from source');


-- Control variable for load of EMRS_D_CLIENT_SUPPLEMENTARY_INFO

INSERT 
  INTO  CORP_ETL_CONTROL (NAME,                             VALUE_TYPE,      VALUE,                      DESCRIPTION) 
VALUES                  ('EMRS_CLIENT_SI_UPDATE_DATE',      'D',            '1900/01/01 00:00:00',      'Max Client Supplementary Info update date from source');


-- Control variable for load of EMRS_D_ALERT

INSERT 
  INTO  CORP_ETL_CONTROL (NAME,                             VALUE_TYPE,      VALUE,                      DESCRIPTION) 
VALUES                  ('EMRS_ALERT_UPDATE_DATE',          'D',            '1900/01/01 00:00:00',      'Max Alert update date from source');


-- Control variable for load of EMRS_D_PHONE

INSERT 
  INTO  CORP_ETL_CONTROL (NAME,                             VALUE_TYPE,      VALUE,                      DESCRIPTION) 
VALUES                  ('EMRS_PHONE_UPDATE_DATE',          'D',            '1900/01/01 00:00:00',      'Max Phone update date from source');


-- Control variable for load of EMRS_D_ADDRESS

INSERT 
  INTO  CORP_ETL_CONTROL (NAME,                             VALUE_TYPE,      VALUE,                      DESCRIPTION) 
VALUES                  ('EMRS_ADDRESS_UPDATE_DATE',        'D',            '1900/01/01 00:00:00',      'Max Address update date from source');


-- Control variable that is used to determine if parallel loading is needed

INSERT 
  INTO  CORP_ETL_CONTROL (NAME,                 VALUE_TYPE,     VALUE,      DESCRIPTION) 
VALUES                  ('EMRS_REC_THRESHOLD',  'N',            '1000000',  'Threshold to run the process Bulk VS Partitioned');


COMMIT;


