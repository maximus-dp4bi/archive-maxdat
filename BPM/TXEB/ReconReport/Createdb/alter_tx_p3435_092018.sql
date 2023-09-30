alter table maxdat.TX_ETL_P3435_DATA modify (
member_fname                   VARCHAR2(30),
responsible_party_fname        VARCHAR2(30)
);

alter table maxdat.TX_ETL_P3435_DATA add (
   member_phone_type1             VARCHAR2(2),
   member_phone_number1           VARCHAR2(80),
   member_phone_type2             VARCHAR2(2),
   member_phone_number2           VARCHAR2(80),
   member_phone_type3             VARCHAR2(2),
   member_phone_number3           VARCHAR2(80),
   member_e_mail                  VARCHAR2(256),
   med_recert_pkt_rcvd_date       DATE,
   created_by                     VARCHAR2(80),
   create_ts                      DATE,
   updated_by                     VARCHAR2(80),
   update_ts                      DATE,
   med_suppressed_ssi             VARCHAR2(1),
   lock_in_provider_num           VARCHAR2(9),
   lock_in_provider_type          VARCHAR2(2),
   lock_in_begin_date             DATE,
   lock_in_end_date               DATE,
   future_med_suppressed_ssi      VARCHAR2(1),
   future_lock_in_provider_num    VARCHAR2(9),
   future_lock_in_provider_type   VARCHAR2(2),
   member_pname                   VARCHAR2(4),
   member_sname                   VARCHAR2(4),
   responsible_party_pname        VARCHAR2(4),
   responsible_party_sname        VARCHAR2(4),
   guardian_pname                 VARCHAR2(4),
   guardian_sname                 VARCHAR2(4),
   guardian_lname                 VARCHAR2(30),
   guardian_fname                 VARCHAR2(30),
   guardian_mi                    VARCHAR2(25)
);
