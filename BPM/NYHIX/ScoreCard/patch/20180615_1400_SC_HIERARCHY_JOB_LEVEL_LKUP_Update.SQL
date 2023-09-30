INSERT INTO DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE
( STAFF_ID, ATTENDANCE_POINTS, START_DATE )
with raw_data as
(
select 'Bartnicki 	' as last_name,
	'Zachary			' as first_name,
	126059	 as national_id,
	58 as initial_balance,	
	'6/8/2018' as start_date 
	from dual union
select 'Huerter 	','Mindy			',56618		,52,	'6/8/2018' from dual union
select 'Melendez	','Wilfred			',101856	,49,	'6/8/2018' from dual union
select 'Palmatier	','Desiree			',59189		,58,	'6/8/2018' from dual union
select 'Trager		','Christopher		',45227		,58,	'6/8/2018' from dual union
select 'Warson		','Leslie			',124385	,56,	'6/8/2018' from dual union
select 'Atchinson	','Diana			',125617	,34,	'6/8/2018' from dual union
select 'Bartell		','William			',71494		,58,	'6/8/2018' from dual union
select 'Burch		','Endia			',101783	,56,	'6/8/2018' from dual union
select 'Hankla		','Donovan			',124306	,50,	'6/8/2018' from dual union
select 'Keenan		','Dylan			',75903		,54,	'6/8/2018' from dual union
select 'Orsini		','Jacob			',59761		,54,	'6/8/2018' from dual union
select 'Ramjattan	','Maltie			',62439		,32,	'6/8/2018' from dual union
select 'Tennyson	','Mark				',102978	,58,	'6/8/2018' from dual union
select 'Watson		','Calvin			',101773	,50,	'6/8/2018' from dual union
select 'Nickles		','Stephanie 		',122402	,54,	'6/8/2018' from dual union
select 'Daniels		','Jeremy 			',124087	,57,	'6/8/2018' from dual union
select 'Palermo		','Jennel 			',124941	,56,	'6/8/2018' from dual union
select 'Siwinski	','Jason 			',122328	,54,	'6/8/2018' from dual union
select 'Kosinov		','Julietta 		',122915	,33,	'6/8/2018' from dual union
select 'Burroughs	','Pamela 			',138236	,46,	'6/8/2018' from dual union
select 'King		','Pat 				',122551	,24,	'6/8/2018' from dual union
select 'Vito		','Samuel 			',122547	,58,	'6/8/2018' from dual union
select 'Hodson		','Danielle 		',124575	,57,	'6/8/2018' from dual union
select 'Wood		','Kimberly 		',125300	,54,	'6/8/2018' from dual union
select 'Lane		','Dylan 			',125301	,58,	'6/8/2018' from dual union
select 'Bell		','Keysha 			',126320	,51,	'6/8/2018' from dual union
select 'Fuller		','Erin 			',124795	,58,	'6/8/2018' from dual union
select 'Brown		','Krystal 			',128050	,56,	'6/8/2018' from dual union
select 'Wiley		','Jennifer 		',125669	,57,	'6/8/2018' from dual union
select 'Stageman	','Erica 			',125801	,58,	'6/8/2018' from dual union
select 'Larios		','Chrystian 		',129120	,57,	'6/8/2018' from dual union
select 'Palumbo		','Andrew 			',130840	,53,	'6/8/2018' from dual
)
select distinct 
staff.staff_id, raw_data.initial_balance, TO_DATE(raw_data.start_date,'MM/DD/YYYY')
from maxdat.pp_wfm_staff staff
join raw_data on to_char(raw_data.national_id) = staff.national_id
--join dp_scorecard.scorecard_hierarchy h on h.staff_staff_id = staff.staff_id
where staff.termination_date is null
order by 1;

COMMIT;
