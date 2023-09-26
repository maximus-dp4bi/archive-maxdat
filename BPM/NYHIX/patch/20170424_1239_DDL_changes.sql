--- NYHIX-30433  add preferred language 
alter session set current_schema = MAXDAT;
ALTER TABLE D_APPEALS_CURRENT                 ADD (PREF_LANGUAGE  varchar2(256));
ALTER TABLE D_IDR_CURRENT                    ADD (PREF_LANGUAGE  varchar2(256));
ALTER TABLE D_COMPLAINT_CURRENT              ADD (PREF_LANGUAGE  varchar2(256));