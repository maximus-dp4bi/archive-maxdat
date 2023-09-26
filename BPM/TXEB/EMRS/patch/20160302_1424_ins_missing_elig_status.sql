INSERT INTO emrs_d_client_ref(client_number)
SELECT distinct client_id
FROM  client_supplementary_info_stg i
where not exists(select 1 from emrs_d_client_ref r where i.client_id = r.client_number);

commit;

create table client_elig_status_bak
as
select * from client_elig_status_stg s
where not exists(select 1 from emrs_d_client_plan_eligibility p where s.client_elig_status_id = p.source_record_id);


DECLARE  
  CURSOR temp_cur IS
   SELECT *
FROM (
SELECT t.* , row_number() over (partition by client_number,plan_type_id order by source_record_id) new_version
FROM 
(SELECT null client_plan_eligibility_id
       ,(SELECT plan_type_id FROM emrs_d_plan_type t WHERE t.plan_type = k.plan_type_cd and t.managed_care_program = k.program_cd) plan_type_id
       ,elig_status_cd eligibility_status_code
       ,null current_eligibility_status_cd
       ,user created_by
       ,create_ts date_created
       ,start_date date_of_validity_start
       ,CASE WHEN end_date IS NULL THEN to_date('12/31/2050','mm/dd/yyyy') ELSE end_date END date_of_validity_end
       ,update_ts date_updated
       ,user updated_by
       ,CASE WHEN end_date IS NULL THEN 'Y' ELSE 'N' END current_flag
       ,client_elig_status_id source_record_id
       ,client_id client_number
       ,(SELECT sub_program_id FROM emrs_d_sub_program s WHERE s.parent_program_name = k.program_cd AND s.sub_program_code = k.subprogram_type) sub_program_id
       ,null version
from client_elig_status_bak k
--where client_id = 14828600
UNION
SELECT  client_plan_eligibility_id
       ,plan_type_id
       ,eligibility_status_code
       ,current_eligibility_status_cd
       ,created_by
       ,date_created
       ,date_of_validity_start
       ,date_of_validity_end
       ,date_updated
       ,updated_by
       ,current_flag
       ,source_record_id
       ,client_number
       ,sub_program_id
       ,version
from emrs_d_client_plan_eligibility p
where exists(select 1 from client_elig_status_bak k where p.client_number = k.client_id)
--where client_number = 14828600 
) t ) f
WHERE (client_plan_eligibility_id IS NULL
  OR version <> new_version)
and exists(select 1 from  emrs_d_client_ref r where r.client_number = f.client_number)
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FOR indx IN 1..temp_tab.COUNT
       LOOP
         IF temp_tab(indx).client_plan_eligibility_id IS NULL THEN
           INSERT INTO emrs_d_client_plan_eligibility(plan_type_id
       ,eligibility_status_code
       ,current_eligibility_status_cd
       ,created_by
       ,date_created
       ,date_of_validity_start
       ,date_of_validity_end
       ,date_updated
       ,updated_by
       ,current_flag
       ,source_record_id
       ,client_number
       ,sub_program_id
       ,version)
           VALUES(temp_tab(indx).plan_type_id
       ,temp_tab(indx).eligibility_status_code
       ,temp_tab(indx).current_eligibility_status_cd
       ,temp_tab(indx).created_by
       ,temp_tab(indx).date_created
       ,temp_tab(indx).date_of_validity_start
       ,temp_tab(indx).date_of_validity_end
       ,temp_tab(indx).date_updated
       ,temp_tab(indx).updated_by
       ,temp_tab(indx).current_flag
       ,temp_tab(indx).source_record_id
       ,temp_tab(indx).client_number
       ,temp_tab(indx).sub_program_id
       ,temp_tab(indx).new_version);
         ELSE
           update emrs_d_client_plan_eligibility
           set version = temp_tab(indx).new_version             
           where client_plan_eligibility_id = temp_tab(indx).client_plan_eligibility_id ;		   
        END IF;
       END LOOP;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

--to get elig status codes that are missing in client_elig_status_stg
drop table client_elig_status_bak;

create table client_elig_status_bak
as
select source_record_id from emrs_d_client_plan_eligibility s 
where not exists(select 1 from client_elig_status_stg p where p.client_elig_status_id = s.source_record_id);

DECLARE  
  CURSOR temp_cur IS
  select e.client_plan_eligibility_id, s.end_date
  from emrs_d_client_plan_eligibility e, client_elig_status_stg s
  where e.source_record_id = s.client_elig_status_id
  and date_of_validity_end > sysdate
  and s.end_date is not null;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE emrs_d_client_plan_eligibility
         SET date_of_validity_end = temp_tab(indx).end_date
             ,current_flag = 'N'
         WHERE client_plan_eligibility_id = temp_tab(indx).client_plan_eligibility_id;        
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
  select s.client_elig_status_id, e.date_of_validity_end
  from emrs_d_client_plan_eligibility e, client_elig_status_stg s
  where e.source_record_id = s.client_elig_status_id
  and date_of_validity_end < sysdate
  and s.end_date is null;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE client_elig_status_stg
         SET end_date = temp_tab(indx).date_of_validity_end             
         WHERE client_elig_status_id = temp_tab(indx).client_elig_status_id;        
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
  select client_elig_status_id
  FROM client_elig_Status_mi_bak;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
        DELETE FROM client_elig_status_stg
        WHERE client_elig_Status_id = temp_tab(indx).client_elig_Status_id;        
     END;
     
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
        DELETE FROM emrs_d_client_plan_eligibility
        WHERE source_record_id = temp_tab(indx).client_elig_Status_id;        
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

update CLIENT_ELIG_STATUS_STG
set end_date = to_date('05/13/2014 06:03:15','mm/dd/yyyy hh24:mi:ss')
where client_elig_status_id = 23413375;

update emrs_d_client_plan_eligibility
set date_of_validity_start = (select start_date from client_elig_status_stg where client_elig_status_id = 74685483)
where source_record_id = 74685483;

update emrs_d_client_plan_eligibility
set date_of_validity_start = (select start_date from client_elig_status_stg where client_elig_status_id = 74685488)
where source_record_id = 74685488;

update emrs_d_client_plan_eligibility
set date_of_validity_start = (select start_date from client_elig_status_stg where client_elig_status_id = 74685493)
where source_record_id = 74685493;

commit;

DECLARE  
  CURSOR temp_cur IS
  select start_date, client_elig_status_id
  FROM client_elig_Status_stg
  WHERE trunc(start_date) = to_date('03/18/2015','mm/dd/yyyy');
  --WHERE trunc(start_date) between to_date('07/09/2015','mm/dd/yyyy') and to_date('07/25/2015','mm/dd/yyyy');
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
        UPDATE emrs_d_client_plan_eligibility
        SET date_of_validity_start = temp_tab(indx).start_date
        WHERE source_record_id = temp_tab(indx).client_elig_Status_id;        
     END;
          
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/