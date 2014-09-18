--
-- @'S:\Texas IEE Project\MAXIMUS\CHIP\TX_CHIP_REPORTING\Reporting Developers\Isaac\Docs\ICE\PLSQL\PeriodPop\release_02\period_pop.pks'
--
-- Date  Created:  11-AUG-05
-- Last Modified:  29-JUL-09
--
--
-- This procedure Populates the Period dimension-table (EMRS_D_DATE_PERIOD).  It takes
-- as its argument a single date and computes from that date, all of the attributes
-- of the PERIOD dimension.
--
--
CREATE OR REPLACE PACKAGE period_pop
  IS
     PROCEDURE  pop_period_row (P_PERIOD_DATE_IN       IN varchar2);
     PROCEDURE loop_period_row (P_PERIOD_DATE_START_IN IN varchar2
                              , P_PERIOD_DATE_END_IN   IN varchar2 );
END period_pop;
/
show errors