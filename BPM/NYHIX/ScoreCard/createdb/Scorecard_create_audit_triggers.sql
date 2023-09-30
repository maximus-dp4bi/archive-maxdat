CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_ATTENDANCE 
AFTER INSERT OR UPDATE OR DELETE ON SC_ATTENDANCE 
for each row
BEGIN
IF UPDATING THEN 
  begin
    INSERT INTO SC_ATTENDANCE_AUDIT
     (Record_type              
      ,Record_action        
      ,SC_ATTENDANCE_ID     
      ,STAFF_ID             
      ,ENTRY_DATE           
      ,SC_ALL_ID            
      ,ABSENCE_TYPE         
      ,POINT_VALUE          
      ,CREATE_BY            
      ,CREATE_DATETIME      
      ,BALANCE              
      ,INCENTIVE_BALANCE    
      ,TOTAL_BALANCE        
      ,INCENTIVE_FLAG       
      ,LAST_UPDATED_BY      
      ,LAST_UPDATED_DATETIME) 
     VALUES 
      ('Update'
      ,'Delete'
      ,:old.SC_ATTENDANCE_ID     
      ,:old.STAFF_ID             
      ,:old.ENTRY_DATE           
      ,:old.SC_ALL_ID            
      ,:old.ABSENCE_TYPE         
      ,:old.POINT_VALUE          
      ,:old.CREATE_BY            
      ,:old.CREATE_DATETIME      
      ,:old.BALANCE              
      ,:old.INCENTIVE_BALANCE    
      ,:old.TOTAL_BALANCE        
      ,:old.INCENTIVE_FLAG       
      ,:old.LAST_UPDATED_BY      
      ,:old.LAST_UPDATED_DATETIME);      

    INSERT INTO SC_ATTENDANCE_AUDIT
      (Record_type              
      ,Record_action        
      ,SC_ATTENDANCE_ID     
      ,STAFF_ID             
      ,ENTRY_DATE           
      ,SC_ALL_ID            
      ,ABSENCE_TYPE         
      ,POINT_VALUE          
      ,CREATE_BY            
      ,CREATE_DATETIME      
      ,BALANCE              
      ,INCENTIVE_BALANCE    
      ,TOTAL_BALANCE        
      ,INCENTIVE_FLAG       
      ,LAST_UPDATED_BY      
      ,LAST_UPDATED_DATETIME) 
     VALUES 
      ('Update'
      ,'Insert'
      ,:new.SC_ATTENDANCE_ID     
      ,:new.STAFF_ID             
      ,:new.ENTRY_DATE           
      ,:new.SC_ALL_ID            
      ,:new.ABSENCE_TYPE         
      ,:new.POINT_VALUE          
      ,:new.CREATE_BY            
      ,:new.CREATE_DATETIME      
      ,:new.BALANCE              
      ,:new.INCENTIVE_BALANCE    
      ,:new.TOTAL_BALANCE        
      ,:new.INCENTIVE_FLAG       
      ,:new.LAST_UPDATED_BY      
      ,:new.LAST_UPDATED_DATETIME);      

  END;
END IF;
IF INSERTING THEN 
    INSERT INTO SC_ATTENDANCE_AUDIT
      (Record_type              
      ,Record_action        
      ,SC_ATTENDANCE_ID     
      ,STAFF_ID             
      ,ENTRY_DATE           
      ,SC_ALL_ID            
      ,ABSENCE_TYPE         
      ,POINT_VALUE          
      ,CREATE_BY            
      ,CREATE_DATETIME      
      ,BALANCE              
      ,INCENTIVE_BALANCE    
      ,TOTAL_BALANCE        
      ,INCENTIVE_FLAG       
      ,LAST_UPDATED_BY      
      ,LAST_UPDATED_DATETIME) 
     VALUES 
      ('Insert'
      ,'Insert'
      ,:new.SC_ATTENDANCE_ID     
      ,:new.STAFF_ID             
      ,:new.ENTRY_DATE           
      ,:new.SC_ALL_ID            
      ,:new.ABSENCE_TYPE         
      ,:new.POINT_VALUE          
      ,:new.CREATE_BY            
      ,:new.CREATE_DATETIME      
      ,:new.BALANCE              
      ,:new.INCENTIVE_BALANCE    
      ,:new.TOTAL_BALANCE        
      ,:new.INCENTIVE_FLAG       
      ,:new.LAST_UPDATED_BY      
      ,:new.LAST_UPDATED_DATETIME);      
