CREATE SEQUENCE  "HCO_SEQ_SHIPMENT_ORDER_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 582 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "HCO_SEQ_SHIPMENT_ORDER_ID" TO "MAXDAT_READ_ONLY";

CREATE TABLE HCO_D_SHIPMENT_ORDER (
DP_SHIPMENT_ORDER_ID NUMBER(10),
SHIPMENT_ID NUMBER(10),
SHIPMENT_DETAIL_ID NUMBER(10),
ORDER_ID NUMBER(10),
ORDER_DETAIL_ID NUMBER(10),
ENTER_DATE DATE,
SHIP_START_DATE DATE,
SHIP_BY_DATE DATE,
SCHEDULED_POST_DATE DATE,
POST_DATE DATE,
PROCESS_NOTE VARCHAR2(512),
ORDER_FILE VARCHAR2(50),
RECEIVE_DATE DATE,
SHIP_DATE DATE,
MODIFIED_DATE DATE,
MODIFY_BY_ID NUMBER(10),
ENTER_BY_ID NUMBER(10),
ACTUAL_ID NUMBER(10),
VENDOR_ID NUMBER(10),
MATERIAL_VERSION_HISTORY_ID NUMBER(10),
AMOUNT NUMBER(10),
RECEIVE_BY_ID NUMBER(10),
RECEIVE_AMOUNT NUMBER(10),
DATE_CREATED DATE,
DATE_UPDATED DATE,
CREATED_BY VARCHAR2(50),
UPDATED_BY VARCHAR2(50)) TABLESPACE MAXDAT_DATA;


ALTER TABLE "HCO_D_SHIPMENT_ORDER" ADD CONSTRAINT "SO_SHIPORDER_PK" PRIMARY KEY ("DP_SHIPMENT_ORDER_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
CREATE INDEX HCODSHIPORDER_IDX01 ON HCO_D_SHIPMENT_ORDER(ORDER_ID) TABLESPACE "MAXDAT_INDX";
CREATE INDEX HCODSHIPORDER_IDX02 ON HCO_D_SHIPMENT_ORDER(ORDER_DETAIL_ID) TABLESPACE "MAXDAT_INDX";
CREATE INDEX HCODSHIPORDER_IDX03 ON HCO_D_SHIPMENT_ORDER(SHIPMENT_ID) TABLESPACE "MAXDAT_INDX";
CREATE INDEX HCODSHIPORDER_IDX04 ON HCO_D_SHIPMENT_ORDER(SHIPMENT_DETAIL_ID) TABLESPACE "MAXDAT_INDX";

GRANT SELECT ON "HCO_D_SHIPMENT_ORDER" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE TRIGGER "BUIR_SHIPMENT_ORDER" 
 BEFORE INSERT OR UPDATE
 ON hco_d_shipment_order
 FOR EACH ROW
DECLARE
    v_seq_id     HCO_D_SHIPMENT_ORDER.dp_shipment_order_id%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.dp_shipment_order_id IS NULL THEN
      SElECT HCO_SEQ_SHIPMENT_ORDER_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_shipment_order_id       := v_seq_id;
    END IF;
    :NEW.date_created := sysdate;
    :NEW.created_by := user;
  END IF;
  
  :NEW.date_updated := sysdate;
  :NEW.updated_by := user;
END BUIR_SHIPMENT_ORDER;
/
ALTER TRIGGER "BUIR_SHIPMENT_ORDER" ENABLE;
/
