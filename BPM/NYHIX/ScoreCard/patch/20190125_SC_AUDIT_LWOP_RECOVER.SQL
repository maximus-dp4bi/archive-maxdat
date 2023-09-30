	delete from dp_scorecard.SC_AUDIT_LWOP;
	
	insert into dp_scorecard.SC_AUDIT_LWOP 
	select * from dp_scorecard.SC_AUDIT_LWOP_20190125_bak;
	
	commit;
