ALTER TABLE NYHBE_PROCESS_APPEALS_WIP_BPM
RENAME COLUMN INCIDENT_DESCRIPTION TO INCIDENT_DESC;

ALTER TABLE NYHBE_PROCESS_APPEALS_WIP_BPM
RENAME COLUMN RESOLUTION_DESCRIPTION TO RESOLUTION_DESC;

ALTER TABLE NYHBE_PROCESS_APPEALS_WIP_BPM
ADD(INCIDENT_DESCRIPTION VARCHAR2(4000),  
       RESOLUTION_DESCRIPTION VARCHAR2(4000));

ALTER TABLE NYHBE_PROCESS_APPEALS_WIP_BPM
DROP (incident_desc, resolution_desc);


ALTER TABLE NYHBE_PROCESS_APPEALS_OLTP
RENAME COLUMN INCIDENT_DESCRIPTION TO INCIDENT_DESC;

ALTER TABLE NYHBE_PROCESS_APPEALS_OLTP
RENAME COLUMN RESOLUTION_DESCRIPTION TO RESOLUTION_DESC;

ALTER TABLE NYHBE_PROCESS_APPEALS_OLTP
ADD(INCIDENT_DESCRIPTION VARCHAR2(4000),  
       RESOLUTION_DESCRIPTION VARCHAR2(4000));

ALTER TABLE NYHBE_PROCESS_APPEALS_OLTP
DROP (incident_desc, resolution_desc);


ALTER TABLE NYHBE_ETL_PROCESS_APPEALS
RENAME COLUMN INCIDENT_DESCRIPTION TO INCIDENT_DESC;

ALTER TABLE NYHBE_ETL_PROCESS_APPEALS
RENAME COLUMN RESOLUTION_DESCRIPTION TO RESOLUTION_DESC;

ALTER TABLE NYHBE_ETL_PROCESS_APPEALS
ADD(INCIDENT_DESCRIPTION VARCHAR2(4000),  
       RESOLUTION_DESCRIPTION VARCHAR2(4000));

ALTER TABLE NYHBE_ETL_PROCESS_APPEALS
DROP (incident_desc, resolution_desc);
