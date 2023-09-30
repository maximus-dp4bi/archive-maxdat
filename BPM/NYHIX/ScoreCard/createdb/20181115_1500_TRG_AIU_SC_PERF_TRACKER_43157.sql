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
    , TRANSACTION_DATE
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
      ,SYSDATE 
      ,SYSDATE
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
    , TRANSACTION_DATE
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
      ,NVL(:new.LAST_UPDATED_BY,USER)          
      ,:new.LAST_UPDATED_DATETIME    
      ,SYSDATE
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
    , TRANSACTION_DATE
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
      ,NVL(:new.LAST_UPDATED_BY,USER)
      ,:new.LAST_UPDATED_DATETIME    
      ,SYSDATE
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
    , TRANSACTION_DATE
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
      ,SYSDATE    
      ,SYSDATE
     );
END IF;

END;
/
