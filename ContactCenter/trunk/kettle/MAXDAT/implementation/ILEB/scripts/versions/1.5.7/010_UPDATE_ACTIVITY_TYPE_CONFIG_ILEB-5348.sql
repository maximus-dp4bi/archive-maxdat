/*
Created on 11/20/2015 by Raj A.
Description:
Created per ILEB-5348.
*/
UPDATE CC_D_ACTIVITY_TYPE
   SET ACTIVITY_TYPE_CATEGORY = 'Scheduled PTO',
       IS_PAID_FLAG = 1,
       IS_ABSENCE_FLAG = 1 
 WHERE activity_type_name = 'Berevement';
UPDATE CC_D_ACTIVITY_TYPE
   SET ACTIVITY_TYPE_CATEGORY = 'Available',
       IS_PAID_FLAG = 1,
       IS_AVAILABLE_FLAG = 1,
       IS_READY_FLAG = 1
WHERE activity_type_name = 'CES CONCERIGE';
 
UPDATE CC_C_ACTIVITY_TYPE
   SET ACTIVITY_TYPE_CATEGORY = 'Scheduled PTO',
       IS_PAID_FLAG = 1,
       IS_ABSENCE_FLAG = 1
  WHERE activity_type_name = 'Berevement';
UPDATE CC_C_ACTIVITY_TYPE
   SET ACTIVITY_TYPE_CATEGORY = 'Available',
       IS_PAID_FLAG = 1,
       IS_AVAILABLE_FLAG = 1,
       IS_READY_FLAG = 1
WHERE activity_type_name = 'CES CONCERIGE';
COMMIT;