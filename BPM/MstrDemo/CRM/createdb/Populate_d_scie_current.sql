
--Populate SCIE
INSERT INTO d_scie_current(contact_record_id, contact_reason_id,contact_reason_cd,contact_reason,contact_action_cd,contact_action,comments)
SELECT d.contact_record_id
 ,d.contact_record_id||d.rnk contact_reason_id
 ,d.contact_reason_cd
 ,d.contact_reason
 ,d.contact_action_cd
 ,d.contact_action
 ,SUBSTR((SELECT listagg(word,' ') WITHIN GROUP(ORDER BY  dbms_random.value) 
   FROM(SELECT word FROM crm_random_word_stg ORDER BY dbms_random.value)
   WHERE rownum < d.len_comments),1,4000) comments
FROM (
SELECT contact_record_id,CASE WHEN contact_sequence > 4 THEN 3 ELSE contact_sequence END contact_sequence, cr.*
 ,to_number(substr(to_char(contact_record_id),length(contact_record_id)-1,2)) len_comments 
 ,rank() over (partition by contact_record_id,contact_type_cd order by dbms_random.value) rnk
FROM d_sci_current sci
  JOIN(SELECT cr.contact_reason_cd, cr.contact_reason,cr.contact_type_cd,ca.contact_action_cd , ca.contact_action
        FROM d_sci_contact_reason cr
        JOIN d_sci_contact_action ca on cr.contact_reason_cd = ca.contact_reason_cd) cr ON sci.supp_contact_type_cd = cr.contact_type_cd
) d
WHERE rnk <= contact_sequence;

--Set note_present correctly
UPDATE d_sci_current sci
SET note_present = 'N'
WHERE EXISTS(SELECT 1 FROM d_scie_current scie WHERE sci.contact_record_id = scie.contact_record_id AND scie.comments IS NULL)
AND note_present = 'Y';

-- Fix duplicate contact record id/comments combination
MERGE INTO d_scie_current e
USING (SELECT contact_record_id,contact_reason_id,comments||' '||(SELECT listagg(word,' ') WITHIN GROUP(ORDER BY  dbms_random.value) 
                                     FROM(SELECT word FROM crm_random_word_stg ORDER BY dbms_random.value)
                                      WHERE rownum < d.rnk) new_comments
       FROM(SELECT contact_record_id,contact_reason_id,
                  comments,rank() over (partition by contact_record_id,comments order by contact_reason_id) rnk
            FROM d_scie_current
            WHERE comments is not null) d
      WHERE rnk >= 2) tmp ON (e.contact_reason_id = tmp.contact_reason_id)
WHEN MATCHED THEN 
 UPDATE SET comments = tmp.new_comments;

--populate additional comments
MERGE INTO d_scie_current e
USING (SELECT contact_record_id,contact_reason_id, comments,contact_action_cd
        ,(SELECT listagg(word,' ') WITHIN GROUP(ORDER BY  dbms_random.value) 
          FROM(SELECT word,rownum row_num FROM crm_random_word_stg ORDER BY dbms_random.value DESC)
          WHERE rownum < length(contact_action_cd) ) additional_comments
      FROM d_scie_current
      WHERE comments IS NOT NULL ) tmp ON (e.contact_reason_id = tmp.contact_reason_id)
WHEN MATCHED THEN 
UPDATE SET additional_comments = tmp.additional_comments;
--COMMIT;