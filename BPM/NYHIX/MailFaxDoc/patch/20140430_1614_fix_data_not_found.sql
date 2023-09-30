DELETE
FROM f_nyhix_mfd_by_date
WHERE nyhix_mfd_bi_id IN (1654455, 1654456, 1653569, 1653570, 1654387, 1952883, 1952884, 1952885, 1952886, 1952887, 2044177, 2222782, 2222794, 2222630, 2222632, 2222634, 2222636, 2222846, 2222852, 2222858, 2222777);
--COMMIT;

DELETE
FROM d_nyhix_mfd_current
WHERE nyhix_mfd_bi_id IN (1654455, 1654456, 1653569, 1653570, 1654387, 1952883, 1952884, 1952885, 1952886, 1952887, 2044177, 2222782, 2222794, 2222630, 2222632, 2222634, 2222636, 2222846, 2222852, 2222858, 2222777);
COMMIT;

INSERT
INTO bpm_update_event_queue
  (
    BUEQ_ID,
    BSL_ID,
    BIL_ID,
    IDENTIFIER,
    EVENT_DATE,
    QUEUE_DATE,
    PROCESS_BUEQ_ID,
  --  WROTE_BPM_EVENT_DATE,
    WROTE_BPM_SEMANTIC_DATE,
    DATA_VERSION,
    OLD_DATA,
    NEW_DATA
  )
SELECT BUEQ_ID,
  BSL_ID,
  BIL_ID,
  IDENTIFIER,
  EVENT_DATE,
  QUEUE_DATE,
  NULL,
 -- WROTE_BPM_EVENT_DATE,
  NULL,
  DATA_VERSION,
  OLD_DATA,
  NEW_DATA
FROM bpm_update_event_queue_archive
WHERE BSL_ID    = 18
AND identifier IN ('10131066', '10131067', '10130824', '10130825', '10130991', '10166553', '10166554', '10166555', '10166556', '10166557', '10181598', 'U140803117133', 'U140803117157', 'U140803117131', 'U140803117139', 'U140803117150', 'U140803117158', 'U140803117122', 'U140803117141', 'U140803117160', 'U140803117125');

DELETE FROM bpm_update_event_queue_archive
WHERE BSL_ID    = 18
AND identifier IN ( '10131066', '10131067', '10130824', '10130825', '10130991', '10166553', '10166554', '10166555', '10166556', '10166557', '10181598', 'U140803117133', 'U140803117157', 'U140803117131', 'U140803117139', 'U140803117150', 'U140803117158', 'U140803117122', 'U140803117141', 'U140803117160', 'U140803117125');
 COMMIT;

DECLARE 
  v_seq NUMBER;
BEGIN 
FOR i in (SELECT * FROM F_NYHIX_MFD_BY_DATE f
where NYHIX_MFD_BI_ID in(
1157112,	
1162268	,
1170391	,
1193863	,
1315517	,
1320350	,
1320352	,
1320360	,
1386195	,
1392675	,
1463138	,
1463140	,
1463569	,
1463571	,
1463614	,
1463615	,
1463616	,
1492769	,
1492770	,
1598158	,
1598159	,
1598160	,
1598161	,
1620081	,
1620083	,
1620085	,
1620087	,
1653568	,
1654381	,
1654382	,
1654383	,
1654384	,
1654385	,
1834947	,
1952878	,
1952879	,
1952880	,
1952881	,
1952882	,
1952888	,
1959108	,
1959109	,
1959110	,
1959111	)
and bucket_end_date = to_date('07/07/2077','mm/dd/yyyy'))
LOOP
  v_seq := NULL;
  
  SELECT SEQ_FNMFDBD_ID.nextval INTO v_seq FROM dual;
  UPDATE F_NYHIX_MFD_BY_DATE
  SET fnmfdbd_id = v_seq
  WHERE fnmfdbd_id = i.fnmfdbd_id;
END LOOP;
END;
/

COMMIT;