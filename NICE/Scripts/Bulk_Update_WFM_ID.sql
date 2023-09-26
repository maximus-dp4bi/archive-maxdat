-- Create temp table to hold Username and WFM ID
Create table #tmp (oldWFM varchar(20), newWFM varchar(20))

-- Insert data


INSERT INTO #tmp values ('80201348', '45201348')
INSERT INTO #tmp values ('80201331', '45201331')
INSERT INTO #tmp values ('80201335', '45201335')
INSERT INTO #tmp values ('80201302', '45201302')
INSERT INTO #tmp values ('80201282', '45201282')
INSERT INTO #tmp values ('80201322', '45201322')
INSERT INTO #tmp values ('80201312', '45201312')
INSERT INTO #tmp values ('80201294', '45201294')
INSERT INTO #tmp values ('80201351', '45201351')
INSERT INTO #tmp values ('80201297', '45201297')
INSERT INTO #tmp values ('80201328', '45201328')
INSERT INTO #tmp values ('80201318', '45201318')
INSERT INTO #tmp values ('80201293', '45201293')
INSERT INTO #tmp values ('80201347', '45201347')
INSERT INTO #tmp values ('80201299', '45201299')
INSERT INTO #tmp values ('80201365', '45201365')
INSERT INTO #tmp values ('80201298', '45201298')
INSERT INTO #tmp values ('80201309', '45201309')
INSERT INTO #tmp values ('80201336', '45201336')
INSERT INTO #tmp values ('80201332', '45201332')
INSERT INTO #tmp values ('80201289', '45201289')



--select * from #tmp

DECLARE @oldWFM varchar(20), @newWFM varchar(20)

DECLARE db_cursor CURSOR FOR  
SELECT oldWFM, newWFM 
FROM #tmp 

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @oldWFM, @newWFM  

WHILE @@FETCH_STATUS = 0   
BEGIN   
     update nice_wfm_customer1..r_agt set C_ID = @newWFM where C_ID = @oldWFM

	 update nice_wfm_customer1..R_USER set  C_USERNAME = @newWFM where C_USERNAME = @oldWFM

	-- select C_ID, C_EXTERNALID from nice_wfm_customer1..r_agt where C_ID = @oldWFM
	 
	 
     FETCH NEXT FROM db_cursor INTO @oldWFM, @newWFM   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor

DROP TABLE #tmp
