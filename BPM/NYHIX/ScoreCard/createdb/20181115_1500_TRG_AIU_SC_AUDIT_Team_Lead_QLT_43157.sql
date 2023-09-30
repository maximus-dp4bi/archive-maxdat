CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_Team_Lead_QLT
AFTER INSERT OR UPDATE OR DELETE ON SC_AUDIT_Team_lead_Quality 
for each row
BEGIN

IF UPDATING THEN 
 
  BEGIN
  
  IF :old.DATES_MONTH_NUM        <>  :new.DATES_MONTH_NUM        
  OR :old.Team_lead_Quality_Create_Date    <>  :new.Team_lead_Quality_Create_Date    
  OR :old.Team_lead_Quality_Create_USER    <>  :new.Team_lead_Quality_Create_USER    
  OR :old.Team_lead_Quality_Update_Date    <>  :new.Team_lead_Quality_Update_Date    
  OR :old.Team_lead_Quality_Update_USER    <>  :new.Team_lead_Quality_Update_USER    
  OR :old.Team_lead_Agent_STAFF_ID      <>  :new.Team_lead_Agent_STAFF_ID
  --
  OR :OLD.Review_Sessions_COMPLTD_Rating  <> :NEW.Review_Sessions_COMPLTD_Rating
  OR :OLD.Review_Sessions_COMPLTD_Points  <> :NEW.Review_Sessions_COMPLTD_Points
  OR :OLD.Live_Obsrv_COMPLTD_rating      <> :NEW.Live_Obsrv_COMPLTD_rating    
  OR :OLD.Live_Obsrv_COMPLTD_points      <> :NEW.Live_Obsrv_COMPLTD_points    
  OR :OLD.QPP_Checklist_COMPLTD_rating     <> :NEW.QPP_Checklist_COMPLTD_rating   
  OR :OLD.QPP_Checklist_COMPLTD_points    <> :NEW.QPP_Checklist_COMPLTD_points  
  OR :OLD.QPP_Quality_Score_1_rating       <> :NEW.QPP_Quality_Score_1_rating     
  OR :OLD.QPP_Quality_Score_1_points       <> :NEW.QPP_Quality_Score_1_points     
  OR :OLD.QPP_Quality_Score_2_rating      <> :NEW.QPP_Quality_Score_2_rating    
  OR :OLD.QPP_Quality_Score_2_points      <> :NEW.QPP_Quality_Score_2_points    
  --
  THEN
    INSERT INTO SC_AUDIT_TEAM_LEAD_QUALITY_AUD
    (Record_type,              
    Record_action, 
    Transaction_Date,
    Team_lead_Quality_ID,        
    DATES_MONTH_NUM,        
    Team_lead_Quality_Create_Date,        
    Team_lead_Quality_Create_USER,        
    Team_lead_Quality_Update_Date,        
    Team_lead_Quality_Update_USER,        
    Team_lead_agent_STAFF_ID,              
    --
    Review_Sessions_COMPLTD_Rating,
    Review_Sessions_COMPLTD_Points,
    Live_Obsrv_COMPLTD_rating,    
    Live_Obsrv_COMPLTD_points,    
    QPP_Checklist_COMPLTD_rating,   
    QPP_Checklist_COMPLTD_points,  
    QPP_Quality_Score_1_rating,     
    QPP_Quality_Score_1_points,     
    QPP_Quality_Score_2_rating,    
    QPP_Quality_Score_2_points    
    --
    )          
    VALUES 
      ('Update',
      'Delete',
      sysdate,
      :OLD.Team_lead_Quality_ID,
    :old.DATES_MONTH_NUM,        
    :old.Team_lead_Quality_Create_Date,        
    :old.Team_lead_Quality_Create_USER,        
    SYSDATE,        
    :old.Team_lead_Quality_Update_USER,        
    :old.Team_lead_Agent_STAFF_ID,      
    --
    :OLD.Review_Sessions_COMPLTD_Rating,
    :OLD.Review_Sessions_COMPLTD_Points,
    :OLD.Live_Obsrv_COMPLTD_rating,    
    :OLD.Live_Obsrv_COMPLTD_points,    
    :OLD.QPP_Checklist_COMPLTD_rating,   
    :OLD.QPP_Checklist_COMPLTD_points,  
    :OLD.QPP_Quality_Score_1_rating,     
    :OLD.QPP_Quality_Score_1_points,     
    :OLD.QPP_Quality_Score_2_rating,    
    :OLD.QPP_Quality_Score_2_points    
    --
    );      

    INSERT INTO SC_AUDIT_TEAM_LEAD_QUALITY_AUD
      (Record_type,              
      Record_action,
    Transaction_Date,
    Team_lead_Quality_ID,
    DATES_MONTH_NUM,        
    Team_lead_Quality_Create_Date,        
    Team_lead_Quality_Create_USER,        
    Team_lead_Quality_Update_Date,        
    Team_lead_Quality_Update_USER,        
    Team_lead_agent_STAFF_ID,              
    --
    Review_Sessions_COMPLTD_Rating,
    Review_Sessions_COMPLTD_Points,
    Live_Obsrv_COMPLTD_rating,    
    Live_Obsrv_COMPLTD_points,    
    QPP_Checklist_COMPLTD_rating,   
    QPP_Checklist_COMPLTD_points,  
    QPP_Quality_Score_1_rating,    
    QPP_Quality_Score_1_points,    
    QPP_Quality_Score_2_rating,    
    QPP_Quality_Score_2_points    
    --
    ) 
     VALUES 
      ('Update',
      'Insert',
    sysdate,
    :NEW.Team_lead_Quality_ID,
    :new.DATES_MONTH_NUM,        
    :new.Team_lead_Quality_Create_Date,        
    :new.Team_lead_Quality_Create_USER,        
    :new.Team_lead_Quality_Update_Date,        
    NVL(:new.Team_lead_Quality_Update_USER,USER),
    :new.Team_lead_agent_STAFF_ID,    
    --
    :NEW.Review_Sessions_COMPLTD_Rating,
    :NEW.Review_Sessions_COMPLTD_Points,
    :NEW.Live_Obsrv_COMPLTD_rating,    
    :NEW.Live_Obsrv_COMPLTD_points,    
    :NEW.QPP_Checklist_COMPLTD_rating,   
    :NEW.QPP_Checklist_COMPLTD_points,  
    :NEW.QPP_Quality_Score_1_rating,     
    :NEW.QPP_Quality_Score_1_points,     
    :NEW.QPP_Quality_Score_2_rating,    
    :NEW.QPP_Quality_Score_2_points    
    --
      );
      
  END IF;
  
  END;
  
