MERGE INTO CC_S_AGENT_SUPERVISOR U1
USING(   
      with T1 as( 
                  SELECT RowNum as RW_NUM, FI.* 
                  FROM cc_s_agent_supervisor M
                  JOIN (
                          SELECT RowId as RW_ID, M.Agent_Id, M.SUPERVISOR_AGENT_ID, M.Record_Eff_Dt, M.Record_End_Dt 
                          FROM cc_s_agent_supervisor M
                          WHERE M.Agent_Id IN 
                          (
                            select s.AGENT_ID from cc_s_agent_supervisor s
                            Group BY Agent_Id, record_end_dt
                            HAVING Count(*) > 1
                          )
                          ORDER BY AGENT_ID,Record_Eff_Dt
                      ) FI ON M.ROWId = FI.RowId)
                  SELECT A1.RW_ID, A2.Record_Eff_Dt as New_End_Dt
                  FROM T1 A1
                  JOIN T1 A2 ON A1.Agent_Id = A2.Agent_Id AND (A1.RW_Num + 1) = A2.RW_NUM)F1 ON (U1.RowID = F1.RW_Id)
        WHEN MATCHED THEN UPDATE
        SET U1.RecorD_END_Dt = F1.New_End_Dt;