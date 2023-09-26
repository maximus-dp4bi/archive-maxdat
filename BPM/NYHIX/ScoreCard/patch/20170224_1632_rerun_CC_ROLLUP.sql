drop table DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP;
commit;

create table DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP
(
  office         VARCHAR2(100),
  building       VARCHAR2(100)
);

GRANT select on DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP to MAXDAT;


insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('11CW FL-6  Z-1','11 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('11CW FL-6  Z-2','11 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('11CW FL-6  Z-3','11 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('E&' || 'E 11CW','11 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('22CW FL-2  Z-1','22 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('22CW FL-2  Z-2','22 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('22CW FL-2  Z-3','22 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('22CW FL-4  Z-1','22 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('22CW FL-4  Z-2','22 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('E&' || 'E 22CW','22 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('30 Broad','NYC');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('NYC FL-16','NYC');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('NYC FL-17','NYC');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('NYC FL-5','NYC');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-1','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-2','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-1 Z-1','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-1 Z-2','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-2 Z-3','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-2 Z-4','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-2 Z-5','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('833 FL-2 Z-6','833 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('ROC ARU','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('11 Suite A','11 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('11 Suite D','11 - ALBANY');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-121','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-122','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-123','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-124','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-127','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-145','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-146','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-15','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-155','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-172','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('AT-182','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('TEMP','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-1','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-2','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-3','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-4','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-5','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-6','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-7','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc N Z-8','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-10','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-11','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-12','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-13','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-14','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-15','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-16','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-17','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Roc S Z-9','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Rochester','ROCHESTER');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('E&' || 'E What If Office','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('15 Corporate','N/A');
insert into dp_scorecard.scorecard_office_building_lkup (office, building) values ('Maximus','');
commit;