END IF;

IF INSERTING THEN 
    INSERT INTO SC_AUDIT_TEAM_LEAD_QUALITY_AUD
      (Record_type,              
    Record_action,
    Transaction_Date,   
    Team_lead_Quality_ID,     
    DATES_MONTH_NUM,        
    Team_lead_Quality_Create_Date,        
    Team_lead_Quality_Create_USER,        
    Team_lead_Quality_Update_Date,        
    Team_lead_Quality_Update_USER,        
    Team_lead_Agent_STAFF_ID,    
    --
    Review_Sessions_COMPLTD_Rating,
    Review_Sessions_COMPLTD_Points,
    Live_Obsrv_COMPLTD_rating,    
    Live_Obsrv_COMPLTD_points,    
    QPP_Checklist_COMPLTD_rating,   
    QPP_Checklist_COMPLTD_points,  
    QPP_Quality_Score_1_rating,     
    QPP_Quality_Score_1_points,     
    QPP_Quality_Score_2_rating,    
    QPP_Quality_Score_2_points    
    --
    )          
     VALUES 
      ('Insert',
      'Insert',
    sysdate,
    :NEW.Team_lead_Quality_ID,
    :new.DATES_MONTH_NUM,        
    :new.Team_lead_Quality_Create_Date,        
    :new.Team_lead_Quality_Create_USER,        
    :new.Team_lead_Quality_Update_Date,        
    NVL(:new.Team_lead_Quality_Update_USER,USER),
    :new.Team_lead_Agent_STAFF_ID,              
    --
    :NEW.Review_Sessions_COMPLTD_Rating,
    :NEW.Review_Sessions_COMPLTD_Points,
    :NEW.Live_Obsrv_COMPLTD_rating,    
    :NEW.Live_Obsrv_COMPLTD_points,    
    :NEW.QPP_Checklist_COMPLTD_rating,   
    :NEW.QPP_Checklist_COMPLTD_points,  
    :NEW.QPP_Quality_Score_1_rating,     
    :NEW.QPP_Quality_Score_1_points,     
    :NEW.QPP_Quality_Score_2_rating,    
    :NEW.QPP_Quality_Score_2_points    
    --
    );          
        
END IF;

IF DELETING THEN 
        INSERT INTO SC_AUDIT_TEAM_LEAD_QUALITY_AUD
        (Record_type,              
        Record_action,   
    Transaction_Date,
    Team_lead_Quality_ID,
    DATES_MONTH_NUM,        
    Team_lead_Quality_Create_Date,        
    Team_lead_Quality_Create_USER,        
    Team_lead_Quality_Update_Date,        
    Team_lead_Quality_Update_USER,        
    Team_lead_Agent_STAFF_ID,        
--
    Review_Sessions_COMPLTD_Rating,
    Review_Sessions_COMPLTD_Points,
    Live_Obsrv_COMPLTD_rating,    
    Live_Obsrv_COMPLTD_points,    
    QPP_Checklist_COMPLTD_rating,   
    QPP_Checklist_COMPLTD_points,  
    QPP_Quality_Score_1_rating,     
    QPP_Quality_Score_1_points,     
    QPP_Quality_Score_2_rating,    
    QPP_Quality_Score_2_points    
--
    ) 
        VALUES 
            ('Delete',
            'Delete',
      sysdate,
      :OLD.Team_lead_Quality_ID,
    :old.DATES_MONTH_NUM,        
    :old.Team_lead_Quality_Create_Date,        
    :old.Team_lead_Quality_Create_USER,        
    SYSDATE,        
    :old.Team_lead_Quality_Update_USER,        
    :old.Team_lead_Agent_STAFF_ID,              
    --
    :OLD.Review_Sessions_COMPLTD_Rating,
    :OLD.Review_Sessions_COMPLTD_Points,
    :OLD.Live_Obsrv_COMPLTD_rating,    
    :OLD.Live_Obsrv_COMPLTD_points,    
    :OLD.QPP_Checklist_COMPLTD_rating,   
    :OLD.QPP_Checklist_COMPLTD_points,  
    :OLD.QPP_Quality_Score_1_rating,     
    :OLD.QPP_Quality_Score_1_points,     
    :OLD.QPP_Quality_Score_2_rating,    
    :OLD.QPP_Quality_Score_2_points    
    --
    );
    END IF;

END;
/