END IF;
IF DELETING THEN 
    INSERT INTO SC_ATTENDANCE_AUDIT
     (Record_type              
      ,Record_action        
      ,SC_ATTENDANCE_ID     
      ,STAFF_ID             
      ,ENTRY_DATE           
      ,SC_ALL_ID            
      ,ABSENCE_TYPE         
      ,POINT_VALUE          
      ,CREATE_BY            
      ,CREATE_DATETIME      
      ,BALANCE              
      ,INCENTIVE_BALANCE    
      ,TOTAL_BALANCE        
      ,INCENTIVE_FLAG       
      ,LAST_UPDATED_BY      
      ,LAST_UPDATED_DATETIME) 
     VALUES 
      ('Delete'
      ,'Delete'
      ,:old.SC_ATTENDANCE_ID     
      ,:old.STAFF_ID             
      ,:old.ENTRY_DATE           
      ,:old.SC_ALL_ID            
      ,:old.ABSENCE_TYPE         
      ,:old.POINT_VALUE          
      ,:old.CREATE_BY            
      ,:old.CREATE_DATETIME      
      ,:old.BALANCE              
      ,:old.INCENTIVE_BALANCE    
      ,:old.TOTAL_BALANCE        
      ,:old.INCENTIVE_FLAG       
      ,:old.LAST_UPDATED_BY      
      ,:old.LAST_UPDATED_DATETIME);      
END IF;

END;
/
CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_CORRECTIVE_ACTION 
AFTER INSERT OR UPDATE OR DELETE ON SC_CORRECTIVE_ACTION 
for each row
BEGIN
IF UPDATING THEN 
  begin
    INSERT INTO SC_CORRECTIVE_ACTION_AUDIT
     (   Record_type              
       , Record_action         
       , CA_ID                 
       , STAFF_ID              
       , CA_ENTRY_DATE         
       , CAL_ID                
       , UNSATISFACTORY_BEHAVIOR
       , COMMENTS              
       , CREATE_BY             
       , CREATE_DATETIME       
       , LAST_UPDATED_BY       
       , LAST_UPDATED_DATETIME 
     ) 
     VALUES 
      ('Update'
      ,'Delete'
      ,:old.CA_ID                     
      ,:old.STAFF_ID                  
      ,:old.CA_ENTRY_DATE             
      ,:old.CAL_ID                    
      ,:old.UNSATISFACTORY_BEHAVIOR     
      ,:old.COMMENTS                  
      ,:old.CREATE_BY                 
      ,:old.CREATE_DATETIME           
      ,:old.LAST_UPDATED_BY           
      ,:old.LAST_UPDATED_DATETIME     
     );      

    INSERT INTO SC_CORRECTIVE_ACTION_AUDIT
     (   Record_type              
       , Record_action         
       , CA_ID                 
       , STAFF_ID              
       , CA_ENTRY_DATE         
       , CAL_ID                
       , UNSATISFACTORY_BEHAVIOR
       , COMMENTS              
       , CREATE_BY             
       , CREATE_DATETIME       
       , LAST_UPDATED_BY       
       , LAST_UPDATED_DATETIME 
    ) 
     VALUES 
      ('Update'
      ,'Insert'
      ,:new.CA_ID                     
      ,:new.STAFF_ID                  
      ,:new.CA_ENTRY_DATE             
      ,:new.CAL_ID                    
      ,:new.UNSATISFACTORY_BEHAVIOR     
      ,:new.COMMENTS                  
      ,:new.CREATE_BY                 
      ,:new.CREATE_DATETIME           
      ,:new.LAST_UPDATED_BY           
      ,:new.LAST_UPDATED_DATETIME     
     );
  END;
END IF;
IF INSERTING THEN 
    INSERT INTO SC_CORRECTIVE_ACTION_AUDIT
      (Record_type              
      ,Record_action        
       , CA_ID                 
       , STAFF_ID              
       , CA_ENTRY_DATE         
       , CAL_ID                
       , UNSATISFACTORY_BEHAVIOR
       , COMMENTS              
       , CREATE_BY             
       , CREATE_DATETIME       
       , LAST_UPDATED_BY       
       , LAST_UPDATED_DATETIME 
    ) 
     VALUES 
      ('Insert'
      ,'Insert'
      ,:new.CA_ID                     
      ,:new.STAFF_ID                  
      ,:new.CA_ENTRY_DATE             
      ,:new.CAL_ID                    
      ,:new.UNSATISFACTORY_BEHAVIOR     
      ,:new.COMMENTS                  
      ,:new.CREATE_BY                 
      ,:new.CREATE_DATETIME           
      ,:new.LAST_UPDATED_BY           
      ,:new.LAST_UPDATED_DATETIME     
     );
