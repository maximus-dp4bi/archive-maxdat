CREATE OR REPLACE PACKAGE txkpr10_xls_PKG AS

  PROCEDURE INS_ERROR_LOG(P_JOB_NAME IN VARCHAR2, P_ERROR_CODE IN VARCHAR2, P_ERROR_MSG IN VARCHAR2, P_TABLE_NAME IN VARCHAR2, P_TABLE_ID IN VARCHAR2);
  ---procedure INS_xls_data_stg(p_star_program in varchar2, P_STAR_CANDIDATE_PROGRAM IN VARCHAR2, p_STG_etl_recon_ctrl_id in number, p_rownum_from in number default 0, p_rownum_to in number default 0);

  procedure ins_xls_data_all(p_job_id in number);
  procedure INS_xls_medicaid_data(p_program in varchar2, P_SubPROGRAM IN VARCHAR2, p_rulename in varchar2, p_proc_name in varchar2, p_filename in varchar2, p_STG_etl_recon_ctrl_id in number, p_rownum_from in number default 0, p_rownum_to in number default 0);

  procedure INS_xls_chip_data(p_program in varchar2, P_SubPROGRAM IN VARCHAR2, p_rulename in varchar2, p_proc_name in varchar2, p_filename in varchar2, p_STG_etl_recon_ctrl_id in number, p_rownum_from in number default 0, p_rownum_to in number default 0);
  PRocedure UPDC_AFTERLOAD(P_ETL_rECON_CTRL_ID IN NUMBER, P_FILE_PREFIX IN VARCHAR2);
  PRocedure UPDM_AFTERLOAD(P_ETL_rECON_CTRL_ID IN NUMBER, P_FILE_PREFIX IN VARCHAR2);


END;
/
CREATE OR REPLACE PACKAGE BODY txkpr10_xls_PKG AS

PROCEDURE INS_ERROR_LOG(P_JOB_NAME IN VARCHAR2, P_ERROR_CODE IN VARCHAR2, P_ERROR_MSG IN VARCHAR2, P_TABLE_NAME IN VARCHAR2, P_TABLE_ID in varchar2) IS
  BEGIN
        INSERT INTO  CORP_ETL_ERROR_LOG(ERR_DATE
          ,ERR_LEVEL
          ,PROCESS_NAME
          ,JOB_NAME
          ,NR_OF_ERROR
          ,ERROR_DESC
          ,ERROR_CODES
          ,DRIVER_TABLE_NAME
          ,DRIVER_KEY_NUMBER
      ) VALUES (
          SYSDATE
          , 'CRITICAL'
          , 'TXKPR10_xls_PKG'
          , P_JOB_NAME
          , 1
          , P_ERROR_MSG
          , P_ERROR_CODE
          , P_TABLE_NAME
          , P_TABLE_ID
      );
  EXCEPTION WHEN OTHERS THEN
  DECLARE
    V_CODE VARCHAR2(30);
    V_ERROR VARCHAR2(200);
  BEGIN
      V_CODE := SQLCODE;
      V_ERROR := SUBSTR(SQLERRM,1,200);
            INSERT INTO  CORP_ETL_ERROR_LOG(ERR_DATE
          ,ERR_LEVEL
          ,PROCESS_NAME
          ,JOB_NAME
          ,NR_OF_ERROR
          ,ERROR_DESC
          ,ERROR_CODES
          ,DRIVER_TABLE_NAME
          ,DRIVER_KEY_NUMBER
      ) VALUES (
          SYSDATE
          , 'CRITICAL'
          , 'TXKPR10_XLS_PKG'
          , 'INS_ERROR_LOG'
          , 1
          , SUBSTR(V_ERROR,1,200)
          , V_CODE
          , NULL
          , NULL
      );
  END;
  END;


 procedure ins_xls_data_all(p_job_id in number) is
   v_chip_job varchar2(1) := 'N';
   v_med_job varchar2(1) := 'N';

 begin
    for vjob in (select DISTINCT FILENAME, UPPER(COL1||','||COL2||','||COL3||','||COL4||','||COL5||','||COL6||','||COL7||','||COL8||','||COL9||','||col10) COLHEADER, etl_Recon_ctrl_id from txkpr10_xls_stg xs where etl_recon_ctrl_id = p_job_id AND ROWNUMBER = 1)
    loop
       --DBMS_OUTPUT.PUT_LINE(CHR(10) || VJOB.FILENAME || CHR(10) || VJOB.COLHEADER );
       if not regexp_like(upper(VJOB.FILENAME), '.*STAGE.*.') then
          for vfile in (select program, subprogram, RULENAME , proc_name, XLSHEADER_PREFIX from txkpr10_xls_transform xt where REGEXP_LIKE(UPPER(VJOB.FILENAME), XT.FILENAME)
            AND substr(VJOB.COLHEADER,1,length(xt.xlsheader_prefix)) = upper(XT.XLSHEADER_PREFIX)
            AND xt.status = 'RUN' order by run_sequence)
          loop
            DBMS_OUTPUT.PUT_LINE('In main: ' ||VJOB.FILENAME || ' ' || VJOB.ETL_rECON_CTRL_ID || ' ' || VFILE.PROGRAM || ' ' || VFILE.SUBPROGRAM);
                case when vfile.program = 'MEDICAID' then
                   INS_xls_medicaid_data(VFILE.program, VFILE.subprogram, vfile.rulename, vfile.proc_name, vjob.filename, vjob.etl_recon_ctrl_id);
                        v_med_job := 'M';
                   when vfile.program = 'CHIP' then
                        INS_xls_chip_data(VFILE.program, VFILE.subprogram, vfile.rulename, vfile.proc_name, vjob.filename, vjob.etl_recon_ctrl_id);
                        v_chip_job := 'C';
                   else
                     null;
                end case;
          end loop;
        end if;
    end loop;
    if v_chip_job = 'C' then
    for vjob in (select distinct substr(filename, 1, 8) fileprefix from txkpr10_chip_xls cs where cs.etl_recon_ctrl_id = p_job_id and cs.program = 'CHIP')
      loop
        updc_AFTERLOAD(p_job_id, vjob.fileprefix);
      end loop;
    end if;
    if v_med_job = 'M' then
    for vjob in (select distinct substr(filename, 1, 8) fileprefix from txkpr10_med_xls cs where cs.etl_recon_ctrl_id = p_job_id and cs.program = 'MEDICAID')
      loop
        updm_AFTERLOAD(p_job_id, vjob.fileprefix);
      end loop;
    end if;
