CREATE SEQUENCE  "HCO_SEQ_VM_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "HCO_SEQ_VM_ID" TO "MAXDAT_READ_ONLY";

DROP TABLE HCO_F_VOICEMAILS;

CREATE TABLE HCO_F_VOICEMAILS
( VM_ID NUMBER(10)
, D_DATE DATE
, VOICEMAILS_RECEIVED NUMBER(4)
, VOICEMAILS_RETURNED_WITHIN_SLA  NUMBER(4)
, VOICEMAILS_SAME_DAY_RECEIVED NUMBER(4)
, VOICEMAILS_SAME_DAY_RETURNED_WITHIN_SLA NUMBER(4)
, VOICEMAILS_NEXT_DAY_RECEIVED NUMBER(4)
, VOICEMAILS_NEXT_DAY_RETURNED_WITHIN_SLA NUMBER(4)
, VOICEMAILS_NON_BUS_RECEIVED NUMBER(4)
, VOICEMAILS_NON_BUS_RETURNED_WITHIN_SLA NUMBER(4)
, CREATED_BY    VARCHAR2(18)
, DATE_CREATED  DATE
, DATE_UPDATED  DATE
, UPDATED_BY    VARCHAR2(18)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  ); 

CREATE OR REPLACE TRIGGER "BUIR_VOICEMAILS"
 BEFORE INSERT OR UPDATE
 ON HCO_F_VOICEMAILS
 FOR EACH ROW
DECLARE
    v_seq_id     HCO_F_VOICEMAILS.VM_ID%TYPE;
BEGIN

  :NEW.date_updated := sysdate;

  IF INSERTING THEN

      IF :NEW.VM_ID IS NULL THEN
        SElECT HCO_SEQ_VM_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.VM_ID       := v_seq_id;
      END IF;

    IF :NEW.created_by IS NULL THEN  
       :NEW.created_by := user;
       :NEW.updated_by := user;
    END IF;
       
    :NEW.date_created := sysdate;

  END IF;

END BUIR_VOICEMAILS;
/  

grant select, insert, update on HCO_F_VOICEMAILS to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on HCO_F_VOICEMAILS to MAXDAT_OLTP_SIUD;
grant select on HCO_F_VOICEMAILS to MAXDAT_READ_ONLY;
grant select , insert, update ON HCO_F_VOICEMAILS TO MAXDAT_MSTR_TRX_RPT; 

--select * from HCO_F_VOICEMAILS


--View

  CREATE OR REPLACE VIEW HCO_F_VOICEMAILS_BY_DAY_SV  AS 
  SELECT
  VM_ID
, D_DATE
, VOICEMAILS_SAME_DAY_RECEIVED
, VOICEMAILS_SAME_DAY_RETURNED_WITHIN_SLA
, VOICEMAILS_NEXT_DAY_RECEIVED
, VOICEMAILS_NEXT_DAY_RETURNED_WITHIN_SLA
, VOICEMAILS_NON_BUS_RECEIVED
, VOICEMAILS_NON_BUS_RETURNED_WITHIN_SLA
, (VOICEMAILS_SAME_DAY_RECEIVED + VOICEMAILS_NEXT_DAY_RECEIVED + VOICEMAILS_NON_BUS_RECEIVED) VOICEMAILS_RECEIVED
, (VOICEMAILS_SAME_DAY_RETURNED_WITHIN_SLA + VOICEMAILS_NEXT_DAY_RETURNED_WITHIN_SLA + VOICEMAILS_NON_BUS_RETURNED_WITHIN_SLA) VOICEMAILS_RETURNED_WITHIN_SLA
, (VOICEMAILS_SAME_DAY_RECEIVED - VOICEMAILS_SAME_DAY_RETURNED_WITHIN_SLA) VOICEMAILS_SAME_DAY_RETURNED_BEYOND_SLA
, (VOICEMAILS_NEXT_DAY_RECEIVED - VOICEMAILS_NEXT_DAY_RETURNED_WITHIN_SLA) VOICEMAILS_NEXT_DAY_RETURNED_BEYOND_SLA         
, (VOICEMAILS_NON_BUS_RECEIVED - VOICEMAILS_NON_BUS_RETURNED_WITHIN_SLA)  VOICEMAILS_NON_BUS_RETURNED_BEYOND_SLA
, ((VOICEMAILS_SAME_DAY_RECEIVED - VOICEMAILS_SAME_DAY_RETURNED_WITHIN_SLA)+(VOICEMAILS_NEXT_DAY_RECEIVED - VOICEMAILS_NEXT_DAY_RETURNED_WITHIN_SLA)+(VOICEMAILS_NON_BUS_RECEIVED - VOICEMAILS_NON_BUS_RETURNED_WITHIN_SLA)) VOICEMAILS_RETURNED_BEYOND_SLA
,CREATED_BY
,DATE_CREATED
,DATE_UPDATED
,UPDATED_BY
FROM HCO_F_VOICEMAILS
With read only;

