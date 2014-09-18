--Complete in ETL, Fact table shows complete but are still active in current dimension, does not have a record in the queue or queue archive
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET stg_last_update_dt = sysdate
WHERE dcn IN('U140171796521',
'10074431',
'10044018',
'U140311901104',
'10073868',
'10074414');

--Complete in ETL, Fact table shows complete but are still active in current dimension, exists in queue archive
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
    WROTE_BPM_EVENT_DATE,
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
  null,
  WROTE_BPM_EVENT_DATE,
  NULL,
  DATA_VERSION,
  OLD_DATA,
  NEW_DATA
FROM bpm_update_event_queue_archive
WHERE
BSL_ID = 18 and 
OLD_DATA is not null and
identifier IN ('10044394'	,'10048382'	,'10075765'	,'10075768'	,'10075778'	,'10075781'	,'10075785'	,'10073860'	,'10075793'	,'U140522332700'	,'U140522332659'	,
'U140522332682'	,'U140522332684'	,'U140522332767'	,'U140712815406'	,'U140762978946'	,'U140762978945'	,'U140762978952'	,'U140873336986'	,'U140953685638'	,
'U140953685563'	,'U140943684898'	,'U140953685510'	,'U140963710312'	,'U140963710325'	,'U140963710297'	,'U140963710298'	,'U140963710317'	,'U140963710440'	,
'U140963710451'	,'U140963710328'	,'U140963710338'	,'U140963710299'	,'U140963710340'	,'U140963710359'	,'U140963710377'	,'U140963710432'	,'U140943684879'	,
'U140943684894'	,'U140953685522'	,'U140953685561'	,'U140953685574'	,'U140953685644'	,'U140963710292'	,'U140963710301'	,'U140963710303'	,'U140963710305'	,
'U140963710308'	,'U140963710302'	,'U140963710431'	,'U140963710367'	,'U140993731837'	,'U141023759472'	,'U141023759478'	,'U141023759477'	,'U141023759490'	,
'U141023759475'	,'U141043769529'	,'U141043769234'	,'U141043769386'	,'U141043769467'	,'U141043769531'	,'U141043769537'	,'U141043769541'	,'U141043770348'	,
'U141043770927'	,'U141043772823'	,'U141043772887'	,'U141043772973'	,'U141043773005'	,'U141043773346'	,'U141043773348'	,'U141043773363'	,'U140943684871'	,
'U140963710336'	,'U140953685590'	,'U140963710296'	,'U140973713904'	,'U141023759486'	,'U140963710357'	,'U140642645860'	,'U140953685597'	,'U140963710351'	,
'U141043773219' );

delete FROM bpm_update_event_queue_archive
WHERE
BSL_ID = 18 and 
OLD_DATA is not null and
identifier IN ('10044394'	,'10048382'	,'10075765'	,'10075768'	,'10075778'	,'10075781'	,'10075785'	,'10073860'	,'10075793'	,'U140522332700'	,'U140522332659'	,
'U140522332682'	,'U140522332684'	,'U140522332767'	,'U140712815406'	,'U140762978946'	,'U140762978945'	,'U140762978952'	,'U140873336986'	,'U140953685638'	,
'U140953685563'	,'U140943684898'	,'U140953685510'	,'U140963710312'	,'U140963710325'	,'U140963710297'	,'U140963710298'	,'U140963710317'	,'U140963710440'	,
'U140963710451'	,'U140963710328'	,'U140963710338'	,'U140963710299'	,'U140963710340'	,'U140963710359'	,'U140963710377'	,'U140963710432'	,'U140943684879'	,
'U140943684894'	,'U140953685522'	,'U140953685561'	,'U140953685574'	,'U140953685644'	,'U140963710292'	,'U140963710301'	,'U140963710303'	,'U140963710305'	,
'U140963710308'	,'U140963710302'	,'U140963710431'	,'U140963710367'	,'U140993731837'	,'U141023759472'	,'U141023759478'	,'U141023759477'	,'U141023759490'	,
'U141023759475'	,'U141043769529'	,'U141043769234'	,'U141043769386'	,'U141043769467'	,'U141043769531'	,'U141043769537'	,'U141043769541'	,'U141043770348'	,
'U141043770927'	,'U141043772823'	,'U141043772887'	,'U141043772973'	,'U141043773005'	,'U141043773346'	,'U141043773348'	,'U141043773363'	,'U140943684871'	,
'U140963710336'	,'U140953685590'	,'U140963710296'	,'U140973713904'	,'U141023759486'	,'U140963710357'	,'U140642645860'	,'U140953685597'	,'U140963710351'	,
'U141043773219' );

commit;