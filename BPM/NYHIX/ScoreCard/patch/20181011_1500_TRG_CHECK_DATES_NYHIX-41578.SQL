 CREATE OR REPLACE TRIGGER TRG_CHECK_DATES
  BEFORE INSERT OR UPDATE ON DP_SCORECARD.SC_ATTENDANCE
  FOR EACH ROW
BEGIN
  IF( :new.ENTRY_DATE > SYSDATE )
  THEN
    RAISE_APPLICATION_ERROR( -20001, 
          'Invalid EntryDate: Entry Date must be less than the current date - value = ' || 
          to_char( :new.ENTRY_DATE, 'YYYY-MM-DD HH24:MI:SS' ) );
  END IF;
 END;