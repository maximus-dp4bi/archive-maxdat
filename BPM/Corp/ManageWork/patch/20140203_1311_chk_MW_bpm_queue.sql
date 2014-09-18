-- Check to see any pending MW queue exists. Do not proceed to BPM update script until all are processed.

select count(1) from BPM_UPDATE_EVENT_QUEUE where BSL_ID = 1;