USE SCHEMA PUBLIC;
CREATE OR REPLACE VIEW mio_d_supervisor_sv AS
    SELECT 
        e.id AS id,
        CONCAT(e.first_name, ' ', e.last_name) AS Supervisor,
        lfa.functional_area AS FunctionalArea,
        e.emp_email AS Email,
        e.max_emp_id AS Max_Emp_ID
    FROM coverva_mio.employees e
      JOIN coverva_mio.employees_look_job_title ljt ON e.job_title = ljt.id
      JOIN coverva_mio.employees_look_functional_area lfa ON e.functional_area = lfa.id
    WHERE ljt.supervisor = 1
     AND ljt.isactive = 1
     AND e.end_date IS NULL ;
    
CREATE OR REPLACE VIEW mio_d_manager_sv AS
    SELECT 
        e.id AS id,
        CONCAT(e.first_name, ' ', e.last_name) AS Manager,
        e.emp_email AS emp_email
    FROM coverva_mio.employees e
        JOIN coverva_mio.employees_look_job_title ljt ON e.job_title = ljt.id
    WHERE ljt.manager = 1
    AND ljt.isactive = 1
    AND e.end_date IS NULL  ;
    
CREATE OR REPLACE VIEW mio_d_supervisor_manager_combined_sv AS
    SELECT 
        mgr.id AS id,
        mgr.Manager AS SupManName,
        mgr.emp_email AS Email
    FROM
        mio_d_manager_sv mgr
    UNION SELECT 
        sup.id AS id,
        sup.Supervisor AS SupManName,
        sup.Email AS Email
    FROM
        mio_d_supervisor_sv sup;    