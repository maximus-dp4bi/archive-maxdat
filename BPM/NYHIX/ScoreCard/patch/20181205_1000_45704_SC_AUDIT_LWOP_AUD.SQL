-- Create table DP_SCORECARD.SC_AUDIT_LWOP_AUD


CREATE TABLE DP_SCORECARD.SC_AUDIT_LWOP_AUD( 
RECORD_TYPE	VARCHAR2(10 BYTE),
RECORD_ACTION	VARCHAR2(10 BYTE),
TRANSACTION_DATE	DATE,
LWOP_Instance_ID	number (38,0),
STAFF_STAFF_ID	number (38,0),
LWOP_OCCURRENCE_DATE	Date,
LWOP_HOURS	number (38,0),
LWOP_CREATE_USER	VARCHAR2(100 BYTE),
LWOP_CREATE_DATE	DATE,
LWOP_UPDATE_USER	VARCHAR2(100 BYTE),
LWOP_UPDATE_DATE	DATE
   ); 

-- need a non unique index on staff_staff_id 

CREATE INDEX lwop_aud_idx
 ON SC_AUDIT_LWOP_AUD(STAFF_STAFF_ID);

-- Grants

grant select, insert, update, delete on DP_SCORECARD.SC_AUDIT_LWOP_AUD to maxdat;

grant select, insert, update, delete on DP_SCORECARD.SC_AUDIT_LWOP_AUD to maxdat_reports;

grant select  on DP_SCORECARD.SC_AUDIT_LWOP_AUD to maxdat_read_only;

/
commit;


