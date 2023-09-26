insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Absence (>4 hrs) (-4)',  -4, 1, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Partial Absence (1-4 hrs) (-2)',  -2, 2, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Tardy (5-59 mins late) (-1)',  -1, 3, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Left early (left up to 59 mins early) (-1)',  -1, 4, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Absence Critical (-6)',  -6, 5, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Tardy and left early (-2)',  -2, 6, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Partial Absence and Tardy/Left early (-3)',  -3, 7, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Critical Day Partial Absence (1-4 hours) (-4)',  -4, 8, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Critical Day Tardy (5-59 mins late) (-2)',  -2, 9, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Critical Day Left early (left up to 59 mins) (-2)',  -2, 10, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Excused (0)',  0, 11, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'FMLA (0)',  0, 12, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Perfect Attendance (4)',  4, 13, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Became Permanent (40)',  40, 14, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
--new entries
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Delete',  0, 15, NULL, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Incentive +1',  1, 16, 'Y', to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Incentive +2',  2, 17, 'Y', to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Incentive +3',  3, 18, 'Y', to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Incentive +4',  4, 19, 'Y', to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Incentive +5',  5, 20, 'Y', to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Incentive +6',  6, 21, 'Y', to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
commit;

/
