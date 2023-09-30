
DROP INDEX FABD_LUPDATE;

commit;

update F_APPEALS_BY_DAY_BY_PART set 
creation_count = 0,
inventory_count=0,
sla_inventory_count=0,
completion_count=0,
closed_count=0,
cancellation_count=0,
withdrawn_count=0,
termination_count=0,
timely_appeals_count=0,
untimely_appeals_count=0,
last_update_date=sysdate;

commit;

update  F_APPEALS_BY_DAY_BY_PART ft
set (creation_count, inventory_count,sla_inventory_count, completion_count, closed_count,cancellation_count,withdrawn_count, termination_count,timely_appeals_count, untimely_appeals_count, last_update_date) = 
(SELECT  creation_count, inventory_count,sla_inventory_count, completion_count, closed_count,cancellation_count,withdrawn_count, termination_count,timely_appeals_count, untimely_appeals_count, last_update_date 
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
WHERE bdd.D_DATE >= TRUNC((SYSDATE - trunc((select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')/2)),'MONTH')
)
group by d_date, appeal_part_id
) results
where ft.d_date = results.d_date
and ft.appeal_part_id = results.appeal_part_id
)
where ft.d_date >= TRUNC((SYSDATE - trunc((select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')/2)),'MONTH')
and ft.last_update_date >= trunc(sysdate-1,'hh');

commit;

update  F_APPEALS_BY_DAY_BY_PART ft
set (creation_count, inventory_count,sla_inventory_count, completion_count, closed_count,cancellation_count,withdrawn_count, termination_count,timely_appeals_count, untimely_appeals_count, last_update_date) = 
(SELECT  creation_count, inventory_count,sla_inventory_count, completion_count, closed_count,cancellation_count,withdrawn_count, termination_count,timely_appeals_count, untimely_appeals_count, last_update_date 
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
WHERE bdd.D_DATE >= TRUNC((SYSDATE - (select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')),'MONTH')
AND bdd.d_date < TRUNC((SYSDATE - trunc((select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')/2)),'MONTH')
)
group by d_date, appeal_part_id
) results
where ft.d_date = results.d_date
and ft.appeal_part_id = results.appeal_part_id
)
WHERE ft.D_DATE >= TRUNC((SYSDATE - (select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')),'MONTH')
AND ft.d_date < TRUNC((SYSDATE - trunc((select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')/2)),'MONTH')
and ft.last_update_date >= trunc(sysdate-1,'hh');

commit;



