DECLARE 
 v_rec        corp_etl_list_lkup%ROWTYPE;
 --
     PROCEDURE ins_rec IS
        v_cnt INTEGER := 0;
        v_id INTEGER;
     BEGIN
     
           SELECT  COUNT(*) INTO v_cnt
             FROM corp_etl_list_lkup  a
            WHERE a.NAME = v_rec.NAME
              AND a.list_type = v_rec.list_type
              AND a.VALUE     = v_rec.value;
           IF v_cnt = 0 THEN
              SELECT seq_cell_id.nextval INTO v_id FROM dual;
              v_rec.CELL_ID:= v_id;
              INSERT INTO corp_etl_list_lkup VALUES v_rec;
           END IF;
     END;
BEGIN
    v_rec.START_DATE := Trunc(SYSDATE-1);
    v_rec.END_DATE := to_date('07/07/7777','mm/dd/yyyy');
    v_rec.CREATED_TS := SYSDATE;
    v_rec.UPDATED_TS := SYSDATE;

    
    --*****************************************
      v_rec.NAME := 'ManageWork_UnitOfWork';
      v_rec.COMMENTS := 'Place holder for Manage Work Unit of work';
      v_rec.LIST_TYPE := 'LIST';
      v_rec.VALUE := 'NONE';
      v_rec.OUT_VAR := NULL;
      ins_rec;
    
    --*****************************************
END;
/

COMMIT;
select * FROM corp_etl_list_lkup ;
