set define off
insert into dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP(office)
values('Roc E&E');
commit;

delete from dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP
where office = 'Roc S Z-18'
and rowid = 'AANj3AAAJAAB8v3AAC';
commit;

update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP
set office = 'ROCARU'
where office = 'ROC ARU';
commit;