GRANT SELECT ON "HCO_F_VOICEMAILS_BY_DAY_SV" TO "MAXDAT_READ_ONLY";

--Procedures

create or replace Procedure ts_voicemails_insert
(
in_date IN DATE,
in_vm_same_day_received           IN NUMBER,
in_vm_same_day_returned_within_sla          IN NUMBER,
in_vm_next_day_received             IN NUMBER,
in_vm_next_day_returned_within_sla            IN NUMBER,
in_vm_non_bus_received              IN NUMBER,
in_vm_non_bus_returned_within_sla            IN NUMBER,
in_staff_id IN VARCHAR2
)
AS
BEGIN
    IF  in_date is null or trunc(in_date) > trunc(sysdate) or in_staff_id is null THEN
        /*do nothing*/
        null;
    ELSE
        INSERT INTO hco_f_voicemails 
        (
            d_date,
            voicemails_same_day_received,
            voicemails_same_day_returned_within_sla,
            voicemails_next_day_received,
            voicemails_next_day_returned_within_sla,
            voicemails_non_bus_received,
            voicemails_non_bus_returned_within_sla,
            created_by,
            updated_by
        ) 
        SELECT 
            in_date as d_date,
            in_vm_same_day_received as voicemails_same_day_received,
            in_vm_same_day_returned_within_sla as voicemails_same_day_returned_within_sla,
            in_vm_next_day_received as voicemails_next_day_received,
            in_vm_next_day_returned_within_sla as voicemails_next_day_returned_within_sla,
            in_vm_non_bus_received as voicemails_non_bus_received,
            in_vm_non_bus_returned_within_sla as voicemails_non_bus_returned_within_sla,
            IN_STAFF_ID as created_by,
            IN_STAFF_ID as updated_by
        FROM DUAL 
        WHERE trunc(in_date) not in (select distinct trunc(d_date) from hco_f_voicemails_by_day_sv);
         
        COMMIT;
    END IF;
    NULL;
END;
/

create or replace Procedure ts_voicemails_update
(
in_vm_id IN NUMBER,
in_vm_same_day_received           IN NUMBER,
in_vm_same_day_returned_within_sla          IN NUMBER,
in_vm_next_day_received             IN NUMBER,
in_vm_next_day_returned_within_sla            IN NUMBER,
in_vm_non_bus_received              IN NUMBER,
in_vm_non_bus_returned_within_sla            IN NUMBER,
in_staff_id IN VARCHAR2
)
AS
BEGIN
    IF  in_vm_id is null or in_staff_id is null 
        or (in_vm_same_day_received is null AND
            in_vm_same_day_returned_within_sla is null AND
            in_vm_next_day_received is null AND
            in_vm_next_day_returned_within_sla is null AND
            in_vm_non_bus_received is null AND
            in_vm_non_bus_returned_within_sla is null)
        THEN
        /*do nothing*/
        null;
    ELSE
        UPDATE hco_f_voicemails SET
            voicemails_same_day_received=CASE WHEN in_vm_same_day_received IS NULL THEN voicemails_same_day_received ELSE in_vm_same_day_received END,
            voicemails_same_day_returned_within_sla=CASE WHEN in_vm_same_day_returned_within_sla IS NULL THEN voicemails_same_day_returned_within_sla ELSE in_vm_same_day_returned_within_sla END,
            voicemails_next_day_received=CASE WHEN in_vm_next_day_received IS NULL THEN voicemails_next_day_received ELSE in_vm_next_day_received END,
            voicemails_next_day_returned_within_sla=CASE WHEN in_vm_next_day_returned_within_sla IS NULL THEN voicemails_next_day_returned_within_sla ELSE in_vm_next_day_returned_within_sla END,
            voicemails_non_bus_received=CASE WHEN in_vm_non_bus_received IS NULL THEN voicemails_non_bus_received ELSE in_vm_non_bus_received END,
            voicemails_non_bus_returned_within_sla=CASE WHEN in_vm_non_bus_returned_within_sla IS NULL THEN voicemails_non_bus_returned_within_sla ELSE in_vm_non_bus_returned_within_sla END,
            date_updated=SYSDATE,
            updated_by=IN_STAFF_ID
        WHERE vm_id=in_vm_id;
        COMMIT;
    END IF;
    NULL;
END;
/

--Grants

GRANT execute ON ts_voicemails_insert TO MAXDAT_MSTR_TRX_RPT;  
GRANT execute ON ts_voicemails_update TO MAXDAT_MSTR_TRX_RPT;  



