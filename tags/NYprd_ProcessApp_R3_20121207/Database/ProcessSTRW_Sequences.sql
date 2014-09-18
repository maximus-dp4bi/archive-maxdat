--------------------------------------------------------------------------
--Create Sequences.
--------------------------------------------------------------------------
--drop sequence seq_srs_id;
CREATE SEQUENCE seq_nesr_stg
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE SEQUENCE seq_nesr_stg_tmp
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 20;