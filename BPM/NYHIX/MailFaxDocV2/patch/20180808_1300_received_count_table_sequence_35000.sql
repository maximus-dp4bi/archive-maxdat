-- NYHIX-35000
-- Drop Sequence
declare  c int;
begin
    select count(*) into c from user_sequences where sequence_name ='SEQ_F_RECEIVED_COUNTS';
    if c = 1 then
       execute immediate 'drop sequence SEQ_F_RECEIVED_COUNTS';
    end if;
end;
/

Create sequence MAXDAT.SEQ_F_RECEIVED_COUNTS
minvalue 1
maxvalue 9999999999999999999
start with 1
increment by 1
cache 20
cycle;
