select * from R_PROCESS --where C_USER = '8a16cc945479f78f0154c4d569983946'

select * from R_RSRCLOCK WHERE C_PROCDESCR = 'Generate Schedule' and C_USER = '8a16cc945479f78f0154c4d569983946'

select * from R_RSRCLOCKDTL WHERE C_RSRCLOCK IN (select C_OID from R_RSRCLOCK WHERE C_PROCDESCR = 'Generate Schedule' and C_USER = '8a16cc945519a40201552bba55db27c7')

/*
Delete from R_PROCESS where  C_OID = '8a16cc946224f9ad01622fc8d2695068'

Delete from R_RSRCLOCKDTL WHERE C_RSRCLOCK IN (select C_OID from R_RSRCLOCK WHERE C_PROCDESCR = 'Schedule Management')-- and C_USER = '8a16cc945519a40201552bba55db27c7')
Delete from R_RSRCLOCK WHERE C_PROCDESCR = 'Schedule Management' --and C_USER = '8a16cc945519a40201552bba55db27c7'

Delete from R_RSRCLOCKDTL WHERE C_RSRCLOCK IN (select C_OID from R_RSRCLOCK WHERE C_PROCDESCR = 'Individual Schedules')-- and C_USER = '8a16cc945519a40201552bba55db27c7')
Delete from R_RSRCLOCK WHERE C_PROCDESCR = 'Individual Schedules' --and C_USER = '8a16cc945519a40201552bba55db27c7'
Delete from R_RSRCLOCKDTL WHERE C_RSRCLOCK IN (select C_OID from R_RSRCLOCK WHERE C_PROCDESCR = 'Generate Schedule')-- and C_USER = '8a16cc945519a40201552bba55db27c7')
Delete from R_RSRCLOCK WHERE C_PROCDESCR = 'Generate Schedule' --and C_USER = '8a16cc945519a40201552bba55db27c7'
Delete from R_RSRCLOCKDTL WHERE C_RSRCLOCK IN (select C_OID from R_RSRCLOCK WHERE C_PROCDESCR = 'Generate Forecast')-- and C_USER = '8a16cc945519a40201552bba55db27c7')
Delete from R_RSRCLOCK WHERE C_PROCDESCR = 'Generate Forecast' --and C_USER = '8a16cc945519a40201552bba55db27c7'
Delete from R_RSRCLOCKDTL WHERE C_RSRCLOCK IN (select C_OID from R_RSRCLOCK WHERE C_PROCDESCR = 'Simulate Schedules')-- and C_USER = '8a16cc945519a40201552bba55db27c7')
Delete from R_RSRCLOCK WHERE C_PROCDESCR = 'Simulate Schedules' --and C_USER = '8a16cc945519a40201552bba55db27c7'
Delete from R_RSRCLOCKDTL WHERE C_RSRCLOCK IN (select C_OID from R_RSRCLOCK WHERE C_PROCDESCR = 'Schedule Optimizer')-- and C_USER = '8a16cc945519a40201552bba55db27c7')
Delete from R_RSRCLOCK WHERE C_PROCDESCR = 'Schedule Optimizer' --and C_USER = '8a16cc945519a40201552bba55db27c7'

*/