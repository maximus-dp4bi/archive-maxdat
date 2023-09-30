DECLARE 
  v_seq NUMBER;
BEGIN 
FOR i in (SELECT * FROM F_COMPLAINT_BY_DATE f
where CMPL_BI_ID in(
1787501)
and fcmplbd_id = 201813 )
LOOP
  v_seq := NULL;
  
  SELECT SEQ_FCMPLBD_ID.nextval INTO v_seq FROM dual;
  UPDATE F_COMPLAINT_BY_DATE
  SET fcmplbd_id = v_seq
  WHERE fcmplbd_id = i.fcmplbd_id;
END LOOP;
COMMIT;
END;


