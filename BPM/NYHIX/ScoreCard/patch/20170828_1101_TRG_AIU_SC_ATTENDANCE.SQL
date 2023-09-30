DROP TRIGGER DP_SCORECARD.TRG_AIU_SC_ATTENDANCE;

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_ATTENDANCE 
AFTER INSERT OR UPDATE OR DELETE ON DP_SCORECARD.SC_ATTENDANCE 
for each row
BEGIN

IF UPDATING THEN 
 
	BEGIN
  
    --  :old.BALANCE          		--<< don't check these             
    --  :old.INCENTIVE_BALANCE   	--<< don't check these 
    --  :old.TOTAL_BALANCE        	--<< don't check these
	
	IF    :old.SC_ATTENDANCE_ID      <> :new.SC_ATTENDANCE_ID       
    or  :old.STAFF_ID              <> :new.STAFF_ID             
    or  :old.ENTRY_DATE            <> :new.ENTRY_DATE           
    or  :old.SC_ALL_ID             <> :new.SC_ALL_ID            
    or  :old.ABSENCE_TYPE          <> :new.ABSENCE_TYPE         
    or  :old.POINT_VALUE           <> :new.POINT_VALUE          
    or  :old.CREATE_BY             <> :new.CREATE_BY            
    or  :old.CREATE_DATETIME       <> :new.CREATE_DATETIME      
    or  :old.INCENTIVE_FLAG        <> :new.INCENTIVE_FLAG       
    or  :old.LAST_UPDATED_BY       <> :new.LAST_UPDATED_BY      
    or  :old.LAST_UPDATED_DATETIME <> :new.LAST_UPDATED_DATETIME
	THEN
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
		,LAST_UPDATED_DATETIME
		,TRANSACTION_DATE) 
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
			,:old.LAST_UPDATED_DATETIME
			,SYSDATE);      

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
      ,LAST_UPDATED_DATETIME
      ,TRANSACTION_DATE) 
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
      ,:new.LAST_UPDATED_DATETIME,
      SYSDATE);
      
	END IF;
	
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
      ,LAST_UPDATED_DATETIME
      ,TRANSACTION_DATE) 
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
      ,:new.LAST_UPDATED_DATETIME
      ,SYSDATE);    
        
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
        ,LAST_UPDATED_DATETIME
        ,TRANSACTION_DATE) 
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
            ,:old.LAST_UPDATED_DATETIME,
            SYSDATE);
    END IF;

END;
/

