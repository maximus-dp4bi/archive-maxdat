--insert new provider numbers
INSERT INTO emrs_d_provider_ref(provider_number)
SELECT provider_number FROM emrs_s_provider_stg s
WHERE NOT EXISTS(SELECT 1 FROM emrs_d_provider_ref r WHERE s.provider_number = r.provider_number);

--delete duplicates
DELETE FROM emrs_d_provider
WHERE ofc_hr_days_of_week IS NOT NULL;

--correct current flag,version and end date
DECLARE  
  CURSOR temp_cur IS
 SELECT t.*,CASE WHEN nw_end < sysdate THEN 'N' ELSE 'Y' END current_flag
FROM (
SELECT provider_number,provider_id,version,row_number() over(partition by provider_number order by provider_id) nw_version
    ,date_of_validity_start,date_of_validity_end
    ,COALESCE(lead(date_of_validity_start,1)  over(partition by provider_number order by provider_id),to_date('12/31/2050','mm/dd/yyyy')) nw_end
FROM emrs_d_provider
WHERE provider_number IN(18362051,
18361921,
18362389,
18361786,
21362654,
21362653,
21362642,
18361889,
18362269,
18361908,
18361752,
18361784,
20380020,
21362667,
18362329,
17277636,
21362562,
18362324,
21362583,
18361831,
20380027,
18362443,
18362445,
18362287,
18361880,
18361982,
18361774,
18362441,
18362237,
18362289,
18362118,
18361933,
18361919,
18361910,
18361887,
18362041,
18361872,
18361925,
18362451,
21362612,
18361970,
21362657,
18362416,
18361853,
20086871,
18362351,
18362270,
21362656,
18362388,
18361890,
21362682,
21362560,
17277791,
18362425,
18361816,
20086873,
18361967,
18362199,
18361762,
20603411,
18361793,
21362561,
18362475,
21362565,
18361977,
21362641,
18361874,
18361773,
21362584,
21362585,
18361916,
21362659,
18361928,
18361903,
21362638,
18361875,
18361885,
18361899,
18362450,
18361866,
18362039,
18362474,
21362651,
18362473,
21362685,
18361886,
21362634,
21362568,
21362573,
18362032,
18361907,
21362593,
18361932,
18361893,
18361901,
18361881,
18361884,
18362424,
18362200,
18362291,
21362570,
18361931,
18362418,
18361850,
21362644,
18361747,
18361917,
18361902,
21362578,
18361803,
21362663,
18361906,
21362680,
21362580,
18362290,
18361924,
18361920,
18362302,
18361854,
21362629,
18362009,
18362456,
21362576,
18361883,
21362640,
18362042,
18362448,
18361926,
21362635,
18362471,
18361983,
21362566,
21362582,
21362668,
18362251,
21362587,
21362652,
18361819,
18361839,
24824970,
18361879,
21362636,
21362574,
18361765,
21362658,
18362163,
21362646,
21362571,
18361986,
21362577,
18361923,
18361744,
18361775,
18361978,
20380026,
21362586,
18361760)
 ORDER BY provider_number,provider_id
) t;
   
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
         UPDATE emrs_d_provider
         SET version = temp_tab(indx).nw_version
             ,date_of_validity_end = temp_tab(indx).nw_end
             ,current_flag = temp_tab(indx).current_flag
         WHERE provider_id = temp_tab(indx).provider_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
      SELECT t.*,CASE WHEN nw_end < sysdate THEN 'N' ELSE 'Y' END current_flag
      FROM (
        SELECT provider_number,provider_id,version,row_number() over(partition by provider_number order by provider_id) nw_version
               ,date_of_validity_start,date_of_validity_end
               ,COALESCE(lead(date_of_validity_start,1)  over(partition by provider_number order by provider_id),to_date('12/31/2050','mm/dd/yyyy')) nw_end
        FROM emrs_d_provider
        WHERE provider_number IN(SELECT provider_number FROM emrs_d_provider p
                                 WHERE current_flag = 'N'
                                 AND NOT EXISTS(SELECT 1 FROM emrs_d_provider dp WHERE p.provider_number = dp.provider_number AND current_flag = 'Y'))
        ORDER BY provider_number,provider_id
          ) t; 

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
         UPDATE emrs_d_provider
         SET version = temp_tab(indx).nw_version
             ,date_of_validity_end = temp_tab(indx).nw_end
             ,current_flag = temp_tab(indx).current_flag
         WHERE provider_id = temp_tab(indx).provider_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

--correct version and provider id in stage table
DECLARE  
  CURSOR temp_cur IS
    SELECT s.provider_number,dp.version nw_version,dp.upd_provider_id nw_upd_provider_id,s.version,s.upd_provider_id
    FROM emrs_s_provider_stg s
    INNER JOIN( SELECT dp.provider_number,dp.managed_care_program, COALESCE(MAX(version),0) version, COALESCE(MAX(provider_id),0) upd_provider_id
               FROM emrs_d_provider dp           
               WHERE dp.version = (SELECT MAX(version)
                                  FROM emrs_d_provider dp1
                                  WHERE dp.provider_number = dp1.provider_number
                                   AND dp.managed_care_program = dp1.managed_care_program
                                  AND dp1.current_flag = 'Y')
                GROUP BY provider_number,managed_care_program
                ) dp
    ON s.provider_number = dp.provider_number
    AND s.managed_care_program = dp.managed_care_program
   WHERE s.upd_provider_id != 0
   AND (s.upd_provider_id != dp.upd_provider_id OR s.version != dp.version);

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
         UPDATE emrs_s_provider_stg
         SET version = temp_tab(indx).nw_version
             ,upd_provider_id = temp_tab(indx).nw_upd_provider_id             
         WHERE provider_number = temp_tab(indx).provider_number;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
      SELECT t.*,CASE WHEN nw_end < sysdate THEN 'N' ELSE 'Y' END current_flag
      FROM (
        SELECT provider_number,provider_id,version,row_number() over(partition by provider_number order by provider_id) nw_version
               ,date_of_validity_start,date_of_validity_end
               ,COALESCE(lead(date_of_validity_start,1)  over(partition by provider_number order by provider_id),to_date('12/31/2050','mm/dd/yyyy')) nw_end
               ,MAX(provider_id) over(partition by provider_number) current_provider_id
        FROM emrs_d_provider      
        ORDER BY provider_number,provider_id
          ) t; 

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
         UPDATE emrs_d_provider
         SET version = temp_tab(indx).nw_version
             ,date_of_validity_end = temp_tab(indx).nw_end
             ,current_flag = temp_tab(indx).current_flag
             ,current_provider_id = temp_tab(indx).current_provider_id
         WHERE provider_id = temp_tab(indx).provider_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

COMMIT;