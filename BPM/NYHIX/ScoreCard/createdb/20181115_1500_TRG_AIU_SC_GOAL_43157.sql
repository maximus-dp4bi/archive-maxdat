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
    , TRANSACTION_DATE
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
      ,SYSDATE 
      ,SYSDATE
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
    , TRANSACTION_DATE
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
      ,NVL(:new.LAST_UPDATED_BY,USER)
      ,:new.LAST_UPDATED_DATETIME 
      ,SYSDATE
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
    , TRANSACTION_DATE
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
      ,NVL(:new.LAST_UPDATED_BY,USER)
      ,:new.LAST_UPDATED_DATETIME 
      ,SYSDATE
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
    , TRANSACTION_DATE
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
      ,SYSDATE 
      ,SYSDATE
     );
END IF;

END;
/
