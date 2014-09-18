DECLARE
  c_type     CONSTANT corp_etl_list_lkup.ref_type%TYPE   := 'STEP_DEFINITION_ID';
  c_name     CONSTANT corp_etl_list_lkup.name%TYPE       := 'TASK_MONITOR_TYPE';
  c_list     CONSTANT corp_etl_list_lkup.list_type%TYPE  := 'LIST';
  c_start    CONSTANT corp_etl_list_lkup.start_date%TYPE := SYSDATE;
  c_end      CONSTANT corp_etl_list_lkup.end_date%TYPE   := TO_DATE('7/7/7777','MM/DD/YYYY');
  c_comments CONSTANT corp_etl_list_lkup.comments%TYPE   := 'Monitor Type for Tasks';
  v_value             corp_etl_list_lkup.value%TYPE;
  v_out_var           corp_etl_list_lkup.out_var%TYPE;
  v_ref_id            corp_etl_list_lkup.ref_id%TYPE;
BEGIN
  FOR i IN 1..28 LOOP
    CASE i
    WHEN 1 THEN v_value := 'PAP Analysis'; v_out_var := 'State Data Entry'; v_ref_id := '2223040';
    WHEN 2 THEN v_value := 'PAP Analysis-Undeliverable'; v_out_var := 'State Data Entry'; v_ref_id := '2223042';
    WHEN 3 THEN v_value := 'PAP Reactivation'; v_out_var := 'State Data Entry'; v_ref_id := '2223041';
    WHEN 4 THEN v_value := 'QC-PAP'; v_out_var := 'QC'; v_ref_id := '2223043';
    WHEN 5 THEN v_value := 'QC-PAP MI'; v_out_var := 'QC'; v_ref_id := '2223044';
    WHEN 6 THEN v_value := 'Data Correction-PAP'; v_out_var := 'QC'; v_ref_id := '2223046';
    WHEN 7 THEN v_value := 'PAP Luberto LDSS Notification'; v_out_var := 'Research'; v_ref_id := '32739';
    WHEN 8 THEN v_value := 'PAP Out of State Notification'; v_out_var := 'Research'; v_ref_id := '32740';
    WHEN 9 THEN v_value := 'PAP Courtesy Letter'; v_out_var := 'Research'; v_ref_id := '32741';
    WHEN 10 THEN v_value := 'PAP Other Notifications'; v_out_var := 'Research'; v_ref_id := '32742';
    WHEN 11 THEN v_value := 'Application Problem Resolution-PAP'; v_out_var := 'Research'; v_ref_id := '2223047';
    WHEN 12 THEN v_value := 'Application Problem Resolution-PAP Referral'; v_out_var := 'Research'; v_ref_id := '2223048';
    WHEN 13 THEN v_value := 'Application Problem Resolution-PAP Other'; v_out_var := 'Research'; v_ref_id := '2223049';
    WHEN 14 THEN v_value := 'Application Problem Resolution-PAP Reactivated in Error'; v_out_var := 'Research'; v_ref_id := '2223050';
    WHEN 15 THEN v_value := 'Document Problem Resolution-PAP'; v_out_var := 'Research'; v_ref_id := '2223039';
    WHEN 16 THEN v_value := 'Document Problem Resolution-PAP Referral'; v_out_var := 'Research'; v_ref_id := '2223038';
    WHEN 17 THEN v_value := 'Document Problem Resolution-PAP Other'; v_out_var := 'Research'; v_ref_id := '2223037';
    WHEN 18 THEN v_value := 'PAP Address Update'; v_out_var := 'State Review'; v_ref_id := '32743';
    WHEN 19 THEN v_value := 'State Review-PAP TPHI'; v_out_var := 'State Review'; v_ref_id := '2223051';
    WHEN 20 THEN v_value := 'State Review-PAP FHP Discontinuance'; v_out_var := 'State Review'; v_ref_id := '2223052';
    WHEN 21 THEN v_value := 'State Review-PAP WMS Enrollment'; v_out_var := 'State Review'; v_ref_id := '2223053';
    WHEN 22 THEN v_value := 'State Review-PAP HIPP Authorize'; v_out_var := 'State Review'; v_ref_id := '2223054';
    WHEN 23 THEN v_value := 'State Review-PAP No TPHI'; v_out_var := 'State Review'; v_ref_id := '2223055';
    WHEN 24 THEN v_value := 'State Review-PAP MI Reprocess'; v_out_var := 'State Review'; v_ref_id := '2223056';
    WHEN 25 THEN v_value := 'State Review-PAP Reactivation'; v_out_var := 'State Review'; v_ref_id := '2223057';
    WHEN 26 THEN v_value := 'State Review-PAP No Response'; v_out_var := 'State Review'; v_ref_id := '2223058';
    WHEN 27 THEN v_value := 'State Review-PAP Discontinuance'; v_out_var := 'State Review'; v_ref_id := '2223059';
    WHEN 28 THEN v_value := 'State Review-PAP Undeliverable'; v_out_var := 'State Review'; v_ref_id := '2223060';
    ELSE NULL;
    END CASE;
    --
    UPDATE corp_etl_list_lkup
       SET value = v_value, out_var = v_out_var, ref_id = v_ref_id,
           start_date = c_start, end_date = c_end, comments = c_comments
     WHERE ref_type = c_type AND name = c_name AND value = v_value;
    IF SQL%ROWCOUNT = 0
    THEN INSERT INTO corp_etl_list_lkup (ref_type, name, list_type, value, out_var, ref_id, comments, start_date, end_date)
         VALUES(c_type, c_name, c_list, v_value, v_out_var, v_ref_id, c_comments, c_start, c_end);
    END IF;
  END LOOP;
  --  
  COMMIT;
END;
/

