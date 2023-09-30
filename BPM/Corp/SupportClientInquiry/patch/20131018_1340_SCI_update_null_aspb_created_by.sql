-- Support Client Inquiry update script for null ASPB_HANDLE_CONTACT and CREATED_BY.

DECLARE
  v_cnt INTEGER := 1;
BEGIN
  FOR a IN (SELECT ceci_id, instance_status, contact_record_id, i.aspb_handle_contact, supp_worker_id, i.supp_worker_name ,i.supp_created_by,i.created_by
                 , COALESCE(first_name ||' ' || last_name, supp_worker_id) staff_fullname
              FROM corp_etl_client_inquiry i
                   LEFT OUTER JOIN staff_lkup s ON staff_id = supp_worker_id
             WHERE i.aspb_handle_contact IS NULL OR created_by IS NULL)
  LOOP
    UPDATE corp_etl_client_inquiry
       SET aspb_handle_contact = a.staff_fullname
         , created_by          = a.staff_fullname
     WHERE ceci_id = a.ceci_id;
    --
    IF v_cnt = 500
    THEN COMMIT; v_cnt := 1;
    ELSE v_cnt := v_cnt + 1;
    END IF;
  END LOOP;
  COMMIT;
END;
/
