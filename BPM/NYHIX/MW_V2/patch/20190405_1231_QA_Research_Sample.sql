CREATE OR REPLACE VIEW MAXDAT.QARESEARCH_SAMPLE_SV
AS select distinct COMPLETE_DATE, TASK_TYPE, TASK_ID,ECN  from
(select a11.COMPLETE_DATE COMPLETE_DATE,
a12.TASK_NAME TASK_TYPE,
a11.TASK_ID TASK_ID,
a13.ecn ECN
from maxdat.D_MW_V2_CURRENT_SV a11
left outer join maxdat.D_TASK_TYPES_SV a12 on a11.TASK_TYPE_ID = a12.TASK_TYPE_ID
left outer join maxdat.d_nyhix_mfd_current_V2 a13 on a11.source_reference_id = a13.app_doc_tracker_id
           and a11.SOURCE_REFERENCE_TYPE='App Doc Tracker ID'
where a11.CURR_TASK_STATUS in ('COMPLETED')
and a11.TASK_TYPE_ID in (2013010, 2013012, 2013028, 2013029, 2013037, 2013053, 2013054, 2013058, 2013400, 2013421, 2013450, 2016155, 2016156)
and trunc(a11.complete_date) > add_months(sysdate,-3) and source_reference_type is not null and a13.ecn is not null
order by dbms_random.value)
where rownum <=50
order by COMPLETE_DATE,TASK_TYPE,TASK_ID,ECN;

Grant select on QAResearch_Sample_SV to MAXDAT_READ_ONLY;
