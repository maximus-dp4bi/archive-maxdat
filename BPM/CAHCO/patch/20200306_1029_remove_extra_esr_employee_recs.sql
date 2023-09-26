--EsrId 33188 removed from source system
--EsrId 289094 duplicate record removed from source system
delete from emrs_d_esr_employee
where esre_id in(4,911);

commit;