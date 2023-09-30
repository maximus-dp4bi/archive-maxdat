delete from DP_SCORECARD.WFL_SC_EXCLUSION_20191002
where exclusion_id 
in ( select exclusion_id from DP_SCORECARD.SC_EXCLUSION );

commit;

insert into dp_scorecard.SC_EXCLUSION
select * from DP_SCORECARD.WFL_SC_EXCLUSION_20191002
order by EXCLUSION_ID;

commit;