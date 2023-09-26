UPDATE emrs_d_esr_employee
SET active = 'D' -- deleted in source
WHERE esre_id IN(978,982);

commit;