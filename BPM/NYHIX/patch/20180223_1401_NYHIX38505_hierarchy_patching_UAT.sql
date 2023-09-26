-------------------------------------------
– update maxdat.pp_wfm_staff
-------------------------------------------

select * from maxdat.pp_wfm_staff
where staff_id in (15070, 10130, 1961, 4156)
order by staff_id;

update maxdat.pp_wfm_staff set national_id = national_id||'WFLTEST'
where staff_id = 1961;

– commit if and only if 1 and only 1 row updated.

update maxdat.pp_wfm_staff set national_id = national_id||'WFLTEST'
where staff_id = 4156;

– commit if and only if 1 and only 1 row updated.
select * from maxdat.pp_wfm_staff
where staff_id in (15070, 10130, 1961, 4156)
order by staff_id;

-------------------------------------------
update maxdat.pp_wfm_supervisor_to_staff
-------------------------------------------

select * from maxdat.pp_wfm_supervisor_to_staff
where staff_id in (15070, 10130, 1961, 4156)
order by staff_id;

update maxdat.pp_wfm_supervisor_to_staff
set supervisor_id = 13352
where staff_id = 15070;

– commit if and only if 1 and only 1 row updated.

select * from maxdat.pp_wfm_supervisor_to_staff
where staff_id in (15070, 10130, 1961, 4156)
order by staff_id;