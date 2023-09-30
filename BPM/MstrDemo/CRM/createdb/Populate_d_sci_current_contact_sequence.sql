
--Populate Contact WrapUp Time
MERGE INTO d_sci_current d
USING (SELECT contact_record_id,contact_sequence
       FROM sci_current_contact_seq_stg) tmp ON (tmp.contact_record_id = d.contact_record_id)
WHEN MATCHED THEN
  UPDATE 
  SET contact_sequence = tmp.contact_sequence
     ;
     
UPDATE d_sci_current
SET contact_sequence = 1
WHERE contact_sequence is null;
         
     