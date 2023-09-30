CREATE OR REPLACE PACKAGE MAXDAT.ManageWork_Pkg IS

  -- Author  : SG21380
  -- Created : 8/2/2012 11:26:36 AM
  -- Purpose : Package for Manage Work process

  -- Public function and procedure declarations
   FUNCTION Get_Work_Req_Flag(p_Envelope_Id       VARCHAR2) RETURN VARCHAR2;

END ManageWork_Pkg;
/
CREATE OR REPLACE PACKAGE BODY MAXDAT.ManageWork_Pkg is

  -- Private type declarations
   FUNCTION Get_Work_Req_Flag(p_Envelope_Id VARCHAR2) RETURN VARCHAR2 IS
      n_Work_Req       NUMBER := 0 ;
   BEGIN
      n_Work_Req := 0 ;

  -- Work is required IF
  -- Check if Envelope is autolinked.  

      SELECT COUNT(1)
      INTO   n_Work_Req
      FROM   App_Doc_Data
      WHERE  Updated_By = '-605'
      AND    Status_Cd = 'LINKED'
      AND    Document_Sub_Type = 'RENEWAL'
      AND   ECN = p_Envelope_Id ;

  -- Check if Application document is linked, there is no open system generated task, and the case status is in Renewal

      IF n_Work_Req > 0 THEN
         RETURN ('Y') ;
      END IF ;

      SELECT COUNT(1)
      INTO   n_Work_Req
      FROM   STEP_INSTANCE SI
           , APP_DOC_DATA  Ad
      WHERE  Si.Ref_Type = 'APP_HEADER'
      AND    Si.Ref_Id = Ad.Application_Id
      AND    Si.Created_By < '0' 
      AND    Si.Status NOT IN ('UNCLAIMED', 'CLAIMED')
      AND    Ad.ECN = p_Envelope_Id ;

      IF n_Work_Req > 0 THEN
         RETURN ('Y') ;
      END IF ;

  -- Check if Fair Hearing document is linked  

      SELECT COUNT(1)
      INTO   n_Work_Req
      FROM   APP_DOC_DATA
      WHERE  STATUS_CD = 'LINKED' 
      AND    ECN = p_Envelope_Id
      AND    Document_Sub_Type IN ('OAH_5473', 'OAH_5472', 'OAH_3792', 'OAH_2846', 'OAH_457',
                                    'OAH_1891', 'FAIR_HEARING_NOTICE','FH_DISPOSITION','FH_PACKET') ;

      IF n_Work_Req > 0 THEN
         RETURN ('Y') ;
      END IF ;
      
  -- Check if Supporting information is linked to a case with an in-process application and no data entry or QC tasks system generated task exists.  
  -- Check if a State Review task exists, then a new data entry task should be created.
      
      SELECT COUNT(1)
      INTO   n_Work_Req
      FROM   STEP_INSTANCE SI
           , APP_DOC_DATA  Ad
      WHERE  Si.Ref_Type = 'APP_HEADER'
      AND    Si.Ref_Id = Ad.Application_Id
      AND    Ad.STATUS_CD = 'LINKED' 
      AND    Ad.UPDATE_TS > Si.COMPLETED_TS
      AND    Ad.ECN = p_Envelope_Id ;

      IF n_Work_Req > 0 THEN
         RETURN ('Y') ;
      END IF ;

      SELECT COUNT(1)
      INTO   n_Work_Req
      FROM   APP_DOC_DATA  Ad
      WHERE  Ad.STATUS_CD = 'LINKED'
      AND    NOT EXISTS (
             SELECT 1
             FROM   STEP_INSTANCE SI
             WHERE  Si.Ref_Type = 'APP_HEADER'
             AND    Si.Ref_Id = Ad.Application_Id)
      AND    Ad.ECN = p_Envelope_Id ;

      IF n_Work_Req > 0 THEN
         RETURN ('Y') ;
      END IF ;

  -- Work is not required IF
  
  -- Check if no case exists in MAXe

      SELECT COUNT(1)
      INTO   n_Work_Req
      FROM   APP_DOC_DATA Ad
      WHERE  Document_Sub_Type = 'RENEWAL'
      AND    Ad.ECN = p_Envelope_Id
      AND    NOT EXISTS (
             SELECT 1
             FROM   APP_CASE_LINK   Acl
             WHERE  Acl.Application_Id = Ad.Application_Id);
             
      IF n_Work_Req > 0 THEN
         RETURN ('N') ;
      END IF ;

  -- Check if the document is an application or supporting information for an in-process application 
  -- and there is an open system generated task that is NOT in State Review

      SELECT Count(1)
      INTO   n_Work_Req
      FROM   STEP_INSTANCE SI
           , APP_DOC_DATA  Ad
           , APP_CASE_LINK Ac
      WHERE  Si.Ref_Type = 'APP_HEADER'
      AND    Si.Ref_Id = Ad.Application_Id
      AND    Ad.ECN = p_Envelope_Id
      AND    Si.Created_By < '0' 
      AND    Ac.Application_Id = Ad.Application_Id
      AND    EXISTS (
             SELECT 1
             FROM   Corp_Etl_List_Lkup   Ce
                  , Step_Definition   Sd
             WHERE  Ce.NAME = 'TASK_MONITOR_TYPE'
             AND    SYSDATE BETWEEN Ce.Start_Date AND Ce.End_Date
             AND    Si.Step_Definition_Id = Sd.Step_Definition_Id
             AND    Ce.Out_Var != 'State Review') ;

      IF n_Work_Req > 0 THEN
         RETURN ('N') ;
      END IF ;
             
  -- Check if the envelope is linked to an application that has been completed and is beyond the 
  -- grace period for reprocessing (each document status is set to "valid no link")
      SELECT Count(1)
      INTO   n_Work_Req
      FROM   APP_DOC_DATA Ad
           , DOCUMENT     Doc
      WHERE  Ad.Document_Id = Doc.Document_Id
      AND    Ad.Status_Cd = 'VALID_NO_LINK'
      AND    Ad.ECN = p_Envelope_Id ;

      IF n_Work_Req > 0 THEN
         RETURN ('N') ;
      END IF ;

  -- Check if the envelope is linked to a case with no application record in MAXe (each document status is set to "link no app") - 

      SELECT Count(1)
      INTO   n_Work_Req
      FROM   APP_DOC_DATA Ad
           , DOCUMENT     Doc
      WHERE  Ad.Document_Id = Doc.Document_Id
      AND    Ad.DCN = Doc.DCN
      AND    Ad.Status_Cd = 'LINK_NO_APP'
      AND    Ad.ECN = p_Envelope_Id ;

      IF n_Work_Req > 0 THEN
         RETURN ('N') ;
      END IF ;

  -- Check if the envelope is trashed

      SELECT Count(1)
      INTO   n_Work_Req
      FROM   APP_DOC_DATA Ad
           , DOCUMENT     Doc
      WHERE  Ad.Document_Id = Doc.Document_Id
      AND    Ad.DCN = Doc.DCN
      AND    Doc.Doc_Status_Cd = 'TRASHED'
      AND    (Doc.Updated_By > '0' OR Doc.Updated_By = 'NYEC-1111')
      AND    Ad.ECN = p_Envelope_Id ;

      IF n_Work_Req > 0 THEN
         RETURN ('N') ;
      END IF ;
  
      RETURN ('NA') ;
  
   EXCEPTION
      WHEN OTHERS THEN
         RETURN ('NA') ;
   End Get_Work_Req_Flag;

END ManageWork_Pkg;
/
