SELECT NULL AS REJECTION_ERROR_REASON_ID
                ,selection_segment_id AS ENROLLMENT_ID 
                ,'0' rejection_code
FROM selection_segment
WHERE selection_segment_id > 1