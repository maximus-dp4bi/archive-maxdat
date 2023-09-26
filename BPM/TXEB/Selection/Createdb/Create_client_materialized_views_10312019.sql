-- Create table
DROP MATERIALIZED VIEW TX_ETL_ELIG_UNPIVOT_MV;
CREATE MATERIALIZED VIEW TX_ETL_ELIG_UNPIVOT_MV
NOLOGGING
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
with COORD_UNPIVOTS as (
Select /*+Parallel(5) */job_id, ROW_NUM, ALIAS_FLAG, CLIENT_NBR, MBI, SSCN, CLIENT_NAME, BIRTH_DATE, MAIL_ZIP, SSN, FILENAME
, MATCH_CLIENT_ID
, NEW_CLIENT_ID
, MATCH_CASE_ID
, NEW_CASE_ID
, ENROLL_SEGMENT, COORD_PLAN, COORD_FROM, COORD_TO, COORD_STATUS_CODE
From
(Select /*+Index(e,TX_ETL_L_ELIGIBILITY_IDX4)*/e.job_id,
e.CLIENT_NBR, e.ALIAS_FLAG
, e.row_num
, MBI
, SSCN
, Client_Name
, BIRTH_DATE
, MAIL_ZIP
, SSN
, FILENAME
, MATCH_CLIENT_ID
, NEW_CLIENT_ID
, MATCH_CASE_ID
, NEW_CASE_ID
, e.cand_candidate_flag1, e.cand_candidate_flag2, e.cand_program1
, e.cand_program2, e.coord_plan1, e.coord_plan2, e.coord_plan3, e.coord_plan4, e.coord_plan5, e.coord_plan6, e.coord_plan7, e.coord_plan8
, e.coord_plan9, e.coord_plan10, e.coord_plan11, e.coord_plan12
, e.coord_from1, e.coord_from2, e.coord_from3, e.coord_from4, e.coord_from5, e.coord_from6, e.coord_from7, e.coord_from8, e.coord_from9
, e.coord_from10, e.coord_from11, e.coord_from12
, e.coord_to1, e.coord_to2, e.coord_to3, e.coord_to4, e.coord_to5, e.coord_to6, e.coord_to7, e.coord_to8, e.coord_to9, e.coord_to10
, e.coord_to11, e.coord_to12
, e.coord_status_code1, e.coord_status_code2, e.coord_status_code3, e.coord_status_code4, e.coord_status_code5, e.coord_status_code6
, e.coord_status_code7, e.coord_status_code8, e.coord_status_code9, e.coord_status_code10, e.coord_status_code11, e.coord_status_code12
From MAXDAT.TX_ETL_L_ELIGIBILITY e--Partition(P230000)E
Where e.alias_flag is null
--and job_id = 328740 and row_num = 290486
)
UNPIVOT((COORD_PLAN, COORD_FROM, COORD_TO, COORD_STATUS_CODE)
FOR ENROLL_SEGMENT IN ((coord_plan1, coord_From1, coord_to1, coord_status_code1) as '01',
(coord_plan2, coord_From2, coord_to2, coord_status_code2) as '02',
(coord_plan3, coord_From3, coord_to3, coord_status_code3) as '03',
(coord_plan4, coord_From4, coord_to4, coord_status_code4) as '04',
(coord_plan5, coord_From5, coord_to5, coord_status_code5) as '05',
(coord_plan6, coord_From6, coord_to6, coord_status_code6) as '06',
(coord_plan7, coord_From7, coord_to7, coord_status_code7) as '07',
(coord_plan8, coord_From8, coord_to8, coord_status_code8) as '08',
(coord_plan9, coord_From9, coord_to9, coord_status_code9) as '09',
(coord_plan10, coord_From10, coord_to10, coord_status_code10) as '10',
(coord_plan11, coord_From11, coord_to11, coord_status_code11) as '11',
(coord_plan12, coord_From12, coord_to12, coord_status_code12) as '12')
)
Where 1=1
and COORD_PLAN IN ('4F','4G','4H','9J','9K','3G','3H','7Q','7V','7Z','H9','HA','H8','6F','6G')
and COORD_FROM IS NOT NULL
)
--, Prior_reporting as (
Select job_id
, row_num
, CLIENT_NBR
, MBI
, SSCN
, Client_Name
, BIRTH_DATE
, MAIL_ZIP
, SSN
, FILENAME
, MATCH_CLIENT_ID
, NEW_CLIENT_ID
, MATCH_CASE_ID
, NEW_CASE_ID
, ENROLL_SEGMENT, COORD_PLAN, COORD_FROM, COORD_TO, COORD_STATUS_CODE
From COORD_UNPIVOTS
;

CREATE INDEX TX_ETL_ELIG_UNPIVOT_MV_IDX1 ON TX_ETL_ELIG_UNPIVOT_MV(JOB_ID, CLIENT_NBR);
CREATE INDEX TX_ETL_ELIG_UNPIVOT_MV_IDX2 ON TX_ETL_ELIG_UNPIVOT_MV(CLIENT_NBR);

grant select on TX_ETL_ELIG_UNPIVOT_MV to MAXDAT_READ_ONLY;
grant select on TX_ETL_ELIG_UNPIVOT_MV to MAXDAT_REPORTS;


DROP MATERIALIZED VIEW TX_ETL_ELIG_CAND_MV;
CREATE MATERIALIZED VIEW TX_ETL_ELIG_CAND_MV
NOLOGGING
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
Select /*parallel(5) +Index(e,TX_ETL_L_ELIGIBILITY_IDX4)*/ E.JOB_ID
, e.CLIENT_NBR, ALIAS_FLAG
, e.ALIAS_FLAG
, e.row_num
, MBI
, SSCN
, Client_Name
, BIRTH_DATE
, MAIL_ZIP
, SSN
, FILENAME
, MATCH_CLIENT_ID
, NEW_CLIENT_ID
, MATCH_CASE_ID
, NEW_CASE_ID
, cand_program1, cand_program2, cand_candidate_flag1, cand_candidate_flag2
From MAXDAT.TX_ETL_L_ELIGIBILITY e
Where alias_flag IS NULL
--and job_id = 328740 and row_num = 290486
and ((e.cand_program1 = '2' and e.cand_candidate_flag1 = 'D') or (e.cand_program2 = '2' and e.cand_candidate_flag2 = 'D'))
;

grant select on TX_ETL_ELIG_CAND_MV to MAXDAT_READ_ONLY;
grant select on TX_ETL_ELIG_CAND_MV to MAXDAT_REPORTS;

CREATE INDEX TX_ETL_ELIG_CAND_MV_IDX1 ON TX_ETL_ELIG_CAND_MV(JOB_ID, CLIENT_NBR) parallel 20;
CREATE INDEX TX_ETL_ELIG_CAND_MV_IDX2 ON TX_ETL_ELIG_CAND_MV(CLIENT_NBR) parallel 20;
CREATE INDEX TX_ETL_ELIG_CAND_MV_IDX1 ON TX_ETL_ELIG_CAND_MV(JOB_ID, row_num) parallel 20;

DROP VIEW TX_ETL_ELIG_UNPIVOT_SV;
CREATE VIEW TX_ETL_ELIG_UNPIVOT_SV AS SELECT * FROM TX_ETL_ELIG_UNPIVOT_MV;

DROP VIEW TX_ETL_ELIG_CAND_SV;
CREATE VIEW TX_ETL_ELIG_CAND_SV AS SELECT * FROM TX_ETL_ELIG_CAND_MV;

grant select on TX_ETL_ELIG_UNPIVOT_SV to MAXDAT_READ_ONLY;
grant select on TX_ETL_ELIG_UNPIVOT_SV to MAXDAT_REPORTS;
grant select on TX_ETL_ELIG_CAND_SV to MAXDAT_READ_ONLY;
grant select on TX_ETL_ELIG_CAND_SV to MAXDAT_REPORTS;
