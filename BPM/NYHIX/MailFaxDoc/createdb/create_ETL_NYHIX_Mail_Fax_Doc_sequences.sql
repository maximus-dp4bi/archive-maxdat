--SEQUENCE EEMFDB_ID
CREATE SEQUENCE SEQ_EEMFDB_ID
MINVALUE 1
MAXVALUE 999999999999999999999999999
START WITH 1
INCREMENT BY 1
CACHE 20;


CREATE OR REPLACE PUBLIC SYNONYM SEQ_EEMFDB_ID FOR SEQ_EEMFDB_ID;