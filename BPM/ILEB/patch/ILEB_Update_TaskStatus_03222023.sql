update MAXDAT.D_MW_CURRENT a12 set "Current Task Status" = 'COMPLETED' where a12."Task ID" in (                
select distinct a12."Task ID"
from MAXDAT.F_MW_BY_DATE_SV a11   
 left outer join                 MAXDAT.D_MW_CURRENT_SV                 a12
                   on          (a11.MW_BI_ID = a12.MW_BI_ID)
                 left outer join                 MAXDAT.D_MW_TASK_TYPE_SV                 a13
                   on          (a11.DMWTT_ID = a13.DMWTT_ID)
                 left outer join                 MAXDAT.D_OPS_GROUP_TASK                 a14
                   on          (a13."Task Type" = a14."Task Type")
where      (a12."Cancel Work Flag" in ('N')
and a11.D_DATE = To_Date('13-03-2023', 'dd-mm-yyyy') and a12."Current Task Type"  = 'Manual Human Task' 
and a12."Current Task Status" = 'UNCLAIMED'
and a12."Complete Flag" in ('N')) 
);

commit;