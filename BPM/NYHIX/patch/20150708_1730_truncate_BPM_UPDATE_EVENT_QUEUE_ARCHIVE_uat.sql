-- Clean up queue archive for UAT only to reduce space usage.
truncate table MAXDAT.BPM_UPDATE_EVENT_QUEUE_ARCHIVE;