end;


procedure INS_xls_medicaid_data(p_program in varchar2, P_SubPROGRAM IN VARCHAR2, p_rulename in varchar2,p_proc_name in varchar2, p_filename in varchar2, p_STG_etl_recon_ctrl_id in number, p_rownum_from in number default 0, p_rownum_to in number default 0)
is

cursor mcur(p_program in varchar2, P_subPROGRAM IN VARCHAR2, p_filename in varchar2, p_STG_etl_recon_ctrl_id in number, p_rownum_from in number default 0, p_rownum_to in number default 0)
is
select *
 from txkpr10_xls_stg xt where xt.filename = p_filename
                                           and rownumber >1
                                           and col3 is not null
                                           and etl_recon_ctrl_id = p_stg_etl_recon_ctrl_id
                                           and (p_rownum_from = 0 or rownumber between p_rownum_from and p_rownum_to)
                                           and 1=1
;

type mtab is table of mcur%rowtype;
vtab mtab;
vtab_empty mtab := mtab(null);
v_rec_count number := 0;
v_prog varchar2(25) := 'ins_xls_medicaid_data';
v_err_count number := 0;
P_ETL_RECON_CTRL_ID number;

v_rowtype varchar2(20);
type otabtype is table of txkpr10_med_xls%rowtype;
otab otabtype;
otab_empty otabtype := otabtype(null);

begin

INSERT INTO TX_ETL_RECON_CTRL (JOB_NAME, JOB_SLICE, JOB_ID, status, status_dt, capitation_partlist) VALUES ('INS_XLS_DATA',1, P_STG_ETL_rECON_cTRL_ID, 'WORK',sysdate, p_filename || '#' || p_proc_name) RETURNING ETL_RECON_CTRL_ID INTO P_ETL_RECON_CTRL_ID;


begin
select distinct source_col
into v_rowtype
from Txkpr10_Xls_Transform_dtl xlt
where xlt.rulename = p_rulename
and upper(target_col) = 'ROWTYPE'
and upper(source_type) = 'CONST';

exception when others then
  null;
end;
dbms_output.put_line('Before opencur:' || p_filename || ' ' || p_proc_name || ' ' || to_char(p_stg_etl_recon_ctrl_id));

