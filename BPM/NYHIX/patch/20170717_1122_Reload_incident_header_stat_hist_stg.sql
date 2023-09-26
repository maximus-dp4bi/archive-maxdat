Delete
FROM MAXDAT.INCIDENT_HEADER_STAT_HIST_STG
WHERE trunc(create_ts) between to_date('2013/01/01','yyyy/mm/dd') and to_date('2014/01/01','yyyy/mm/dd') ;

COMMIT;

Delete
FROM MAXDAT.INCIDENT_HEADER_STAT_HIST_STG
WHERE trunc(create_ts) between to_date('2014/01/01','yyyy/mm/dd') and to_date('2015/01/01','yyyy/mm/dd') ;

COMMIT;

Delete
FROM MAXDAT.INCIDENT_HEADER_STAT_HIST_STG
WHERE trunc(create_ts) between to_date('2015/01/01','yyyy/mm/dd') and to_date('2016/01/01','yyyy/mm/dd') ;

COMMIT;

Delete
FROM MAXDAT.INCIDENT_HEADER_STAT_HIST_STG
WHERE trunc(create_ts) between to_date('2016/01/01','yyyy/mm/dd') and to_date('2017/01/01','yyyy/mm/dd') ;

COMMIT;

Delete
FROM MAXDAT.INCIDENT_HEADER_STAT_HIST_STG
WHERE trunc(create_ts) between to_date('2017/01/01','yyyy/mm/dd') and to_date('2018/01/01','yyyy/mm/dd') ;

COMMIT;

UPDATE corp_etl_control
SET value = '2013/01/01 01:01:01'
WHERE NAME = 'MAX_UPDATE_TS_INCIDENT_STTAUS_HIST';

COMMIT;

