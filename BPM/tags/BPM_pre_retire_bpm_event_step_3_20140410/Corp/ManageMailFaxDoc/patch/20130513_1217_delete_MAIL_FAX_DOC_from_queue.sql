-- Remove Mail Fax Docs rows from queue
delete from BPM_UPDATE_EVENT_QUEUE where BSL_ID = 9;

commit;
