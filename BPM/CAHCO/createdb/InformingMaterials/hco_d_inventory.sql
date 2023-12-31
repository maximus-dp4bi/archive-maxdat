CREATE SEQUENCE  "HCO_SEQ_ITEM_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 582 CACHE 5 NOORDER  NOCYCLE ;
CREATE SEQUENCE  "HCO_SEQ_ITEMCATEGORY_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 582 CACHE 5 NOORDER  NOCYCLE ;
CREATE SEQUENCE  "HCO_SEQ_ITEMINVENTORY_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 582 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "HCO_SEQ_ITEM_ID" TO "MAXDAT_READ_ONLY";
GRANT SELECT ON "HCO_SEQ_ITEMCATEGORY_ID" TO "MAXDAT_READ_ONLY";
GRANT SELECT ON "HCO_SEQ_ITEMINVENTORY_ID" TO "MAXDAT_READ_ONLY";


CREATE TABLE HCO_D_ITEM(
DP_ITEM_ID NUMBER(10),
ITEM_ID NUMBER(10),
ITEM_CODE VARCHAR2(50),
ITEM_DESCRIPTION VARCHAR2(50),
ITEM_PAGE_COUNT NUMBER(10),
UNIT_OF_MEASURE_ID VARCHAR2(10),
ITEM_CATEGORY_ID NUMBER(10),
ITEM_SUBCATEGORY_ID NUMBER(10),
ITEM_GROUP_ID NUMBER(10),
IS_BLOCKED VARCHAR2(1),
OLD_ITEM_CODE VARCHAR2(30),
DATE_RECORD_CREATED DATE,
RECORD_CREATED_BY VARCHAR2(50),
DATE_RECORD_UPDATED DATE,
RECORD_UPDATED_BY VARCHAR2(50) ) TABLESPACE MAXDAT_DATA;

ALTER TABLE "HCO_D_ITEM" ADD CONSTRAINT "ITEM_ITEMID_PK" PRIMARY KEY ("DP_ITEM_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
CREATE UNIQUE INDEX HCODITEM_UK ON HCO_D_ITEM(ITEM_ID) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODITEM_IDX01 ON HCO_D_ITEM(ITEM_CATEGORY_ID) TABLESPACE MAXDAT_INDX; 

GRANT SELECT ON "HCO_D_ITEM" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE TRIGGER "BIR_HCO_D_ITEM" 
 BEFORE INSERT
 ON hco_d_item
 FOR EACH ROW
DECLARE
    v_seq_id     HCO_D_ITEM.dp_item_id%TYPE;
BEGIN
  IF :NEW.dp_item_id IS NULL THEN
      SElECT HCO_SEQ_ITEM_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_item_id   := v_seq_id;
  END IF;

END BIR_HCO_D_ITEM;
/
ALTER TRIGGER "BIR_HCO_D_ITEM" ENABLE;
/

CREATE TABLE HCO_D_ITEM_CATEGORY
(DP_ITEM_CATEGORY_ID NUMBER(10),
ITEM_CATEGORY_ID NUMBER(10),
ITEM_CATEGORY_DESCRIPTION VARCHAR2(100),
ITEM_CATEGORY_CODE VARCHAR2(50) ,
ITEM_SUBCATEGORY_ID NUMBER(10),
ITEM_SUBCATEGORY_DESCRIPTION VARCHAR2(100)
) TABLESPACE MAXDAT_DATA;

ALTER TABLE "HCO_D_ITEM_CATEGORY" ADD CONSTRAINT "ITEM_ITEMCATID_PK" PRIMARY KEY ("DP_ITEM_CATEGORY_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
CREATE INDEX HCODITEMCAT_01 ON HCO_D_ITEM_CATEGORY(ITEM_CATEGORY_ID) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODITEMCAT_02 ON HCO_D_ITEM_CATEGORY(ITEM_SUBCATEGORY_ID) TABLESPACE MAXDAT_INDX; 

GRANT SELECT ON "HCO_D_ITEM_CATEGORY" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE TRIGGER "BIR_HCO_D_ITEM_CATEGORY" 
 BEFORE INSERT
 ON hco_d_item_category
 FOR EACH ROW
DECLARE
    v_seq_id     HCO_D_ITEM_CATEGORY.dp_item_category_id%TYPE;
BEGIN
  IF :NEW.dp_item_category_id IS NULL THEN
      SElECT HCO_SEQ_ITEMCATEGORY_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_item_category_id   := v_seq_id;
  END IF;

END BIR_HCO_D_ITEM_CATEGORY;
/
ALTER TRIGGER "BIR_HCO_D_ITEM_CATEGORY" ENABLE;
/


CREATE TABLE HCO_D_ITEM_INVENTORY(
DP_ITEM_INVENTORY_ID NUMBER(10),
ITEM_ID NUMBER(10),
QUANTITY_ON_HAND NUMBER(10),
DAILY_USAGE NUMBER(38,20),
MONTHLY_USAGE NUMBER(38,20),
DATE_RECORD_CREATED DATE,
DATE_RECORD_UPDATED DATE,
DATE_CREATED DATE,
CREATED_BY VARCHAR2(50),
DATE_UPDATED DATE,
UPDATED_BY VARCHAR2(50)
) TABLESPACE MAXDAT_DATA;

ALTER TABLE "HCO_D_ITEM_INVENTORY" ADD CONSTRAINT "ITEM_ITEMINV_PK" PRIMARY KEY ("DP_ITEM_INVENTORY_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
CREATE INDEX HCODITEMINV_01 ON HCO_D_ITEM_INVENTORY(ITEM_ID) TABLESPACE MAXDAT_INDX; 
CREATE INDEX HCODITEMINV_FN02 ON HCO_D_ITEM_INVENTORY(TRUNC(DATE_RECORD_CREATED)) TABLESPACE MAXDAT_INDX; 

GRANT SELECT ON "HCO_D_ITEM_INVENTORY" TO "MAXDAT_READ_ONLY";

CREATE OR REPLACE TRIGGER "BUIR_ITEM_INVENTORY" 
 BEFORE INSERT OR UPDATE
 ON hco_d_item_inventory
 FOR EACH ROW
DECLARE
    v_seq_id     HCO_D_ITEM_INVENTORY.dp_item_inventory_id%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.dp_item_inventory_id IS NULL THEN
      SElECT HCO_SEQ_ITEMINVENTORY_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;

      :NEW.dp_item_inventory_id       := v_seq_id;
    END IF;
    :NEW.date_created := sysdate;
    :NEW.created_by := user;
  END IF;
  
  :NEW.date_updated := sysdate;
  :NEW.updated_by := user;
END BUIR_ITEM_INVENTORY;
/
ALTER TRIGGER "BUIR_ITEM_INVENTORY" ENABLE;
/


CREATE OR REPLACE VIEW hco_d_inventory_sv
AS
SELECT i.item_id
       ,i.item_code
       ,i.item_description
       ,i.unit_of_measure_id
       ,i.item_category_id
       ,ic.item_category_description
       ,ic.item_category_code
       ,ic.item_subcategory_id
       ,ic.item_subcategory_description
       ,ic.item_subcategory_id item_subcategory_code
       ,i.item_group_id
       ,i.is_blocked
       ,i.old_item_code
       ,i.date_record_created
       ,i.record_created_by
       ,i.item_page_count
FROM hco_d_item i
 JOIN hco_d_item_category ic ON i.item_category_id = ic.item_category_id;

GRANT SELECT ON "HCO_D_INVENTORY_SV" TO "MAXDAT_READ_ONLY";

