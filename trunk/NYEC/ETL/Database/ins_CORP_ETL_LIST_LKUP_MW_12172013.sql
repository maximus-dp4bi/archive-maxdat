DECLARE 
 v_rec        corp_etl_list_lkup%ROWTYPE;
 v_rec_tt     bpm_d_ops_group_task%ROWTYPE;
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
     
 --
     PROCEDURE ins_rec_tt IS
        v_tt_cnt INTEGER := 0;
     BEGIN
     
           SELECT  COUNT(*) INTO v_tt_cnt
             FROM bpm_d_ops_group_task g
            WHERE g.ops_group = v_rec_tt.ops_group
              AND g.task_type = v_rec_tt.task_type;
              
           IF v_tt_cnt = 0 THEN
              INSERT INTO bpm_d_ops_group_task VALUES v_rec_tt;
           END IF;
     END;     
     
     
BEGIN
    v_rec.START_DATE := Trunc(SYSDATE-1);
    v_rec.END_DATE := to_date('07/07/7777','mm/dd/yyyy');
    v_rec.CREATED_TS := SYSDATE;
    v_rec.UPDATED_TS := SYSDATE;
    v_rec.ref_type := 'STEP_DEFINITION_ID';

    
v_rec.NAME := 'ManageWork_SLA_Days';   v_rec.COMMENTS := 'Research SLA Variables';  v_rec.LIST_TYPE := 'TASK_TYPE'; v_rec.VALUE := 'HSDE-QC- FPBP';   v_rec.OUT_VAR := '2';  v_rec.REF_ID := 1113001;    ins_rec;
v_rec.NAME := 'ManageWork_SLA_Days';   v_rec.COMMENTS := 'Research SLA Variables';  v_rec.LIST_TYPE := 'TASK_TYPE'; v_rec.VALUE := 'HSDE-QC- PAP';   v_rec.OUT_VAR := '2';  v_rec.REF_ID := 2223001;    ins_rec;
v_rec.NAME := 'ManageWork_SLA_Days';   v_rec.COMMENTS := 'Research SLA Variables';  v_rec.LIST_TYPE := 'TASK_TYPE'; v_rec.VALUE := 'Link Document Set-PAP';   v_rec.OUT_VAR := '2';  v_rec.REF_ID := 2223005;    ins_rec;
--
v_rec.NAME := 'ManageWork_SLA_Days_Type';   v_rec.COMMENTS := 'Research SLA Variables';  v_rec.LIST_TYPE := 'TASK_TYPE'; v_rec.VALUE := 'HSDE-QC- FPBP';   v_rec.OUT_VAR := 'B';  v_rec.REF_ID := 1113001;    ins_rec;
v_rec.NAME := 'ManageWork_SLA_Days_Type';   v_rec.COMMENTS := 'Research SLA Variables';  v_rec.LIST_TYPE := 'TASK_TYPE'; v_rec.VALUE := 'HSDE-QC- PAP';   v_rec.OUT_VAR := 'B';  v_rec.REF_ID := 2223001;    ins_rec;
v_rec.NAME := 'ManageWork_SLA_Days_Type';   v_rec.COMMENTS := 'Research SLA Variables';  v_rec.LIST_TYPE := 'TASK_TYPE'; v_rec.VALUE := 'Link Document Set-PAP';   v_rec.OUT_VAR := 'B';  v_rec.REF_ID := 2223005;    ins_rec;
--
v_rec.NAME := 'ManageWork_SLA_Jeopardy_Days';   v_rec.COMMENTS := 'Research SLA Variables';  v_rec.LIST_TYPE := 'TASK_TYPE'; v_rec.VALUE := 'HSDE-QC- FPBP';   v_rec.OUT_VAR := '1';  v_rec.REF_ID := 1113001;    ins_rec;
v_rec.NAME := 'ManageWork_SLA_Jeopardy_Days';   v_rec.COMMENTS := 'Research SLA Variables';  v_rec.LIST_TYPE := 'TASK_TYPE'; v_rec.VALUE := 'HSDE-QC- PAP';   v_rec.OUT_VAR := '1';  v_rec.REF_ID := 2223001;    ins_rec;
v_rec.NAME := 'ManageWork_SLA_Jeopardy_Days';   v_rec.COMMENTS := 'Research SLA Variables';  v_rec.LIST_TYPE := 'TASK_TYPE'; v_rec.VALUE := 'Link Document Set-PAP';   v_rec.OUT_VAR := '1';  v_rec.REF_ID := 2223005;    ins_rec;
--
v_rec.NAME := 'ManageWork_SLA_Target_Days';   v_rec.COMMENTS := 'Research SLA Variables';  v_rec.LIST_TYPE := 'TASK_TYPE'; v_rec.VALUE := 'HSDE-QC- FPBP';   v_rec.OUT_VAR := '2';  v_rec.REF_ID := 1113001;    ins_rec;
v_rec.NAME := 'ManageWork_SLA_Target_Days';   v_rec.COMMENTS := 'Research SLA Variables';  v_rec.LIST_TYPE := 'TASK_TYPE'; v_rec.VALUE := 'HSDE-QC- PAP';   v_rec.OUT_VAR := '2';  v_rec.REF_ID := 2223001;    ins_rec;
v_rec.NAME := 'ManageWork_SLA_Target_Days';   v_rec.COMMENTS := 'Research SLA Variables';  v_rec.LIST_TYPE := 'TASK_TYPE'; v_rec.VALUE := 'Link Document Set-PAP';   v_rec.OUT_VAR := '2';  v_rec.REF_ID := 2223005;    ins_rec;
    


   -- common values
    v_rec.NAME := 'TASK_MONITOR_TYPE';
    v_rec.COMMENTS := 'Monitor Type for Tasks';
    v_rec.LIST_TYPE := 'LIST';

    -- Create monitor Types
    v_rec.VALUE := 'HSDE-QC- FPBP';   v_rec.OUT_VAR := 'Mailroom';  v_rec.REF_ID := 1113001;    ins_rec;
    v_rec.VALUE := 'HSDE-QC- PAP';   v_rec.OUT_VAR := 'Mailroom';  v_rec.REF_ID := 2223001;    ins_rec;
    v_rec.VALUE := 'Link Document Set-PAP';   v_rec.OUT_VAR := 'Mailroom';  v_rec.REF_ID := 2223005;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution-PAP Reactivation';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 2223036;    ins_rec;
    v_rec.VALUE := 'DOH Supervisor Complaint Task (Elig-Complaint)';   v_rec.OUT_VAR := 'Call Center';  v_rec.REF_ID := 1130056;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Reactivation';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113051;    ins_rec;
    


-- Insert OPS Group Task Type


v_rec_tt.ops_group := 'Document Management - FPBP'; v_rec_tt.task_type := 'HSDE-QC- FPBP'; ins_rec_tt;
v_rec_tt.ops_group := 'Document Management -PAP'; v_rec_tt.task_type := 'HSDE-QC- PAP'; ins_rec_tt;
v_rec_tt.ops_group := 'Document Management -PAP'; v_rec_tt.task_type := 'Link Document Set-PAP'; ins_rec_tt;
v_rec_tt.ops_group := 'PAP Research'; v_rec_tt.task_type := 'Document Problem Resolution-PAP Reactivation'; ins_rec_tt;
v_rec_tt.ops_group := 'DOH Eligibility Determination Supervisor'; v_rec_tt.task_type := 'DOH Supervisor Complaint Task (Elig-Complaint)'; ins_rec_tt;
v_rec_tt.ops_group := 'Renewal Research'; v_rec_tt.task_type := 'Document Problem Resolution: Reactivation'; ins_rec_tt;

   
END;
/

COMMIT;