update corp_etl_proc_letters
set letter_definition_id = 497
where letter_type = 'MMP Unauthorized Enrollment Request Letter'
and letter_definition_id != 497;

update corp_etl_proc_letters
set letter_definition_id = 431
where letter_type = 'Refund Address Confirmation (CHIP)'
and letter_definition_id is null;

update corp_etl_proc_letters
set letter_definition_id = 439
where letter_type = 'Disenrollment Request Information'
and (letter_definition_id != 439 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 454
where letter_type = 'Case Management Letter'
and (letter_definition_id != 454 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 446
where letter_type = 'Enrollment Transfer Forms (CHIP)'
and (letter_definition_id != 446 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 716
where letter_type = 'Charge Back Letter (CHIP)'
and (letter_definition_id != 716 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 458
where letter_type = 'HE Foster care Enrollment Packet'
and (letter_definition_id != 458 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 425
where letter_type = 'Cost Share Not Met'
and (letter_definition_id != 425 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 493
where letter_type = 'MMP Unauthorized Disenrollment Request Letter'
and (letter_definition_id != 493 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 403
where letter_type = 'Extra Effort Referral Letter'
and (letter_definition_id != 403 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 758
where letter_type = 'Retro Notification Letter'
and (letter_definition_id != 758 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 484
where letter_type = 'MMP Enrollment Request Form'
and (letter_definition_id != 484 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 488
where letter_type = 'MMP Opt In Cancellation Letter'
and (letter_definition_id != 488 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 424
where letter_type = 'Cost Share Met'
and (letter_definition_id != 424 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 447
where letter_type = 'Medical Payment Form: Blank (CHIP)'
and (letter_definition_id != 447 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 448
where letter_type = 'Medical Payment Form: Prefilled (CHIP)'
and (letter_definition_id != 448 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 494
where letter_type = 'MMP Loss of Medicare Eligibility Letter'
and (letter_definition_id != 494 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 489
where letter_type = 'MMP Out of Service Area Disenrollment Letter'
and (letter_definition_id != 489 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 434
where letter_type = 'Materials Request'
and (letter_definition_id != 434 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 411
where letter_type = 'Provider Outreach Referral Letter'
and (letter_definition_id != 411 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 445
where letter_type = 'Medical Payment Coupon (CHIP)'
and (letter_definition_id != 445 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 456
where letter_type = 'Foster Care Mandatory Enrollment Packet'
and (letter_definition_id != 456 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 460
where letter_type = 'ACA Former Foster Care - notice to clients under 21 (one-time)'
and (letter_definition_id != 460 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 452
where letter_type = 'Dental Packet Request (MEDICAID)'
and (letter_definition_id != 452 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 485
where letter_type = 'MMP Enrollment Confirmation Letter'
and (letter_definition_id != 485 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 413
where letter_type = 'Pregnant Parenting Teens'
and (letter_definition_id != 413 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 419
where letter_type = 'Enrollment Package Request (CHIP)'
and (letter_definition_id != 419 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 409
where letter_type = 'SSI and Foster Care Follow-Up Letter'
and (letter_definition_id != 409 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 407
where letter_type = 'CPW Referral Follow-up'
and (letter_definition_id != 407 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 465
where letter_type = 'CHIP Special Packet'
and (letter_definition_id != 465 or letter_definition_id is null);


update corp_etl_proc_letters
set letter_definition_id = 487
where letter_type = 'MMP Denial of Enrollment Letter'
and (letter_definition_id != 487 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 405
where letter_type = 'Leaving DFPS Conservatorship'
and (letter_definition_id != 405 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 423
where letter_type = 'Health Plan Denial'
and (letter_definition_id != 423 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 756
where letter_type = 'NorthSTAR only w/Medicare Mandatory Enrollment Packet'
and (letter_definition_id != 756 or letter_definition_id is null);


update corp_etl_proc_letters
set letter_definition_id = 412
where letter_type = 'Parenting Teens'
and (letter_definition_id != 412 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 450
where letter_type = 'Medical Enrollment Packet Request (MEDICAID)'
and (letter_definition_id != 450 or letter_definition_id is null);

update corp_etl_proc_letters
set letter_definition_id = 491
where letter_type = 'MMP Opt In Letter'
and (letter_definition_id != 491 or letter_definition_id is null);

commit;

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'MMP STAR+PLUS Re-enrollment Letter'
     and (letter_definition_id != 492 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  492           
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Missing Information Letter'
     and (letter_definition_id != 408 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  408          
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Non Sufficient Funds'
     and (letter_definition_id != 717 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  717          
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Health Plan Change'
     and (letter_definition_id != 421 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  421          
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/


DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'MMP Opt Out Letter'
     and (letter_definition_id != 490 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  490          
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Enrollment Missing Info'
     and (letter_definition_id != 418 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  418          
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = '2nd Enrollment Reminder'
     and (letter_definition_id != 20 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  20          
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Missed Appointment Letter'
     and (letter_definition_id != 410 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  410          
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'NorthSTAR Mandatory Enrollment Packet'
     and (letter_definition_id != 437 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  437          
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Transfer Approval'
     and (letter_definition_id != 430 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  430          
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Enrollment Fee'
     and (letter_definition_id != 429 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  429          
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'StarPlus Expansion Reminder Letter'
     and (letter_definition_id != 475 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  475          
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'MMP PE Reminder Letter'
     and (letter_definition_id != 483 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  483         
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'MMP PE Enrollment Letter'
     and (letter_definition_id != 482 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  482         
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'MMP PE Intro Letter'
     and (letter_definition_id != 481 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  481         
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Cost Share Change'
     and (letter_definition_id != 433 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  433         
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Pregnant Women Letter'
     and (letter_definition_id != 414 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  414        
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Non-Participant Letter'
     and (letter_definition_id != 401 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  401        
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Enrollment Reminder'
     and (letter_definition_id != 420 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  420        
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = '4-Month Dental Letter'
     and (letter_definition_id != 402 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  402        
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Newly Certified Letter - HCO'
     and (letter_definition_id != 441 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  441        
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/


DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Enrollment Confirmation'
     and (letter_definition_id != 422 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  422        
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Medical Voluntary Enrollment Letter'
     and (letter_definition_id != 438 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  438        
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Newly Certified Letter'
     and (letter_definition_id != 101 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  101        
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Checkup Reminder Dental Letter'
     and (letter_definition_id != 761 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  761        
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/


DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'One Time Letter'
     and (letter_definition_id != 757 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  757        
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Special Outreach Letter'
     and (letter_definition_id != 776 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  776        
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Enrollment Letter'
     and (letter_definition_id != 417 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  417        
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id
     from corp_etl_proc_letters l
     where letter_type = 'Checkup Reminder Medical Letter'
     and (letter_definition_id != 453 OR letter_definition_id IS NULL)
   ;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update corp_etl_proc_letters nf
         set letter_definition_id =  453        
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select l.letter_request_id,l.letter_definition_id
     from corp_etl_proc_letters l, d_pl_current p
     where l.letter_request_id = p.letter_request_id
     and p.letter_definition_id is null
     and l.letter_definition_id is not null
--     and l.letter_type = 'Checkup Due Letter'
--     and p.letter_type = 'Checkup Due Letter'
;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update d_pl_current nf
         set letter_definition_id =  temp_tab(indx).letter_definition_id
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/