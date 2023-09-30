
UPDATE survey_header_info
SET challenge_type = 'Initial'
WHERE survey_header_info_id IN(81055,
81067,
85069,
85073,
87041,
81061,
81077);

UPDATE survey_header_info
SET challenge_type = 'Update - Initial'
WHERE survey_header_info_id = 85075;

UPDATE survey_header_info
SET challenge_type = 'Update - Second Level'
WHERE survey_header_info_id = 87047;

UPDATE survey_header_info
SET challenge_type = 'Third Level'
WHERE survey_header_info_id = 87033;

UPDATE survey_header_info
SET challenge_type = 'Second Level'
WHERE survey_header_info_id = 81051;


UPDATE survey_header_info_hist
SET challenge_type = 'Initial'
WHERE survey_header_info_hist_id IN(82006,
82007,
82008,
82019,
82020,
82022,
82021,
82001,
82002,
82003,
82004);

UPDATE survey_header_info_hist
SET challenge_type = 'Update - Initial'
WHERE survey_header_info_hist_id = 82009;

UPDATE survey_header_info_hist
SET challenge_type = 'Update - Second Level'
WHERE survey_header_info_hist_id = 82024;

UPDATE survey_header_info_hist
SET challenge_type = 'Third Level'
WHERE survey_header_info_hist_id = 82026;

UPDATE survey_header_info_hist
SET challenge_type = 'Second Level'
WHERE survey_header_info_hist_id IN(82010,
82023,
82025);

COMMIT;

