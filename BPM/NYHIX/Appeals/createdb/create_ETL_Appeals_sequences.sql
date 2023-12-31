DROP SEQUENCE SEQ_NEPA_ID;

CREATE SEQUENCE SEQ_NEPA_ID
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;


CREATE OR REPLACE PUBLIC SYNONYM SEQ_NEPA_ID FOR SEQ_NEPA_ID;

DROP SEQUENCE SEQ_NEAR_ID;

CREATE SEQUENCE SEQ_NEAR_ID
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;


CREATE OR REPLACE PUBLIC SYNONYM SEQ_NEAR_ID FOR SEQ_NEAR_ID;

declare  c int;
begin
   select count(*) into c from user_objects where object_type = 'SEQUENCE' and object_name ='SEQ_NEPAS_ID';
   if c = 1 then
      execute immediate 'DROP SEQUENCE SEQ_NEPAS_ID';
   end if;
end;
/

CREATE SEQUENCE SEQ_NEPAS_ID -- FOR NYHBE_ETL_APPEALS_SCHEDULER
    START WITH 10
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    NOCYCLE
    NOORDER
    CACHE 20;
