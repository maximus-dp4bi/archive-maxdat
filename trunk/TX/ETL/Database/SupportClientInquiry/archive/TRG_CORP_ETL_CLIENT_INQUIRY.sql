

-- Triggers
CREATE OR REPLACE TRIGGER trg_biu_etl_client_inquiry
BEFORE INSERT OR UPDATE ON corp_etl_client_inquiry
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF :n.ceci_id IS NULL
    THEN :n.ceci_id := seq_ceci_id.NEXTVAL;
    END IF;
    --
    :n.stg_extract_date  := SYSDATE;
  END IF;
  :n.stg_last_update_date := SYSDATE;
  --
  IF (:n.supp_contact_type_cd IS NULL AND :n.contact_type IS NOT NULL) OR
     (:n.supp_contact_type_cd IS NOT NULL AND :n.contact_type IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20111, 'Value and supplementary do not match: SUPP_CONTACT_TYPE_CD/CONTACT_TYPE');
  END IF;
  IF (:n.supp_contact_group_cd IS NULL AND :n.contact_group IS NOT NULL) OR
     (:n.supp_contact_group_cd IS NOT NULL AND :n.contact_group IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20112, 'Value and supplementary do not match: SUPP_CONTACT_GROUP_CD/CONTACT_GROUP');
  END IF;
  IF (:n.supp_language_cd IS NULL AND :n.language IS NOT NULL) OR
     (:n.supp_language_cd IS NOT NULL AND :n.language IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20113, 'Value and supplementary do not match: SUPP_LANGUAGE_CD/LANGUAGE');
  END IF;
  IF (:n.supp_created_by IS NULL AND :n.created_by IS NOT NULL) OR
     (:n.supp_created_by IS NOT NULL AND :n.created_by IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20114, 'Value and supplementary do not match: SUPP_CREATED_BY/CREATED_BY');
  END IF;
  IF (:n.supp_update_by IS NULL AND :n.last_update_by_name IS NOT NULL) OR
     (:n.supp_update_by IS NOT NULL AND :n.last_update_by_name IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20115, 'Value and supplementary do not match: SUPP_UPDATE_BY/LAST_UPDATE_BY_NAME');
  END IF;
END trg_biu_etl_client_inquiry;
/

CREATE OR REPLACE TRIGGER trg_biu_etl_clnt_inqry_wip
BEFORE INSERT OR UPDATE ON corp_etl_clnt_inqry_wip
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
BEGIN
  IF (:n.supp_contact_type_cd IS NULL AND :n.contact_type IS NOT NULL) OR
     (:n.supp_contact_type_cd IS NOT NULL AND :n.contact_type IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20101, 'Value and supplementary do not match: SUPP_CONTACT_TYPE_CD/CONTACT_TYPE');
  END IF;
  IF (:n.supp_contact_group_cd IS NULL AND :n.contact_group IS NOT NULL) OR
     (:n.supp_contact_group_cd IS NOT NULL AND :n.contact_group IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20102, 'Value and supplementary do not match: SUPP_CONTACT_GROUP_CD/CONTACT_GROUP');
  END IF;
  IF (:n.supp_language_cd IS NULL AND :n.language IS NOT NULL) OR
     (:n.supp_language_cd IS NOT NULL AND :n.language IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20103, 'Value and supplementary do not match: SUPP_LANGUAGE_CD/LANGUAGE');
  END IF;
  IF (:n.supp_created_by IS NULL AND :n.created_by IS NOT NULL) OR
     (:n.supp_created_by IS NOT NULL AND :n.created_by IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20104, 'Value and supplementary do not match: SUPP_CREATED_BY/CREATED_BY');
  END IF;
  IF (:n.supp_update_by IS NULL AND :n.last_update_by_name IS NOT NULL) OR
     (:n.supp_update_by IS NOT NULL AND :n.last_update_by_name IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20105, 'Value and supplementary do not match: SUPP_UPDATE_BY/LAST_UPDATE_BY_NAME');
  END IF;
END trg_biu_etl_clnt_inqry_wip;
/


CREATE OR REPLACE TRIGGER trg_biu_etl_clnt_inqry_eve_wip
BEFORE INSERT OR UPDATE ON corp_etl_clnt_inqry_event_wip
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
BEGIN
  IF (:n.supp_event_created_by IS NULL AND :n.event_created_by IS NOT NULL) OR
     (:n.supp_event_created_by IS NOT NULL AND :n.event_created_by IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20106, 'Value and supplementary do not match: SUPP_EVENT_CREATED_BY/EVENT_CREATED_BY');
  END IF;
END trg_biu_etl_clnt_inqry_eve_wip;
/


CREATE OR REPLACE TRIGGER trg_biu_etl_client_inqry_event
BEFORE INSERT OR UPDATE ON corp_etl_client_inquiry_event
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF :n.cecie_id IS NULL
    THEN :n.cecie_id := seq_cecie_id.NEXTVAL;
    END IF;
    --
    :n.stg_extract_date := SYSDATE;
  END IF;
  :n.stg_last_update_date := SYSDATE;
  --
  IF (:n.supp_event_created_by IS NULL AND :n.event_created_by IS NOT NULL) OR
     (:n.supp_event_created_by IS NOT NULL AND :n.event_created_by IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20116, 'Value and supplementary do not match: SUPP_EVENT_CREATED_BY/EVENT_CREATED_BY');
  END IF;
END trg_biu_etl_client_inqry_event;
/



