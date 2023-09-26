set echo on
set define off

insert into dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP(office)
values('Roc E&E');

commit;

delete from dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP where OFFICE = 'Roc Nest (Monster)';
commit;

Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set OFFICE = 'ROCARU' where office = 'ROC ARU'; 
commit;

Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'SOUTH - ROCHESTER' where office = 'ROCARU';  
commit;

Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = null where office = 'Rochester';  
commit;

Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'N/A' where office = 'Roc Nest';
commit;
 
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'NORTH - ROCHESTER' where office = 'Roc N Z-1';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'NORTH - ROCHESTER' where office = 'Roc N Z-2';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'NORTH - ROCHESTER' where office = 'Roc N Z-3';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'NORTH - ROCHESTER' where office = 'Roc N Z-4';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'NORTH - ROCHESTER' where office = 'Roc N Z-5';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'NORTH - ROCHESTER' where office = 'Roc N Z-6';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'NORTH - ROCHESTER' where office = 'Roc N Z-7';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'NORTH - ROCHESTER' where office = 'Roc N Z-8';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'SOUTH - ROCHESTER' where office = 'Roc S Z-10';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'SOUTH - ROCHESTER' where office = 'Roc S Z-11';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'SOUTH - ROCHESTER' where office = 'Roc S Z-12';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'SOUTH - ROCHESTER' where office = 'Roc S Z-13';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'SOUTH - ROCHESTER' where office = 'Roc S Z-14';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'SOUTH - ROCHESTER' where office = 'Roc S Z-15';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'SOUTH - ROCHESTER' where office = 'Roc S Z-16';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'SOUTH - ROCHESTER' where office = 'Roc S Z-17';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'SOUTH - ROCHESTER' where office = 'Roc S Z-18';
 Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'SOUTH - ROCHESTER' where office = 'Roc S Z-9';
 
 Commit;
 
 set define off

Update dp_scorecard.SCORECARD_OFFICE_BUILDING_LKUP set building = 'SOUTH - ROCHESTER' where office = 'Roc E&E';

commit;