open mcur(p_program, p_subprogram, p_filename, p_stg_etl_recon_ctrl_id, p_rownum_from, p_rownum_to);
loop
      vtab := vtab_empty;
      FETCH mcur
      BULK COLLECT INTO vtab LIMIT 1000;
      --- delete if new recs exist
      --dbms_output.put_line(v_rec_count || ' ' || vtab.count || ' ' || V_rowtype);
      if v_rec_count = 0 and vtab.COUNT > 0 then
                delete /*+ parallel(10) */ txkpr10_med_xls xl where upper(xl.filename) = upper(p_filename);
                commit;
      end if;

      if vtab.count > 0 then
      V_REC_COUNT := V_REC_COUNT + vtab.COUNT;
      --dbms_output.put_line('Rec:' || v_rec_count || ' ##' || vtab.count);

      BEGIN

         begin
                otab := otab_empty;
                for x in 1..vtab.count --first..vtab.last
                   loop
                         --dbms_output.put_line('before extend');
                         if x> 1 then
                             otab.extend;
                             --dbms_output.put_line('after extend:' || otab(x).rowtype || '#' || vtab(x).rowtype);
                         end if;
                          --dbms_output.put_line(vtab(x).filename || vtab(x).col2 || '##' || otab(x).filename);
                    case when p_program = 'MEDICAID' and p_proc_name = 'MAP_MED_STAR_REC' THEN
                          otab(x) := map_med_star_rec(vtab(x));
                          when p_program = 'MEDICAID' and p_proc_name = 'MAP_MED_SK_REC' then
                          otab(x) := map_med_sk_rec(vtab(x));
                          when p_program = 'MEDICAID' and p_proc_name = 'MAP_MED_SP_REC' then
                          otab(x) := map_med_sp_rec(vtab(x));
                          when p_program = 'MEDICAID' and p_proc_name = 'MAP_MED_DENTAL_REC' then
                          otab(x) := map_med_dental_rec(vtab(x));
                          when p_program = 'MEDICAID' and p_proc_name = 'MAP_MED_R1_REC' then
                              otab(x) := map_med_r1_rec(vtab(x));
                          when p_program = 'MEDICAID' and p_proc_name = 'MAP_MED_R2_REC' then
                          otab(x) := map_med_r2_rec(vtab(x));
                          when p_program = 'MEDICAID' and p_proc_name = 'MAP_MED_RK_REC' then
                          otab(x) := map_med_rK_rec(vtab(x));
                          when p_program = 'MEDICAID' and p_proc_name = 'MAP_MED_TP40_REC' then
                            --dbms_output.put_line('calling tp40 code');
                          otab(x) := map_med_tp40_rec(vtab(x));
                          when p_program = 'MEDICAID' and p_proc_name = 'MAP_MED_SDA_REC' then
                          otab(x) := map_med_sda_rec(vtab(x));
                          when p_program = 'MEDICAID' and p_proc_name = 'MAP_MED_1A_REC' then
                          otab(x) := map_med_1A_rec(vtab(x));
                          when p_program = 'MEDICAID' and p_proc_name = 'MAP_MED_3A_REC' then
                          otab(x) := map_meD_3A_rec(vtab(x));
                          when p_program = 'MEDICAID' and p_proc_name = 'MAP_MED_R1_COMM_REC' then
                              otab(x) := map_med_r1_comm_rec(vtab(x));
                          when p_program = 'MEDICAID' and p_proc_name = 'MAP_MED_RK_COMM_REC' then
                              otab(x) := map_med_rK_comm_rec(vtab(x));
                          else
                            null;
                          end case;
                          --dbms_output.put_line(otab(x).filename || otab(x).client_nbr);
                 end loop;

                 BEGIN
                     FORALL x in otab.First..otab.Last save exceptions
                      insert into TXKPR10_MED_XLS
                                values otab(x);

                   EXCEPTION
                               WHEN OTHERS
                               THEN
                                 V_ERR_COUNT := V_ERR_COUNT + SQL%BULK_EXCEPTIONS.COUNT;
                               FOR J IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
                               LOOP
                                    DECLARE
                                    V_CODE VARCHAR2(30);
                                    V_ERROR VARCHAR2(200);
                                    V_ID    NUMBER;
                                    BEGIN
                                    V_CODE := SQL%BULK_EXCEPTIONS (J).ERROR_CODE;
                                    V_ERROR := SUBSTR(SQLERRM(''-'' || V_CODE),1,200);
                                    V_ID := SQL%BULK_EXCEPTIONS(J).ERROR_INDEX;
                                        INSERT INTO  CORP_ETL_ERROR_LOG(ERR_DATE
                                            ,ERR_LEVEL
                                            ,PROCESS_NAME
                                            ,JOB_NAME
                                            ,NR_OF_ERROR
                                            ,ERROR_DESC
                                            ,ERROR_CODES
                                            ,DRIVER_TABLE_NAME
                                            ,DRIVER_KEY_NUMBER
                                        ) VALUES (
                                            SYSDATE
                                            , 'CRITICAL'
                                            , 'TXKPR10_XLS_PKG'
                                            , v_prog
                                            , 1
                                            , p_filename || '#' || p_proc_name || '#' || SUBSTR(V_ERROR,1,200)
                                            , V_CODE
                                            , NULL
                                            , vtab(V_ID).rownumber
                                        );
                                        END;
                               END LOOP;
                      commit;
                    END; --FOR ALL
                 end;

        commit;
        UPDATE TX_ETL_RECON_CTRL SET STATUS = 'ERROR', STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE ETL_RECON_CTRL_ID = P_ETL_rECON_CTRL_ID;
        commit;

      end;
      end if;

    commit;
     EXIT WHEN mcur%NOTFOUND;
