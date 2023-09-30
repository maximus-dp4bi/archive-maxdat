DELETE FROM emrs_d_case
WHERE case_id IN(
10977846,
10979017,
10978016,
10979076,
10979218,
10979309,
10977880,
10979164,
10979306,
10979962,
10980245,
10979649,
10979319,
10977896,
10979150,
10979241,
10979261,
10979932,
10979312,
10977960,
10979047,
10979163,
10979662,
10979945,
10980232,
10979376,
10979667,
10979288,
10979308,
10979313,
10979055,
10977767,
10979688,
10979525,
10979652,
10980233,
10979939,
10979941,
10979654,
10979061,
10979140,
10979228,
10977761,
10977778,
10979669,
10979450,
10979481,
10979002,
10979944,
10979696,
10979303,
10979083,
10979580,
10979300,
10979375,
10979931,
10977773);

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE client_enroll_status_id = 23911725;

UPDATE emrs_d_client_plan_enrl_status
SET version = 5
WHERE client_enroll_status_id = 23855754;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE client_enroll_status_id = 23911917;

UPDATE emrs_d_client_plan_enrl_status
SET version = 15
WHERE client_enroll_status_id = 23911927;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE client_enroll_status_id = 23912476;

UPDATE emrs_d_client_plan_enrl_status
SET version = 9
WHERE client_enroll_status_id = 23912432;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE client_enroll_status_id = 23912443;

UPDATE emrs_d_client_plan_enrl_status
SET version = 8
WHERE client_enroll_status_id = 23912475;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE client_enroll_status_id = 23912431;

UPDATE emrs_d_client_plan_enrl_status
SET version = 7
WHERE client_enroll_status_id = 23912492;


UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE client_enroll_status_id = 23911636;

UPDATE emrs_d_client_plan_enrl_status
SET version = 5
WHERE client_enroll_status_id = 23911817;


UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N',version = 9
WHERE client_enroll_status_id = 23911829;

UPDATE emrs_d_client_plan_enrl_status
SET version = 10
WHERE client_enroll_status_id = 23912298;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE client_enroll_status_id = 23912603;

UPDATE emrs_d_client_plan_enrl_status
SET version = 15
WHERE client_enroll_status_id = 23912572;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end =TO_DATE('07/22/2013','MM/DD/YYYY'), current_flag = 'N'
WHERE client_enroll_status_id = 23418200;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE client_enroll_status_id = 23912588;

UPDATE emrs_d_client_plan_enrl_status
SET version = 8
WHERE client_enroll_status_id = 23912530;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE client_enroll_status_id = 23912333;

UPDATE emrs_d_client_plan_enrl_status
SET version = 11
WHERE client_enroll_status_id = 23912430;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE client_enroll_status_id = 23912606;

UPDATE emrs_d_client_plan_enrl_status
SET version = 9
WHERE client_enroll_status_id = 23912577;


UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE client_enroll_status_id = 23912221;

UPDATE emrs_d_client_plan_enrl_status
SET version = 6
WHERE client_enroll_status_id = 23912377;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end =TO_DATE('07/30/2013','MM/DD/YYYY'), current_flag = 'N'
WHERE client_enroll_status_id = 23733952;


UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE client_enroll_status_id = 23912520;

UPDATE emrs_d_client_plan_enrl_status
SET version = 10
WHERE client_enroll_status_id = 23912514;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end =TO_DATE('07/22/2013','MM/DD/YYYY'), current_flag = 'N'
WHERE client_enroll_status_id = 23418200;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end =TO_DATE('07/30/2013','MM/DD/YYYY'), current_flag = 'N'
WHERE client_enroll_status_id = 23733952;

UPDATE emrs_d_client_plan_enrl_status
SET current_enrollment_status_id = enrollment_status_id
WHERE current_enrollment_status_id IS NULL;

COMMIT;