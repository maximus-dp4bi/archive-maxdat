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
    v_rec.ref_type := 'STEP_DEFINITION_ID';

    
    --*****************************************
    -- common values
    v_rec.NAME := 'TASK_MONITOR_TYPE';
    v_rec.COMMENTS := 'Monitor Type for Tasks';
      v_rec.LIST_TYPE := 'LIST';


    -- Created Research  monitor Types
    v_rec.VALUE := 'Application Problem Resolution';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 3009;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: LDSS Withdrawl Request';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113031;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Stop Application';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113032;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Clockdown Case with CSD';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113033;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Application Clockdown';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113034;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Clearance Error';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113035;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: WMS/ MBL Mismatch';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113036;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Application Suspension';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113037;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Self Employment Calc';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113038;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Interest Calc Error';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113039;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Unknown Immigration Doc';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113040;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Adult Dependent Care';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113041;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Undeliverable';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113042;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Potential HSDE Error';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113043;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Unresolved Linking Error';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113044;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Unresolved SDE Error';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113045;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Unresolved MAX-QC Error';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113046;    ins_rec;
    v_rec.VALUE := 'Application Problem Resolution: Refer to Notes Section';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113047;    ins_rec;

    v_rec.VALUE := 'Document Problem Resolution';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 3003;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: LDSS Withdrawl Request';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113014;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Stop Application';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113015;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Clockdown Case with CSD';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113016;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Application Clockdown';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113017;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Clearance Error';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113018;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Application Suspension';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113020;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Self Employment Calc';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113021;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Interest Calc Error';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113022;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Unknown Immigration Doc';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113023;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Adult Dependent Care';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113024;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Undeliverable';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113025;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Potential HSDE Error';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113026;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Unresolved Linking Error';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113027;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Unresolved State Data Entry Error';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113028;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Unresolved MAX-QC Error';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113029;    ins_rec;
    v_rec.VALUE := 'Document Problem Resolution: Refer to Notes Section';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113030;    ins_rec;    
    v_rec.VALUE := 'Document Problem Resolution: WMS/ MBL Mismatch';   v_rec.OUT_VAR := 'Research';  v_rec.REF_ID := 113019;    ins_rec;    
    
    -- Created Data Correction  monitor Types  
    v_rec.VALUE := 'Data Correction';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 3015;    ins_rec;
    v_rec.VALUE := 'Data Correction - RFI Update Required';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113000;    ins_rec;
    v_rec.VALUE := 'Data Correction - Incorrect Budget';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113001;    ins_rec;
    v_rec.VALUE := 'Data Correction - Incorrect Financial Data';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113002;    ins_rec;
    v_rec.VALUE := 'Data Correction - Additional Documentation...';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113003;    ins_rec;
    v_rec.VALUE := 'Data Correction - EDC Update Required';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113004;    ins_rec;
    v_rec.VALUE := 'Data Correction - LDSS Referral Not Valid';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113005;    ins_rec;
    v_rec.VALUE := 'Data Correction - Fast Alert';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113006;    ins_rec;
    v_rec.VALUE := 'Data Correction - Incorrect Contact Data';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113007;    ins_rec;
    v_rec.VALUE := 'Data Correction - Incorrect Demographic';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113008;    ins_rec;
    v_rec.VALUE := 'Data Correction - Incorrect Documentation...';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113009;    ins_rec;
    v_rec.VALUE := 'Data Correction - Incorrect Demographic: IV-D';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113010;    ins_rec;
    v_rec.VALUE := 'Data Correction - Incorrect Demographic: CR';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113011;    ins_rec;
    v_rec.VALUE := 'Data Correction - Incorrect Financial Data: TPHI';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113012;    ins_rec;
    v_rec.VALUE := 'Data Correction - MAXIMUS Requested';   v_rec.OUT_VAR := 'Data Correction';  v_rec.REF_ID := 113013;    ins_rec;
    
    -- Created QC  monitor Types  
    v_rec.VALUE := 'MAXIMUS-QC';   v_rec.OUT_VAR := 'QC';  v_rec.REF_ID := 3011;    ins_rec;
    v_rec.VALUE := 'MAXIMUS QC - MI Task';   v_rec.OUT_VAR := 'QC';  v_rec.REF_ID := 32385;    ins_rec;
    v_rec.VALUE := 'MAXIMUS QC - LDSS Referral Task';   v_rec.OUT_VAR := 'QC';  v_rec.REF_ID := 32386;    ins_rec;
    
    -- Created State Data Entry  monitor Types
    v_rec.VALUE := 'State Data Entry';   v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 3007;    ins_rec;
    v_rec.VALUE := 'Case Addition State Data Entry';   v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 32323;    ins_rec;
    v_rec.VALUE := 'State Data Entry Task -Clockdown';   v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 32380;    ins_rec;
    v_rec.VALUE := 'State Data Entry Task - MI';   v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 32381;    ins_rec;
    v_rec.VALUE := 'State Data Entry Task - TPHI';   v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 32382;    ins_rec;
    v_rec.VALUE := 'State Data Entry Task - 5 Bdays until Auth End';   v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 32383;    ins_rec;
    v_rec.VALUE := 'State Data Entry Task - Undeliverable';   v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 1132384;    ins_rec;
      
    -- Created State Review monitor Types
    v_rec.VALUE := 'State Acceptance';   v_rec.OUT_VAR := 'State Review';  v_rec.REF_ID := 3013;    ins_rec;
    v_rec.VALUE := 'State Review Task - Clockdown';   v_rec.OUT_VAR := 'State Review';  v_rec.REF_ID := 32388;    ins_rec;
    v_rec.VALUE := 'State Review Task -LDSS Referral';   v_rec.OUT_VAR := 'State Review';  v_rec.REF_ID := 32389;    ins_rec;
    v_rec.VALUE := 'State Review Task - MI Reprocess Result';   v_rec.OUT_VAR := 'State Review';  v_rec.REF_ID := 32390;    ins_rec;
    v_rec.VALUE := 'State Review Task - Ineligible Member';   v_rec.OUT_VAR := 'State Review';  v_rec.REF_ID := 1132396;    ins_rec;
    v_rec.VALUE := 'State Review Task - Pregnancy';   v_rec.OUT_VAR := 'State Review';  v_rec.REF_ID := 1132397;    ins_rec;
    v_rec.VALUE := 'State Review Task - New Case Member';   v_rec.OUT_VAR := 'State Review';  v_rec.REF_ID := 1132398;    ins_rec;
    v_rec.VALUE := 'State Review Task - Undeliverable';   v_rec.OUT_VAR := 'State Review';  v_rec.REF_ID := 1132399;    ins_rec;
    --*****************************************
END;
/

COMMIT;
