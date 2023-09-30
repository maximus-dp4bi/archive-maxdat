WITH
    u AS (SELECT id , name AS createdByName FROM raw_configuration_objects  WHERE type = 'user')
SELECT 
       raw_transcription_sentiment_feedback.id,
       phrase,
       dialect,
       feedbackValue,
       dateCreated,
       createdById,
       createdByName
FROM raw_transcription_sentiment_feedback
         LEFT OUTER JOIN u ON raw_transcription_sentiment_feedback.createdById = u.id