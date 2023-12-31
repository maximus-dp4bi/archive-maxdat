DELETE FROM CORP_ETL_PROC_LETTERS
WHERE LETTER_REQUEST_ID IN (
'9298290',
'9298287',
'9298309',
'9298289',
'9294639',
'9298040',
'9298288')
;

DELETE FROM CORP_ETL_PROC_LETTERS_CHD
WHERE LETTER_REQUEST_ID IN (
'9298290',
'9298287',
'9298309',
'9298289',
'9294639',
'9298040',
'9298288')
;

DELETE FROM CORP_ETL_PROC_LETTERS_OLTP
WHERE LETTER_REQUEST_ID IN (
'9298290',
'9298287',
'9298309',
'9298289',
'9294639',
'9298040',
'9298288')
;

DELETE FROM CORP_ETL_PROC_LETTERS_WIP_BPM
WHERE LETTER_REQUEST_ID IN (
'9298290',
'9298287',
'9298309',
'9298289',
'9294639',
'9298040',
'9298288')
;

delete from F_PL_BY_DATE
where PL_BI_ID in (select PL_BI_ID from D_PL_CURRENT where LETTER_REQUEST_ID IN (
'9298290',
'9298287',
'9298309',
'9298289',
'9294639',
'9298040',
'9298288')
);

DELETE FROM D_PL_CURRENT
WHERE LETTER_REQUEST_ID IN (
'9298290',
'9298287',
'9298309',
'9298289',
'9294639',
'9298040',
'9298288')
;

COMMIT;

DELETE FROM BPM_UPDATE_EVENT_QUEUE
WHERE BSL_ID = 12
AND identifier IN (
'9298290',
'9298287',
'9298309',
'9298289',
'9294639',
'9298040',
'9298288')
;

COMMIT;

