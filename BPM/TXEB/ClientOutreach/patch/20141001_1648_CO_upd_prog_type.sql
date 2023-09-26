DECLARE  
  CURSOR temp_cur IS
  select outreach_id,client_id,service_area,county
  from CORP_ETL_CLNT_OUTREACH
  where INSTANCE_STATUS = 'Complete'
  and client_id is not null
  and (program_type is null or program_type = 'CHIP');

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;
  v_prgm_type VARCHAR2(20);
  v_servc_area VARCHAR2(100);
  v_cnty VARCHAR2(100);
BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FOR indx IN 1..temp_tab.COUNT LOOP
         v_prgm_type := NULL;
         --for the 2 fields below, set to the same values if in case the query to csi stage does not return any rows
         v_servc_area := temp_tab(indx).service_area;
         v_cnty := temp_tab(indx).county;  
         FOR p IN(SELECT case when program_cd ='MEDICAID'then program_cd else null end as prgm_type
                          , service_area as servc_area
                          , addr_county_label as cnty
                     FROM client_supplementary_info_stg
                     WHERE client_id = temp_tab(indx).client_id
                     ORDER BY prgm_type ASC)
          LOOP
            v_prgm_type := p.prgm_type;
            v_servc_area := p.servc_area;
            v_cnty := p.cnty;
            EXIT; --get first record only
          END LOOP;

          UPDATE CORP_ETL_CLNT_OUTREACH
            SET program_type = v_prgm_type
                ,COUNTY = v_cnty 
               ,SERVICE_AREA = v_servc_area   
          WHERE outreach_id = temp_tab(indx).outreach_id;
        END LOOP; 
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/
