GRANT select on TS_CAHCO_SYSTEM_LKUP_SV to MAXDAT_READ_ONLY;
GRANT select on TS_CAHCO_TRACK_DOWNTIME_SV to MAXDAT_READ_ONLY;
---Grants - to allow MSTR Transactions to perform U,D,I
GRANT insert, update, delete ON TS_CAHCO_TRACK_DOWNTIME TO MAXDAT_MSTR_TRX_RPT;
GRANT execute ON TS_CAHCO_TRACK_DOWNTIME_INSERT TO MAXDAT_MSTR_TRX_RPT;
GRANT execute ON TS_CAHCO_TRACK_DOWNTIME_UPDATE TO MAXDAT_MSTR_TRX_RPT; 
commit;

/