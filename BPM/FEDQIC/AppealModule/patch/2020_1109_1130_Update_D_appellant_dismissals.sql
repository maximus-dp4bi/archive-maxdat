delete from maxdat.d_appellant_dismissals  
where dismissal_id = 1764;

insert into maxdat.d_appellant_dismissals ( d_ad_id, dismissal_id, dismissal_name,dismissal_description)
values (1,0,'No','No');
insert into maxdat.d_appellant_dismissals ( d_ad_id, dismissal_id, dismissal_name,dismissal_description)
values (2,1,'Yes','Yes');

commit;