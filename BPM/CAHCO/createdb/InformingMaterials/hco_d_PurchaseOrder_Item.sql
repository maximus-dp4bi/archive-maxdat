CREATE SEQUENCE  "HCO_SEQ_PURCHASEORDER_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 582 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "HCO_SEQ_PURCHASEORDER_ID" TO "MAXDAT_READ_ONLY";


CREATE TABLE HCO_D_PURCHASEORDER_ITEM(
DP_PURCHASEORDER_ITEM_ID NUMBER(10),
PURCHASE_ORDER_NUMBER VARCHAR2(20),
ITEM_ID NUMBER(10),
REFERENCE VARCHAR2(30),
DATE_ORDERED DATE,
DATE_REQUESTED_RECEIPT DATE,
DATE_ACTUAL_RECEIPT DATE,
ORDER_STATUS_ID NUMBER(10),
ITEM_PAGE_COUNT NUMBER(10),
UNIT_OF_MEASURE_ID VARCHAR2(10),
QUANTITY NUMBER(10),
UNIT_PRICE NUMBER(38,20),
LINE_NUMBER NUMBER(10),
DATE_CREATED DATE,
CREATED_BY VARCHAR2(50),
DATE_UPDATED DATE,
UPDATED_BY VARCHAR2(50) ) TABLESPACE MAXDAT_DATA;

ALTER TABLE "HCO_D_PURCHASEORDER_ITEM" ADD CONSTRAINT "PO_ITEMID_PK" PRIMARY KEY ("DP_PURCHASEORDER_ITEM_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
CREATE INDEX HCODPOITEM ON HCO_D_PURCHASEORDER_ITEM(ITEM_ID) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODPONUM ON HCO_D_PURCHASEORDER_ITEM(PURCHASE_ORDER_NUMBER) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODPOLINENUM ON HCO_D_PURCHASEORDER_ITEM(LINE_NUMBER) TABLESPACE MAXDAT_INDX; 

GRANT SELECT ON "HCO_D_PURCHASEORDER_ITEM" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE TRIGGER "BIR_HCO_D_PURCHASEORDER_ITEM" 
 BEFORE INSERT
 ON hco_d_PURCHASEORDER_item
 FOR EACH ROW
DECLARE
    v_seq_id     HCO_D_PURCHASEORDER_ITEM.dp_PURCHASEORDER_item_id%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.dp_PURCHASEORDER_item_id IS NULL THEN
        SElECT HCO_SEQ_PURCHASEORDER_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_PURCHASEORDER_item_id   := v_seq_id;
    END IF;
    :NEW.date_created := sysdate;
    :NEW.created_by := user;
  END IF;

  :NEW.date_updated := sysdate;
  :NEW.updated_by := user;

END BIR_HCO_D_PURCHASEORDER_ITEM;
/
ALTER TRIGGER "BIR_HCO_D_PURCHASEORDER_ITEM" ENABLE;
/


