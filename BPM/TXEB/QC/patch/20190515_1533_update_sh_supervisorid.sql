
BEGIN
FOR x IN(select q.survey_id, q.supervisor_id,s.ext_staff_number, s.staff_id,q.sup_last_name,q.sup_first_name,s.last_name,s.first_name
         from qc_reviews_sv q
          join qc_staff s on q.supervisor_id = s.staff_id
         where SUP_LAST_NAME is not null) LOOP
 UPDATE survey_header_info
 SET supervisor_id  = TO_NUMBER(x.ext_staff_number)
 WHERE survey_id = x.survey_id;
END LOOP;
END;
/

COMMIT;