end loop;
close mcur;

 IF V_REC_COUNT > 0 THEN
     UPDATE TX_ETL_RECON_CTRL SET STATUS = 'DONE', STAT_COMMENT = 'subprogram = ' || p_subprogram || ' RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE ETL_RECON_CTRL_ID = P_ETL_RECON_CTRL_ID;
  ELSE
         UPDATE TX_ETL_RECON_CTRL SET STATUS = 'DONE', STAT_COMMENT = 'NODATA FILENAME = ' || p_subprogram || ' RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE ETL_RECON_CTRL_ID = P_ETL_RECON_CTRL_ID;
  END IF;
 commit;

exception when others then
          DECLARE
            V_CODE VARCHAR2(30);
            V_ERROR VARCHAR2(200);
          BEGIN
              V_CODE := SQLCODE;
              V_ERROR := SUBSTR(SQLERRM,1,200);
                    INSERT INTO  CORP_ETL_ERROR_LOG(ERR_DATE
                  ,ERR_LEVEL
                  ,PROCESS_NAME
                  ,JOB_NAME
                  ,NR_OF_ERROR
                  ,ERROR_DESC
                  ,ERROR_CODES
                  ,DRIVER_TABLE_NAME
                  ,DRIVER_KEY_NUMBER
              ) VALUES (
                  SYSDATE
                  , 'CRITICAL'
                  , 'TXKPR10_XLS_PKG'
                  , v_prog
                  , 1
                  , p_filename || '#' || p_proc_name || '#' || SUBSTR(V_ERROR,1,200)
                  , V_CODE
                  , NULL
                  , NULL
              );
          END;
          commit;

end;


procedure INS_xls_chip_data(p_program in varchar2, P_SubPROGRAM IN VARCHAR2, p_rulename in varchar2,p_proc_name in varchar2, p_filename in varchar2, p_STG_etl_recon_ctrl_id in number, p_rownum_from in number default 0, p_rownum_to in number default 0)
is

cursor mcur(p_program in varchar2, P_subPROGRAM IN VARCHAR2, p_filename in varchar2, p_STG_etl_recon_ctrl_id in number, p_rownum_from in number default 0, p_rownum_to in number default 0)
is
select *
 from txkpr10_xls_stg xt where xt.filename = p_filename
                                           and rownumber >1
                                           and col3 is not null
                                           and etl_recon_ctrl_id = p_stg_etl_recon_ctrl_id
                                           and (p_rownum_from = 0 or rownumber between p_rownum_from and p_rownum_to)
                                           and 1=1
;

type mtab is table of mcur%rowtype;
vtab mtab;
vtab_empty mtab := mtab(null);
v_rec_count number := 0;
v_prog varchar2(25) := 'ins_xls_chip_data';
v_err_count number := 0;
P_ETL_RECON_CTRL_ID number;

v_rowtype varchar2(20);
type otabtype is table of txkpr10_chip_xls%rowtype;
otab otabtype;
otab_empty otabtype := otabtype(null);

begin

INSERT INTO TX_ETL_RECON_CTRL (JOB_NAME, JOB_SLICE, JOB_ID, status, status_dt, capitation_partlist) VALUES ('INS_XLS_DATA',1, P_STG_ETL_rECON_cTRL_ID, 'WORK',sysdate, p_filename || '#' || p_proc_name) RETURNING ETL_RECON_CTRL_ID INTO P_ETL_RECON_CTRL_ID;


begin
select distinct source_col
into v_rowtype
from Txkpr10_Xls_Transform_dtl xlt
where xlt.rulename = p_rulename
and upper(target_col) = 'ROWTYPE'
and upper(source_type) = 'CONST';

