delete from coverkids_approval_stg
where trunc(create_date) = to_date('01/24/2018','mm/dd/yyyy')
and cumulative_ind = 'N'
and application_id not in(918244,144427);


--put member 408 letter on hold so the member would be excluded on the CoverKids report
UPDATE letters_stg
SET letter_status_cd = 'HOLD'
WHERE letter_id = 2422031;

commit;