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
    v_rec.START_DATE := Trunc(SYSDATE-10);
    v_rec.END_DATE := to_date('07/07/7777','mm/dd/yyyy');
    v_rec.CREATED_TS := SYSDATE;
    v_rec.UPDATED_TS := SYSDATE;
    v_rec.ref_type := 'STEP_DEFINITION_ID';

    
    --*****************************************
    -- common values
    v_rec.NAME := 'TASK_MONITOR_TYPE';
    v_rec.COMMENTS := 'Monitor Type for Tasks';
      v_rec.LIST_TYPE := 'LIST';


    -- Created Research  monitor Types

v_rec.VALUE := 'FPBP Manual Notice'; v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 2223020;    ins_rec;
v_rec.VALUE := 'Application Problem Resolution: FPBP '; v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 2223029;    ins_rec;
v_rec.VALUE := 'Application Problem Resolution - FPBP Upstate'; v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 2113009;    ins_rec;
v_rec.VALUE := 'Application Problem Resolution - FPBP Downstate'; v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 2113010;    ins_rec;
v_rec.VALUE := 'Application Problem Resolution - FPBP Upstate: Insufficient Data'; v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 2223021;    ins_rec;
v_rec.VALUE := 'Application Problem Resolution - FPBP Downstate: Insufficient Data'; v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 2223022;    ins_rec;
v_rec.VALUE := 'Application Problem Resolution - FPBP Upstate: Retro Coverage'; v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 2223023;    ins_rec;
v_rec.VALUE := 'Application Problem Resolution - FPBP Downstate: Retro Coverage'; v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 2223024;    ins_rec;
v_rec.VALUE := 'Document Problem Resolution - FPBP Upstate'; v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 1113003;    ins_rec;
v_rec.VALUE := 'Document Problem Resolution - FPBP Downstate'; v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 1113004;    ins_rec;
v_rec.VALUE := 'Document Problem Resolution - FPBP Upstate: Invalid Zip Code'; v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 2223025;    ins_rec;
v_rec.VALUE := 'Document Problem Resolution - FPBP Downstate: Invalid Zip Code'; v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 2223026;    ins_rec;
v_rec.VALUE := 'Document Problem Resolution: FPBP'; v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 2223028;    ins_rec;

    -- Created Data Correction  monitor Types  
    
v_rec.VALUE := 'Data Correction-FPBP Upstate'; v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 1113015;    ins_rec;
v_rec.VALUE := 'Data Correction-FPBP Downstate'; v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 1113016;    ins_rec;

    -- Created QC  monitor Types  

v_rec.VALUE := 'MAXIMUS-QC FPBP Upstate'; v_rec.OUT_VAR := 'QC';  v_rec.REF_ID := 2223011;    ins_rec;
v_rec.VALUE := 'MAXIMUS-QC FPBP Downstate'; v_rec.OUT_VAR := 'QC';  v_rec.REF_ID := 2223012;    ins_rec;
v_rec.VALUE := 'MAXIMUS-QC FPBP MI Upstate'; v_rec.OUT_VAR := 'QC';  v_rec.REF_ID := 2223013;    ins_rec;
v_rec.VALUE := 'MAXIMUS-QC FPBP MI Downstate'; v_rec.OUT_VAR := 'QC';  v_rec.REF_ID := 2223014;    ins_rec;
v_rec.VALUE := 'MAXIMUS-QC WMS Data Entry FPBP Upstate'; v_rec.OUT_VAR := 'QC';  v_rec.REF_ID := 2223017;    ins_rec;
v_rec.VALUE := 'MAXIMUS-QC WMS Data Entry FPBP Downstate'; v_rec.OUT_VAR := 'QC';  v_rec.REF_ID := 2223018;    ins_rec;
    
    -- Created State Data Entry  monitor Types

v_rec.VALUE := 'State Data Entry-FPBP Upstate'; v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 1113009;    ins_rec;
v_rec.VALUE := 'State Data Entry-FPBP Downstate'; v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 1113010;    ins_rec;
v_rec.VALUE := 'State Data Entry-FPBP MI Upstate'; v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 1113011;    ins_rec;
v_rec.VALUE := 'State Data Entry-FPBP MI Downstate'; v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 1113012;    ins_rec;
v_rec.VALUE := 'WMS Data Entry - FPBP Upstate'; v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 1113013;    ins_rec;
v_rec.VALUE := 'WMS Data Entry - FPBP Downstate'; v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 1113014;    ins_rec;

    -- Created State Review monitor Types

v_rec.VALUE := 'State Review - FPBP Upstate'; v_rec.OUT_VAR := 'State Review';  v_rec.REF_ID := 2113013;    ins_rec;
v_rec.VALUE := 'State Review - FPBP Downstate'; v_rec.OUT_VAR := 'State Review';  v_rec.REF_ID := 2113014;    ins_rec;
v_rec.VALUE := 'State Review - FPBP Reprocess Upstate'; v_rec.OUT_VAR := 'State Review';  v_rec.REF_ID := 2113015;    ins_rec;
v_rec.VALUE := 'State Review - FPBP Reprocess Downstate'; v_rec.OUT_VAR := 'State Review';  v_rec.REF_ID := 2113016;    ins_rec;

    --*****************************************
END;

/


update corp_etl_list_lkup set Ref_type = 'STEP_DEFINITION_ID'
where ref_type = 'STEP_INSTANCE_ID'  and Name = 'MI_TASK_TYPE';

COMMIT;
