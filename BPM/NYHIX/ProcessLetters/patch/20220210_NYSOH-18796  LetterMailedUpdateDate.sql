--NYHIX
UPDATE d_pl_current
   SET
    mailed_date = to_date('20220103 12:00:00 am','yyyymmdd hh:mi:ss am')
 WHERE letter_request_id
 IN (10794348, 10794347, 10794346, 10794344, 10794343,
     10794341, 10794340, 10794339, 10794338, 10794337,
     10794336, 10794335, 10794334, 10794332, 10794331,
     10794328, 10794327, 10794326, 10794325, 10794324,
     10794323, 10794322, 10794313, 10794312, 10794306,
     10794305, 10794304, 10794303, 10794299, 10794298,
     10794297, 10794296, 10794291, 10794287, 10794285,
     10794284, 10794281, 10794272, 10794271, 10794270,
     10794269, 10794268, 10794266, 10794265, 10794263,
     10794261, 10794259, 10794258, 10794256, 10794255,
     10794254, 10794253, 10794250, 10794247, 10794244,
     10794243, 10794242, 10794236, 10794233, 10794232,
     10794227, 10794225, 10794223, 10794219, 10794214,
     10794212, 10794209, 10794208, 10794207, 10794201,
     10794196, 10794195, 10794194, 10794193, 10794191,
     10794190, 10794188, 10794187, 10794186, 10794185,
     10794184, 10794183, 10794181, 10794180, 10794178,
     10794176, 10794175, 10794174, 10794173, 10794172,
     10794170, 10794169, 10794168, 10794167, 10794166,
     10794165, 10794164, 10794162, 10794160, 10794158,
     10794157, 10794155, 10794154, 10794153, 10794152,
     10794151, 10794150, 10794149, 10794148, 10794147,
     10794146, 10794145, 10794144, 10794142, 10794138,
     10794137, 10794136, 10794135, 10794133, 10794132,
     10794131, 10794130, 10794129, 10794128, 10794127,
     10794126, 10794125, 10794124, 10794122, 10794121,
     10794118, 10794117, 10794116, 10794115, 10794114,
     10794112, 10794109, 10794104, 10794082, 10794046,
     10794033, 10794030, 10794024, 10794023, 10794022,
     10794017, 10793995, 10793991, 10793989, 10793988,
     10793985, 10793984, 10793983, 10793975, 10793971,
     10793968, 10793958, 10793953, 10793950, 10793946,
     10793944, 10793942, 10793941, 10793938, 10793930,
     10793920, 10793916, 10793909, 10793905, 10793904,
     10793901, 10793899, 10793897, 10793895, 10793894,
     10793882, 10793855, 10793832, 10793484, 10793482,
     10793481, 10793480, 10793474, 10793472, 10793468,
     10793461, 10793460, 10793458, 10793456, 10793452,
     10793445, 10793444, 10793215, 10793213, 10793210,
     10793209, 10793205, 10793203, 10793196, 10793195,
     10793187, 10793186, 10793185, 10793184, 10793183,
     10793180, 10793179, 10793177, 10792654, 10792651,
     10792650, 10792646, 10792639, 10792638, 10792634,
     10792632, 10792631, 10792630, 10792626, 10792622,
     10792616, 10792613, 10792611, 10792561, 10792503,
     10792500, 10792495, 10792488, 10794352, 10794342,
     10794267, 10794262, 10794362, 10794260);
					 
-- do not commit YET.
-- if rows updated does not = 234
-- ROLLBACK;					 

--Validation Query
SELECT DISTINCT mailed_date
  FROM d_pl_current_sv
 WHERE letter_request_id 
 IN (10794348, 10794347, 10794346, 10794344, 10794343,
      10794341, 10794340, 10794339, 10794338, 10794337,
      10794336, 10794335, 10794334, 10794332, 10794331,
      10794328, 10794327, 10794326, 10794325, 10794324,
      10794323, 10794322, 10794313, 10794312, 10794306,
      10794305, 10794304, 10794303, 10794299, 10794298,
      10794297, 10794296, 10794291, 10794287, 10794285,
      10794284, 10794281, 10794272, 10794271, 10794270,
      10794269, 10794268, 10794266, 10794265, 10794263,
      10794261, 10794259, 10794258, 10794256, 10794255,
      10794254, 10794253, 10794250, 10794247, 10794244,
      10794243, 10794242, 10794236, 10794233, 10794232,
      10794227, 10794225, 10794223, 10794219, 10794214,
      10794212, 10794209, 10794208, 10794207, 10794201,
      10794196, 10794195, 10794194, 10794193, 10794191,
      10794190, 10794188, 10794187, 10794186, 10794185,
      10794184, 10794183, 10794181, 10794180, 10794178,
      10794176, 10794175, 10794174, 10794173, 10794172,
      10794170, 10794169, 10794168, 10794167, 10794166,
      10794165, 10794164, 10794162, 10794160, 10794158,
      10794157, 10794155, 10794154, 10794153, 10794152,
      10794151, 10794150, 10794149, 10794148, 10794147,
      10794146, 10794145, 10794144, 10794142, 10794138,
      10794137, 10794136, 10794135, 10794133, 10794132,
      10794131, 10794130, 10794129, 10794128, 10794127,
      10794126, 10794125, 10794124, 10794122, 10794121,
      10794118, 10794117, 10794116, 10794115, 10794114,
      10794112, 10794109, 10794104, 10794082, 10794046,
      10794033, 10794030, 10794024, 10794023, 10794022,
      10794017, 10793995, 10793991, 10793989, 10793988,
      10793985, 10793984, 10793983, 10793975, 10793971,
      10793968, 10793958, 10793953, 10793950, 10793946,
      10793944, 10793942, 10793941, 10793938, 10793930,
      10793920, 10793916, 10793909, 10793905, 10793904,
      10793901, 10793899, 10793897, 10793895, 10793894,
      10793882, 10793855, 10793832, 10793484, 10793482,
      10793481, 10793480, 10793474, 10793472, 10793468,
      10793461, 10793460, 10793458, 10793456, 10793452,
      10793445, 10793444, 10793215, 10793213, 10793210,
      10793209, 10793205, 10793203, 10793196, 10793195,
      10793187, 10793186, 10793185, 10793184, 10793183,
      10793180, 10793179, 10793177, 10792654, 10792651,
      10792650, 10792646, 10792639, 10792638, 10792634,
      10792632, 10792631, 10792630, 10792626, 10792622,
      10792616, 10792613, 10792611, 10792561, 10792503,
      10792500, 10792495, 10792488, 10794352, 10794342,
      10794267, 10794262, 10794362, 10794260);

-- note if the above validation query
-- show only 1 date of 
-- then commit;
-- else rollback