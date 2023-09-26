update nyhx_etl_idr_incidents
set instance_complete_dt=incident_status_dt,
    complete_dt=incident_status_dt,
    stage_done_date=incident_status_dt
where incident_id in 
(27087314,27007324,27007316,27054222,26879798,27018051,26979354,26980809,
 27068134,27027124,26985536,26944206,27035613,27078001,26953425,26955750,26999007);
commit;

update nyhx_etl_idr_incidents
set instance_status = 'Active',
     instance_complete_dt=null,
     complete_dt=null,
     stage_done_date=null 
where incident_id=27078790;
commit;

update nyhx_etl_idr_incidents
set instance_complete_dt=incident_status_dt,
    complete_dt=incident_status_dt,
    stage_done_date=incident_status_dt
where incident_id=26300882;
commit;

update nyhx_etl_idr_incidents
set complete_dt=instance_complete_dt,
     stage_done_date=instance_complete_dt
where incident_id in
(26036304,26036372,26042266,26985782,26986757,26037376,26036649,26036451,26037961,
26036255,26037661,26759417,26036311,26036283,26607899,26045568,26207230,26043004,
26035291,26518394,26475484,26044079,26046939,26554679,26036265,26036175,26036333,
26041296,26041585,26041150,26686470,26042715);
commit;