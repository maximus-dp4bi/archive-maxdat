USE SCHEMA COVERVA_MIO;
CREATE OR REPLACE VIEW mio_inventory_full_load_vw AS
   SELECT 
        e.first_name AS first_name,
        e.last_name AS last_name,
        e.ldap_id AS ldap_id,
        cp.case_number AS case_number,
        cp.task_status AS task_status,
        cp.denial_reason AS denial_reason,
        cp.transferred_to AS transferred_to,
        cp.location AS location,
        cp.why AS why,
        cp.additional_case_outcomes AS additional_case_outcomes,
        cp.number_approved AS number_approved,
        cp.vcl_doc_type_requested AS vcl_doc_type_requested,
        cp.vcl_due AS vcl_due,
        CONVERT_TIMEZONE('UTC', 'America/New_York',cp.bucket_date) AS disposition_date,
        CONVERT_TIMEZONE('UTC', 'America/New_York',cp.updated) AS updated
    FROM coverva_mio.case_pool cp
      LEFT JOIN coverva_mio.employees e ON e.id = cp.assigned_to      
UNION ALL
SELECT  e.first_name AS first_name,
        e.last_name AS last_name,
        e.ldap_id AS ldap_id,
        cp.case_number AS case_number,
        cp.task_status AS task_status,
        cp.denial_reason AS denial_reason,
        cp.transferred_to AS transferred_to,
        cp.location AS location,
        cp.why AS why,
        cp.additional_case_outcomes AS additional_case_outcomes,
        cp.number_approved AS number_approved,
        cp.vcl_doc_type_requested AS vcl_doc_type_requested,
        cp.vcl_due AS vcl_due,
        CONVERT_TIMEZONE('UTC', 'America/New_York',cp.bucket_date) AS disposition_date,
        CONVERT_TIMEZONE('UTC', 'America/New_York',cp.updated) AS updated
    FROM (SELECT *
          FROM(SELECT cp.*, RANK() OVER (PARTITION BY cp.case_number ORDER BY updated DESC, id DESC) rnk
               FROM coverva_mio.case_pool_log cp)
          WHERE rnk = 1 ) cp
      LEFT JOIN coverva_mio.employees e ON e.id = cp.assigned_to 
WHERE NOT EXISTS(SELECT 1 FROM coverva_mio.case_pool p WHERE cp.case_number = p.case_number);