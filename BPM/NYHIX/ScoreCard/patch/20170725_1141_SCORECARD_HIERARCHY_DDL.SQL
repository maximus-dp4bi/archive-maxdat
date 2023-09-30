-------------------------------------------------
-- NYHIX-30479 -- Add EVENT_NAME
-------------------------------------------------

ALTER TABLE DP_SCORECARD.SCORECARD_HIERARCHY
ADD (EVENT_NAME     VARCHAR2(250) )
;


ALTER TABLE DP_SCORECARD.SCORECARD_HIERARCHY
ADD (
  DEPARTMENT                    VARCHAR2(50 BYTE),
  BUILDING                      VARCHAR2(100 BYTE)
);