CREATE OR REPLACE VIEW coverva_dmas.dmas_mms_ldap_full_load_vw AS
SELECT last_name,first_name,UPPER(CONCAT(last_name,',',SUBSTR(first_name,1,1))) lname_initial,worker_name, ldap,rnk 
             FROM(SELECT last_name,first_name,CONCAT(first_name,' ',last_name) worker_name,ldap,RANK() OVER(PARTITION BY ldap ORDER BY file_date DESC) rnk  
                  FROM coverva_dmas.mms_ldap_full_load ldap  
                    JOIN coverva_dmas.dmas_file_log lf ON UPPER(ldap.filename) = lf.filename) l  
WHERE rnk = 1
AND NOT EXISTS(SELECT 1 FROM coverva_mio.employees e where e.ldap_id = l.ldap)
UNION ALL
SELECT last_name,first_name,lname_initial,worker_name,ldap,rnk
FROM(SELECT last_name,first_name,UPPER(CONCAT(last_name,',',SUBSTR(first_name,1,1))) lname_initial,CONCAT(first_name,' ',last_name) worker_name,ldap_id ldap
       ,RANK() OVER(PARTITION BY ldap_id ORDER BY id DESC) rnk  
     FROM coverva_mio.employees)
WHERE rnk = 1
;
