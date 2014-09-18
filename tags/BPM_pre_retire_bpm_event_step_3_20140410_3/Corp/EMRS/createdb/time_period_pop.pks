--
-- @'S:\Texas IEE Project\MAXIMUS\CHIP\TX_CHIP_REPORTING\Reporting Developers\Isaac\Docs\ICE\PLSQL\Time Dim\time_period_pop.pks'
--
-- Date  Created:  11-OCT-05
-- Last Modified:  
--
--
-- This procedure Populates the Time dimension-table (EMRS_D_TIME_PERIOD).  It takes
-- no arguments and computes all HH:MI:SS in a 24HH clock.  It then populates each attribute
-- of the dimension.
--
--
CREATE OR REPLACE PACKAGE period_time_pop
  IS
     PROCEDURE  pop_time_period_row (CURR_TIME_IN     IN  varchar2);
     PROCEDURE loop_time_period_row;
END period_time_pop;
/
show errors