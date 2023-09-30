/* CREATE OR REPLACE TRIGGER MAXDAT."BUIR_PORTAL_PROVIDERS"
 BEFORE INSERT OR UPDATE
 ON hco_d_portal_providers
 FOR EACH ROW
BEGIN
  IF INSERTING THEN
    :NEW.create_by := user;
    :NEW.create_date := sysdate;
  END IF;
  :NEW.last_update_by := user;
  :NEW.last_update_date := sysdate;
END BUIR_PORTAL_PROVIDERS;
/
 */

CREATE OR REPLACE TRIGGER MAXDAT."BUIR_PORTAL_SEARCHES_BY_DATE"
 BEFORE INSERT OR UPDATE
 ON hco_f_portal_searches_by_date
 FOR EACH ROW
BEGIN
  IF INSERTING THEN
    :NEW.stg_create_by := user;
    :NEW.stg_create_date := sysdate;
  END IF;
  :NEW.stg_last_update_by := user;
  :NEW.stg_last_update_date := sysdate;
END BUIR_PORTAL_SEARCHES_BY_DATE;
/