END IF;
IF DELETING THEN 
    INSERT INTO SC_CORRECTIVE_ACTION_AUDIT
     (   Record_type              
       , Record_action         
       , CA_ID                 
       , STAFF_ID              
       , CA_ENTRY_DATE         
       , CAL_ID                
       , UNSATISFACTORY_BEHAVIOR
       , COMMENTS              
       , CREATE_BY             
       , CREATE_DATETIME       
       , LAST_UPDATED_BY       
       , LAST_UPDATED_DATETIME 
     ) 
     VALUES 
      ('Delete'
      ,'Delete'
      ,:old.CA_ID                     
      ,:old.STAFF_ID                  
      ,:old.CA_ENTRY_DATE             
      ,:old.CAL_ID                    
      ,:old.UNSATISFACTORY_BEHAVIOR     
      ,:old.COMMENTS                  
      ,:old.CREATE_BY                 
      ,:old.CREATE_DATETIME           
      ,:old.LAST_UPDATED_BY           
      ,:old.LAST_UPDATED_DATETIME     
     );      
END IF;

END;
/
CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_GOAL 
AFTER INSERT OR UPDATE OR DELETE ON SC_GOAL 
for each row
BEGIN
IF UPDATING THEN 
  begin
    INSERT INTO SC_GOAL_AUDIT
    ( Record_type                 
    , Record_action             
    , GOAL_ID                   
    , STAFF_ID                  
    , GOAL_ENTRY_DATE           
    , GTL_ID                    
    , GOAL_DESCRIPTION          
    , GOAL_DATE                 
    , PROGRESS_NOTE             
    , CREATE_BY                 
    , CREATE_DATETIME           
    , LAST_UPDATED_BY           
    , LAST_UPDATED_DATETIME
    )     
     VALUES 
      ('Update'
      ,'Delete'
      ,:old.GOAL_ID                  
      ,:old.STAFF_ID                 
      ,:old.GOAL_ENTRY_DATE          
      ,:old.GTL_ID                   
      ,:old.GOAL_DESCRIPTION           
      ,:old.GOAL_DATE                
      ,:old.PROGRESS_NOTE            
      ,:old.CREATE_BY                
      ,:old.CREATE_DATETIME          
      ,:old.LAST_UPDATED_BY          
      ,:old.LAST_UPDATED_DATETIME 
     );
     
    INSERT INTO SC_GOAL_AUDIT
    ( Record_type                 
    , Record_action             
    , GOAL_ID                   
    , STAFF_ID                  
    , GOAL_ENTRY_DATE           
    , GTL_ID                    
    , GOAL_DESCRIPTION          
    , GOAL_DATE                 
    , PROGRESS_NOTE             
    , CREATE_BY                 
    , CREATE_DATETIME           
    , LAST_UPDATED_BY           
    , LAST_UPDATED_DATETIME
    )     
     VALUES 
      ('Update'
      ,'Insert'
      ,:new.GOAL_ID                  
      ,:new.STAFF_ID                 
      ,:new.GOAL_ENTRY_DATE          
      ,:new.GTL_ID                   
      ,:new.GOAL_DESCRIPTION           
      ,:new.GOAL_DATE                
      ,:new.PROGRESS_NOTE            
      ,:new.CREATE_BY                
      ,:new.CREATE_DATETIME          
      ,:new.LAST_UPDATED_BY          
      ,:new.LAST_UPDATED_DATETIME 
     );
  END;
END IF;
IF INSERTING THEN 
    INSERT INTO SC_GOAL_AUDIT
    ( Record_type                 
    , Record_action             
    , GOAL_ID                   
    , STAFF_ID                  
    , GOAL_ENTRY_DATE           
    , GTL_ID                    
    , GOAL_DESCRIPTION          
    , GOAL_DATE                 
    , PROGRESS_NOTE             
    , CREATE_BY                 
    , CREATE_DATETIME           
    , LAST_UPDATED_BY           
    , LAST_UPDATED_DATETIME
    )     
     VALUES 
      ('Insert'
      ,'Insert'
      ,:new.GOAL_ID                  
      ,:new.STAFF_ID                 
      ,:new.GOAL_ENTRY_DATE          
      ,:new.GTL_ID                   
      ,:new.GOAL_DESCRIPTION           
      ,:new.GOAL_DATE                
      ,:new.PROGRESS_NOTE            
      ,:new.CREATE_BY                
      ,:new.CREATE_DATETIME          
      ,:new.LAST_UPDATED_BY          
      ,:new.LAST_UPDATED_DATETIME 
     );
