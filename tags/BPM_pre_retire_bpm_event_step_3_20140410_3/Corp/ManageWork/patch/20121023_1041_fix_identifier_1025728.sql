delete from BPM_UPDATE_EVENT where BUE_ID = 5941352 and BI_ID = 773887;
delete from BPM_UPDATE_EVENT where BUE_ID = 6115913 and BI_ID = 773887;
delete from BPM_INSTANCE where BI_ID = 773887 and IDENTIFIER = 4304520;
update BPM_UPDATE_EVENT_QUEUE set WROTE_BPM_EVENT_DATE = null where BUEQ_ID = 1084463 and IDENTIFIER = 4304520;
update BPM_UPDATE_EVENT_QUEUE set WROTE_BPM_EVENT_DATE = null where BUEQ_ID = 1117791 and IDENTIFIER = 4304520;
commit;
