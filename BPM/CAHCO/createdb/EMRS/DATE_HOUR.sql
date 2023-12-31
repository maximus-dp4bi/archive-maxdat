CREATE OR REPLACE VIEW MAXDAT.DATE_HOUR 
AS
SELECT TIMESTAMP '2000-01-01 00:00:00' + 1/24 * rownum AS D_DATE
, (TO_CHAR(TIMESTAMP '2000-01-01 00:00:00' + 1/24 * rownum,'HH24')||':00') 
      || '-' 
      || (TO_CHAR(TIMESTAMP '2000-01-01 00:00:00' + 1/24 * (rownum + 1),'HH24') ||':00') AS HOUR_RANGE
FROM dual
  CONNECT BY level <= (sysdate - DATE '2000-01-01') * 24;
  
  GRANT SELECT ON MAXDAT.DATE_HOUR TO MAXDAT_READ_ONLY; 