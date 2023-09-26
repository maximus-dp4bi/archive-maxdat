WITH u AS (SELECT id , name as userName FROM raw_configuration_objects  WHERE type = 'user')
SELECT
    
    raw_user_status_intervals.userId,
    u.userName,
    intervalStartTime,
    offlineDuration,
    availableDuration,
    onQueueDuration,
    awayDuration,
    busyDuration,
    mealDuration,
    meetingDuration,
    trainingDuration,
    breakDuration,
    idleDuration,
    notAnsweringDuration,
    interactingDuration,
    systemAwayDuration,
    communicatingDuration
FROM raw_user_status_intervals
LEFT OUTER JOIN u ON raw_user_status_intervals.userid = u.id