exception when others then
  null;
end;
dbms_output.put_line('Before opencur:' || p_filename || ' ' || p_proc_name || ' ' || to_char(p_stg_etl_recon_ctrl_id));

open mcur(p_program, p_subprogram, p_filename, p_stg_etl_recon_ctrl_id, p_rownum_from, p_rownum_to);
loop
      vtab := vtab_empty;
      FETCH mcur
      BULK COLLECT INTO vtab LIMIT 1000;
      --- delete if new recs exist
      --dbms_output.put_line(v_rec_count || ' ' || vtab.count || ' ' || V_rowtype);
      if v_rec_count = 0 and vtab.COUNT > 0 then
                delete txkpr10_chip_xls xl where upper(xl.filename) = upper(p_filename);
                commit;
      end if;

      if vtab.count > 0 then
      V_REC_COUNT := V_REC_COUNT + vtab.COUNT;
      --dbms_output.put_line('Rec:' || v_rec_count || ' ##' || vtab.count);

      BEGIN

         begin
                otab := otab_empty;
                for x in 1..vtab.count --first..vtab.last
                   loop
                         --dbms_output.put_line('before extend');
                         if x> 1 then
                             otab.extend;
                             --dbms_output.put_line('after extend:' || otab(x).rowtype || '#' || vtab(x).rowtype);
                         end if;
                          --dbms_output.put_line(vtab(x).filename || vtab(x).col2 || '##' || otab(x).filename);
                    case when p_program = 'CHIP' and p_proc_name = 'MAP_CHIP_NEW_REC' THEN
                          otab(x) := map_chip_new_rec(vtab(x));
                          when p_program = 'CHIP' and p_proc_name = 'MAP_CHIP_PERI_REC' then
                          otab(x) := map_chip_PERI_rec(vtab(x));
                          when p_program = 'CHIP' and p_proc_name = 'MAP_CHIP_RNW_REC' then
                          otab(x) := map_chip_RNW_rec(vtab(x));
                          when p_program = 'CHIP' and p_proc_name = 'MAP_CHIP_CHIPOON_REC' then
                          otab(x) := map_chip_CHIPOON_rec(vtab(x));
                          when p_program = 'CHIP' and p_proc_name = 'MAP_CHIP_PERIOON_REC' then
                              otab(x) := map_chip_PERIOON_rec(vtab(x));
                          else
                            null;
                          end case;
                          --dbms_output.put_line(otab(x).filename || otab(x).client_nbr);
                 end loop;

                 BEGIN
                     dbms_output.put_line('before insert');
                     FORALL x in otab.First..otab.Last save exceptions
                      insert into TXKPR10_CHIP_XLS
                                values otab(x);

                   EXCEPTION
                               WHEN OTHERS
                               THEN
                                 V_ERR_COUNT := V_ERR_COUNT + SQL%BULK_EXCEPTIONS.COUNT;
                               FOR J IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
                               LOOP
                                    DECLARE
                                    V_CODE VARCHAR2(30);
                                    V_ERROR VARCHAR2(200);
                                    V_ID    NUMBER;
                                    BEGIN
                                    V_CODE := SQL%BULK_EXCEPTIONS (J).ERROR_CODE;
                                    V_ERROR := SUBSTR(SQLERRM(''-'' || V_CODE),1,200);
                                    V_ID := SQL%BULK_EXCEPTIONS(J).ERROR_INDEX;
                                        INSERT INTO  CORP_ETL_ERROR_LOG(ERR_DATE
                                            ,ERR_LEVEL
                                            ,PROCESS_NAME
                                            ,JOB_NAME
                                            ,NR_OF_ERROR
                                            ,ERROR_DESC
                                            ,ERROR_CODES
                                            ,DRIVER_TABLE_NAME
                                            ,DRIVER_KEY_NUMBER
                                        ) VALUES (
                                            SYSDATE
                                            , 'CRITICAL'
                                            , 'TXKPR10_XLS_PKG'
                                            , v_prog
                                            , 1
                                            , p_filename || '#' || p_proc_name || '#' || SUBSTR(V_ERROR,1,200)
                                            , V_CODE
                                            , NULL
                                            , vtab(V_ID).rownumber
                                        );
                                        END;
                               END LOOP;
                      commit;
                    END; --FOR ALL
                 end;

        commit;
        UPDATE TX_ETL_RECON_CTRL SET STATUS = 'ERROR', STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE ETL_RECON_CTRL_ID = P_ETL_rECON_CTRL_ID;
        commit;

      end;
      end if;

    commit;
     EXIT WHEN mcur%NOTFOUND;
