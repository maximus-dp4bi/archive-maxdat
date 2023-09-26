--Test script for TRAN_COMM_INSERT
--success
begin
  TRAN_COMM_INSERT(
   IN_TRAN_DATE => to_date('8/10/2022','mm/dd/yyyy')
  , IN_ACTION_LABEL => 'Initial Transmittal sent to EYR'
  , IN_ACTION_CODE_OTHER => null
  , IN_ACTION_DATE => trunc(sysdate-5)
  , IN_ACTION_USER => 'Laura'
  , IN_FILENAME => 'Transmittal Approval 08032022.xlsx'
  , IN_COMMENTS => 'Transmittal sent after mailing for audit'
  , IN_CREATED_BY => 'Laura'
);
end;
--error tran date not found
begin
  TRAN_COMM_INSERT(
   IN_TRAN_DATE => to_date('8/1/2022','mm/dd/yyyy')
  , IN_ACTION_LABEL => 'Initial Transmittal sent to EYR'
  , IN_ACTION_CODE_OTHER => null
  , IN_ACTION_DATE => trunc(sysdate-3)
  , IN_ACTION_USER => 'Laura'
  , IN_FILENAME => 'Transmittal Approval 08032022.xlsx'
  , IN_COMMENTS => 'Transmittal sent after mailing for audit'
  , IN_CREATED_BY => 'Laura'
);
end;
--error action date too much in the past
begin
  TRAN_COMM_INSERT(
   IN_TRAN_DATE => to_date('8/3/2022','mm/dd/yyyy')
  , IN_ACTION_LABEL => 'Initial Transmittal sent to EYR'
  , IN_ACTION_CODE_OTHER => null
  , IN_ACTION_DATE => to_date('8/3/2000','mm/dd/yyyy')
  , IN_ACTION_USER => 'Laura'
  , IN_FILENAME => 'Transmittal Approval 08032022.xlsx'
  , IN_COMMENTS => 'Transmittal sent after mailing for audit'
  , IN_CREATED_BY => 'Laura'
);
end;
--action date in the future
begin
  TRAN_COMM_INSERT(
   IN_TRAN_DATE => to_date('8/3/2022','mm/dd/yyyy')
  , IN_ACTION_LABEL => 'Initial Transmittal sent to EYR'
  , IN_ACTION_CODE_OTHER => null
  , IN_ACTION_DATE => to_date('8/3/2024','mm/dd/yyyy')
  , IN_ACTION_USER => 'Laura'
  , IN_FILENAME => 'Transmittal Approval 08032022.xlsx'
  , IN_COMMENTS => 'Transmittal sent after mailing for audit'
  , IN_CREATED_BY => 'Laura'
);
end;

--error action code incorrect
begin
  TRAN_COMM_INSERT(
   IN_TRAN_DATE => to_date('8/3/2022','mm/dd/yyyy')
  , IN_ACTION_LABEL => 'Initial Transmital sent to EYR'
  , IN_ACTION_CODE_OTHER => null
  , IN_ACTION_DATE => trunc(sysdate-3)
  , IN_ACTION_USER => 'Laura'
  , IN_FILENAME => 'Transmittal Approval 08032022.xlsx'
  , IN_COMMENTS => 'Transmittal sent after mailing for audit'
  , IN_CREATED_BY => 'Laura'
);
end;
--error action user
begin
  TRAN_COMM_INSERT(
   IN_TRAN_DATE => to_date('8/3/2022','mm/dd/yyyy')
  , IN_ACTION_LABEL => 'Initial Transmittal sent to EYR'
  , IN_ACTION_CODE_OTHER => null
  , IN_ACTION_DATE => trunc(sysdate-3)
  , IN_ACTION_USER => null
  , IN_FILENAME => 'Transmittal Approval 08032022.xlsx'
  , IN_COMMENTS => 'Transmittal sent after mailing for audit'
  , IN_CREATED_BY => 'Laura'
);
end;
    
