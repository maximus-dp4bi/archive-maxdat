        
/**
CISCo VCP sql for IVR Data model
*/        
        
        
select t1.*       
    ,det.elementname as exit_point, det.callguid as det_guid      
    ,tcd2.PrecisionQueueID, pq.EnterpriseName as PQName, tcd2.CallTypeID, ct.EnterpriseName as CTName, tcd2.TalkTime, tcd2.HoldTime, tcd2.WorkTime, tcd2.RingTime, tcd2.TimeToAband
    ,DATEADD(minute, (t1.localtimezoneoffset)*-1, cast(t1.callstartdate as datetime)) as callstartdate_utc          
from        
(       
  select distinct f.callstartdate, f.startdatetime, f.enddatetime, f.appname, e.eventtypeid, e.eventtype, c.causeid, c.cause, f.duration, f.callguid, cl.ani, cl.dnis     
      ,tcd.RouterCallKeyDay, tcd.RouterCallKey, f.localtimezoneoffset    
  --- select *      
  from   CVPApps.dbo.VXMLSession f      
  left join CVPApps.dbo.CauseRef c on (f.causeid = c.causeid)     
  left join CVPApps.dbo.EventTypeRef e on (f.eventtypeid = e.eventtypeid)     
  left outer join CVPApps.dbo.Call cl on (f.callguid = cl.callguid)     
  left outer join maxco_awdb.dbo.Termination_Call_Detail tcd on (f.callguid = tcd.CallGUID and cl.dnis = tcd.DNIS)      
  where  f.appname  = '${APP_NAME_TO_LOAD}'     
    and    f.callstartdate >= '2020-04-01'        
    and    f.callstartdate <= '2020-04-01'        
  union all     
  select distinct f.callstartdate, f.startdatetime, f.enddatetime,f.appname, e.eventtypeid, e.eventtype, c.causeid, c.cause, f.duration, f.callguid, cl.ani, cl.dnis      
      ,tcd.RouterCallKeyDay, tcd.RouterCallKey, f.localtimezoneoffset    
  from   CVPApps_B.dbo.VXMLSession f      
  left join CVPApps_B.dbo.CauseRef c on (f.causeid = c.causeid)     
  left join CVPApps_B.dbo.EventTypeRef e on (f.eventtypeid = e.eventtypeid)     
  left outer join CVPApps_B.dbo.Call cl on (f.callguid = cl.callguid)     
  left outer join maxco_awdb.dbo.Termination_Call_Detail tcd on (f.callguid = tcd.CallGUID and cl.dnis = tcd.DNIS)      
  where  f.appname  = '${APP_NAME_TO_LOAD}'     
    and    f.callstartdate >= '2020-04-01'        
    and    f.callstartdate <= '2020-04-01'        
) t1        
left outer join maxco_awdb.dbo.Termination_Call_Detail tcd2 on (t1.RouterCallKeyDay = tcd2.RouterCallKeyDay         
                                                            and t1.RouterCallKey = tcd2.RouterCallKey         
      and tcd2.CallReferenceID is not null  
      and tcd2.PrecisionQueueID is not null)  
left outer join maxco_awdb.dbo.Call_Type ct on (tcd2.CallTypeID = ct.CallTypeID)        
left outer join maxco_awdb.dbo.Precision_Queue pq on (tcd2.PrecisionQueueID = pq.PrecisionQueueID)        
left outer join         
(       
  select f.appname, f.callstartdate, f.callguid     
      ,el.elementid,el.exitdatetime, el.elementname, e.elementtype, el.exitstate, r.result    
      ,ROW_NUMBER () OVER (PARTITION BY el.callguid, el.callstartdate order by el.exitdatetime desc, el.elementid desc) as RN       
  from   CVPApps.dbo.VXMLSession f      
  join   CVPApps.dbo.VXMLElement el on (el.callguid = f.callguid and el.callstartdate = f.callstartdate)      
  join   CVPApps.dbo.ResultRef r on (el.resultid = r.resultid)      
  join   CVPApps.dbo.ElementTypeRef e on (el.elementtypeid = e.elementtypeid and el.elementtypeid = 9)      
  where  f.appname  = '${APP_NAME_TO_LOAD}'     
    and    f.callstartdate >= '2020-04-01'        
    and    f.callstartdate <= '2020-04-01'        
  UNION     
  select f.appname, f.callstartdate, f.callguid     
      ,el.elementid,el.exitdatetime, el.elementname, e.elementtype, el.exitstate, r.result    
      ,ROW_NUMBER () OVER (PARTITION BY el.callguid, el.callstartdate order by el.exitdatetime desc, el.elementid desc) as RN       
  from   CVPApps_B.dbo.VXMLSession f      
  join   CVPApps_B.dbo.VXMLElement el on (el.callguid = f.callguid and el.callstartdate = f.callstartdate)      
  join   CVPApps_B.dbo.ResultRef r on (el.resultid = r.resultid)      
  join   CVPApps_B.dbo.ElementTypeRef e on (el.elementtypeid = e.elementtypeid and el.elementtypeid = 9)      
  where  f.appname  = '${APP_NAME_TO_LOAD}'     
    and    f.callstartdate >= '2020-04-01'        
    and    f.callstartdate <= '2020-04-01'        
) det on (det.callstartdate = t1.callstartdate and det.callguid = t1.callguid and det.RN = 1)
;