end loop;
close mcur;

 IF V_REC_COUNT > 0 THEN
     UPDATE TX_ETL_RECON_CTRL SET STATUS = 'DONE', STAT_COMMENT = 'subprogram = ' || p_subprogram || ' RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE ETL_RECON_CTRL_ID = P_ETL_RECON_CTRL_ID;
  ELSE
         UPDATE TX_ETL_RECON_CTRL SET STATUS = 'DONE', STAT_COMMENT = 'NODATA FILENAME = ' || p_subprogram || ' RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE ETL_RECON_CTRL_ID = P_ETL_RECON_CTRL_ID;
  END IF;
 commit;

exception when others then
          DECLARE
            V_CODE VARCHAR2(30);
            V_ERROR VARCHAR2(200);
          BEGIN
              V_CODE := SQLCODE;
              V_ERROR := SUBSTR(SQLERRM,1,200);
                    INSERT INTO  CORP_ETL_ERROR_LOG(ERR_DATE
                  ,ERR_LEVEL
                  ,PROCESS_NAME
                  ,JOB_NAME
                  ,NR_OF_ERROR
                  ,ERROR_DESC
                  ,ERROR_CODES
                  ,DRIVER_TABLE_NAME
                  ,DRIVER_KEY_NUMBER
              ) VALUES (
                  SYSDATE
                  , 'CRITICAL'
                  , 'TXKPR10_XLS_PKG'
                  , v_prog
                  , 1
                  , p_filename || '#' || p_proc_name || '#' || SUBSTR(V_ERROR,1,200)
                  , V_CODE
                  , NULL
                  , NULL
              );
          END;

end;

PRocedure UPDC_AFTERLOAD(P_ETL_rECON_CTRL_ID IN NUMBER, P_FILE_PREFIX IN VARCHAR2) IS

P_WORK_ETL_rECON_CTRL_ID number;

CURSOR c_data IS
with meda as
(SELECT DISTINCT  FILENAME, etl_recon_ctrl_id, lp.Tot_Client_ID, Max(lp.elig_start_date)Over(Partition by lp.etl_recon_ctrl_id,lp.tot_client_id) as Max_elig_date
,MIN(lp.elig_start_date)Over(Partition by lp.etl_recon_ctrl_id, SUBSTR(LP.FILENAME,1,LENGTH(P_FILE_PREFIX)), lp.tot_client_id) as Min_elig_date
from txkpr10_chIp_xls lp
where lp.etl_recon_ctrl_id = p_etl_recon_ctrl_id
AND REGEXP_LIKE(LP.FILENAME, P_FILE_PREFIX || '.*')
), csub as (
SELECT cl.etl_recon_ctrl_id
, cl.filename
, CL.rowid rowidval
, cl.tot_client_id
, cl.min_elig_date
, cl.max_elig_date
, cl.p834_date
, cl.duration
, cl.duration_group
, meda.min_elig_date meda_min_elig_date
, meda.max_elig_date meda_max_elig_date
, CASE WHEN (cl.p834_date-meda.max_elig_date)<0 THEN (cl.p834_date-meda.min_elig_date)
          WHEN (cl.p834_date-meda.max_elig_date) >= 0 THEN (cl.p834_date-meda.max_elig_date) else 9999 end meda_Duration
, case when nvl(cl.min_elig_date, meda.min_elig_date+1) <> meda.min_elig_date then 1
       when nvl(cl.max_elig_date, meda.max_elig_date+1) <> meda.max_elig_date then 1
         when nvl(cl.duration, -99999) <> (CASE WHEN (cl.p834_date-meda.max_elig_date)<0 THEN (cl.p834_date-meda.min_elig_date)
          WHEN (cl.p834_date-meda.max_elig_date) >= 0 THEN (cl.p834_date-meda.max_elig_date) else 9999 end) then 1
         else 0
  end update_flag
from txkpr10_chIp_xls cl
join meda meda on meda.tot_client_id = cl.tot_client_id and meda.etl_recon_ctrl_id = cl.etl_recon_ctrl_id
where cl.etl_recon_ctrl_id = P_ETL_RECON_CTRL_ID
AND REGEXP_LIKE(CL.FILENAME, P_FILE_PREFIX || '.*')
AND SUBSTR(MEDA.FILENAME,1,LENGTH(P_FILE_PREFIX)) = SUBSTR(CL.FILENAME,1,LENGTH(P_FILE_PREFIX))
)
select
ch.*
, CASE WHEN ch.meda_Duration BETWEEN 0 AND 5 THEN 1
          WHEN ch.meda_Duration BETWEEN 6 AND 10 THEN 2
               WHEN ch.meda_Duration BETWEEN 11 AND 15 THEN 3
                    WHEN ch.meda_Duration BETWEEN 16 AND 20 THEN 4
                         WHEN ch.meda_Duration >20 THEN 5 ELSE ch.meda_Duration END as meda_DURATION_GROUP
