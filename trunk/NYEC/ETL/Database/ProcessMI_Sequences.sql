--------------------------------------------------------------------------
--Create Sequences.
--------------------------------------------------------------------------
drop sequence seq_pms_id;
CREATE SEQUENCE seq_pms_id
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 20;