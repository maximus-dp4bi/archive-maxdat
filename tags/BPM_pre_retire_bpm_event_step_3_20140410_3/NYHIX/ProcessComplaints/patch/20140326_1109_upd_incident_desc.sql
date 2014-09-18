BEGIN

UPDATE nyhx_etl_complaints_incidents
SET incident_description = 'Consumer Name: JOCELYNE FEQUIERE 
Consumer Phone #: 107-56-3544
Enrollee''s Name/s: JOCELYNE FEQUIERE 
Enrollee''s CIN: WP17644C
Marketplace Account ID (if applicable): AC0001008897 
Marketplace HX ID (if applicable): HX0001320239
Applicant SSN: 107-56-3544
Applicant DOB: 3/5/1953
TPHI Plan Name: Multiple TPHI''s {see description for more info} 

Description of Problem: Jocelyne can''t enroll into a MA care plan because the "third party" in eMedNY is highlighted. All of the Policy''s that are shown all have end dates. They all are as follows; policy numbers followed by the begin and end dates for each; 
[ 107563544 -- 02/01/2005 -- 11/30/2005 ] , [ 107563544 W10 -- 04/01/1999 -- 08/31/2000 ] , [ 107563544A --12/01/1996 --05/31/2007 ] ,
 [ 107563544A -- 12/01/1996 -- 05/31/2007 ] , [ 107563544A -- 12/01/1996 -- 12/31/2004 ].'
WHERE incident_id = 26060635;
END;
/
COMMIT;