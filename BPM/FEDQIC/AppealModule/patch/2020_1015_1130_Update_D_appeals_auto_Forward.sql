## Delete and add records 

delete from maxdat.d_appeal_auto_forwards  
where auto_forward_id = 1770;

insert into maxdat.d_appeal_auto_forwards ( auto_forward_id, auto_forward_name, auto_forward_description)
values (0,NULL,NULL);
insert into maxdat.d_appeal_auto_forwards ( auto_forward_id, auto_forward_name, auto_forward_description)
values (1,NULL,NULL);

commit;