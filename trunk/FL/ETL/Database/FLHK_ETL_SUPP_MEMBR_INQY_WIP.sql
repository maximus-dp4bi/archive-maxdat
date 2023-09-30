create table FLHK_ETL_SUPP_MEMBR_INQY_WIP
(
FEMSI_ID	NUMBER NOT NULL,
CONTACT_ID	NUMBER NOT NULL,
CONTACT_SOURCE	VARCHAR2(100 BYTE) NOT NULL,
COMPLETE_DATE	DATE,
CALL_START_TIME	VARCHAR2(20 BYTE),
CALL_END_TIME	VARCHAR2(20 BYTE),
CONTACT_NAME	VARCHAR2(100 BYTE),
CALL_HANDLE_TIME	NUMBER,
CALLER_SOURCE	VARCHAR2(100 BYTE),
ACCOUNT_ID	NUMBER,
CONTACT_REASON	VARCHAR2(100 BYTE),
CONTACT_NOTE	VARCHAR2(2000 BYTE) NOT NULL,
CREATED_NAME	VARCHAR2(100 BYTE) NOT NULL,
STAGE_DONE_DATE	DATE,
STG_EXTRACT_DATE	DATE NOT NULL,
STG_LAST_UPDATE_DATE	DATE,
INSTANCE_STATUS	VARCHAR2(10 BYTE) DEFAULT 'ACTIVE' NOT NULL,
INSTANCE_STATUS_DATE	DATE NOT NULL,
CHANNEL	VARCHAR2(80 BYTE),
ACCOUNT_NUMBER	NUMBER,
INSTANCE_CREATE_DATE	DATE NOT NULL,
UPDATED	VARCHAR2(1 BYTE)
);

  --------------------------------------------------------
  --  DDL for Index CONTACT_ID_PK
  --------------------------------------------------------
CREATE UNIQUE INDEX "CONTACT_ID_PK2" ON "FLHK_ETL_SUPP_MEMBR_INQY_WIP"
  (
    "CONTACT_ID"
  )
  ;
  /
  --------------------------------------------------------
  --  Constraints for Table FLHK_ETL_SUPP_MEMBR_INQY
  --------------------------------------------------------
  ALTER TABLE "FLHK_ETL_SUPP_MEMBR_INQY_WIP" ADD CONSTRAINT "CONTACT_ID_PK2" PRIMARY KEY ("CONTACT_ID") ENABLE;
  /