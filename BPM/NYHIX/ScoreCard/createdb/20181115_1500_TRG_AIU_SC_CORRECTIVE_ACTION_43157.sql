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
       , TRANSACTION_DATE
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
      ,SYSDATE     
      ,SYSDATE
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
       , TRANSACTION_DATE
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
      ,NVL(:new.LAST_UPDATED_BY,USER)           
      ,:new.LAST_UPDATED_DATETIME     
      ,SYSDATE
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
       , TRANSACTION_DATE
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
      ,NVL(:new.LAST_UPDATED_BY,USER)
      ,:new.LAST_UPDATED_DATETIME     
      ,SYSDATE
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
       , TRANSACTION_DATE
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
      ,SYSDATE     
      ,SYSDATE
     );      
END IF;

END;
/
