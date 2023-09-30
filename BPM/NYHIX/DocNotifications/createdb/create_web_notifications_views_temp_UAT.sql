Alter session set current_schema=maxdat;

DROP VIEW D_NYHIX_WEB_NOTIFICATIONS_SV;

CREATE VIEW D_NYHIX_WEB_NOTIFICATIONS_SV
AS
SELECT DISTINCT --a12.COMPLETE_DATE  COMPLETE_DATE_TIME, 
  a11.kofax_dcn,
  (Case when a12.TASK_TYPE_ID in (2013019) and a11.CREATE_DT <=  a12.COMPLETE_DATE then 1 else 0 end)  GODWFLAG2_1,
  (Case when a12.TASK_TYPE_ID in (2016306, 2016308, 2013051, 2013050, 2016307, 2013052) and a11.CREATE_DT >= a12.create_date then 1 else 0 end)  GODWFLAG4_1,
  TRUNC(a12.complete_date) complete_date,
  'Consumer Docs(Web)' as document_type,
  'Web' as channel,
  (Case when a12.TASK_TYPE_ID in (2013019) and a11.CREATE_DT <=  a12.COMPLETE_DATE then 1 else 0 end)   +
  (Case when a12.TASK_TYPE_ID in (2016306, 2016308, 2013051, 2013050, 2016307, 2013052) and a11.CREATE_DT >= a12.create_date then 1 else 0 end) as 
   completed_count
FROM D_NYHIX_DOC_NOTIF_CURRENT a11
INNER JOIN D_MW_V2_CURRENT a12
ON a12.SOURCE_PROCESS_INSTANCE_ID = a11.PROCESS_INSTANCE_ID
WHERE a11.KOFAX_DCN LIKE 'U%'
AND a12.CURR_TASK_STATUS = 'COMPLETED'
AND ( ( a12.TASK_TYPE_ID in (2016306,2013054,2016308,2013051,2013050,2016307,2013052) AND a11.CREATE_DT >= a12.create_date) 
  OR  (a12.task_type_id = 2013019 AND a11.CREATE_DT <= a12.COMPLETE_DATE ) )
UNION
  select 'U190786781807' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/03/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION
select 'U190806954347' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/03/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION 
select 'U190806954356' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/03/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION  
select 'U190806954535' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/03/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION 
select 'U190806954720' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/03/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION
select 'U190786781999' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/04/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION
select 'U190806954999' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/04/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION
select 'U190806954999' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/04/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION
select 'U190806954999' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/04/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION
select 'U190806954999' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/04/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION
select 'U190786781888' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/05/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION
select 'U190806954888' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/05/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION
select 'U190806954888' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/05/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION
select 'U190806954888' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/05/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual
UNION
select 'U190806954888' KOFAX_DCN, null as GODWFLAG2_1, null as GODWFLAG4_1,to_date('04/05/2019','mm/dd/yyyy') as COMPLETE_DATE, 'Consumer Docs(Web)' as DOCUMENT_TYPE, 'Web' as CHANNEL,1 as COMPLETED_COUNT from dual;


grant select on D_NYHIX_WEB_NOTIFICATIONS_SV to MAXDAT_READ_ONLY;  
