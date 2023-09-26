
-------------------------------------------------------------
-- Add new Absence TYPE
-------------------------------------------------------------

INSERT INTO DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (
    SC_ALL_ID, ABSENCE_TYPE, POINT_VALUE,
    END_DATE, CREATE_BY, CREATE_DATETIME,
    INCENTIVE_FLAG
    )
 VALUES ( SEQ_SCAL_ID.Nextval, 		--	SC_ALL_ID 
  'Perfect Attendance (3)', 		--	ABSENCE_TYPE 
  3, 								--	POINT_VALUE 
  to_date('20770707','YYYYMMDD'), 	-- 	END_DATE 
  'script', 						--	CREATE_BY 
  sysdate,  						--	CREATE_DATETIME 
  null 								--	INCENTIVE_FLAG 
  );
  
commit; 


-------------------------------------------------------------
-- Hide Old Absence Types
-------------------------------------------------------------

DROP VIEW DP_SCORECARD.SCORECARD_ATTENDANCE_LKUP_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_ATTENDANCE_LKUP_SV
(SC_ALL_ID, ABSENCE_TYPE, ABSENCE_TYPE_SHORT_NAME, POINT_VALUE, END_DATE, 
 CREATE_BY, CREATE_DATETIME, INCENTIVE_FLAG)
AS 
select sc_all_id,
       absence_type,
       case
         when instr(ABSENCE_TYPE, '|') = 0 then
          ABSENCE_TYPE
         else
          substr(ABSENCE_TYPE, 1, instr(ABSENCE_TYPE, '|') - 2)
       end as ABSENCE_TYPE_SHORT_NAME,
       point_value,
       end_date,
       create_by,
       create_datetime,
       incentive_flag
  from dp_scorecard.sc_attendance_absence_lkup
  where absence_type not like 'Perfect Attendance |%';


GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_LKUP_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_LKUP_SV TO MAXDAT_READ_ONLY;

-------------------------------------------------------------
-- Atler SC_ATTENDANCE_AUDIT and the Trigger on SC_ATTENDANCE
-------------------------------------------------------------

ALTER TABLE DP_SCORECARD.SC_ATTENDANCE_AUDIT
ADD TRANSACTION_DATE  DATE;

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

