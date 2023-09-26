UPDATE RESPONSE_AFTER_TERM_STG
SET aid_end = replace(aid_end,'.0')
   ,dte_rfi_sent = replace(dte_rfi_sent,'.0')
   ,dte_dhs_med_app = replace(dte_dhs_med_app,'.0')
   ,dte_rfi_response_due = replace(dte_rfi_response_due,'.0')
   ,as_of_date = replace(as_of_date,'''');


BEGIN
  FOR x IN (select client_id,nam_last,nam_first
	    from(
		select i.client_id, i.client_cin,nam_last,nam_first,i.application_id,
                      count(i.application_id) over (partition by nam_last,nam_first) cnt
		from RESPONSE_AFTER_TERM_STG t 
		 join app_individual_stg i on nam_last = client_lname and nam_first = client_fname 
	    where priority_flag = 2
	    and t.client_id is null)
 	    where cnt = 1) LOOP

  UPDATE RESPONSE_AFTER_TERM_STG
  SET client_id = x.client_id
      rids_id = x.client_cin
  WHERE nam_last = x.nam_last
  AND nam_first = x.nam_first
  AND priority_flag = 2
  AND client_id is null;
  
END LOOP;
END;
/



UPDATE response_after_term_stg
SET rids_id = '11042393489'
WHERE nam_first = 'KATHERINE'
AND nam_last = 'SMITH';

UPDATE response_after_term_stg
SET rids_id = '97041062928'
WHERE nam_first = 'SHUSHARA'
AND nam_last = 'JOHNSON';

UPDATE response_after_term_stg
SET rids_id = '78702040348'
WHERE nam_first = 'NICOLE'
AND nam_last = 'NAVA';

UPDATE response_after_term_stg
SET rids_id = '11036614007'
WHERE nam_first = 'MASON'
AND nam_last = 'REEVES';

UPDATE response_after_term_stg
SET rids_id = '11048187554'
WHERE nam_first = 'JUAN'
AND nam_last = 'MORENO';

UPDATE response_after_term_stg
SET rids_id = '97040908246'
WHERE nam_first = 'ETHAN'
AND nam_last = 'STRONG';

UPDATE response_after_term_stg
SET rids_id = '11021653855'
WHERE nam_first = 'CRESENCIO'
AND nam_last = 'BARRIENTOS';


UPDATE response_after_term_stg
SET rids_id = '97040893583'
WHERE nam_first = 'DAVID'
AND nam_last = 'PRUITT';

UPDATE response_after_term_stg
SET rids_id = '97040966246'
WHERE nam_first = 'MORGAN'
AND nam_last = 'WALKER';

UPDATE response_after_term_stg
SET rids_id = '97041010260'
WHERE nam_first = 'HECTOR'
AND nam_last = 'MEDINA RODRIGUEZ';

UPDATE response_after_term_stg
SET rids_id = '97041006271'
WHERE nam_first = 'NELSON'
AND nam_last = 'MORALES CHAVEZ';

UPDATE response_after_term_stg
SET rids_id = '11047529826'
WHERE nam_first = 'ARLETTE'
AND nam_last = 'GARCIA';

UPDATE response_after_term_stg
SET rids_id = '11046100419'
WHERE nam_first = 'JENNIFER'
AND nam_last = 'MEDINA';
  
UPDATE response_after_term_stg
SET rids_id = '78702040198'
WHERE nam_first = 'AVA'
AND nam_last = 'ANDERSON';
  
UPDATE response_after_term_stg
SET rids_id = '78702042500'
WHERE nam_first = 'ANTHONY'
AND nam_last = 'BANKS' ;

UPDATE response_after_term_stg
SET rids_id = '78702041652'
WHERE nam_first = 'JAXON'
AND nam_last = 'HOOPER';   

UPDATE response_after_term_stg
SET rids_id = '97041024180'
WHERE nam_first = 'MARYBETH'
AND nam_last = 'HARVEY';        

UPDATE response_after_term_stg e
SET rids_id = (select distinct client_cin from app_individual_stg i where e.client_id = i.client_id)
WHERE  e.client_id is not null
AND e.rids_id is null;

UPDATE response_after_term_stg e
SET client_id = (select distinct client_id from app_individual_stg i where e.rids_id = i.client_cin)
WHERE  e.client_id is null
AND e.rids_id is not null;

delete FROM response_after_term_stg  s
where priority_flag = 3
and rids_id in('97007441413',
'11014225881',
'11046586028',
'11018783730',
'11030073349',
'11020970661',
'11026256307',
'00721309860',
'00722053249',
'11018142564',
'11018529531',
'11030573465',
'11027228021',
'11026078115',
'97041126501',
'11028185351',
'11025146800',
'11028483238',
'00731959242',
'00718487293')
and rowid = (select min(rowid) from response_after_term_stg t where t.client_id = s.client_id and t.priority_flag = s.priority_flag);


BEGIN
  FOR x IN(SELECT * FROM (
            SELECT client_id, 
            (SELECT MIN(priority_flag)
             FROM response_after_term_stg t
             WHERE r.client_id = t.client_id
             AND priority_flag <=2 ) prior_group
           FROM response_after_term_stg r
           WHERE priority_flag = 4)
          WHERE prior_group IS NOT NULL) 
  LOOP         
    UPDATE response_after_term_stg
    SET prior_group = x.prior_group
    WHERE client_id = x.client_id
    AND priority_flag = 4;
  END LOOP;
END;
/

commit;