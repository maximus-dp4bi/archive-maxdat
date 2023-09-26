-- insert successful
begin
  MI_LETTER_ADJUST_FORM_INSERT(IN_LETTER_TYPE_NAME => 'HC - MIHC - CSHCS FA'
  ,IN_ADJUSTMENT_DATE => sysdate
  ,IN_LETTER_ADJUST_REASON_CODE => 'STATE'
  ,IN_ADJUSTMENT_COUNT => 40
  , IN_COMMENTS => 'State Requested'
  , IN_CREATED_BY => 'Prashanth'
  , IN_UPDATED_BY => 'Prashanth'
  );
end;

-- insert Input values incorrect
begin
  MI_LETTER_ADJUST_FORM_INSERT(IN_LETTER_TYPE_NAME => null
  ,IN_ADJUSTMENT_DATE => sysdate
  ,IN_LETTER_ADJUST_REASON_CODE => 'STATE'
  ,IN_ADJUSTMENT_COUNT => 40
  , IN_COMMENTS => 'State Requested'
  , IN_CREATED_BY => 'Prashanth'
  , IN_UPDATED_BY => 'Prashanth'
  );
end;

-- Insert Input values incorrect
begin
  MI_LETTER_ADJUST_FORM_INSERT(IN_LETTER_TYPE_NAME => 'MAXEB - MIHC - HMP FK'
  ,IN_ADJUSTMENT_DATE => sysdate
  ,IN_LETTER_ADJUST_REASON_CODE => 'STATE'
  ,IN_ADJUSTMENT_COUNT => 0
  , IN_COMMENTS => 'State Requested'
  , IN_CREATED_BY => 'Prashanth'
  , IN_UPDATED_BY => 'Prashanth'
  );
end;

-- Insert Letter Type not found
begin
  MI_LETTER_ADJUST_FORM_INSERT(IN_LETTER_TYPE_NAME => 'MAXEB - MIHC - HMP K'
  ,IN_ADJUSTMENT_DATE => sysdate
  ,IN_LETTER_ADJUST_REASON_CODE => 'STATE'
  ,IN_ADJUSTMENT_COUNT => 40
  , IN_COMMENTS => 'State Requested'
  , IN_CREATED_BY => 'Prashanth'
  , IN_UPDATED_BY => 'Prashanth'
  );
end;


-- update successful
begin
  MI_LETTER_ADJUST_FORM_UPDATE(IN_LETTER_ADJUSTMENT_FORM_ID => 606,
  IN_LETTER_TYPE_NAME => 'HC - MIHC - MED FF'
  ,IN_ADJUSTMENT_DATE => sysdate
  ,IN_LETTER_ADJUST_REASON_CODE => 'STATE'
  ,IN_ADJUSTMENT_COUNT => 40
  , IN_COMMENTS => 'State Requested'
  , IN_UPDATED_BY => 'Mona'
  );
end;

-- update Input values incorrect
begin
  MI_LETTER_ADJUST_FORM_UPDATE(IN_LETTER_ADJUSTMENT_FORM_ID => 591,
  IN_LETTER_TYPE_NAME => 'MAXEB - MIHC - CSHCS RA'
  ,IN_ADJUSTMENT_DATE => sysdate
  ,IN_LETTER_ADJUST_REASON_CODE => 'STATE'
  ,IN_ADJUSTMENT_COUNT => 0
  , IN_COMMENTS => 'State Requested'
  , IN_UPDATED_BY => 'Mona'
  );
end;

-- update  Input values incorrect
begin
  MI_LETTER_ADJUST_FORM_UPDATE(IN_LETTER_ADJUSTMENT_FORM_ID => 0,
  IN_LETTER_TYPE_NAME => 'MAXEB - MIHC - CSHCS RA'
  ,IN_ADJUSTMENT_DATE => sysdate
  ,IN_LETTER_ADJUST_REASON_CODE => 'STATE'
  ,IN_ADJUSTMENT_COUNT => 40
  , IN_COMMENTS => 'State Requested'
  , IN_UPDATED_BY => 'Mona'
  );
end;

-- update  Letter Type not found
begin
  MI_LETTER_ADJUST_FORM_UPDATE(IN_LETTER_ADJUSTMENT_FORM_ID => 591,
  IN_LETTER_TYPE_NAME => 'MAXEB - MIHC - CSHCS A'
  ,IN_ADJUSTMENT_DATE => sysdate
  ,IN_LETTER_ADJUST_REASON_CODE => 'STATE'
  ,IN_ADJUSTMENT_COUNT => 40
  , IN_COMMENTS => 'State Requested'
  , IN_UPDATED_BY => 'Mona'
  );
end;

 
