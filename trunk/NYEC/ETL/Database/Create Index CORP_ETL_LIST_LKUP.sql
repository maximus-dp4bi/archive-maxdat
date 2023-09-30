
CREATE INDEX CORP_ETL_LIST_LKUP2_idx
   ON CORP_ETL_LIST_LKUP (Name, Out_Var, Start_Date, End_Date)

CREATE INDEX CORP_ETL_LIST_LKUP_NAME_idx
   ON CORP_ETL_LIST_LKUP (Name)

CREATE INDEX CORP_ETL_LIST_LKUP_OUT_VAR_idx
   ON CORP_ETL_LIST_LKUP (Out_Var)

CREATE INDEX CORP_ETL_LIST_LKUP_ST_DT_idx
   ON CORP_ETL_LIST_LKUP (Start_Date)

CREATE INDEX CORP_ETL_LIST_LKUP_END_DT_idx
   ON CORP_ETL_LIST_LKUP (End_Date)
   
   OutVar, Name, Start_Date, End_Date