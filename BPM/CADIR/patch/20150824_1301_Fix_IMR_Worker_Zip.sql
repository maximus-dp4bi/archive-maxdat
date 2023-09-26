update s_crs_imr
set injured_worker_zip = null
where imr_id in (555024,1018739,2325963);

commit;

update s_crs_imr
set injured_worker_zip = substr(injured_worker_zip, 1, 5)
where IMR_ID IN (118367216,
118371915,
118319137,
118500562,
118520717);

commit;