END IF;
IF DELETING THEN 
    INSERT INTO SC_GOAL_AUDIT
    ( Record_type                 
    , Record_action             
    , GOAL_ID                   
    , STAFF_ID                  
    , GOAL_ENTRY_DATE           
    , GTL_ID                    
    , GOAL_DESCRIPTION          
    , GOAL_DATE                 
    , PROGRESS_NOTE             
    , CREATE_BY                 
    , CREATE_DATETIME           
    , LAST_UPDATED_BY           
    , LAST_UPDATED_DATETIME
    )     
     VALUES 
      ('Delete'
      ,'Delete'
      ,:old.GOAL_ID                  
      ,:old.STAFF_ID                 
      ,:old.GOAL_ENTRY_DATE          
      ,:old.GTL_ID                   
      ,:old.GOAL_DESCRIPTION           
      ,:old.GOAL_DATE                
      ,:old.PROGRESS_NOTE            
      ,:old.CREATE_BY                
      ,:old.CREATE_DATETIME          
      ,:old.LAST_UPDATED_BY          
      ,:old.LAST_UPDATED_DATETIME 
     );
END IF;

END;
/
CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_PERF_TRACKER 
AFTER INSERT OR UPDATE OR DELETE ON SC_PERFORMANCE_TRACKER 
for each row
BEGIN
IF UPDATING THEN 
  begin
    INSERT INTO SC_PERFORMANCE_TRACKER_AUDIT
    ( Record_type                 
    , Record_action             
    , PT_ID                 
    , STAFF_ID              
    , PT_ENTRY_DATE         
    , DL_ID                 
    , COMMENTS              
    , CREATE_BY             
    , CREATE_DATETIME       
    , LAST_UPDATED_BY       
    , LAST_UPDATED_DATETIME 
    )     
     VALUES 
      ('Update'
      ,'Delete'
      ,:old.PT_ID                    
      ,:old.STAFF_ID                 
      ,:old.PT_ENTRY_DATE              
      ,:old.DL_ID                    
      ,:old.COMMENTS                 
      ,:old.CREATE_BY                
      ,:old.CREATE_DATETIME          
      ,:old.LAST_UPDATED_BY          
      ,:old.LAST_UPDATED_DATETIME 
     );
     
    INSERT INTO SC_PERFORMANCE_TRACKER_AUDIT
    ( Record_type                 
    , Record_action             
    , PT_ID                     
    , STAFF_ID                  
    , PT_ENTRY_DATE             
    , DL_ID                     
    , COMMENTS                  
    , CREATE_BY                 
    , CREATE_DATETIME           
    , LAST_UPDATED_BY           
    , LAST_UPDATED_DATETIME
    )     
     VALUES 
      ('Update'
      ,'Insert'
      ,:new.PT_ID                    
      ,:new.STAFF_ID                 
      ,:new.PT_ENTRY_DATE            
      ,:new.DL_ID                    
      ,:new.COMMENTS                   
      ,:new.CREATE_BY                
      ,:new.CREATE_DATETIME          
      ,:new.LAST_UPDATED_BY          
      ,:new.LAST_UPDATED_DATETIME    
     );
  END;
END IF;
IF INSERTING THEN 
    INSERT INTO SC_PERFORMANCE_TRACKER_AUDIT
    ( Record_type                 
    , Record_action             
    , PT_ID                    
    , STAFF_ID                 
    , PT_ENTRY_DATE            
    , DL_ID                    
    , COMMENTS                 
    , CREATE_BY                
    , CREATE_DATETIME          
    , LAST_UPDATED_BY          
    , LAST_UPDATED_DATETIME    
    )     
     VALUES 
      ('Insert'
      ,'Insert'
      ,:new.PT_ID                    
      ,:new.STAFF_ID                 
      ,:new.PT_ENTRY_DATE            
      ,:new.DL_ID                    
      ,:new.COMMENTS                   
      ,:new.CREATE_BY                
      ,:new.CREATE_DATETIME          
      ,:new.LAST_UPDATED_BY          
      ,:new.LAST_UPDATED_DATETIME    
     );
END IF;
IF DELETING THEN 
    INSERT INTO SC_PERFORMANCE_TRACKER_AUDIT
    ( Record_type                 
    , Record_action             
    , PT_ID                     
    , STAFF_ID                  
    , PT_ENTRY_DATE             
    , DL_ID                     
    , COMMENTS                  
    , CREATE_BY                 
    , CREATE_DATETIME           
    , LAST_UPDATED_BY           
    , LAST_UPDATED_DATETIME     
    )     
     VALUES 
      ('Delete'
      ,'Delete'
      ,:old.PT_ID                    
      ,:old.STAFF_ID                 
      ,:old.PT_ENTRY_DATE            
      ,:old.DL_ID                    
      ,:old.COMMENTS                   
      ,:old.CREATE_BY                
      ,:old.CREATE_DATETIME          
      ,:old.LAST_UPDATED_BY          
      ,:old.LAST_UPDATED_DATETIME    
     );
END IF;

END;
/
