CREATE INDEX Step_Instance_Stg_hist_st_idx
   ON Step_Instance_Stg (hist_status)
   
CREATE INDEX Step_Instance_Stg_hist_ts_idx
   ON Step_Instance_Stg (hist_create_ts)
    
CREATE INDEX Step_Instance_Stg_ref_id_idx
   ON Step_Instance_Stg (ref_id)

CREATE INDEX Step_Instance_Stg_SIH_id_idx
   ON Step_Instance_Stg (step_instance_history_id)

CREATE INDEX Step_Instance_Stg_Hist_Own_idx
   ON Step_Instance_Stg (hist_owner)

CREATE INDEX Step_Instance_Stg_Hist_by_idx
   ON Step_Instance_Stg (hist_create_by)
   
CREATE INDEX Step_Instance_Stg_step_def_idx
   ON Step_Instance_Stg (step_definition_id)
   