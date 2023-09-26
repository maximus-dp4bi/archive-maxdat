delete f_appeals_by_day_by_part where d_date >= '25-APR-20';
insert into F_APPEALS_BY_DAY_BY_PART ft
(SELECT  SEQ_ABD_DP_ID.nextVal,d_date, appeal_part_id, creation_count, inventory_count,sla_inventory_count, completion_count, closed_count,cancellation_count,withdrawn_count, termination_count,timely_appeals_count, untimely_appeals_count, last_update_date 
FROM (
SELECT 
d_date
,appeal_part_id
,sum(creation_count) as creation_count
,sum(inventory_count) as inventory_count
,sum(sla_inventory_count) as sla_inventory_count
,sum(completion_count) as completion_count
,sum(closed_count) as closed_count
,sum(cancellation_count) as cancellation_count
,sum(withdrawn_count) as withdrawn_count
,sum(termination_count) as termination_count
,sum(timely_appeals_count) as timely_appeals_count
,sum(untimely_appeals_count) as untimely_appeals_count
,sysdate as last_update_date
from (
SELECT 
a.appeal_id,
bdd.d_date,
a.appeal_part_id,
              CASE WHEN bdd.D_DATE = TRUNC(a.CREATE_DATE) THEN 1 ELSE 0 END AS CREATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE)) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE))
		OR (a.COMPLETE_DATE IS NOT NULL AND bdd.d_DATE >= TRUNC(a.COMPLETE_DATE))
		THEN 0 ELSE 1 END AS SLA_INVENTORY_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.COMPLETE_DATE) THEN 1 ELSE 0 END AS COMPLETION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.CLOSED_DATE) THEN 1 ELSE 0 END AS CLOSED_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.CANCELLED_DATE) THEN 1 ELSE 0 END AS CANCELLATION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE) THEN 1 ELSE 0 END AS WITHDRAWN_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.CLOSED_DATE) OR bdd.D_DATE = TRUNC(a.CANCELLED_DATE) OR bdd.D_DATE = TRUNC(a.WITHDRAWN_DATE)) THEN 1 ELSE 0 END AS TERMINATION_COUNT,
              CASE WHEN  (bdd.D_DATE = TRUNC(a.COMPLETE_DATE) AND bdd.D_DATE <= a.DEADLINE_DATE AND a.complete_date <= a.deadline_date) THEN 1 ELSE 0 END as TIMELY_APPEALS_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(a.COMPLETE_DATE) AND (bdd.D_DATE > a.DEADLINE_DATE or a.complete_date > a.deadline_date)) THEN 1 ELSE 0 END as UNTIMELY_APPEALS_COUNT
FROM D_DATES bdd
JOIN D_MW_APPEAL_INSTANCE a
  ON  (
       ((a.create_date is null) OR (bdd.D_DATE >= TRUNC(a.CREATE_DATE)))
       AND (
                ((closed_date is null) OR (bdd.d_date <= trunc(closed_date))) AND
 		((cancelled_date is null) OR (bdd.d_date <= trunc(cancelled_date))) AND
     		((withdrawn_date is null) OR (bdd.d_date <= trunc(withdrawn_date)))
            )
    )
WHERE bdd.D_DATE >= '25-APR-20'
)
group by d_date, appeal_part_id
));
commit;
insert into F_APPEALS_BY_DAY_BY_PART 
(ABD_DP_ID,
D_DATE,
APPEAL_PART_ID,
creation_count,
inventory_count,
sla_inventory_count,
completion_count,
closed_count,
cancellation_count,
withdrawn_count,
termination_count,
timely_appeals_count,
untimely_appeals_count,
LAST_UPDATE_DATE)
SELECT 
SEQ_ABD_DP_ID.nextVal, res.*, sysdate as last_update_date from
(select
bdd.d_date
,ap.part_id
,sum(0) as creation_count
,sum(0) as inventory_count
,sum(0) as sla_inventory_count
,sum(0) as completion_count
,sum(0) as closed_count
,sum(0) as cancellation_count
,sum(0) as withdrawn_count
,sum(0) as termination_count
,sum(0) as timely_appeals_count
,sum(0) as untimely_appeals_count
FROM D_DATES bdd
CROSS JOIN d_appeal_parts ap
WHERE bdd.D_DATE >= '25-APR-20'   
group by bdd.d_date, ap.part_id
order by bdd.d_date, ap.part_id) res
where not exists (select 1 from f_appeals_by_day_by_part ft 
where ft.d_date = res.d_date 
and ft.appeal_part_id = res.part_id);
commit;
delete f_appeal_tasks_by_day where d_date >= '25-APR-20';
insert into F_APPEAL_TASKS_BY_DAY ft
(SELECT  SEQ_ATBD_DPT_ID.nextVal,d_date, appeal_part_id, task_type_id,creation_count, inventory_count,completion_count,cancellation_count,last_update_date 
FROM (
SELECT 
d_date
,appeal_part_id
,task_type_id
,sum(creation_count) as creation_count
,sum(inventory_count) as inventory_count
,sum(completion_count) as completion_count
,sum(cancellation_count) as cancellation_count
,sysdate as last_update_date
from (
SELECT 
bdd.d_date,
a.appeal_part_id as appeal_part_id,
t.task_type_id,
              CASE WHEN bdd.D_DATE = TRUNC(t.CREATE_DATE) THEN 1 ELSE 0 END AS CREATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(t.COMPLETE_DATE) OR bdd.D_DATE = TRUNC(t.CANCEL_WORK_DATE)) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(t.COMPLETE_DATE) THEN 1 ELSE 0 END AS COMPLETION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(t.CANCEL_WORK_DATE) THEN 1 ELSE 0 END AS CANCELLATION_COUNT
FROM D_DATES bdd
JOIN D_MW_TASK_INSTANCE t
  ON  (
       (bdd.D_DATE >= TRUNC(t.CREATE_DATE))
       AND (
                ((t.complete_date is null) OR (bdd.d_date <= trunc(t.complete_date))) AND
 		((t.cancel_work_date is null) OR (bdd.d_date <= trunc(t.cancel_work_date))) 
            )
    )
join D_MW_APPEAL_INSTANCE a
ON t.source_reference_id = a.appeal_id
WHERE bdd.D_DATE >= '25-APR-20'
)
group by d_date, appeal_part_id, task_type_id
));
commit;
insert into F_APPEAL_TASKS_BY_DAY
(ATD_DPT_ID,
D_DATE,
APPEAL_PART_ID,
TASK_TYPE_ID,
creation_count,
inventory_count,
completion_count,
cancellation_count,
LAST_UPDATE_DATE)
SELECT 
SEQ_ATBD_DPT_ID.nextVal, res.*, sysdate as last_update_date from
(select
bdd.d_date
,ap.part_id as appeal_part_id
,t.status_id as task_type_id
,sum(0) as creation_count
,sum(0) as inventory_count
,sum(0) as completion_count
,sum(0) as cancellation_count
FROM D_DATES bdd
CROSS JOIN D_APPEAL_STATUSES t
CROSS JOIN d_appeal_parts ap
WHERE bdd.D_DATE >= '25-APR-20'
group by bdd.d_date, ap.part_id, t.status_id
order by bdd.d_date, ap.part_id,t.status_id) res
where not exists (select 1 from f_appeal_tasks_by_day ft 
where ft.d_date = res.d_date 
and ft.appeal_part_id = res.appeal_part_id and ft.task_type_id = res.task_type_id);
commit;