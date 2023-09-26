-- Create table DP_SCORECARD.SC_AUDIT_LWOP

CREATE TABLE DP_SCORECARD.SC_AUDIT_LWOP( 
LWOP_INSTANCE_ID	number (38,0) not null,  
STAFF_STAFF_ID	number (38,0) not null ,		
LWOP_OCCURRENCE_DATE	Date not null,
LWOP_HOURS	number (38,4),
LWOP_CREATE_USER	VARCHAR2(100 BYTE),
LWOP_CREATE_DATE	DATE,
LWOP_UPDATE_USER	VARCHAR2(100 BYTE),
LWOP_UPDATE_DATE	DATE,
CONSTRAINT lwop_pk PRIMARY KEY (LWOP_INSTANCE_ID)
); 



-- Unique index sql

CREATE UNIQUE INDEX lwop_idx
 ON SC_AUDIT_LWOP(STAFF_STAFF_ID,LWOP_OCCURRENCE_DATE);


-- Sequence 


CREATE SEQUENCE lwop_seq
  MINVALUE 1
   MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;


-- BIU Trigger

CREATE OR REPLACE TRIGGER "DP_SCORECARD"."TRG_BIU_SC_AUDIT_LWOP" 
BEFORE INSERT OR UPDATE ON SC_AUDIT_LWOP
FOR EACH ROW
BEGIN
 :new.Lwop_Update_Date := sysdate;

 IF :new.lwop_Update_USER IS NULL
	THEN :new.lwop_Update_USER := USER;
 END IF;

 IF INSERTING THEN
    :new.lwop_instance_ID := DP_SCORECARD.lwop_seq.nextval;
    :new.lwop_Create_Date := sysdate;
    :new.lwop_Create_USER := NVL( :new.lwop_Create_USER, user);
    :new.lwop_Update_Date := sysdate;
    :new.lwop_Update_USER := NVL( :new.lwop_Create_USER, user);
  END IF;
 
end;
/
ALTER TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_LWOP ENABLE;

-- AIU Trigger

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_LWOP
AFTER INSERT OR UPDATE OR DELETE ON SC_AUDIT_LWOP
for each row
BEGIN

IF UPDATING THEN

  BEGIN

  IF :old.STAFF_STAFF_ID        <>  :new.STAFF_STAFF_ID
  OR :old.LWOP_OCCURRENCE_DATE    <>  :new.LWOP_OCCURRENCE_DATE
  OR  :OLD.LWOP_HOURS      <>  :NEW.lwop_hours
  OR :old.lwop_Create_USER    <>  :new.lwop_Create_USER
  OR :old.lwop_Create_Date    <>  :new.lwop_Create_Date
  OR :old.lwop_Update_Date    <>  :new.lwop_Update_Date
  OR :old.lwop_Update_USER    <>  :new.lwop_Update_USER
 
  THEN
    INSERT INTO SC_AUDIT_LWOP_AUD
    (Record_type,
    Record_action,
    Transaction_Date,
LWOP_Instance_ID,
STAFF_STAFF_ID,
LWOP_OCCURRENCE_DATE,
LWOP_HOURS,
LWOP_CREATE_USER,
LWOP_CREATE_DATE,
LWOP_UPDATE_USER,
LWOP_UPDATE_DATE

   )
    VALUES
      ('Update',
       'Delete',
       sysdate,
       :old.LWOP_Instance_ID,
       :old.STAFF_STAFF_ID,
       :old.LWOP_OCCURRENCE_DATE,
       :old.LWOP_HOURS,
       :old.LWOP_CREATE_USER,
       :old.LWOP_CREATE_DATE,
       :old.LWOP_UPDATE_USER,
       SYSDATE

      );

    INSERT INTO SC_AUDIT_LWOP_AUD
      (
Record_type,
    Record_action,
    Transaction_Date,
LWOP_Instance_ID,
STAFF_STAFF_ID,
LWOP_OCCURRENCE_DATE,
LWOP_HOURS,
LWOP_CREATE_USER,
LWOP_CREATE_DATE,
LWOP_UPDATE_USER,
LWOP_UPDATE_DATE
    )
     VALUES
      ('Update',
       'Insert',
       sysdate,
       :new.LWOP_Instance_ID,
       :new.STAFF_STAFF_ID,
       :new.LWOP_OCCURRENCE_DATE,
       :new.LWOP_HOURS,
       :new.LWOP_CREATE_USER,
       :new.LWOP_CREATE_DATE,
       NVL(:new.LWOP_Update_USER,USER),
       SYSDATE
      );

  END IF;

  END;

END IF;

IF INSERTING THEN
    INSERT INTO SC_AUDIT_LWOP_AUD
      (
Record_type,
    Record_action,
    Transaction_Date,
LWOP_Instance_ID,
STAFF_STAFF_ID,
LWOP_OCCURRENCE_DATE,
LWOP_HOURS,
LWOP_CREATE_USER,
LWOP_CREATE_DATE,
LWOP_UPDATE_USER,
LWOP_UPDATE_DATE
    )
     VALUES
      ('Insert',
      'Insert',
      sysdate,
       :new.LWOP_Instance_ID,
       :new.STAFF_STAFF_ID,
       :new.LWOP_OCCURRENCE_DATE,
       :new.LWOP_HOURS,
       :new.LWOP_CREATE_USER,
       :new.LWOP_CREATE_DATE,
       NVL(:new.LWOP_Update_USER,USER),
       :new.LWOP_UPDATE_DATE
    );

END IF;

IF DELETING THEN
        INSERT INTO SC_AUDIT_LWOP_AUD
        (
Record_type,
    Record_action,
    Transaction_Date,
LWOP_Instance_ID,
STAFF_STAFF_ID,
LWOP_OCCURRENCE_DATE,
LWOP_HOURS,
LWOP_CREATE_USER,
LWOP_CREATE_DATE,
LWOP_UPDATE_USER,
LWOP_UPDATE_DATE
    )
        VALUES
            ('Delete',
            'Delete',
            sysdate,
       :OLD.LWOP_Instance_ID,
       :old.STAFF_STAFF_ID,
       :old.LWOP_OCCURRENCE_DATE,
       :old.LWOP_HOURS,
       :old.LWOP_CREATE_USER,
       :old.LWOP_CREATE_DATE,
       :old.LWOP_UPDATE_USER,
       sysdate
            
    );
    END IF;

END;


/
ALTER TRIGGER "DP_SCORECARD"."TRG_AIU_SC_AUDIT_LWOP" ENABLE;

-- Grants 

grant select, insert, update, delete on DP_SCORECARD.SC_AUDIT_LWOP to maxdat;

grant select, insert, update, delete on DP_SCORECARD.SC_AUDIT_LWOP to maxdat_reports;

grant select  on DP_SCORECARD.SC_AUDIT_LWOP to maxdat_read_only;

--grant select  on DP_SCORECARD.SC_AUDIT_LWOP to dp_scorecard_read_only;

/

commit;