from csub ch
;


  TYPE TSTARTable IS TABLE OF C_DATA%ROWTYPE;
STARTAB_EMPTY TSTARTABLE;

STARTABUpd TSTARTable;
V_REC_COUNT NUMBER := 0;
V_ERR_COUNT NUMBER := 0;


BEGIN


  BEGIN
dbms_output.put_line('here1 before insert ' || p_etl_recon_ctrl_id);
  INSERT INTO TX_ETL_RECON_CTRL (JOB_NAME, JOB_SLICE, STATUS, status_dt) VALUES ('UPDC_AFTERLOAD',1, 'WORK', sysdate) RETURNING ETL_RECON_CTRL_ID INTO P_WORK_ETL_RECON_CTRL_ID;
dbms_output.put_line('here1 ' || p_etl_recon_ctrl_id);

  BEGIN
    OPEN c_data;
    LOOP
      STARTABUPD := STARTAB_EMPTY;
      FETCH c_data
      BULK COLLECT INTO STARTABUpd LIMIT 10000;
      V_REC_COUNT := V_REC_COUNT + STARTABUPD.COUNT;

      BEGIN
        dbms_output.put_line('here2 before update ' || STARTABUPD.COUNT);
        FORALL x in STARTABUpd.First..STARTABUpd.Last SAVE EXCEPTIONS
            update txkpr10_chIp_xls str set
                  str.min_elig_date = STARTABUPD(X).MEDA_MIN_ELIG_DATE
                , str.max_elig_date = STARTABUPD(X).MEDA_MAX_ELIG_DATE
                , str.duration = STARTABUPD(X).MEDA_DURATION
                , str.duration_group = STARTABUPD(X).meda_DURATION_GROUP
                where str.rowid = STARTABUPD(X).rowidval;

                commit;
  EXCEPTION
     WHEN OTHERS
     THEN
       V_ERR_COUNT := V_ERR_COUNT + SQL%BULK_EXCEPTIONS.COUNT;
     FOR J IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
     LOOP
          DECLARE
          V_CODE VARCHAR2(30);
          V_ERROR VARCHAR2(200);
          V_ID    NUMBER;
          BEGIN
          V_CODE := SQL%BULK_EXCEPTIONS (J).ERROR_CODE;
          V_ERROR := SUBSTR(SQLERRM('-' || V_CODE),1,200);
          V_ID := SQL%BULK_EXCEPTIONS(J).ERROR_INDEX;
          INS_ERROR_LOG(p_job_name=>'UPDC_AFTERLOAD',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'TXKPR10_CHIP_XLS', P_TABLE_ID=> STARTABUpd(V_ID).TOT_CLIENT_ID);
          END;
     END LOOP;
  END;
      commit;
      EXIT WHEN c_data%NOTFOUND;
    END LOOP;
    CLOSE c_data;
  END;
  commit;

  UPDATE TX_ETL_RECON_CTRL SET STATUS = 'DONE', STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE ETL_RECON_CTRL_ID = P_WORK_ETL_RECON_CTRL_ID;
  commit;

  EXCEPTION WHEN OTHERS THEN
      DECLARE
        V_CODE VARCHAR2(30);
        V_ERROR VARCHAR2(200);
      BEGIN
      V_CODE := SQLCODE;
      V_ERROR := SUBSTR(SQLERRM,1,200);
          INS_ERROR_LOG(p_job_name=>'UPDC_AFTERLOAD',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'TXKPR10_CHIP_XLS', P_TABLE_ID=> P_ETL_RECON_CTRL_ID);
        UPDATE TX_ETL_RECON_CTRL SET STATUS = 'ERROR', STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE ETL_RECON_CTRL_ID = P_WORK_ETL_rECON_CTRL_ID;
        COMMIT;
        end;
  END;


  END;

---update M after load
PRocedure UPDM_AFTERLOAD(P_ETL_rECON_CTRL_ID IN NUMBER, P_FILE_PREFIX IN VARCHAR2) IS

P_WORK_ETL_rECON_CTRL_ID number;

