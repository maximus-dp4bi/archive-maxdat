insert into dp_scorecard.scorecard_office_building_lkup
(OFFICE, BUILDING)
select '11CW FL-2 Z-C', '11 - ALBANY' from dual
where not exists 
( select 'x' from dp_scorecard.scorecard_office_building_lkup 
where office = '11CW FL-2 Z-C');

commit;

insert into dp_scorecard.scorecard_office_building_lkup
(OFFICE, BUILDING)
select '833 FL-2 Z-7',  '833 - ALBANY' from dual
where not exists 
( select 'x' from dp_scorecard.scorecard_office_building_lkup 
where office = '833 FL-2 Z-7');

commit;

insert into dp_scorecard.scorecard_office_building_lkup
(OFFICE, BUILDING)
select '11CW FL-2 Z-B', '11 - ALBANY' from dual
where not exists 
( select 'x' from dp_scorecard.scorecard_office_building_lkup 
where office = '11CW FL-2 Z-B');

commit;

insert into dp_scorecard.scorecard_office_building_lkup
(OFFICE, BUILDING)
select '11CW FL-2 Z-D', '11 - ALBANY' from dual
where not exists 
( select 'x' from dp_scorecard.scorecard_office_building_lkup 
where office = '11CW FL-2 Z-D' );

commit;

insert into dp_scorecard.scorecard_office_building_lkup
(OFFICE, BUILDING)
select '11CW FL-2 Z-A', '11 - ALBANY' from dual
where not exists 
( select 'x' from dp_scorecard.scorecard_office_building_lkup 
where office = '11CW FL-2 Z-A' );

commit;
