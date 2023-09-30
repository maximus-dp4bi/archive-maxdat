CREATE OR REPLACE VIEW D_CASE_CLIENT_LINK_SV 
AS
 SELECT s.case_id, s.case_cin state_case_id, s.client_id, s.clnt_cin recipient_id, s.clnt_fname client_fname,s.clnt_lname client_lname,s.clnt_mi client_mi
FROM client_stg s
WHERE EXISTS(SELECT 1 FROM app_individual_stg ai WHERE ai.client_id = s.client_id AND applicant_ind = 1);

GRANT SELECT ON D_CASE_CLIENT_LINK_SV to MAXDAT_READ_ONLY;