CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_Team_Lead_QZ
AFTER INSERT OR UPDATE OR DELETE ON SC_AUDIT_Team_lead_QUIZ 
for each row
BEGIN

IF UPDATING THEN 
 
  BEGIN
  
  IF :old.Team_lead_QUIZ_Create_Date    <>  :new.Team_lead_QUIZ_Create_Date    
  OR :old.Team_lead_QUIZ_Create_USER    <>  :new.Team_lead_QUIZ_Create_USER    
  OR :old.Team_lead_QUIZ_Update_Date    <>  :new.Team_lead_QUIZ_Update_Date    
  OR :old.Team_lead_QUIZ_Update_USER    <>  :new.Team_lead_QUIZ_Update_USER    
  OR :old.Team_lead_Agent_STAFF_ID    <>  :new.Team_lead_Agent_STAFF_ID
  --
  OR :old.CBT_EXAM_NAME          <>  :NEW.CBT_EXAM_NAME              
  OR :old.CBT_EXAM_ASSIGNMENT_DATE    <>  :NEW.CBT_EXAM_ASSIGNMENT_DATE
  OR :old.CBT_EXAM_COMPLETION_DATE    <>  :NEW.CBT_EXAM_COMPLETION_DATE
  OR :old.CBT_EXAM_SCORE          <>  :NEW.CBT_EXAM_SCORE      
  OR :old.CBT_EXAM_TIMELINESS        <>  :NEW.CBT_EXAM_TIMELINESS    
  --
  THEN
    INSERT INTO SC_AUDIT_TEAM_LEAD_QUIZ_AUD
    (Record_type,              
    Record_action, 
    Transaction_Date,
    Team_lead_QUIZ_ID,        
    Team_lead_QUIZ_Create_Date,        
    Team_lead_QUIZ_Create_USER,        
    Team_lead_QUIZ_Update_Date,        
    Team_lead_QUIZ_Update_USER,        
    Team_lead_agent_STAFF_ID,              
    --
    CBT_EXAM_NAME,      
    CBT_EXAM_ASSIGNMENT_DATE,
    CBT_EXAM_COMPLETION_DATE,
    CBT_EXAM_SCORE,      
    CBT_EXAM_TIMELINESS    
    --
    )          
    VALUES 
      ('Update',
      'Delete',
      sysdate,
      :OLD.Team_lead_QUIZ_ID,
    :old.Team_lead_QUIZ_Create_Date,        
    :old.Team_lead_QUIZ_Create_USER,        
    SYSDATE,        
    :old.Team_lead_QUIZ_Update_USER,        
    :old.Team_lead_Agent_STAFF_ID,      
    --
    :old.CBT_EXAM_NAME,        
    :old.CBT_EXAM_ASSIGNMENT_DATE,  
    :old.CBT_EXAM_COMPLETION_DATE,  
    :old.CBT_EXAM_SCORE,        
    :old.CBT_EXAM_TIMELINESS      
    --
    );      

    INSERT INTO SC_AUDIT_TEAM_LEAD_QUIZ_AUD
      (Record_type,              
      Record_action,
    Transaction_Date,
    Team_lead_QUIZ_ID,
    Team_lead_QUIZ_Create_Date,        
    Team_lead_QUIZ_Create_USER,        
    Team_lead_QUIZ_Update_Date,        
    Team_lead_QUIZ_Update_USER,        
    Team_lead_agent_STAFF_ID,              
    --
    CBT_EXAM_NAME,      
    CBT_EXAM_ASSIGNMENT_DATE,
    CBT_EXAM_COMPLETION_DATE,
    CBT_EXAM_SCORE,      
    CBT_EXAM_TIMELINESS    
    --
    ) 
     VALUES 
      ('Update',
      'Insert',
    sysdate,
    :NEW.Team_lead_QUIZ_ID,
    :new.Team_lead_QUIZ_Create_Date,        
    :new.Team_lead_QUIZ_Create_USER,        
    :new.Team_lead_QUIZ_Update_Date,        
    NVL(:new.Team_lead_QUIZ_Update_USER,USER),
    :new.Team_lead_agent_STAFF_ID,    
    --
    :NEW.CBT_EXAM_NAME,      
    :NEW.CBT_EXAM_ASSIGNMENT_DATE,
    :NEW.CBT_EXAM_COMPLETION_DATE,
    :NEW.CBT_EXAM_SCORE,      
    :NEW.CBT_EXAM_TIMELINESS    
    --
      );
      
  END IF;
  
  END;
  
END IF;

IF INSERTING THEN 
    INSERT INTO SC_AUDIT_TEAM_LEAD_QUIZ_AUD
      (Record_type,              
    Record_action,
    Transaction_Date,   
    Team_lead_QUIZ_ID,     
    Team_lead_QUIZ_Create_Date,        
    Team_lead_QUIZ_Create_USER,        
    Team_lead_QUIZ_Update_Date,        
    Team_lead_QUIZ_Update_USER,        
    Team_lead_Agent_STAFF_ID,    
    --
    CBT_EXAM_NAME,      
    CBT_EXAM_ASSIGNMENT_DATE,
    CBT_EXAM_COMPLETION_DATE,
    CBT_EXAM_SCORE,      
    CBT_EXAM_TIMELINESS    
    --
    )          
     VALUES 
      ('Insert',
      'Insert',
    sysdate,
    :NEW.Team_lead_QUIZ_ID,
    :new.Team_lead_QUIZ_Create_Date,        
    :new.Team_lead_QUIZ_Create_USER,        
    :new.Team_lead_QUIZ_Update_Date,        
    NVL(:new.Team_lead_QUIZ_Update_USER,USER),
    :new.Team_lead_Agent_STAFF_ID,              
    --
    :NEW.CBT_EXAM_NAME,      
    :NEW.CBT_EXAM_ASSIGNMENT_DATE,
    :NEW.CBT_EXAM_COMPLETION_DATE,
    :NEW.CBT_EXAM_SCORE,      
    :NEW.CBT_EXAM_TIMELINESS    
    --
    );          
        
END IF;

IF DELETING THEN 
        INSERT INTO SC_AUDIT_TEAM_LEAD_QUIZ_AUD
        (Record_type,              
        Record_action,   
    Transaction_Date,
    Team_lead_QUIZ_ID,
    Team_lead_QUIZ_Create_Date,        
    Team_lead_QUIZ_Create_USER,        
    Team_lead_QUIZ_Update_Date,        
    Team_lead_QUIZ_Update_USER,        
    Team_lead_Agent_STAFF_ID,        
    CBT_EXAM_NAME,      
    CBT_EXAM_ASSIGNMENT_DATE,
    CBT_EXAM_COMPLETION_DATE,
    CBT_EXAM_SCORE,      
    CBT_EXAM_TIMELINESS    
    ) 
        VALUES 
            ('Delete',
            'Delete',
      sysdate,
      :OLD.Team_lead_QUIZ_ID,
    :old.Team_lead_QUIZ_Create_Date,        
    :old.Team_lead_QUIZ_Create_USER,        
    SYSDATE,        
    :old.Team_lead_QUIZ_Update_USER,        
    :old.Team_lead_Agent_STAFF_ID,              
    --
    :OLD.CBT_EXAM_NAME,      
    :OLD.CBT_EXAM_ASSIGNMENT_DATE,
    :OLD.CBT_EXAM_COMPLETION_DATE,
    :OLD.CBT_EXAM_SCORE,      
    :OLD.CBT_EXAM_TIMELINESS    
    --
    );
    END IF;

END;
/