CURSOR c_data IS
SELECT cl.etl_recon_ctrl_id
, cl.filename
, CL.rowid rowidval
, CASE WHEN cl.Duration BETWEEN 0 AND 5 THEN 1
          WHEN cl.Duration BETWEEN 6 AND 10 THEN 2
               WHEN cl.Duration BETWEEN 11 AND 15 THEN 3
                    WHEN cl.Duration BETWEEN 16 AND 20 THEN 4
                         WHEN cl.Duration >20 THEN 5 ELSE cl.Duration END as meda_DURATION_GROUP
from txkpr10_MED_xls cL
where cl.etl_recon_ctrl_id = P_ETL_RECON_CTRL_ID
AND PROGRAM = 'MEDICAID'
---AND REGEXP_LIKE(CL.FILENAME, P_FILE_PREFIX || '.*')
;


  TYPE TSTARTable IS TABLE OF C_DATA%ROWTYPE;
STARTAB_EMPTY TSTARTABLE;

STARTABUpd TSTARTable;
V_REC_COUNT NUMBER := 0;
V_ERR_COUNT NUMBER := 0;


BEGIN


  BEGIN
dbms_output.put_line('here1 before insert ' || p_etl_recon_ctrl_id || ' ' || p_file_prefix );
  INSERT INTO TX_ETL_RECON_CTRL (JOB_NAME, JOB_SLICE, STATUS, status_dt) VALUES ('UPDM_AFTERLOAD',1, 'WORK', sysdate) RETURNING ETL_RECON_CTRL_ID INTO P_WORK_ETL_RECON_CTRL_ID;
dbms_output.put_line('here1 ' || p_etl_recon_ctrl_id);

  BEGIN
    OPEN c_data;
    LOOP
      STARTABUPD := STARTAB_EMPTY;
      FETCH c_data
      BULK COLLECT INTO STARTABUpd LIMIT 10000;
      V_REC_COUNT := V_REC_COUNT + STARTABUPD.COUNT;

      BEGIN
        dbms_output.put_line('here2 before update ' || STARTABUPD.COUNT);
        FORALL x in STARTABUpd.First..STARTABUpd.Last SAVE EXCEPTIONS
            update txkpr10_med_xls str set
                 str.duration_group = STARTABUPD(X).meda_DURATION_GROUP
                where str.rowid = STARTABUPD(X).rowidval;

                commit;
  EXCEPTION
     WHEN OTHERS
     THEN
       V_ERR_COUNT := V_ERR_COUNT + SQL%BULK_EXCEPTIONS.COUNT;
     FOR J IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
     LOOP
          DECLARE
          V_CODE VARCHAR2(30);
          V_ERROR VARCHAR2(200);
          V_ID    NUMBER;
          BEGIN
          V_CODE := SQL%BULK_EXCEPTIONS (J).ERROR_CODE;
          V_ERROR := SUBSTR(SQLERRM('-' || V_CODE),1,200);
          V_ID := SQL%BULK_EXCEPTIONS(J).ERROR_INDEX;
          INS_ERROR_LOG(p_job_name=>'UPDM_AFTERLOAD',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'TXKPR10_MED_XLS', P_TABLE_ID=> STARTABUpd(V_ID).ROWIDVAL);
          END;
     END LOOP;
  END;
      commit;
      EXIT WHEN c_data%NOTFOUND;
    END LOOP;
    CLOSE c_data;
  END;
  commit;

  UPDATE TX_ETL_RECON_CTRL SET STATUS = 'DONE', STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE ETL_RECON_CTRL_ID = P_WORK_ETL_RECON_CTRL_ID;
  commit;

  EXCEPTION WHEN OTHERS THEN
      DECLARE
        V_CODE VARCHAR2(30);
        V_ERROR VARCHAR2(200);
      BEGIN
      V_CODE := SQLCODE;
      V_ERROR := SUBSTR(SQLERRM,1,200);
          INS_ERROR_LOG(p_job_name=>'UPDM_AFTERLOAD',P_ERROR_MSG=> V_ERROR, P_ERROR_CODE =>V_CODE
                      , P_TABLE_NAME=>'txkpr10_med_xls', P_TABLE_ID=> P_ETL_RECON_CTRL_ID);
        UPDATE TX_ETL_RECON_CTRL SET STATUS = 'ERROR', STAT_COMMENT = 'RECCOUNT = ' || V_REC_COUNT || ' ;ERRCOUNT = ' || V_ERR_COUNT WHERE ETL_RECON_CTRL_ID = P_WORK_ETL_rECON_CTRL_ID;
        COMMIT;
        end;
  END;


  END;

end;
/
