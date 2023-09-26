-- NYHIX-35000 / NYHIX-46259
-- Drop semantic view
declare  c int;
begin
    select count(*) into c from user_views where view_name ='F_MFD_RECEIVED_COUNTS_SV';
    if c = 1 then
       execute immediate 'drop view MAXDAT.F_MFD_RECEIVED_COUNTS_SV cascade constraints';
    end if;
end;
/

-- Drop trigger
declare  c int;
begin
    select count(*) into c from user_triggers where trigger_name = 'F_MFD_RECEIVED_COUNTS';
    if c = 1 then
       execute immediate 'drop trigger MAXDAT.F_MFD_RECEIVED_COUNTS';
    end if;
end;
/

-- Drop Sequence
declare  c int;
begin
    select count(*) into c from user_sequences where sequence_name ='SEQ_F_RECEIVED_COUNTS';
    if c = 1 then
       execute immediate 'drop sequence SEQ_F_RECEIVED_COUNTS';
    end if;
end;
/

-- Drop table
DECLARE c INT;
BEGIN
  SELECT COUNT(*) INTO c FROM user_tables WHERE table_name = 'F_MFD_RECEIVED_COUNTS';
  IF c = 1 THEN
    EXECUTE IMMEDIATE 'drop table F_MFD_RECEIVED_COUNTS cascade constraints';
  END IF;
END;
/
