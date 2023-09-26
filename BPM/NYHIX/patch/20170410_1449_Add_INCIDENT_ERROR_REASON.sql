--- NYHIX-30329
insert into maxdat.corp_etl_control 
values('MAX_UPDATE_TS_INCIDENT_ERROR_REASON', 'D', '2017/01/01 00:00:00', 'Max Update Date for load_incident_error_reason table',sysdate,sysdate);
commit;

insert into maxdat.corp_etl_control
values('LOOK_BACK_INCIDENT_ERROR_REASON', 'N', 1, 'Number of days loopback for incident error reason', sysdate, sysdate);
commit; 

CREATE TABLE MAXDAT.NYHBE_INCIDENT_ERROR_REASON 
( INCIDENT_ERROR_REASON_ID NUMBER(18, 0) NOT NULL 
, INCIDENT_HEADER_ID       NUMBER(18, 0)
, INCIDENT_ERROR_REASON_CD VARCHAR2(64 BYTE) 
, ERROR_REASON             VARCHAR2(64 BYTE) 
, HIST_IND                 NUMBER(1,0) 
, CREATED_BY               VARCHAR2(80 BYTE) 
, CREATE_TS                DATE
, UPDATED_BY               VARCHAR2(80 BYTE)
, UPDATE_TS                DATE 
);

CREATE UNIQUE INDEX MAXDAT.NYHBE_INCIDENT_ERROR_REASON_UK 
    ON MAXDAT.NYHBE_INCIDENT_ERROR_REASON (INCIDENT_HEADER_ID ASC, INCIDENT_ERROR_REASON_ID ASC);


CREATE OR REPLACE VIEW MAXDAT.D_NYHIX_INCIDENT_ERR_REASON_SV
AS select 
INCIDENT_HEADER_ID AS INCIDENT_ID,
INCIDENT_ERROR_REASON_ID,
INCIDENT_ERROR_REASON_CD,
ERROR_REASON,
HIST_IND,
CREATE_TS,
CREATED_BY,
UPDATED_BY,
UPDATE_TS
from 
NYHBE_INCIDENT_ERROR_REASON with read only;

grant select on MAXDAT.D_NYHIX_INCIDENT_ERR_REASON_SV to MAXDAT_READ_ONLY;