-- Create table

create OR REPLACE VIEW TX_ETL_ELIG_UNPIVOT_SV AS
with COORD_UNPIVOTS as (
Select /*+Parallel*/job_id, CLIENT_NBR, ENROLL_SEGMENT, COORD_PLAN, COORD_FROM, COORD_TO
From
(Select /*+Index(e,TX_ETL_L_ELIGIBILITY_IDX4)*/e.job_id, 
e.CLIENT_NBR, e.ALIAS_FLAG, e.cand_candidate_flag1, e.cand_candidate_flag2, e.cand_program1
, e.cand_program2, e.coord_plan1, e.coord_plan2, e.coord_plan3, e.coord_plan4, e.coord_plan5, e.coord_plan6, e.coord_plan7, e.coord_plan8
, e.coord_plan9, e.coord_plan10, e.coord_plan11, e.coord_plan12
, e.coord_from1, e.coord_from2, e.coord_from3, e.coord_from4, e.coord_from5, e.coord_from6, e.coord_from7, e.coord_from8, e.coord_from9
, e.coord_from10, e.coord_from11, e.coord_from12
, e.coord_to1, e.coord_to2, e.coord_to3, e.coord_to4, e.coord_to5, e.coord_to6, e.coord_to7, e.coord_to8, e.coord_to9, e.coord_to10
, e.coord_to11, e.coord_to12
From MAXDAT.TX_ETL_L_ELIGIBILITY e--Partition(P230000)E
Where e.alias_flag is null

)
UNPIVOT((COORD_PLAN, COORD_FROM, COORD_TO)
FOR ENROLL_SEGMENT IN ((coord_plan1, coord_From1, coord_to1) as '01',
(coord_plan2, coord_From2, coord_to2) as '02',
(coord_plan3, coord_From3, coord_to3) as '03',
(coord_plan4, coord_From4, coord_to4) as '04',
(coord_plan5, coord_From5, coord_to5) as '05',
(coord_plan6, coord_From6, coord_to6) as '06',
(coord_plan7, coord_From7, coord_to7) as '07',
(coord_plan8, coord_From8, coord_to8) as '08',
(coord_plan9, coord_From9, coord_to9) as '09',
(coord_plan10, coord_From10, coord_to10) as '10',
(coord_plan11, coord_From11, coord_to11) as '11',
(coord_plan12, coord_From12, coord_to12) as '12'
)
)
Where 1=1
and COORD_PLAN IN ('4F','4G','4H','9J','9K','3G','3H','7Q','7V','7Z','H9','HA','H8','6F','6G')
and COORD_FROM IS NOT NULL
)
--, Prior_reporting as (
Select job_id, CLIENT_NBR, COORD_PLAN, COORD_FROM, COORD_TO
From COORD_UNPIVOTS
;

grant select on TX_ETL_ELIG_UNPIVOT_SV to MAXDAT_READ_ONLY;

