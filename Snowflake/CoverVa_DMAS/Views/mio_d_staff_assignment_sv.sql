USE SCHEMA PUBLIC;
CREATE OR REPLACE VIEW mio_d_staff_assignment_sv 
AS
SELECT m.manager,s.supervisor
  ,sf.employee_id, CONCAT(e.first_name, ' ', e.last_name) employee_name
  ,CASE WHEN sf.category_hierarchy1 = 'Application' AND ef.functional_area != 'VDE' THEN 1 ELSE 0 END count_staff_applications
  ,CASE WHEN sf.category_hierarchy1 = 'Renewal' AND ef.functional_area != 'VDE' THEN 1 ELSE 0 END count_staff_renewals
  ,CASE WHEN ef.functional_area = 'VDE' THEN 1 ELSE 0 END count_staff_vde
  ,CASE WHEN sf.specialty = 'None' AND ef.functional_area != 'VDE' THEN 1 ELSE 0 END count_staff_none
  ,CASE WHEN sf.specialty = 'Pregnant Women' AND ef.functional_area != 'VDE' THEN 1 ELSE 0 END count_staff_pw
  ,CASE WHEN sf.specialty = 'Manual' AND ef.functional_area != 'VDE' THEN 1 ELSE 0 END count_staff_manual
  ,CASE WHEN sf.specialty = 'Worker Manual' AND ef.functional_area != 'VDE' THEN 1 ELSE 0 END count_staff_worker_manual
  ,ef.functional_area
FROM coverva_mio.safe sf
  JOIN coverva_mio.employees e ON e.id = sf.employee_id
  JOIN coverva_mio.employees_look_functional_area ef ON e.functional_area = ef.id
  LEFT JOIN mio_d_supervisor_sv s ON e.supervisor = s.id
  LEFT JOIN mio_d_manager_sv m ON e.manager = m.id;